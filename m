From: <linux-ide@momail.e4ward.com>
Subject: Re: PIONEER DVD-RW DVRTD08 is disabled if there is no disc present
 at   boot time
Date: Mon, 22 Dec 2008 13:13:18 +0100
Message-ID: <1229947998.6045.10.camel@Thutmosis>
References: <1229894315.6931.17.camel@Thutmosis> <494EDDBE.3010306@shaw.ca>
	 <494F65C1.80602@kernel.org>
Reply-To: linux--ide-momail.e4ward.com-linux--ide-vger.kernel.org-CCE-pbwz-4@reply.e4ward.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e4ward.com ([70.85.31.73]:42992 "EHLO e4ward.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753848AbYLVMN0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Dec 2008 07:13:26 -0500
Received: from localhost ([127.0.0.1])
	by e4ward.com with smtp (Exim 4.63)
	id 1LEjf3-0006JS-CI
	for linux-ide@vger.kernel.org; Mon, 22 Dec 2008 07:13:25 -0500
In-Reply-To: <494F65C1.80602@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Am Montag, den 22.12.2008, 19:02 +0900 schrieb ein unbekannter Absender:
> Robert Hancock wrote:
> > linux-ide@momail.e4ward.com wrote:
> >> Hello,
> >> several Sony Vaio laptops seem to have the PIONEER DVD-RW DVRTD08 DVD/CD
> >> drive built in. This drive is available only when a disc is inserted
> >> during boot.
> >> when no disc is present, dmesg has
> >>
> >> [    3.715535] ata2: SATA max UDMA/133 abar m2048@0xd3e04000 port
> >> 0xd3e04180 irq 218
> >> [    4.368166] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >> [    4.380063] ata2.00: ATAPI: PIONEER DVD-RW  DVRTD08, 1.00, max UDMA/33
> >> [    9.380102] ata2.00: qc timeout (cmd 0xef)
> >> [    9.380112] ata2.00: failed to set xfermode (err_mask=0x4)
> >> [    9.700093] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >> [   19.712097] ata2.00: qc timeout (cmd 0xef)
> >> [   19.712105] ata2.00: failed to set xfermode (err_mask=0x4)
> >> [   19.712158] ata2: limiting SATA link speed to 1.5 Gbps
> >> [   19.712160] ata2.00: limiting speed to UDMA/33:PIO3
> >> [   20.032106] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> >> [   30.040084] ata2.00: qc timeout (cmd 0xef)
> >> [   30.040091] ata2.00: failed to set xfermode (err_mask=0x4)
> >> [   30.040144] ata2.00: disabled
> >> [   30.056102] ata2: hard resetting link
> >> [   30.376108] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> >> [   30.376114] ata2: EH complete
> >>
> >> when a disc is present, dmesg has
> >> [    3.804304] ata2: SATA max UDMA/133 irq_stat 0x00000040, cirq 219
> >> [    5.268599] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >> [    5.270213] ata2.00: ATAPI: PIONEER DVD-RW  DVRTD08, 1.00, max UDMA/33
> >> [    5.272217] ata2.00: configured for UDMA/33
> >>
> >> You'll find more details at
> >> http://ubuntuforums.org/showthread.php?p=6412465#post6412465
> >>
> >> Having read
> >> http://www.mail-archive.com/linux-ide@vger.kernel.org/msg06127.html I
> >> guess it is not OK for the device to timeout in response to 0xef.
> >> Still I would like to be able to use the drive without having to
> >> insert a CD at every boot. Is there any workaround? Can't the driver
> >> just treat
> >> repeated timeouts like it would treat an abort?
> > 
> > That case was a bit different in that it was a CompactFlash device
> > (which has some different rules, especially older ones), but there was
> > also a SATA-PATA bridge chip involved (which seems quite likely the case
> > here too since the drive reports UDMA33 maximum). This could be another
> > case of the bridge chip being broken. Set Features - Set Transfer Mode
> > is a mandatory command that all ATA devices must implement, and the
> > device really can't be used properly if it's not successful (for true
> > SATA devices it's mostly vestigial, but if there's any actual PATA
> > involved, it's required). It's rather bizarre that having a disc
> > inserted avoids the problem.
> 
> Aiee... these broken devices.  :-(
> 
> So, w/ a disk inserted, there's no error whatsoever?  
There's no error in dmesg output. But when I boot with a disk in the
drive, I get the following errors in the boot screen:
* Loading hardware devices
[23.927373] end_request: I/O error, dev sr0, sector 1431744
[23.927373] Buffer I/O error on device sr0, logical block 178968
and then several more with just a different number in the square
brackets. However, that does not seem to affect the operation of the
drive.
> Can you please
> post the output of "hdparm -I /dev/sr0"?

/dev/sr0:

ATAPI CD-ROM, with removable media
	Model Number:       PIONEER DVD-RW  DVRTD08                 
	Serial Number:      
	Firmware Revision:  1.00    
Standards:
	Likely used CD-ROM ATAPI-1
Configuration:
	DRQ response: 50us.
	Packet size: 12 bytes
Capabilities:
	LBA, IORDY(can be disabled)
	Buffer size: 64.0kB
	DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	Power Management feature set
	   *	PACKET command feature set
	   *	DEVICE_RESET command
	   *	NOP cmd
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	Host-initiated interface power management
	   *	Phy event counters
	    	Device-initiated interface power management
	   *	Software settings preservation



