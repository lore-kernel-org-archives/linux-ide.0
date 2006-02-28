From: Sebastian Kuzminsky <seb@highlab.com>
Subject: what is hdparm doing?
Date: Tue, 28 Feb 2006 15:13:57 -0700
Message-ID: <E1FED6T-0004a4-LN@highlab.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sccrmhc13.comcast.net ([63.240.77.83]:55728 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932537AbWB1WL6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Feb 2006 17:11:58 -0500
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1FED6T-0004a4-LN
	for linux-ide@vger.kernel.org; Tue, 28 Feb 2006 15:13:57 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi folks, hdparm's got me confused.

I've got an old PC with an ALi Corporation MS4803 (rev 01) IDE controller.
According to the manufacturer, this controller does NOT support DMA,
only PIO 0-4.  I'm booting off various Sandisk Compact Flash cards,
which I believe all support both PIO and DMA.

I'm using hdparm 6.1, and I get practically identical results with 2.4.32
and 2.6.15.4.


"hdparm /dev/hda" says:

    /dev/hda:
     multcount    =  0 (off)
     IO_support   =  0 (default 16-bit)
     unmaskirq    =  0 (off)
     using_dma    =  0 (off)
     keepsettings =  0 (off)
     readonly     =  0 (off)
     readahead    =  8 (on)
     geometry     = 1986/16/63, sectors = 2001888, start = 0


"hdparm -I /dev/hda" says:

    CompactFlash ATA device, with removable media
            Model Number:       SanDisk SDCFH-1024
            Serial Number:      003305F1104P3318
            Firmware Revision:  HDX 2.18
    Standards:
            Supported: 10
            Likely used: 10
    Configuration:
            Logical         max     current
            cylinders       1986    1986
            heads           16      16
            sectors/track   63      63
            --
            CHS current addressable sectors:    2001888
            LBA    user addressable sectors:    2001888
            device size with M = 1024*1024:         977 MBytes
            device size with M = 1000*1000:        1024 MBytes (1 GB)
    Capabilities:
            LBA, IORDY(may be)(cannot be disabled)
            Queue depth: 1
            Standby timer values: spec'd by Vendor
            R/W multiple sector transfer: Max = 1   Current = 1
            DMA: mdma0 mdma1 *mdma2
                 Cycle time: min=120ns recommended=120ns
            PIO: pio0 pio1 pio2 pio3 pio4
                 Cycle time: no flow control=120ns  IORDY flow control=120ns


The "hdparm" output shows using_dma is off.  That's refering the the
HBA, right?

As I understand the "hdparm -I" output, however, it claims the drive
(not the HBA) is using mdma2.  Is that right?  How can the drive and
the HBA use different modes?

I thought the HBA and the drive(s) would automatically use the fastest
mode that both devices support, which in this case should be PIO4.

I tried to manually switch the HBA to pio4 with "hdparm -p4 /dev/hda"
but got this error:

    /dev/hda:
     attempting to set PIO mode to 4
     HDIO_SET_PIO_MODE failed: Function not implemented

Manually switching the drive to pio4 with "hdparm -X pio4 /dev/hda"
seems to work:

    /dev/hda:
     setting xfermode to 12 (PIO flow control mode4)

But even after running this, "hdparm -I /dev/hda" shows it using mdma2
(with the * by it).


BTW, here's the relevant part of dmesg, from 2.4.32:

    Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
    ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    hda: SanDisk SDCFH-1024, CFA DISK drive
    ide2: ports already in use, skipping probe
    ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    hda: attached ide-disk driver.
    hda: 2001888 sectors (1025 MB) w/1KiB Cache, CHS=1986/16/63
    Partition check:
     hda: hda1 hda2 hda3


Please clue in a poor monkey - what is going on here?


-- 
Sebastian Kuzminsky
