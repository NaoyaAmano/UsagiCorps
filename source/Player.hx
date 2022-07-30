package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.util.FlxFSM;
import flixel.effects.FlxFlicker;
import flixel.input.FlxInput;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import js.html.Animation;

// This time for real.
class Player extends FlxSprite
{
	// Variables
	// Constants
	public static var onVictory:Bool = false;

	public var SPEED:Float = 180;
	public var JUMPSPEED:Float = 480;
	public var GRAVITY:Float = 16;
	public var FALLMULTIPLIER:Float = 3;

	public var MODE:String = "land";

	// Objects and Stuff
	public var walljumpCheckL:FlxSprite;
	public var walljumpCheckR:FlxSprite;
	public var fsm:FlxFSM<Player>;
	public var sPistolSound:FlxSound;

	// Primitives
	public var hDir:Float = 0;
	public var curState:Int = 0;
	public var onWallSlide:Bool = false;
	public var canWallJump:Bool = false;
	public var onControl:Bool = true;
	public var touchWall:Bool = false;
	public var jump:Bool = false;
	public var coyoteFrames:Int = 8;
	public var wallJumpFrames:Int = 10;
	public var firingStance:Bool = false;
	public var facingDir:Int = 1;
	public var onWallJump:Bool = false;
	public var onClimb:Bool = false;

	public var leftWallOverlap:Bool = false;
	public var rightWallOverlap:Bool = false;

	var zero:FlxVector = new FlxVector(0, 0);
	var inputVector:FlxVector = new FlxVector(0, 0);

	public var landSound:FlxSound;
	public var flightSound:FlxSound;
	public var climbSound:FlxSound;

	// Constructor

	public function new(x:Float, y:Float)
	{
		super(x, y - 32);

		loadGraphic("assets/images/usagi-sheet.png", true, 40, 40);

		animation.add("b-idle", [0, 1, 2, 3, 4], 12, true);
		animation.add("b-begin", [6], 12, false);
		animation.add("b-run", [7, 8], 12, true);
		animation.add("b-jump", [9], 12, false);
		animation.add("b-fall", [11], 12, false);
		animation.add("f-normal", [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22], 12, true);
		animation.add("c-idle", [23, 24, 25, 26, 27, 28], 12, true);
		animation.add("c-begin", [29], 12, false);
		animation.add("c-run", [30, 31], 12, true);
		animation.add("c-jump", [32], 12, false);
		animation.add("c-fall", [33], 12, false);
		animation.add("victory", [
			34, 35, 36, 37, 38, 39, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42,
			40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42,
			40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42,
			40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42, 40, 41, 42
		]);

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);

		// shader = new OutlineShader();

		landSound = new FlxSound();
		climbSound = new FlxSound();
		flightSound = new FlxSound();

		landSound = FlxG.sound.load("assets/music/land.wav", 0.04);
		climbSound = FlxG.sound.load("assets/music/climb.wav", 0.04);
		flightSound = FlxG.sound.load("assets/music/fly.wav", 0.04);

		fsm = new FlxFSM<Player>(this);

