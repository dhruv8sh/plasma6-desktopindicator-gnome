import QtQuick
import org.kde.plasma.components
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid

Rectangle {
    id: container
    z: 5
    height: plasmoid.configuration.dotSizeCustom
    property int pos
    color: plasmoid.configuration.customColorsEnabled ? plasmoid.configuration.activeColor : Kirigami.Theme.highlightColor
    radius: height * 0.5
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        onClicked: pagerModel.changePage(pos)
        onContainsMouseChanged: {
            if( containsMouse ) container.opacity = 0.3
            else container.opacity = current == pos ? 1 : 0.5
        }
    }
    Behavior on x {
        NumberAnimation {
            duration: 300
        }
    }
    Behavior on y {
        NumberAnimation {
            duration: 300
        }
    }
    Behavior on width {
        NumberAnimation {
            duration: 300
        }
    }
    Behavior on height {
        NumberAnimation {
            duration: 300
        }
    }
    Behavior on opacity {
        NumberAnimation {
            duration: 300
        }
    }
    states: [
        State {
            name: "horizontalActive"
            when: isHorizontal && current == pos
            PropertyChanges{
                target: container
                y: (root.height - height)/2
                x: pos * (size+spacing)
                width: plasmoid.configuration.activeSizeW
                height: plasmoid.configuration.activeSizeH
                opacity: 1
            }
        },State {
            name: "horizontalInactive"
            when: isHorizontal && current != pos
            PropertyChanges{
                target: container
                y: (root.height - height)/2
                x: current < pos ? ((pos-1)*(size+spacing)) + plasmoid.configuration.activeSizeW + spacing : pos * (size+spacing)
                height: size
                width: size
                opacity: 0.5
            }
        },State {
            name: "verticalActive"
            when: !isHorizontal && current == pos
            PropertyChanges{
                target: container
                y: pos * (size+spacing)
                x: (root.width - width)/2
                width: plasmoid.configuration.activeSizeH
                height: plasmoid.configuration.activeSizeW
                opacity: 1
            }
        },State {
            name: "verticalInactive"
            when: !isHorizontal && current != pos
            PropertyChanges{
                target: container
                y : current < pos ? ((pos-1)*(size+spacing)) + plasmoid.configuration.activeSizeW + spacing : pos * (size+spacing)
                x: (root.width - width)/2
                width: size
                height: size
                opacity: 0.5
            }
        }
    ]
}
