From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11602] New: cdrom drive cannot open the tray, but reported this badly in /proc/sys/dev/cdrom/info
Date: Sat, 20 Sep 2008 10:58:21 -0700 (PDT)
Message-ID: <bug-11602-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50075 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750786AbYITR6X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Sep 2008 13:58:23 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8KHwMqb026781
	for <linux-ide@vger.kernel.org>; Sat, 20 Sep 2008 10:58:23 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11602

           Summary: cdrom drive cannot open the tray, but reported this
                    badly in /proc/sys/dev/cdrom/info
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.27-rc6
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: nm127@freemail.hu


Latest working kernel version:
Earliest failing kernel version:
Distribution: Debian
Hardware Environment: Clevo D410J + Optiarc DVD RW AD-7543A
Software Environment:
Problem Description:

The "Optiarc DVD RW AD-7543A" DVD-ROM drive is a slim drive and
cannot close the tray automatically once it was opened. I applied
a debug patch to drivers/ide/ide-cd.c to 2.6.27-rc6 which prints
out that the drive reports correctly that it cannot colose the tray:

[   12.133887] drivers/ide/ide-cd.c:1664: mechtype=1
[   12.133892] drivers/ide/ide-cd.c:1669: cdrom CANNOT close the tray
[   12.133895] hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
[   12.134224] drivers/ide/ide-cd.c:1922: cdi->mask=0x40010, (cdi->mask &
CDC_CLOSE_TRAY)=FALSE
[   12.134229] drivers/cdrom/cdrom.c:396: cdi->mask=0x40010, (cdi->mask &
CDC_CLOSE_TRAY)=FALSE
[   12.134232] Uniform CD-ROM driver Revision: 3.20
[   12.134288] drivers/cdrom/cdrom.c:410: cdi->mask=0x40010, (cdi->mask &
CDC_CLOSE_TRAY)=FALSE
[   12.134291] drivers/cdrom/cdrom.c:413: cdi->mask=0x40010, (cdi->mask &
CDC_CLOSE_TRAY)=FALSE
[   12.134296] drivers/cdrom/cdrom.c:447: cdi->mask=0x40010, (cdi->mask &
CDC_CLOSE_TRAY)=FALSE

However, when the "/proc/sys/dev/cdrom/info" is examined from the
userspace, the "Can close tray" field becomes "1" (expected: "0").

$ cat /proc/sys/dev/cdrom/info
CD-ROM information, Id: cdrom.c 3.20 2003/12/17

drive name:             hdc
drive speed:            24
drive # of slots:       1
Can close tray:         1
Can open tray:          1
Can lock tray:          1
Can change speed:       1
Can select disk:        0
Can read multisession:  1
Can read MCN:           1
Reports media changed:  1
Can play audio:         1
Can write CD-R:         1
Can write CD-RW:        1
Can read DVD:           1
Can write DVD-R:        1
Can write DVD-RAM:      1
Can read MRW:           1
Can write MRW:          1
Can write RAM:          1

$ cat /proc/ide/hdc/model
Optiarc DVD RW AD-7543A

Steps to reproduce:
1. Boot the system
2. cat /proc/sys/dev/cdrom/info


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
