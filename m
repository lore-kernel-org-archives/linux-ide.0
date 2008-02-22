From: Daniel Schroeder <sec@dschroeder.info>
Subject: [MCP-55] IDE problem after bios update
Date: Fri, 22 Feb 2008 20:57:54 +0100
Message-ID: <47BF2942.90901@dschroeder.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.183]:61965 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114AbYBVT57 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2008 14:57:59 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by isla-magica.localdomain (Postfix) with ESMTP id 7EF63F42C0
	for <linux-ide@vger.kernel.org>; Fri, 22 Feb 2008 20:57:54 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hi there,

this is an asus m2n32-sli deluxe with nvidia chipset. After updating the 
bios from 1503 to 1701 following in dmesg, and ide drive doesn't work.
Kernel is 2.6.24.2
<dmesg>
..snip...
Feb 21 22:37:02 isla-magica Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
Feb 21 22:37:02 isla-magica ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
Feb 21 22:37:02 isla-magica NFORCE-MCP55: IDE controller (0x10de:0x036e 
rev 0xa1) at  PCI slot 0000:00:0c.0
Feb 21 22:37:02 isla-magica NFORCE-MCP55: not 100% native mode: will 
probe irqs later
Feb 21 22:37:02 isla-magica NFORCE-MCP55: 0000:00:0c.0 (rev a1) UDMA133 
controller
Feb 21 22:37:02 isla-magica ide0: BM-DMA at 0xf400-0xf407, BIOS 
settings: hda:DMA, hdb:DMA
Feb 21 22:37:02 isla-magica NFORCE-MCP55: IDE port disabled
Feb 21 22:37:02 isla-magica Probing IDE interface ide0...
Feb 21 22:37:02 isla-magica hda: PLEXTOR DVDR PX-740A, ATAPI CD/DVD-ROM 
drive
Feb 21 22:37:02 isla-magica hda: host max PIO5 wanted PIO255(auto-tune) 
selected PIO4
Feb 21 22:37:02 isla-magica hda: UDMA/33 mode selected
Feb 21 22:37:02 isla-magica ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 21 22:37:02 isla-magica hda: lost interrupt
Feb 21 22:37:02 isla-magica hda: task_in_intr: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Feb 21 22:37:02 isla-magica hda: task_in_intr: error=0x00 { }
Feb 21 22:37:02 isla-magica ide: failed opcode was: 0xa1
Feb 21 22:37:02 isla-magica Probing IDE interface ide1...
Feb 21 22:37:02 isla-magica hda: status error: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Feb 21 22:37:02 isla-magica hda: status error: error=0x00 { }
Feb 21 22:37:02 isla-magica ide: failed opcode was: unknown
Feb 21 22:37:02 isla-magica hda: drive not ready for command
Feb 21 22:37:02 isla-magica hda: ATAPI CD-ROM drive, 0kB Cache
Feb 21 22:37:02 isla-magica Uniform CD-ROM driver Revision: 3.20
Feb 21 22:37:02 isla-magica hda: status error: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Feb 21 22:37:02 isla-magica hda: status error: error=0x00 { }
Feb 21 22:37:02 isla-magica ide: failed opcode was: unknown
Feb 21 22:37:02 isla-magica hda: drive not ready for command
Feb 21 22:37:02 isla-magica hda: status error: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Feb 21 22:37:02 isla-magica hda: status error: error=0x00 { }
Feb 21 22:37:02 isla-magica ide: failed opcode was: unknown
Feb 21 22:37:02 isla-magica hda: drive not ready for command
Feb 21 22:37:02 isla-magica hda: status error: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Feb 21 22:37:02 isla-magica hda: status error: error=0x00 { }
Feb 21 22:37:02 isla-magica ide: failed opcode was: unknown
Feb 21 22:37:02 isla-magica hda: drive not ready for command
Feb 21 22:37:02 isla-magica hda: status error: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Feb 21 22:37:02 isla-magica hda: status error: error=0x00 { }
Feb 21 22:37:02 isla-magica ide: failed opcode was: unknown
Feb 21 22:37:02 isla-magica hda: drive not ready for command
Feb 21 22:37:02 isla-magica hda: status error: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Feb 21 22:37:02 isla-magica hda: status error: error=0x00 { }
Feb 21 22:37:02 isla-magica ide: failed opcode was: unknown
Feb 21 22:37:02 isla-magica hda: drive not ready for command
Feb 21 22:37:02 isla-magica hda: status error: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Feb 21 22:37:02 isla-magica hda: status error: error=0x00 { }
Feb 21 22:37:02 isla-magica ide: failed opcode was: unknown
Feb 21 22:37:02 isla-magica hda: drive not ready for command
Feb 21 22:37:02 isla-magica hda: status error: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Feb 21 22:37:02 isla-magica hda: status error: error=0x00 { }
Feb 21 22:37:02 isla-magica ide: failed opcode was: unknown
Feb 21 22:37:02 isla-magica hda: drive not ready for command
Feb 21 22:37:02 isla-magica Driver 'sd' needs updating - please use 
bus_type methods
Feb 21 22:37:02 isla-magica Driver 'sr' needs updating - please use 
bus_type methods
Feb 21 22:37:02 isla-magica sata_sil24 0000:02:00.0: version 1.1
...snip...
</dmesg>

tia
daniel