		fsm.transitions.add(LandIdling, LandStartRun, PConditions.startMoving)
			.add(LandIdling, LandJump, PConditions.onJump)
			.add(LandJump, LandFall, PConditions.onFall)
			.add(LandFall, LandIdling, PConditions.onGround)
			.add(LandStartRun, LandRun, PConditions.animationFinish)
			.add(LandRun, LandFall, PConditions.onFall)
			.add(LandRun, LandJump, PConditions.onJump)
			.add(LandRun, LandIdling, PConditions.stopMoving)
			.add(LandFall, FlightNormal, PConditions.turnFlight)
			.add(LandIdling, FlightNormal, PConditions.turnFlight)
			.add(LandJump, FlightNormal, PConditions.turnFlight)
			.add(LandRun, FlightNormal, PConditions.turnFlight)
			.add(LandStartRun, FlightNormal, PConditions.turnFlight)
			.add(LandFall, LandJump, PConditions.onJump)
			.add(FlightNormal, LandFall, PConditions.turnLand)
			.add(FlightNormal, ClimbFall, PConditions.turnClimb)
			.add(ClimbIdling, ClimbStartRun, PConditions.startMoving)
			.add(ClimbIdling, ClimbJump, PConditions.onJump)
			.add(ClimbJump, ClimbFall, PConditions.onFall)
			.add(ClimbFall, ClimbIdling, PConditions.onGround)
			.add(ClimbStartRun, ClimbRun, PConditions.animationFinish)
			.add(ClimbRun, ClimbFall, PConditions.onFall)
			.add(ClimbRun, ClimbJump, PConditions.onJump)
			.add(ClimbRun, ClimbIdling, PConditions.stopMoving)
			.add(ClimbIdling, LandFall, PConditions.turnLand)
			.add(ClimbJump, LandFall, PConditions.turnLand)
			.add(ClimbFall, LandFall, PConditions.turnLand)
			.add(ClimbStartRun, LandFall, PConditions.turnLand)
			.add(ClimbRun, LandFall, PConditions.turnLand)
			.add(ClimbIdling, FlightNormal, PConditions.turnFlight)
			.add(ClimbJump, FlightNormal, PConditions.turnFlight)
			.add(ClimbFall, FlightNormal, PConditions.turnFlight)
			.add(ClimbStartRun, FlightNormal, PConditions.turnFlight)
			.add(ClimbRun, FlightNormal, PConditions.turnFlight)
			.add(ClimbRun, FlightNormal, PConditions.turnFlight)
			.add(LandIdling, ClimbFall, PConditions.turnClimb)
			.add(LandIdling, ClimbFall, PConditions.turnClimb)
			.add(LandJump, ClimbFall, PConditions.turnClimb)
			.add(LandFall, ClimbFall, PConditions.turnClimb)
			.add(LandStartRun, ClimbFall, PConditions.turnClimb)
			.add(LandRun, ClimbFall, PConditions.turnClimb)
			.add(ClimbFall, ClimbRun, PConditions.onWall)
			.add(ClimbJump, ClimbRun, PConditions.onWall)
			.start(LandFall);

		setSize(26, 20);
		offset.set(9, 20);

