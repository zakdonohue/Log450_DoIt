const mongoose = require('mongoose');

const { Schema } = mongoose;

// Settings Schema
const settingsSchema = new Schema({
  is_account_private: Boolean,
  notifications_enabled: Boolean,
});

// Task Schema
const taskSchema = new Schema({
  title: String,
  due_date: Date,
  isDone: Boolean,
  created_at: { type: Date, default: Date.now },
  updated_at: { type: Date, default: Date.now },
});

// User Schema
const userSchema = new Schema({
  username: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  password_hash: { type: String, required: true },
  surname: String,
  lastName: String,
  city: String,
  province: String,
  country: String,
  created_at: { type: Date, default: Date.now },
  updated_at: { type: Date, default: Date.now },
  settings: settingsSchema, // Use settings schema here
  tasks: [taskSchema], // Use task schema here for an array of tasks
  friend_ids: [{ type: Schema.Types.ObjectId, ref: 'Friend' }],
  reminder_ids: [{ type: Schema.Types.ObjectId, ref: 'Reminder' }],
});

// Friend Schema
const friendSchema = new Schema({
  user_id: { type: Schema.Types.ObjectId, ref: 'User' },
  friend_user_id: { type: Schema.Types.ObjectId, ref: 'User' },
  status: String,
  created_at: { type: Date, default: Date.now },
});

// Reminder Schema
const reminderSchema = new Schema({
  user_id: { type: Schema.Types.ObjectId, ref: 'User' },
  task_id: { type: Schema.Types.ObjectId },
  reminder_time: Date,
  created_at: { type: Date, default: Date.now },
});

const User = mongoose.model('User', userSchema);
const Friend = mongoose.model('Friend', friendSchema);
const Reminder = mongoose.model('Reminder', reminderSchema);

module.exports = { User, Friend, Reminder };
