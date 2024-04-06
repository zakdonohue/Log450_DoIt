const { User } = require('../models');
const fs = require('fs');

// Add a Task to a User
const addTask = async (req, res) => {
  try {
    const userId = req.params.userId;
    const task = req.body; // Task details from request body
    const user = await User.findByIdAndUpdate(userId, { $push: { tasks: task } }, { new: true, runValidators: true });
    if (!user) {
      return res.status(404).send('User not found');
    }
    res.status(201).send(user.tasks);
  } catch (error) {
    res.status(400).send(error);
  }
};

// Get All Tasks of a User
const getTasks = async (req, res) => {
  try {
    const userId = req.params.userId;
    const user = await User.findById(userId, 'tasks');
    if (!user) {
      return res.status(404).send('User not found');
    }

    const tasksWithBase64Images = user.tasks.map(task => {
      if (task.image && task.image.data) {
        // Convert binary data to base64 string
        task.image = `data:image/png;base64,${task.image.data.toString('base64')}`;
      } else {
        // Assign null or a default base64 string for a placeholder image
        task.image = null;
      }
      return task;
    });

    res.send(tasksWithBase64Images);
  } catch (error) {
    res.status(500).send(error);
  }
};

// Update a Task
const updateTask = async (req, res) => {
  try {
    const userId = req.params.userId;
    const taskId = req.params.taskId;
    let taskUpdates = { ...req.body, isDone: req.body.isDone === 'true' }; // Convert isDone string to boolean

    // multer adds file information in req.file
    if (req.file) {
      const imageBuffer = fs.readFileSync(req.file.path); // Here you can use the file path to read the file into a buffer
      taskUpdates = { ...taskUpdates, image: imageBuffer };
    }

    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).send('User not found');
    }
    const task = user.tasks.id(taskId);
    if (!task) {
      return res.status(404).send('Task not found');
    }
    Object.assign(task, taskUpdates);
    await user.save();
    res.send(task);
  } catch (error) {
    console.log(error);
    res.status(400).send(error);
  }
};

// Delete a Task
const deleteTask = async (req, res) => {
  try {
    const userId = req.params.userId;
    const taskId = req.params.taskId;

    const user = await User.findByIdAndUpdate(userId, { $pull: { tasks: { _id: taskId } } }, { new: true });
    if (!user) {
      return res.status(404).send('User not found');
    }
    res.send({ message: 'Task deleted successfully' });
  } catch (error) {
    res.status(500).send(error);
  }
};

module.exports = {
  addTask,
  getTasks,
  updateTask,
  deleteTask,
};
