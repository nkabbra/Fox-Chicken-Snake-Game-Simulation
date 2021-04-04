# Multi Agent System Game Simulation : 'Fox-chicken-snake'
The idea was to use potential field control in order to simulate the known primary school game 'Fox Chicken Snake'.
The game rules are simple: The fox tries to catch the chicken, the chicken try to catch the snake, and the snake try to catch the fox. The team that catches  all opponents first wins!
Each agent is modeled according to the 'Pedestrian Flow' model and an appropriate distributed control U is calculated for each agent in order to satisfy the desired attractive/repulsive behaviour. 
Two possible simulation modes exist: A simulation with animal icons and a simulation showing the potential field. You can simply choose either modes in initialization.
All you need to do is run server.m to start the game.

