require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const userController = require('./controllers/userController');
const userSettingsController = require("./controllers/settingController");
const userTasksController = require("./controllers/taskController");
const friendsController = require("./controllers/friendController");
const reminderController = require("./controllers/reminderController");
const multer = require('multer');
const upload = multer({ dest: 'uploads/' });

const router = express();
const port = 3000;

router.use(bodyParser.json());

mongoose.connect(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => console.log('MongoDB connected'))
  .catch(err => console.error('MongoDB connection error:', err));

//UserProfile Routes
router.post('/users', userController.createUser);
router.post('/users/auth', userController.authenticateUser);
router.get('/users', userController.getAllUsers);
router.get('/users/:id', userController.getUserById);
router.patch('/users/:id', userController.updateUser);
router.delete('/users/:id', userController.deleteUser);

// UserSettings Routes
router.get('/users/:userId/settings', userSettingsController.getUserSettings);
router.patch('/users/:userId/settings', userSettingsController.updateUserSettings);
router.delete('/users/:userId/settings', userSettingsController.deleteUserSettings);

// UserTasks Routes
router.post('/users/:userId/tasks', userTasksController.addTask);
router.get('/users/:userId/tasks', userTasksController.getTasks);
router.post('/users/:userId/tasks/:taskId', upload.single('image'), userTasksController.updateTask);
router.delete('/users/:userId/tasks/:taskId', userTasksController.deleteTask);

// Friend Routes
router.post('/users/:userId/friends', friendsController.addFriend);
router.get('/users/:userId/friends', friendsController.getFriends);
router.delete('/users/:userId/friends/:friendId', friendsController.removeFriend);

// Reminder routes
router.post('/reminders', reminderController.createReminder);
router.get('/reminders/user/:userId', reminderController.getRemindersByUser);
router.patch('/reminders/:reminderId', reminderController.updateReminder);
router.delete('/reminders/:reminderId', reminderController.deleteReminder);

router.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
