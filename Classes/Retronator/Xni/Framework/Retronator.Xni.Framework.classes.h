@class Protocols;

// Data structures
#import "RectangleStruct.h"
@class Rectangle, Color;

// Game
#import "DisplayOrientation.h"
@protocol IGraphicsDeviceManager;
@class Game, GameTime, GameServiceContainer, GraphicsDeviceManager;

// Game host
@class GameHost, GameWindow, GameViewController, GameView;

// Game components
@protocol IGameComponent, IUpdatable, IDrawable;
@class GameComponent, DrawableGameComponent, GameComponentCollection, GameComponentCollectionEventArgs;