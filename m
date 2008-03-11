From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10225] New: 80-wire cable detection failed for SAMSUNG SP0822N
Date: Tue, 11 Mar 2008 12:22:11 -0700 (PDT)
Message-ID: <bug-10225-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57850 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752364AbYCKTWb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 15:22:31 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2BJMssr029020
	for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 12:22:56 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10225

           Summary: 80-wire cable detection failed for SAMSUNG SP0822N
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.25-rc4
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: haferfrost@web.de


Earliest failing kernel version:(tested with 2.6.24 and 2.6.25-rc4)
Problem Description:

hda: SAMSUNG SP0822N, ATA DISK drive
hda: drive side 80-wire cable detection failed, limiting max speed to UDMA33

I've seen that there are already several reports about erroneous failures of
the 80-wire cable detection, so I'm not sure if this one is useful, but the
message

ide_setup: ide0=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!

scares me a bit. I don't want to end up having my hard disk reduced to half
speed with no way to override it. Here's the data from my disk drive.

/dev/hda:

ATA device, with non-removable media
        Model Number:       SAMSUNG SP0822N                         
        Serial Number:      S06QJ10Y437166      
        Firmware Revision:  WA100-10
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 1 
        Supported: 7 6 5 4 & some of 7
Configuration:
        Logical         max     current
        cylinders       16383   4047
        heads           16      16
        sectors/track   63      255
        --
        CHS current addressable sectors:   16511760
        LBA    user addressable sectors:  156368016
        LBA48  user addressable sectors:  156368016
        device size with M = 1024*1024:       76351 MBytes
        device size with M = 1000*1000:       80060 MBytes (80 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 254, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
                SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
                NOP cmd
           *    DOWNLOAD_MICROCODE
                SET_MAX security extension
                Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    SMART error logging
           *    SMART self-test
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
                supported: enhanced erase
        50min for SECURITY ERASE UNIT. 50min for ENHANCED SECURITY ERASE UNIT.
Checksum: correct

/dev/hda:
045a 3fff c837 0010 7a8e 01f2 003f ffff
0000 0000 5330 3651 4a31 3059 3433 3731
3636 2020 2020 2020 0003 1000 0004 5741
3130 302d 3130 5341 4d53 554e 4720 5350
3038 3232 4e20 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0200 0007 0fcf 0010
00ff f310 00fb 0110 fc90 0951 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
00fe 001c 746b 5f01 4003 3468 1c01 4003
407f 0019 0019 0000 fffe 2008 fe00 0000
0000 0000 0000 0000 fc90 0951 0000 0000
0000 0000 0000 0000 50f0 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0021 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 bda5


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
