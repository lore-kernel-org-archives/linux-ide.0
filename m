From: Russell Coker <ide@coker.com.au>
Subject: PATA on a SATA system doing PIO not DMA
Date: Tue, 15 Aug 2006 13:54:20 +1000
Message-ID: <200608151354.21359.ide@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sws.net.au ([61.95.69.6]:32455 "EHLO smtp.sws.net.au")
	by vger.kernel.org with ESMTP id S1752096AbWHODyY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Aug 2006 23:54:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id C91C161B0C
	for <linux-ide@vger.kernel.org>; Tue, 15 Aug 2006 13:54:22 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 31807-10 for <linux-ide@vger.kernel.org>;
	Tue, 15 Aug 2006 13:54:22 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 81A8361AFA
	for <linux-ide@vger.kernel.org>; Tue, 15 Aug 2006 13:54:22 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 8DFC3A86E9
	for <linux-ide@vger.kernel.org>; Tue, 15 Aug 2006 13:54:21 +1000 (EST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a Pentium-D machine with ICH7 chipset running the 64bit version of FC5 
that has one S-ATA disk and one P-ATA disk.  The S-ATA disk runs normally 
giving good performance while the P-ATA disk does about 1.5MB/s (PIO).

I have the drivers loaded in the initrd (can even have the root filesystem on 
the P-ATA disk).  The P-ATA disk in question ran at full speed on RHEL4 in a 
32bit Celeron machine and has run at full speed in a Pentium 4 machine 
running FC5.

Any ideas or suggestions for tests I should perform?  Below is the relevant 
section of dmesg output:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
Probing IDE interface ide1...
hdc: WDC WD3000JB-00KFA0, ATA DISK drive
hdd: BENQ DVD DD DW1640, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 512KiB
hdc: 586072368 sectors (300069 MB) w/8192KiB Cache, CHS=36481/255/63
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3
hdd: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
