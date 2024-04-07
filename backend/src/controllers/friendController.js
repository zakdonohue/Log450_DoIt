const { User } = require('../models');

// Add a Friend to a User
const addFriend = async (req, res) => {
  try {
    const userId = req.params.userId;
    const friendId = req.params.friendId; // ID of the user to be added as a friend
    // Ensure both users exist
    const user = await User.findById(userId);
    const friend = await User.findById(friendId);
    if (!user || !friend) {
      return res.status(404).send('User not found');
    }
    // Add friendId to the user's friend_ids if not already present
    if (!user.friend_ids.includes(friendId)) {
      user.friend_ids.push(friendId);
      await user.save();
    }
    // Optionally, add userId to the friend's friend_ids as well for bidirectional friendship
    if (!friend.friend_ids.includes(userId)) {
      friend.friend_ids.push(userId);
      await friend.save();
    }
    res.status(201).send({ message: 'Friend added successfully', friends: user.friend_ids });
  } catch (error) {
    res.status(400).send(error);
  }
};

// Get All Friends of a User
const getFriends = async (req, res) => {
  try {
    const userId = req.params.userId;
    const user = await User.findById(userId).populate('friend_ids');
    if (!user) {
      return res.status(404).send('User not found');
    }
    res.send(user.friend_ids);
  } catch (error) {
    res.status(500).send(error);
  }
};

// Remove a Friend
const removeFriend = async (req, res) => {
  try {
    const userId = req.params.userId;
    const friendId = req.params.friendId;
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).send('User not found');
    }
    // Remove friendId from the user's friend_ids
    user.friend_ids = user.friend_ids.filter(id => id.toString() !== friendId);
    await user.save();
    // Optionally, remove userId from the friend's friend_ids as well for bidirectional removal
    const friend = await User.findById(friendId);
    if (friend && friend.friend_ids.includes(userId)) {
      friend.friend_ids = friend.friend_ids.filter(id => id.toString() !== userId);
      await friend.save();
    }
    res.send({ message: 'Friend removed successfully', friends: user.friend_ids });
  } catch (error) {
    res.status(500).send(error);
  }
};

module.exports = {
    addFriend,
    getFriends,
    removeFriend,
  };