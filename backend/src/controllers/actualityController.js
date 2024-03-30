const { User } = require('../models');

// Add an Actuality to a User
const addActuality = async (req, res) => {
  try {
    const userId = req.params.userId;
    const actuality = req.body; // Actuality details from request body
    const user = await User.findByIdAndUpdate(userId, { $push: { actualities: actuality } }, { new: true, runValidators: true });
    if (!user) {
      return res.status(404).send('User not found');
    }
    res.status(201).send(user.actualities);
  } catch (error) {
    res.status(400).send(error);
  }
};

// Get All Actualities of a User
const getActualities = async (req, res) => {
  try {
    const userId = req.params.userId;
    const user = await User.findById(userId, 'actualities');
    if (!user) {
      return res.status(404).send('User not found');
    }
    res.send(user.actualities);
  } catch (error) {
    res.status(500).send(error);
  }
};

// Update an Actuality
const updateActuality = async (req, res) => {
  try {
    const userId = req.params.userId;
    const actualityId = req.params.actualityId;
    const actualityUpdates = req.body;

    // Find the user and the actuality to be updated
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).send('User not found');
    }
    const actuality = user.actualities.id(actualityId);
    if (!actuality) {
      return res.status(404).send('Actuality not found');
    }
    Object.assign(actuality, actualityUpdates);
    await user.save();
    res.send(actuality);
  } catch (error) {
    res.status(400).send(error);
  }
};

// Delete an Actuality
const deleteActuality = async (req, res) => {
  try {
    const userId = req.params.userId;
    const actualityId = req.params.actualityId;

    // Pull (remove) the actuality from the actualities array
    const user = await User.findByIdAndUpdate(userId, { $pull: { actualities: { _id: actualityId } } }, { new: true });
    if (!user) {
      return res.status(404).send('User not found');
    }
    res.send({ message: 'Actuality deleted successfully' });
  } catch (error) {
    res.status(500).send(error);
  }
};

module.exports = {
    addActuality,
    getActualities,
    updateActuality,
    deleteActuality
  };