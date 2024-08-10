//
//  ContentView.swift
//  LabJoystick
//
//  Created by Domenico Porcino on 8/10/24.
//
import SwiftUI
import GameController

struct ContentView: View {
    @State private var isJoystickVisible: Bool = true

    @State private var leftStickX: Float = 0.0
    @State private var leftStickY: Float = 0.0
    @State private var rightStickX: Float = 0.0
    @State private var rightStickY: Float = 0.0
    @State private var leftShoulder: Bool = false
    @State private var rightShoulder: Bool = false
    @State private var leftTrigger: Float = 0.0
    @State private var rightTrigger: Float = 0.0
    @State private var buttonA: Bool = false
    @State private var buttonB: Bool = false
    @State private var buttonX: Bool = false
    @State private var buttonY: Bool = false
    @State private var menuButton: Bool = false
    @State private var startButton: Bool = false
    @State private var leftThumbstickButton: Bool = false
    @State private var rightThumbstickButton: Bool = false

    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()

            // Conditional overlay of JoystickOverlayView
            if isJoystickVisible {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            isJoystickVisible.toggle()
                        }) {
                            Text("Hide Joystick")
                                .font(.caption)
                                .padding(5)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(4)
                        }
                        .padding(.trailing, 10)
                    }
                    JoystickOverlayView(
                        leftStickX: .constant(0.0),
                        leftStickY: .constant(0.0),
                        rightStickX: .constant(0.0),
                        rightStickY: .constant(0.0),
                        leftShoulder: .constant(false),
                        rightShoulder: .constant(false),
                        leftTrigger: .constant(0.0),
                        rightTrigger: .constant(0.0),
                        buttonA: .constant(false),
                        buttonB: .constant(false),
                        buttonX: .constant(false),
                        buttonY: .constant(false),
                        menuButton: .constant(false),
                        startButton: .constant(false),
                        leftThumbstickButton: .constant(false),
                        rightThumbstickButton: .constant(false)
                    )
                    .background(Color.black.opacity(0.3))
                    Spacer()
                }
            }

            // Always display the "Show Joystick" button when the overlay is hidden
            if !isJoystickVisible {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            isJoystickVisible.toggle()
                        }) {
                            Text("Show Joystick")
                                .font(.caption)
                                .padding(5)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(4)
                        }
                        .padding(.trailing, 10)
                    }
                    Spacer()
                }
            }
        }
        .onAppear(perform: setupController)
    }

    func setupController() {
        NotificationCenter.default.addObserver(forName: .GCControllerDidConnect, object: nil, queue: .main) { _ in
            if let controller = GCController.controllers().first {
                controller.extendedGamepad?.valueChangedHandler = { gamepad, element in
                    self.leftStickX = gamepad.leftThumbstick.xAxis.value
                    self.leftStickY = gamepad.leftThumbstick.yAxis.value
                    self.rightStickX = gamepad.rightThumbstick.xAxis.value
                    self.rightStickY = gamepad.rightThumbstick.yAxis.value
                    self.leftShoulder = gamepad.leftShoulder.isPressed
                    self.rightShoulder = gamepad.rightShoulder.isPressed
                    self.leftTrigger = gamepad.leftTrigger.value
                    self.rightTrigger = gamepad.rightTrigger.value
                    self.buttonA = gamepad.buttonA.isPressed
                    self.buttonB = gamepad.buttonB.isPressed
                    self.buttonX = gamepad.buttonX.isPressed
                    self.buttonY = gamepad.buttonY.isPressed
                    self.menuButton = gamepad.buttonMenu.isPressed
                    self.startButton = ((gamepad.buttonOptions?.isPressed) != nil)
                    self.leftThumbstickButton = gamepad.leftThumbstickButton?.isPressed ?? false
                    self.rightThumbstickButton = gamepad.rightThumbstickButton?.isPressed ?? false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
