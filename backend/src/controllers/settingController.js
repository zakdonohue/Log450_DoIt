const { User } = require('../models');

// Get User Settings
const getUserSettings = async (req, res) => {
  try {
    const userId = req.params.userId;
    const user = await User.findById(userId, 'settings');
    if (!user) {
      return res.status(404).send('User not found');
    }
    res.send(user.settings);
  } catch (error) {
    res.status(500).send(error);
  }
};

// Update User Settings
const updateUserSettings = async (req, res) => {
  try {
    const userId = req.params.userId;
    const user = await User.findByIdAndUpdate(userId, { $set: { 'settings': req.body } }, { new: true, runValidators: true });
    if (!user) {
      return res.status(404).send('User not found');
    }
    res.send(user.settings);
  } catch (error) {
    res.status(400).send(error);
  }
};

// Delete User Settings
// For deleting settings, we can either set each field to null or remove the settings key entirely. Here's how to set them to null:
const deleteUserSettings = async (req, res) => {
  try {
    const userId = req.params.userId;
    const user = await User.findByIdAndUpdate(userId, { $set: { 'settings': {} } }, { new: true });
    if (!user) {
      return res.status(404).send('User not found');
    }
    res.send(user.settings); // This will return an empty settings object.
  } catch (error) {
    res.status(500).send(error);
  }
};

module.exports = {
    getUserSettings,
    updateUserSettings,
    deleteUserSettings
  };