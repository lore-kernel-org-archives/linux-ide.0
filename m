From: "A.E.Lawrence" <A.E.Lawrence@lboro.ac.uk>
Subject: Primary ide disk inaccessible. 2.6.11.7, x86_64
Date: Sun, 24 Apr 2005 13:12:04 +0100
Message-ID: <426B8D14.9050408@lboro.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from weed.lut.ac.uk ([158.125.1.226]:39906 "EHLO weed.lut.ac.uk")
	by vger.kernel.org with ESMTP id S262311AbVDXMMn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Apr 2005 08:12:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

AMD64 FX, x86_64 architecture, 2.6.11.7 (and earlier)
-----------------------------------------------------

I have 4 sata, 1 scsi and 1 ata hard disks attached to an Asus A8N-SLI.
The primary ata disc (connected to ide0) is inaccessible:

NFORCE-CK804: 0000:00:06.0 (rev a2) UDMA133 controller
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: JTS Corporation CHAMPION MODEL C3000-3A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

But later:-

Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 0 sectors (0 MB) w/256KiB Cache, CHS=5824/16/63, DMA   <=======
hda: cache flushes not supported                            <=======

At some point when I was installing and running some sort of 2.6.n
debian installation kernel, the problem was not present: this disc was
mounted along with the others. But now with all the debian kernels that
I have tried, and my own builds of 2.6.7.11, the disc on ide0 cannot be
used.

There is a report with configurations and dmesg dumps etc here:
http://homepage.ntlworld.com/lawrence_a_e/report.txt

I have turned #DEBUG on in ide-disk.c although I suspect that the 
problem is elsewhere.

ael

