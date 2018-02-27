// Copyright (c) 2015 Ultimaker B.V.
// Uranium is released under the terms of the LGPLv3 or higher.

import QtQuick 2.1
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

import UM 1.2 as UM

UM.TooltipArea
{
    x: model.depth * UM.Theme.getSize("default_margin").width;
    text: model.description;

    width: childrenRect.width;
    height: childrenRect.height;

    CheckBox
    {
        id: check

        text: definition.label
        checked: addedSettingsModel.getVisible(model.key)

        onClicked:
        {
            // Important first set visible and then subscribe
            // otherwise the setting is not yet in list
            // For unsubscribe is important first remove the subscription and then
            // set as invisible
            if(checked)
            {
                addedSettingsModel.setVisible(model.key, checked);
                UM.ActiveTool.triggerAction("subscribeForSettingValidation", model.key)
            }
            else
            {
                UM.ActiveTool.triggerAction("unsubscribeForSettingValidation", model.key)
                addedSettingsModel.setVisible(model.key, checked);
            }
            UM.ActiveTool.forceUpdate();
        }
    }
}


