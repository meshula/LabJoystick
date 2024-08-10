//
//  JoystickOverlayView.swift
//  LabJoystick
//
//  Created by Domenico Porcino on 8/10/24.
//
import SwiftUI

struct JoystickOverlayView: View {
    @Binding var leftStickX: Float
    @Binding var leftStickY: Float
    @Binding var rightStickX: Float
    @Binding var rightStickY: Float
    @Binding var leftShoulder: Bool
    @Binding var rightShoulder: Bool
    @Binding var leftTrigger: Float
    @Binding var rightTrigger: Float
    @Binding var buttonA: Bool
    @Binding var buttonB: Bool
    @Binding var buttonX: Bool
    @Binding var buttonY: Bool
    @Binding var menuButton: Bool
    @Binding var startButton: Bool
    @Binding var leftThumbstickButton: Bool
    @Binding var rightThumbstickButton: Bool

    var body: some View {
        ZStack {
            VStack {
                // Menu and Start Buttons
                HStack {
                    Spacer()
                    Text("Menu: \(menuButton ? "Pressed" : "Released")")
                        .font(.caption)
                    Spacer()
                    Text("Start: \(startButton ? "Pressed" : "Released")")
                        .font(.caption)
                    Spacer()
                }
                .padding(.bottom, 10)

                // Shoulder Buttons
                HStack {
                    Text("L1: \(leftShoulder ? "Pressed" : "Released")")
                        .font(.caption)
                    Spacer()
                    Text("R1: \(rightShoulder ? "Pressed" : "Released")")
                        .font(.caption)
                }
                .padding(.bottom, 10)

                // ABXY Buttons
                HStack {
                    VStack(alignment: .leading) {
                        Text("X: \(buttonX ? "Pressed" : "Released")")
                        Text("Y: \(buttonY ? "Pressed" : "Released")")
                    }
                    .font(.caption)

                    Spacer()

                    VStack(alignment: .trailing) {
                        Text("A: \(buttonA ? "Pressed" : "Released")")
                        Text("B: \(buttonB ? "Pressed" : "Released")")
                    }
                    .font(.caption)
                }
                .padding(.bottom, 10)

                // Joystick Values
                HStack {
                    VStack {
                        Text("Left Stick")
                            .font(.caption)
                        Text("X: \(leftStickX, specifier: "%.2f")")
                        Text("Y: \(leftStickY, specifier: "%.2f")")
                        Text("Press: \(leftThumbstickButton ? "Pressed" : "Released")")
                            .font(.caption)
                    }
                    Spacer()
                    VStack {
                        Text("Right Stick")
                            .font(.caption)
                        Text("X: \(rightStickX, specifier: "%.2f")")
                        Text("Y: \(rightStickY, specifier: "%.2f")")
                        Text("Press: \(rightThumbstickButton ? "Pressed" : "Released")")
                            .font(.caption)
                    }
                }
                .padding(.bottom, 10)

                // Trigger Buttons
                HStack {
                    Text("L2: \(leftTrigger, specifier: "%.2f")")
                        .font(.caption)
                    Spacer()
                    Text("R2: \(rightTrigger, specifier: "%.2f")")
                        .font(.caption)
                }
            }
            .padding()
            .background(Color.black.opacity(0.5))
            .cornerRadius(10)
            .padding()
        }
        .foregroundColor(.white)
    }
}
