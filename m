From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10216] New: kernel from different versions hangs with some CD/DVD drives
Date: Mon, 10 Mar 2008 10:38:07 -0700 (PDT)
Message-ID: <bug-10216-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47473 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752094AbYCJRi0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 13:38:26 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2AHcj7p019422
	for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 10:38:46 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10216

           Summary: kernel from different versions hangs with some CD/DVD
                    drives
           Product: IO/Storage
           Version: 2.5
     KernelVersion: all tried (2.4.* and 2.6.*)
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: lars.winterfeld@tu-ilmenau.de


Latest working kernel version: unknown
Earliest failing kernel version: 2.4
Distribution: all tried
Hardware Environment: notebook "Fujitsu Siemens Amilo Xa-2528", output from
`lspci -vvv` attached
Software Environment: n/a
Problem Description:
I want to report a problem with certain CD/DVD drives / controllers, which is
kernel-related as far as I can see. I came to face the problem on my new
notebook (Fujitsu Siemens Amilo Xa-2528). Although I tried the installation CDs
of different distributions (Gentoo, Ubuntu, DSL,...) with different
kernel-versions including some of the 2.4 and 2.6 series all failed to boot.
Here is part of the log:

Mar  7 20:51:59 (none) Freeing unused kernel memory: 376k freed
Mar  7 20:51:59 (none) ide-cd: cmd 0x5a timed out
Mar  7 20:51:59 (none) hda: irq timeout: status=0x58 { DriveReady SeekComplete
DataRequest }
Mar  7 20:51:59 (none) ide: failed opcode was: unknown
Mar  7 20:51:59 (none) hda: ATAPI CD-ROM drive, 0kB Cache
Mar  7 20:51:59 (none) Uniform CD-ROM driver Revision: 3.20
Mar  7 20:51:59 (none) hda: status error: status=0x58 { DriveReady SeekComplete
DataRequest }
Mar  7 20:51:59 (none) ide: failed opcode was: unknown
Mar  7 20:51:59 (none) hda: drive not ready for command
Mar  7 20:51:59 (none) hda: status error: status=0x58 { DriveReady SeekComplete
DataRequest }
Mar  7 20:51:59 (none) ide: failed opcode was: unknown
Mar  7 20:51:59 (none) hda: drive not ready for command

Last error messages are repetitiously outputted until the computer freezes /
hangs. By googleing the error-message I found that it is not a problem of my
computer alone. ( http://ubuntuforums.org/showthread.php?t=699244 ,
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/182996 ,
http://forums.gentoo.org/viewtopic-t-666680.html?sid=36e4b5379601abe70a5f2fc5420e1765
, ...)

As far as I can tell, the problem appears as soon as the CD/DVD drive is
accessed, which is of cause done by almost any linux installation or "live" CD.
So I tried a Gentoo-based boot-cd called "unattended gui" which does not mount
the cd filesystem (btw: kernel config
http://unattended-gui.sourceforge.net/wiki/index.php?title=Bootcd:kernel )

Once booted, I ran lspci telling me:
00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev f1)
00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller (rev f1)

The drive inside my notebook is recognized as "hda: Optiarc DVD RW AD-7540A,
ATAPI CD/DVD-ROM drive", but google tells me the problem (or similar) also
appears on "PHILIPS DVDR1660P1", "BENQ DVD DD DW1620", "LILITE-ON DVD
SOHD-16P6P9S", "RICOH CD-R/RW MP7040A" and other.

The pre-installed Windows Vista can read and write DVDs.

Some log (from the "unattended"...):
http://www.winterfeld.de/Lars/amalio/lspci-vvv
http://www.winterfeld.de/Lars/amalio/messages
http://www.winterfeld.de/Lars/amalio/dmesg
produced on this system:
http://www.winterfeld.de/Lars/amalio/cpuinfo
http://www.winterfeld.de/Lars/amalio/iomem
http://www.winterfeld.de/Lars/amalio/ioports
http://www.winterfeld.de/Lars/amalio/modules
http://www.winterfeld.de/Lars/amalio/scsi
http://www.winterfeld.de/Lars/amalio/uname-a


Since I also program in C, I took a look at some ide*.c files where I found the
error message, but I have no clue about how the kernel works. So, I would be
really grateful for any suggestions and if more information is needed, then
please just ask.

Lars

Steps to reproduce: boot problem...


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