		walljumpCheckR = new FlxSprite(x + 5, y).makeGraphic(6, 20, FlxColor.TRANSPARENT);
		walljumpCheckL = new FlxSprite(x - 5, y).makeGraphic(6, 20, FlxColor.TRANSPARENT);
	}

	override function update(elapsed:Float)
	{
		// Input
		pMovement();

		// Updating the State Machine

		fsm.update(elapsed);

		pAnimation();

		// Updating Physics

		physicsUpdate();

		super.update(elapsed);
	}

	public function physicsUpdate()
	{
		if (!onVictory)
		{
			switch (MODE)
			{
				case "land":
					if (onControl)
					{
						velocity.x = hDir * SPEED;
					}

					velocity.y += GRAVITY;

				case "climb":
					onClimb = (leftWallOverlap || rightWallOverlap);
					if (!onWallJump)
					{
						if (onControl)
						{
							velocity.x = hDir * SPEED * 0.8;
						}
					}

					if (!onClimb)
					{
						velocity.y += GRAVITY;
					}
			}
		}
		else
		{
			velocity.x = 0;
			curState = 11;
		}
	}

	public function pMovement()
	{
		var down:Bool = FlxG.keys.anyPressed([S, DOWN]);
		var up:Bool = FlxG.keys.anyPressed([W, UP]);

		// Input

		if (!onVictory)
		{
			switch (MODE)
			{
				case "land":
					/// ------ LAND MODE ------ ///
					// Checks

					// Handling Input

					angle = 0;
					setSize(26, 20);
					offset.set(9, 20);
					onClimb = false;
					horizontalControl();
					gravityControl(1);

					if (curState == 2)
						landSound.play();
					else
					{
						climbSound.stop();
						flightSound.stop();
						landSound.stop();
					}

				/// ----- END LAND MODE ----- ///

				/// --- START FLIGHT MODE --- ///

				case "flight":
					// Thanks Freya Holmer for this method
					inputVector = new FlxVector(0, 0);
					angle = 0;
					setSize(26, 34);
					offset.set(7, 6);
					onClimb = false;

					if (curState == 5)
						flightSound.play();
					else
					{
						climbSound.stop();
						flightSound.stop();
						landSound.stop();
					}

					applyInput([FlxKey.LEFT], new FlxVector(-1, 0));
					applyInput([FlxKey.RIGHT], new FlxVector(1, 0));
					applyInput([FlxKey.UP], new FlxVector(0, -1));
					applyInput([FlxKey.DOWN], new FlxVector(0, 1));

					if (FlxG.keys.pressed.RIGHT)
						facing = FlxObject.RIGHT;
					else if (FlxG.keys.pressed.LEFT)
						facing = FlxObject.LEFT;

					if (inputVector != zero)
					{
						moveTowards(inputVector);
					}

				/// ----- END FLIGHT MODE ----- ///

				/// ----- START CLIMB MODE ----- ///

				case "climb":
					if (!onClimb)
					{
						angle = 0;
						offset.set(9, 20);

						if (!onWallJump)
						{
							horizontalControl();
						}
						else if (onWallJump && wallJumpFrames > 0)
						{
							wallJumpFrames--;
						}
						else
						{
							onWallJump = false;
							wallJumpFrames = 10;
						}

						gravityControl(0.6);
					}
					else
					{
						if (leftWallOverlap)
						{
							angle = 90;
							offset.set(0, 15);
							if (up)
							{
								flipX = true;
							}
							if (down)
							{
								flipX = false;
							}
						}

						if (rightWallOverlap)
						{
							angle = 270;
							offset.set(15, 15);
							if (up)
							{
								flipX = false;
							}
							if (down)
							{
								flipX = true;
							}
						}

						if (FlxG.keys.justPressed.Z)
						{
							onWallJump = true;
							onClimb = false;

							if (leftWallOverlap)
							{
								velocity.set(SPEED * 1.5, -JUMPSPEED * 2);
							}
							else if (rightWallOverlap)
							{
								velocity.set(SPEED * -1.5, -JUMPSPEED * 2);
							}
						}

						if ((up || down) || (!up || !down))
						{
							velocity.y = 0;
						}
						if (up)
						{
							velocity.y = -SPEED;
						}
						if (down)
						{
							velocity.y = SPEED;
						}
					}
					if (curState == 8)
						climbSound.play();
					else
					{
						climbSound.stop();
						flightSound.stop();
						landSound.stop();
					}

					/// ----- END CLIMB MODE ----- ///
			}
		}
		else
		{
			velocity.x = 0;
		}
	}

	public function pAnimation()
	{
		switch curState
		{
			case 0:
				animation.play("b-idle");
			case 1:
				animation.play("b-begin");
			case 2:
				animation.play("b-run");
			case 3:
				animation.play("b-jump");
			case 4:
				animation.play("b-fall");
			case 5:
				animation.play("f-normal");
			case 6:
				animation.play("c-idle");
			case 7:
				animation.play("c-begin");
			case 8:
				animation.play("c-run");
			case 9:
				animation.play("c-jump");
			case 10:
				animation.play("c-fall");
			case 11:
				animation.play("victory");
		}
	}

	function moveTowards(dir:FlxVector)
	{
		dir.normalize();
		velocity.set(dir.x * SPEED, dir.y * SPEED);
	}

	function applyInput(key:Array<FlxKey>, dir:FlxVector)
	{
		if (FlxG.keys.anyPressed(key))
		{
			inputVector.add(dir.x, dir.y);
		}
	}

	function horizontalControl()
	{
		var left:Bool = FlxG.keys.anyPressed([A, LEFT]);
		var right:Bool = FlxG.keys.anyPressed([D, RIGHT]);

		if (onControl)
		{
			if (((left && right) || (!left && !right)))
			{
				hDir = 0;
			}
			else if (right)
			{
				facing = FlxObject.RIGHT;
				hDir = 1;
			}
			else if (left)
			{
				facing = FlxObject.LEFT;
				hDir = -1;
			}
		}
	}

	function gravityControl(delayer:Float)
	{
		jump = (FlxG.keys.justPressed.Z);

		if ((jump && (isTouching(FlxObject.FLOOR) || coyoteFrames > 0)))
		{
			velocity.y = -JUMPSPEED * delayer;
		}

		// Low Gravity Multiplier

		if (velocity.y < 0 && !FlxG.keys.pressed.Z)
		{
			velocity.y += GRAVITY * FALLMULTIPLIER;
		}

		// Coyote Check

		if (!isTouching(FlxObject.FLOOR))
		{
			coyoteFrames--;
			firingStance = false;
		}
		else
		{
			coyoteFrames = 8;
		}
	}
}

