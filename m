From: Chase Venters <chase.venters@clientec.com>
Subject: System lockup due to ATA timeout (ICH6)
Date: Tue, 8 Nov 2005 20:36:47 -0600
Message-ID: <200511082037.09734.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay01.pair.com ([209.68.5.15]:22291 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1030344AbVKIChN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2005 21:37:13 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Greetings,
	I'm having some problems with ATA timeouts on my system. They will cause my 
system to go unresponsive and to lock up short moments later. I do have a 
serial console hooked up, so I'm able to capture what happens before the 
system dies:

ATA: abnormal status 0x80 on port 0x9807
ATA: abnormal status 0x80 on port 0x9807
ATA: abnormal status 0x80 on port 0x9807
ata2: command 0x25 timeout, stat 0x51 host_stat 0x61
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x04 { DriveStatusError }

	Here's the output of lspci:

0000:00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to 
I/O Controller (rev 04)
0000:00:01.0 PCI bridge: Intel Corporation 915G/P/GV/GL/PL/910GL PCI Express 
Root Port (rev 04)
0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
High Definition Audio Controller (rev 03)
0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
PCI Express Port 1 (rev 03)
0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
PCI Express Port 2 (rev 03)
0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #3 (rev 03)
0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #4 (rev 03)
0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB2 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
0000:00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC 
Interface Bridge (rev 03)
0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) IDE Controller (rev 03)
0000:00:1f.2 IDE interface: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW) SATA 
Controller (rev 03)
0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
SMBus Controller (rev 03)
0000:01:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A 
IEEE-1394a-2000 Controller (PHY/Link)
0000:01:04.0 Mass storage controller: Integrated Technology Express, Inc. 
IT/ITE8212 Dual channel ATA RAID controller (PCI version seems to be IT8212, 
embedded seems (rev 13)
0000:01:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 
07)
0000:01:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 07)
0000:01:0a.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 
Gigabit Ethernet Controller (rev 15)
0000:04:00.0 VGA compatible controller: nVidia Corporation: Unknown device 
0092 (rev a1)

	The kernel is 2.6.14. If .config is necessary, I'll supply it. I do see these 
messages occasionally:

ata2: error occurred, port reset
ata2: status=0x01 { Error }
ata2: error=0x04 { DriveStatusError }

	But they typically don't result in anything noticeably bad happening. Note 
that it doesn't just happen on ata2.

Cheers,
Chase Venters

