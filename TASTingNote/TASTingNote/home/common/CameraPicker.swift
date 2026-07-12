//
//  CameraPicker.swift.swift
//  TastingApp
//
//  Created by 佐々木 勇太 on 2026/07/12.
//
import SwiftUI

struct CameraPicker:
UIViewControllerRepresentable {

    @Environment(\.dismiss)
    private var dismiss

    @Binding var image: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(
        context: Context
    ) -> UIImagePickerController {

        let picker = UIImagePickerController()

        picker.sourceType = .camera
        picker.delegate = context.coordinator

        return picker
    }

    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: Context
    ) {
    }

    class Coordinator:
        NSObject,
        UINavigationControllerDelegate,
        UIImagePickerControllerDelegate {

        let parent: CameraPicker

        init(_ parent: CameraPicker) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [
                UIImagePickerController.InfoKey : Any
            ]
        ) {

            if let image =
                info[
                    .originalImage
                ] as? UIImage {

                parent.image = image
            }

            parent.dismiss()
        }

        func imagePickerControllerDidCancel(
            _ picker: UIImagePickerController
        ) {
            parent.dismiss()
        }
    }
}