class PConditions
{
	public static function animationFinish(Owner:Player):Bool
	{
		return (Owner.animation.finished);
	}

	public static function startMoving(Owner:Player):Bool
	{
		return ((Owner.hDir != 0 && Owner.isTouching(FlxObject.FLOOR)) && !Owner.isTouching(FlxObject.WALL));
	}

	public static function stopMoving(Owner:Player):Bool
	{
		return (Owner.hDir == 0);
	}

	public static function onJump(Owner:Player):Bool
	{
		return (Owner.velocity.y < 0 && !Owner.onClimb);
	}

	public static function onFall(Owner:Player):Bool
	{
		return (Owner.velocity.y > 0 && !Owner.onClimb);
	}

	public static function onGround(Owner:Player):Bool
	{
		return (Owner.isTouching(FlxObject.FLOOR));
	}

	public static function onWall(Owner:Player):Bool
	{
		return (Owner.onClimb);
	}

	public static function turnFlight(Owner:Player):Bool
	{
		return (Owner.MODE == "flight");
	}

	public static function turnLand(Owner:Player):Bool
	{
		return (Owner.MODE == "land");
	}

	public static function turnClimb(Owner:Player):Bool
	{
		return (Owner.MODE == "climb");
	}
}

class LandIdling extends FlxFSMState<Player>
{
	override function enter(owner:Player, fsm:FlxFSM<Player>)
	{
		owner.curState = 0;
		super.enter(owner, fsm);
	}
}

class LandStartRun extends FlxFSMState<Player>
{
	override function enter(owner:Player, fsm:FlxFSM<Player>)
	{
		owner.curState = 1;
		super.enter(owner, fsm);
	}
}

class LandRun extends FlxFSMState<Player>
{
	override function enter(owner:Player, fsm:FlxFSM<Player>)
	{
		owner.curState = 2;
		super.enter(owner, fsm);
	}
}

class LandJump extends FlxFSMState<Player>
{
	override function enter(owner:Player, fsm:FlxFSM<Player>)
	{
		owner.curState = 3;
		super.enter(owner, fsm);
	}
}

class LandFall extends FlxFSMState<Player>
{
	override function enter(owner:Player, fsm:FlxFSM<Player>)
	{
		owner.curState = 4;
		super.enter(owner, fsm);
	}
}

class FlightNormal extends FlxFSMState<Player>
{
	override function enter(owner:Player, fsm:FlxFSM<Player>)
	{
		owner.curState = 5;
		super.enter(owner, fsm);
	}
}

class ClimbIdling extends FlxFSMState<Player>
{
	override function enter(owner:Player, fsm:FlxFSM<Player>)
	{
		owner.curState = 6;
		super.enter(owner, fsm);
	}
}

class ClimbStartRun extends FlxFSMState<Player>
{
	override function enter(owner:Player, fsm:FlxFSM<Player>)
	{
		owner.curState = 7;
		super.enter(owner, fsm);
	}
}

class ClimbRun extends FlxFSMState<Player>
{
	override function enter(owner:Player, fsm:FlxFSM<Player>)
	{
		owner.curState = 8;
		super.enter(owner, fsm);
	}
}

class ClimbJump extends FlxFSMState<Player>
{
	override function enter(owner:Player, fsm:FlxFSM<Player>)
	{
		owner.curState = 9;
		super.enter(owner, fsm);
	}
}

class ClimbFall extends FlxFSMState<Player>
{
	override function enter(owner:Player, fsm:FlxFSM<Player>)
	{
		owner.curState = 10;
		super.enter(owner, fsm);
	}
}
