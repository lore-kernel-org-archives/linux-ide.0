From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 43211] New: Pressing the DVD eject button renders the DVD-ROM
 unusable
Date: Sun, 6 May 2012 13:36:21 GMT
Message-ID: <bug-43211-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bugzilla.kernel.org ([198.145.19.204]:37702 "EHLO
	bugzilla.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab2EFNgW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 May 2012 09:36:22 -0400
Received: from bugzilla.kernel.org (localhost [127.0.0.1])
	by bugzilla.kernel.org (8.14.5/8.14.5) with ESMTP id q46DaLoO018645
	for <linux-ide@vger.kernel.org>; Sun, 6 May 2012 13:36:21 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=43211

           Summary: Pressing the DVD eject button renders the DVD-ROM
                    unusable
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 3.2.0-24-generic
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: kricsek@yahoo.com
        Regression: No


Created an attachment (id=73209)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=73209)
sudo lspci -vvnn

I'm using Ubuntu 12.04 with a Acer 4810TG laptop. This laptop has a DVD eject
hardware button which renders the DVD-ROM device unusable when it's pressed.

The "eject cdrom" command works if the button hasn't been pressed. But after
it's been pressed it does not work anymore:

$ eject cdrom
eject: tried to use `/dev/scd0' as device name but it is no block device
eject: unable to find or open device for: `cdrom'

The system has to be restarted to make the DVD-ROM work again.

Please see the attached dmesg-before.txt and dmesg-after.txt to see what's
happening when that button is pressed.

Also please take a look at the original bug report on Launchpad:
https://bugs.launchpad.net/ubuntu/+source/eject/+bug/412527
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/811464

WORKAROUNDS:

WORKAROUND #1: (should always work)
Instead of pressing the hardware button enter this command in the command line:
eject cdrom

WORKAROUND #2: (works for some people including me)
In the BIOS set SATA mode from AHCI to IDE.

WORKAROUND #3: (works for some people but not for me)
Use the noacpi kernel parameter.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
