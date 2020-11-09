Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA41C2D0A3
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 22:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B58206CB
	for <linux-ide@archiver.kernel.org>; Mon,  9 Nov 2020 22:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgKIWeO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:34:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgKIWeO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 9 Nov 2020 17:34:14 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ide@vger.kernel.org
Subject: [Bug 205107] No HDD spindown/parking on shutdown
Date:   Mon, 09 Nov 2020 22:34:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo io_ide@kernel-bugs.osdl.org
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: IDE
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: amubtdx@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: io_ide@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205107-11633-Wfo7VtRjwu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205107-11633@https.bugzilla.kernel.org/>
References: <bug-205107-11633@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205107

--- Comment #19 from Alexis Murzeau (amubtdx@gmail.com) ---
I've done these tests (see attachment
harddisk_shutdown_tests_wd_elements_linux_5.9.tar.gz):
 - Powerup the computer without the hard disk connected
 - When in grub, at the same time as chossing Linux, connect the USB cable to
the computer
 - Wait console login prompt
 - Login as root, dump SMART data in "linux_harddrive_shutdown_smartdump1"
 - Power off the computer using "poweroff" command a root
 - The harddisk will emit a clearly ear-able "clic" sound

 - While the computer if OFF, unplug the hard disk (which is not powered
anymore because the computer is OFF)
 - Powerup the computer
 - Boot Linux
 - Wait console login prompt
 - Login as root
 - Plug the hard drive
 - Dump SMART data in
"linux_harddrive_shutdown_smartdump2_after_plug_while_kernelboot"
    - These SMART fields were incremented (beside Spin_Up_Time which changed
too but is probably unrelated to this issue):
      - Start_Stop_Count
      - Power_Cycle_Count
      - Power-Off_Retract_Count
      - Load_Cycle_Count
 - Power off the computer using "poweroff" command a root
 - The harddisk does not emit any clic sound when the computer powers off, and
just spin down

 - While the computer if OFF, unplug the hard disk (which is not powered
anymore because the computer is OFF)
 - Powerup the computer
 - Boot Linux
 - Wait console login prompt
 - Login as root
 - Plug the hard drive
 - Dump SMART data in
"linux_harddrive_shutdown_smartdump3_after_plug_after_console_login"
    - No SMART field was changed
 - Power off the computer using "poweroff" command a root
 - The harddisk does not emit any clic sound when the computer powers off, and
just spin down

 - While the computer if OFF, unplug the hard disk (which is not powered
anymore because the computer is OFF)
 - Powerup the computer
 - Boot Linux
 - Wait console login prompt
 - Login as root
 - Plug the hard drive (same test as previous boot)
 - Dump SMART data in
"linux_harddrive_shutdown_smartdump4_after_plug_after_console_login"
    - No SMART field was changed beside Spin_Up_Time
 - Spin down the hard drive using this command: "udisksctl power-off -b
/dev/sdb"
 - The hard disk spin down as expected
 - Unplug the hard disk
 - Plug the hard disk again
 - Dump SMART data in
"linux_harddrive_shutdown_smartdump5_after_udiskctl_poweroff"
    - These SMART fields were incremented beside Spin_Up_Time:
      - Start_Stop_Count
      - Power_Cycle_Count
      - Load_Cycle_Count

 - Spin down the hard drive using this command: "udisksctl power-off -b
/dev/sdb"
 - The hard disk spin down as expected
 - Unplug the hard disk
 - Poweroff the computer

 - Powerup the computer
 - When in grub, at the same time as chosing Linux, connect the USB cable to
the computer
 - Wait console login prompt
 - Login as root
 - Dump SMART data in
"linux_harddrive_shutdown_smartdump6_after_udiskctl_poweroff"
    - These SMART fields were incremented beside Spin_Up_Time:
      - Start_Stop_Count
      - Power_Cycle_Count
      - Load_Cycle_Count
 - Run this command with the apropriate path matching the hard disk:
    - echo 1 > /sys/devices/.../manage_start_stop
 - Power off the computer using "poweroff" command a root
 - The harddisk does not emit a "clic" sound

 - While the computer if OFF, unplug the hard disk (which is not powered
anymore because the computer is OFF)
 - Powerup the computer
 - Boot Linux
 - Wait console login prompt
 - Login as root
 - Plug the hard drive
 - Dump SMART data in
"linux_harddrive_shutdown_smartdump7_after_plug_before_kernelboot_and_enabling_manage_start_stop"
    - These SMART fields were incremented (beside Spin_Up_Time):
      - Start_Stop_Count
      - Power_Cycle_Count
      - Load_Cycle_Count
 - Run this command with the apropriate path matching the hard disk:
    - echo 1 > /sys/devices/.../manage_start_stop
 - Power off the computer using "poweroff" command a root
 - The harddisk does not emit any clic sound when the computer powers off, and
just spin down

 - While the computer if OFF, unplug the hard disk (which is not powered
anymore because the computer is OFF)
 - Powerup the computer
 - Boot Linux
 - Wait console login prompt
 - Login as root
 - Plug the hard drive
 - Dump SMART data in
"linux_harddrive_shutdown_smartdump8_after_plug_after_console_login_and_enabling_manage_start_stop"
    - These SMART fields were incremented (beside Spin_Up_Time and
Power_On_Hours):
      - Start_Stop_Count
      - Power_Cycle_Count
      - Load_Cycle_Count

 - Reboot the computer
 - Boot Windows
 - Dump SMART data in "linux_harddrive_shutdown_smartdump9_after_windows_boot"
(using smartctl for Windows)
    - These SMART fields were incremented (beside Temperature_Celsius):
      - Load_Cycle_Count
 - Shutdown Windows
 - When the computer is powered off, unplug the hard disk

 - Powerup the computer
 - Boot Linux
 - Wait console login prompt
 - Login as root
 - Plug the hard drive
 - Dump SMART data in
"linux_harddrive_shutdown_smartdump10_after_windows_shutdown"
    - These SMART fields were incremented (beside Spin_Up_Time and
Temperature_Celsius):
      - Start_Stop_Count
      - Power_Cycle_Count
      - Load_Cycle_Count

[... I've done a failed Windows VM boot test elided here]

 - Dump SMART data in
"linux_harddrive_shutdown_smartdump11_before_windows_VM_test"
 - On Linux host, modprobe usbmon and start wireshark to capture USB traffic
 - Boot a Windows VM (using Virtual Box) with USB pass-though for hard disk
 - Shutdown the Windows VM via its gui
 - Wait Windows VM to shutdown
 - Dump SMART data in
"linux_harddrive_shutdown_smartdump12_after_windows_VM_shutdown"
    - These SMART fields were incremented (beside Power_On_Hours):
      - Load_Cycle_Count
 - Save USB packet dump summary as
"linux_harddrive_shutdown_smartdump12_after_windows_VM_shutdown_usb_capture"
keeping only packets while the VM was running
    - At shutdown, there are only SCSI read/write USB packets (no SCSI spin
down command)

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
