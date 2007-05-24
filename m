From: Florian Effenberger <florian@effenberger.org>
Subject: libata interface fatal error
Date: Thu, 24 May 2007 15:25:18 +0200
Message-ID: <4655923E.5000409@effenberger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from garfield.effenberger.org ([85.214.43.221]:50308 "EHLO
	garfield.effenberger.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756890AbXEXNcW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 09:32:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi there,

seems I've always subscribed to SATA problems. :-)

We installed Debian Etch with the pre-compiled kernel, but when doing 
heavy SATA data transfer, the drives seem to make trouble. Even with the 
latest kernel, 2.6.21.2, we receive:

===
ata3.00: exception Emask 0x10 SAct 0x1 SErr 0x400100 action 0x2 frozen
ata3.00: (irq_stat 0x08000000, interface fatal error)
ata3.00: cmd 61/80:00:00:91:91/00:00:1d:00:00/40 tag 0 cdb 0x0 data 
65536 out
          res 40/00:04:00:91:91/00:00:1d:00:00/40 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: configured for UDMA/133
ata3: EH complete
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
===

MD5 sums of copied files are right and we experience no other problems. 
Is this a driver bug? If so, can I be of any help in debugging it?

lspci gives:

===
00:00.0 Host bridge: Intel Corporation P965/G965 Memory Controller Hub 
(rev 02)
00:01.0 PCI bridge: Intel Corporation P965/G965 PCI Express Root Port 
(rev 02)
00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
#4 (rev 02)
00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
#5 (rev 02)
00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI 
#2 (rev 02)
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio 
Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 1 (rev 02)
00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 5 (rev 02)
00:1c.5 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 6 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
#1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
#2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
#3 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI 
#1 (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev f2)
00:1f.0 ISA bridge: Intel Corporation 82801HB/HR (ICH8/R) LPC Interface 
Controller (rev 02)
00:1f.2 SATA controller: Intel Corporation 82801HB (ICH8) SATA AHCI 
Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller 
(rev 02)
01:00.0 VGA compatible controller: nVidia Corporation Unknown device 
016a (rev a1)
03:00.0 Ethernet controller: Marvell Technology Group Ltd. Unknown 
device 4364 (rev 12)
04:00.0 SATA controller: JMicron Technologies, Inc. JMicron 20360/20363 
AHCI Controller (rev 02)
04:00.1 IDE interface: JMicron Technologies, Inc. JMicron 20360/20363 
AHCI Controller (rev 02)
05:01.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 
100] (rev 0c)
05:06.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 
IEEE-1394a-2000 Controller (PHY/Link)
===

Thanks
Florian
