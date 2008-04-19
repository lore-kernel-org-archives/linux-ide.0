From: Yann SLADEK <yann.sladek@free.fr>
Subject: Problems with 2.6.24 and ICH7 controller
Date: Sat, 19 Apr 2008 22:45:04 +0200
Message-ID: <480A59D0.8090106@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp6-g19.free.fr ([212.27.42.36]:48228 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755499AbYDSUpG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Apr 2008 16:45:06 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 8E90A5FE2E
	for <linux-ide@vger.kernel.org>; Sat, 19 Apr 2008 22:45:04 +0200 (CEST)
Received: from [192.168.0.13] (vel78-3-88-185-160-60.fbx.proxad.net [88.185.160.60])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 637575FD78
	for <linux-ide@vger.kernel.org>; Sat, 19 Apr 2008 22:45:04 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

Hi there,

I contact you because I encountered some issues regarding the 2.6.24 
kernel and my ICH7 controller.
I'm using an Asus P5W-DH with 2 hard drives plugged on the SATA port 1 
and 3 and a DVD writer on SATA port 4.
My Jmicron controller is disabled.
The problem appears since I've bought that motherboard but wasn't really 
a major issue (when using a 2.6.20, everything works fine, using a 
2.6.22 forced me to unplug my dvd writer to boot properly, now with 
2.6.24, my dvd writer is working but handles for a while on boot)

Here is the dmesg result :

42.029888] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
  [   42.029891] ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part 
  [   42.029895] PCI: Setting latency timer of device 0000:00:1f.2 to 64
  [   42.030045] scsi0 : ahci
  [   42.030159] scsi1 : ahci
  [   42.030927] scsi2 : ahci
  [   42.031006] scsi3 : ahci
  [   42.031029] ata1: SATA max UDMA/133 abar m1024@0xfebfb800 port 0xfebfb900 irq 219
  [   42.031031] ata2: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq 219
  [   42.031033] ata3: SATA max UDMA/133 abar m1024@0xfebfb800 port 0xfebfba00 irq 219
  [   42.031035] ata4: SATA max UDMA/133 abar m1024@0xfebfb800 port 0xfebfba80 irq 219
  [...]
  [   42.505023] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  [   42.552256] ata1.00: ATA-7: ST3320620AS, 3.AAK, max UDMA/133
  [   42.552258] ata1.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32)
  [   42.610461] ata1.00: configured for UDMA/133
*  [   43.487236] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  [   73.433023] ata2.00: qc timeout (cmd 0xec)
  [   73.433029] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x5)
  [   73.433031] ata2: failed to recover some devices, retrying in 5 secs
  [   83.935003] ata2: port is slow to respond, please be patient (Status 0x80)
  [   88.461808] ata2: COMRESET failed (errno=-16)
  [   89.160549] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  [   89.160616] ata2.00: ATA-6: Config  Disk, RGL10364, max UDMA/133
  [   89.160618] ata2.00: 640 sectors, multi 1: LBA 
  [   89.160622] ata2.00: device is on DMA blacklist, disabling DMA
  [   89.160693] ata2.00: configured for PIO4*
  [   89.471981] ata3: SATA link down (SStatus 0 SControl 300)
  [   89.947121] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  [   90.105746] ata4.00: ATAPI: HL-DT-ST DVDRAM GSA-H62N, CL00, max UDMA/100
  [   90.261657] ata4.00: configured for UDMA/100


As you can see, the second sata port handles the system for a while. The 
2nd port seems to be used as a bridge for the jmicron controller (I'm 
not sure about that).

But, this bug has been marked for being fixed on the kernel 2.6.23 
(http://bugzilla.kernel.org/show_bug.cgi?id=8923)

I configured the Controller for being in AHCI mode (dmesg printed 
above), I also tried in IDE standard with compatible mode but it doesn't 
boot in that mode.

I'd like to say I'm on an Ubuntu systems (Hardy RC) but this problem 
occurs with a compiled kernel 2.6.24, so I think it's not Ubuntu related)

My 2 drives :
Seagate HDD SATA2 ST3320620AS
WD HDD SATA2 WDC WD2500KS-00MJB0

So my final question is : as this bug has been maked as fixed in 2.6.24 
kernel, is my problem a new one or the patch has been applied later and 
I should wait ?

Don't hesitate to ask me further information and for more tests.
