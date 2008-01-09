From: "Daniel J Blueman" <daniel.blueman@gmail.com>
Subject: hdparm "unknown 206[12]" features and security...
Date: Wed, 9 Jan 2008 11:17:08 +0000
Message-ID: <6278d2220801090317g5afda292qd1a8e1a9a802a651@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:42258 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbYAILRM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 06:17:12 -0500
Received: by wa-out-1112.google.com with SMTP id v27so348185wah.23
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 03:17:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

Hi Mark,

I was looking at the features on a new 320GB 2.5" SATA2 disk and
finding the current hdparm 7.7 doesn't recognise a couple of features
[1]. I dumped the raw identify data [2], if it is of use.

Also, do you know what tools to use to set a drive password and unlock
the drive at boot-time, equivalent to what various laptop BIOSes
allow.

Thanks!
  Daniel

--- [1]

# ./hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
        Model Number:       WDC WD3200BEVT-22ZCT0
        Serial Number:      WD-WXEY07C86146
        Firmware Revision:  11.01A11
        Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA Rev 2.5
Standards:
        Supported: 8 7 6 5
        Likely used: 8
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  625142448
        device size with M = 1024*1024:      305245 MBytes
        device size with M = 1000*1000:      320072 MBytes (320 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, with device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0080)
        Recommended acoustic management value: 128, current value: 128
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
           *    Advanced Power Management feature set
                SET_MAX security extension
           *    Automatic Acoustic Management feature set
           *    48-bit Address feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    WRITE_{DMA|MULTIPLE}_FUA_EXT
           *    64-bit World wide name
           *    IDLE_IMMEDIATE with UNLOAD
           *    Segmented DOWNLOAD_MICROCODE
           *    SATA-I signaling speed (1.5Gb/s)
           *    SATA-II signaling speed (3.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Host-initiated interface power management
           *    Phy event counters
                DMA Setup Auto-Activate optimization
                Device-initiated interface power management
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT Long Sector Access (AC1)
           *    SCT LBA Segment Access (AC2)
           *    SCT Error Recovery Control (AC3)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
                unknown 206[12]
                unknown 206[13]
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
                supported: enhanced erase
        102min for SECURITY ERASE UNIT. 102min for ENHANCED SECURITY ERASE UNIT.
Checksum: correct

--- [2]

# hdparm --Istdout /dev/sda

/dev/sda:
427a 3fff c837 0010 0000 0000 003f 0000
0000 0000 2020 2020 2057 442d 5758 4559
3037 4338 3631 3436 0000 4000 0032 3131
2e30 3141 3131 5744 4320 5744 3332 3030
4245 5654 2d32 325a 4354 3020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4001 0000 0000 0007 3fff 0010
003f fc10 00fb 0110 ffff 0fff 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 001f 0706 0000 004c 0040
01fe 0000 746b 7f09 6163 7469 be09 6163
407f 0033 0033 0080 fffe 0000 8080 0000
0000 0000 0000 0000 eab0 2542 0000 0000
0000 0000 0000 0000 5001 4ee2 ab7b 1fe7
0000 0000 0000 0000 0000 0000 0000 4010
4010 0000 0000 0000 0000 0000 0000 0000
0021 0000 0000 0000 0000 169e 0000 0000
0000 0000 0000 0000 0000 0000 0004 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 303f 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 1518 0000 0000 0000 0000 100e 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0001 1000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 84a5
-- 
Daniel J Blueman
