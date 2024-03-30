const { Reminder, User } = require('../models'); // Adjust the path as necessary

// Create a new Reminder
const createReminder = async (req, res) => {
  try {
    const { userId, task_id, reminder_time } = req.body;
    const reminder = new Reminder({ user_id: userId, task_id, reminder_time });
    await reminder.save();

    // Optionally, add reminder to user's reminder_ids array
    await User.findByIdAndUpdate(userId, { $push: { reminder_ids: reminder._id } });

    res.status(201).json(reminder);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Get all Reminders for a User
const getRemindersByUser = async (req, res) => {
  try {
    const { userId } = req.params;
    const reminders = await Reminder.find({ user_id: userId });
    res.json(reminders);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Update a Reminder
const updateReminder = async (req, res) => {
  try {
    const { reminderId } = req.params;
    const reminder = await Reminder.findByIdAndUpdate(reminderId, req.body, { new: true, runValidators: true });
    if (!reminder) {
      return res.status(404).json({ message: 'Reminder not found' });
    }
    res.json(reminder);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Delete a Reminder
const deleteReminder = async (req, res) => {
  try {
    const { reminderId } = req.params;
    const reminder = await Reminder.findByIdAndDelete(reminderId);
    if (!reminder) {
      return res.status(404).json({ message: 'Reminder not found' });
    }

    // Optionally, remove reminder from user's reminder_ids array
    await User.findByIdAndUpdate(reminder.user_id, { $pull: { reminder_ids: reminder._id } });

    res.json({ message: 'Reminder deleted successfully' });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};


module.exports = {
    createReminder,
    getRemindersByUser,
    updateReminder,
    deleteReminder
  };