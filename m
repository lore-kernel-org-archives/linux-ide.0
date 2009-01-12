From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12437] New: My DVD+\-RW ROM can not write any disc
Date: Mon, 12 Jan 2009 12:21:41 -0800 (PST)
Message-ID: <bug-12437-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35541 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750948AbZALUWL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jan 2009 15:22:11 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0CKLf3m032525
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2009 12:21:42 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12437

           Summary: My DVD+\-RW ROM can not write any disc
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.28
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: eiskalt.erwischt@mail.ru


Latest working kernel version: 2.27.9
Earliest failing kernel version:2.6.28
Distribution: Debian Lenny
Hardware Environment:Mb: ASUS M2N-X Plus, DVD+\-RW ROM - Optiarc DVD RW
AD-7191A
Software Environment:
Problem Description:
When i try to write data to any disk with my DVD-RW drive with k3b (or any
software) i get error message.
hdparm says:

negativ-pc:/home/negativ# hdparm /dev/hda

/dev/hda:
 IO_support    =  1 (32-bit)
 unmaskirq     =  1 (on)
 using_dma     =  1 (on)
 keepsettings  =  0 (off)
 readonly      =  0 (off)
 readahead     = 256 (on)
 HDIO_GETGEO failed: Inappropriate ioctl for device
negativ-pc:/home/negativ#

negativ-pc:/home/negativ# hdparm -tT /dev/hda

/dev/hda:
read() failed: Input/output error
 Timing buffered disk reads:  read() failed: Input/output error
BLKFLSBUF failed: Function not implemented
negativ-pc:/home/negativ# 


dmesg says:

Buffer I/O error on device hda, logical block 0
[  169.009426] hda: command error: status=0x51 { DriveReady SeekComplete Error
}
[  169.009433] hda: command error: error=0x54 { AbortedCommand
LastFailedSense=0x05 }
[  169.009436] ide: failed opcode was: unknown
[  169.026470] ATAPI device hda:
[  169.026473]   Error: Illegal request -- (Sense key=0x05)
[  169.026476]   Logical block address out of range -- (asc=0x21, ascq=0x00)
[  169.026478]   The failed "Read 10" packet command was: 
[  169.026479]   "28 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 "
[  169.026486] end_request: I/O error, dev hda, sector 0
[  169.026489] Buffer I/O error on device hda, logical block 0
[  246.268514] hda: UDMA/44 mode selected
[  246.426667] hda: CHECK for good STATUS
[  278.873509] cdrom: This disc doesn't have any tracks I recognize!
[  288.083056] hda: UDMA/44 mode selected
[  288.239993] hda: CHECK for good STATUS
[  295.690576] hda: UDMA/66 mode selected
[  355.321105] cdrom: This disc doesn't have any tracks I recognize!
[  380.169967] hda: command error: status=0x51 { DriveReady SeekComplete Error
}
[  380.169973] hda: command error: error=0x54 { AbortedCommand
LastFailedSense=0x05 }
[  380.169976] ide: failed opcode was: unknown
[  380.189576] ATAPI device hda:
[  380.189579]   Error: Illegal request -- (Sense key=0x05)
[  380.189582]   Logical block address out of range -- (asc=0x21, ascq=0x00)
[  380.189584]   The failed "Read 10" packet command was: 
[  380.189585]   "28 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 "
[  380.189591] end_request: I/O error, dev hda, sector 0
[  380.189594] Buffer I/O error on device hda, logical block 0
[  380.205187] hda: command error: status=0x51 { DriveReady SeekComplete Error
}
[  380.205191] hda: command error: error=0x54 { AbortedCommand
LastFailedSense=0x05 }
[  380.205194] ide: failed opcode was: unknown
/*............................................*/
[  893.801447] Buffer I/O error on device hda, logical block 0
[  893.801450] Buffer I/O error on device hda, logical block 1
[  893.801454] Buffer I/O error on device hda, logical block 2
[  893.801456] Buffer I/O error on device hda, logical block 3
[  893.801458] Buffer I/O error on device hda, logical block 4
[  893.801460] Buffer I/O error on device hda, logical block 5
[  893.801462] Buffer I/O error on device hda, logical block 6
[  893.801463] Buffer I/O error on device hda, logical block 7
[  893.801465] Buffer I/O error on device hda, logical block 8
[  893.801467] Buffer I/O error on device hda, logical block 9
[  893.802224] ide-cd: hda: tray open
[  893.802773] end_request: I/O error, dev hda, sector 256
[  893.803567] ide-cd: hda: tray open
[  893.804116] end_request: I/O error, dev hda, sector 0
[  896.907225] ide-cd: hda: tray open
[  896.907789] end_request: I/O error, dev hda, sector 0
[  896.908568] ide-cd: hda: tray open
[  896.909116] end_request: I/O error, dev hda, sector 0
[ 6373.797585] ide-cd: hda: tray open
[ 6373.798151] end_request: I/O error, dev hda, sector 0
[ 6373.798154] __ratelimit: 154 callbacks suppressed
[ 6373.798157] Buffer I/O error on device hda, logical block 0
[ 6373.798159] Buffer I/O error on device hda, logical block 1
[ 6373.798163] Buffer I/O error on device hda, logical block 2
[ 6373.798165] Buffer I/O error on device hda, logical block 3
[ 6373.798167] Buffer I/O error on device hda, logical block 4
[ 6373.798169] Buffer I/O error on device hda, logical block 5
[ 6373.798171] Buffer I/O error on device hda, logical block 6
[ 6373.798172] Buffer I/O error on device hda, logical block 7
[ 6373.798174] Buffer I/O error on device hda, logical block 8
[ 6373.798176] Buffer I/O error on device hda, logical block 9
[ 6373.798927] ide-cd: hda: tray open
[ 6373.799475] end_request: I/O error, dev hda, sector 256
[ 6373.800253] ide-cd: hda: tray open
[ 6373.800799] end_request: I/O error, dev hda, sector 0
[ 6376.807709] ide-cd: hda: tray open
[ 6376.808269] end_request: I/O error, dev hda, sector 0
[ 6376.809044] ide-cd: hda: tray open
[ 6376.809590] end_request: I/O error, dev hda, sector 0

I try to change udma mode to udma3 (hdparm -X67 /dev/hda) and change some BIOS
preferences, but it have no result. My DVD+/-RW ROM has no defects and i think
that is a kernel bug.
Steps to reproduce:


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
