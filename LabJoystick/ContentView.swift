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
    @State private var selectedController: GCController?
    @State private var availableControllers: [GCController] = []

    // Joystick state variables
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
                        
                        // Dropdown for selecting controller
                        if !availableControllers.isEmpty {
                            Menu {
                                ForEach(availableControllers, id: \.self) { controller in
                                    Button(action: {
                                        selectController(controller)
                                    }) {
                                        Text(controller.vendorName ?? "Unknown Controller")
                                    }
                                }
                            } label: {
                                Text(selectedController?.vendorName ?? "Select Controller")
                                    .font(.caption)
                                    .padding(5)
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(4)
                            }
                        }
                    }
                    JoystickOverlayView(
                        leftStickX: $leftStickX,
                        leftStickY: $leftStickY,
                        rightStickX: $rightStickX,
                        rightStickY: $rightStickY,
                        leftShoulder: $leftShoulder,
                        rightShoulder: $rightShoulder,
                        leftTrigger: $leftTrigger,
                        rightTrigger: $rightTrigger,
                        buttonA: $buttonA,
                        buttonB: $buttonB,
                        buttonX: $buttonX,
                        buttonY: $buttonY,
                        menuButton: $menuButton,
                        startButton: $startButton,
                        leftThumbstickButton: $leftThumbstickButton,
                        rightThumbstickButton: $rightThumbstickButton
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
                            Text(availableControllers.isEmpty ? "No Controllers Connected" : "Show Joystick")
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
        // Observe controller connection and disconnection
        NotificationCenter.default.addObserver(forName: .GCControllerDidConnect, object: nil, queue: .main) { _ in
            updateAvailableControllers()
        }
        
        NotificationCenter.default.addObserver(forName: .GCControllerDidDisconnect, object: nil, queue: .main) { _ in
            updateAvailableControllers()
        }

        // Initial setup
        updateAvailableControllers()
    }

    func updateAvailableControllers() {
        availableControllers = GCController.controllers()
        if availableControllers.isEmpty {
            selectedController = nil
        } else if selectedController == nil {
            selectController(availableControllers.first!)
        }
    }

    func selectController(_ controller: GCController) {
        selectedController = controller
        setupControllerBinding(for: controller)
    }

    func setupControllerBinding(for controller: GCController) {
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
            self.startButton = gamepad.buttonOptions?.isPressed ?? false
            self.leftThumbstickButton = gamepad.leftThumbstickButton?.isPressed ?? false
            self.rightThumbstickButton = gamepad.rightThumbstickButton?.isPressed ?? false
        }
    }
}

#Preview {
    ContentView()
}

#Preview {
    ContentView()
}
