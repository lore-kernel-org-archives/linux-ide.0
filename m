From: <linux-ide@momail.e4ward.com>
Subject: Re: PIONEER DVD-RW DVRTD08 is disabled if there is no disc present
 at   boot time
Date: Wed, 24 Dec 2008 14:40:55 +0100
Message-ID: <1230126055.6430.17.camel@Thutmosis>
References: <1229894315.6931.17.camel@Thutmosis> <494EDDBE.3010306@shaw.ca>
	 <494F65C1.80602@kernel.org> <1229947998.6045.10.camel@Thutmosis>
	 <49505500.8080409@kernel.org>
Reply-To: linux--ide-momail.e4ward.com-linux--ide-vger.kernel.org-CD0-57es-4@reply.e4ward.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e4ward.com ([70.85.31.73]:50833 "EHLO e4ward.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbYLXN7o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Dec 2008 08:59:44 -0500
Received: from localhost ([127.0.0.1])
	by e4ward.com with smtp (Exim 4.63)
	id 1LFTz1-0002WE-OT
	for linux-ide@vger.kernel.org; Wed, 24 Dec 2008 08:41:08 -0500
In-Reply-To: <49505500.8080409@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hello,
I've tried the patch (thanks a lot for your help) and it works more or
less. 

More precisely:
when booting without a CD in the drive:
* no errors during the boot
* the drive is now active (that's a big plus)
* it can read about half the CDs that I insert (in a sample of ~7 audio
and data, burnt and pressed), I have tested no DVDs yet, and I haven't
burnt anything yet
* sudo hdparm -I /dev/sr0 now gives

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


* and the error log when a CD can't be read looks like this (dmesg tail)
[  227.213893] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE,SUGGEST_OK
[  227.213914] sr 1:0:0:0: [sr0] Sense Key : Medium Error [current] 
[  227.213926] Info fld=0x2e81
[  227.213930] sr 1:0:0:0: [sr0] Add. Sense: L-EC uncorrectable error
[  227.213942] end_request: I/O error, dev sr0, sector 47616
[  227.213954] Buffer I/O error on device sr0, logical block 5952
[  234.227424] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE,SUGGEST_OK
[  234.227446] sr 1:0:0:0: [sr0] Sense Key : Medium Error [current] 
[  234.227457] Info fld=0x2e81
[  234.227461] sr 1:0:0:0: [sr0] Add. Sense: L-EC uncorrectable error
[  234.227473] end_request: I/O error, dev sr0, sector 47616
[  234.227484] Buffer I/O error on device sr0, logical block 5952
[  241.163142] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE,SUGGEST_OK
[  241.163162] sr 1:0:0:0: [sr0] Sense Key : Medium Error [current] 
[  241.163173] Info fld=0x2e81
[  241.163177] sr 1:0:0:0: [sr0] Add. Sense: L-EC uncorrectable error
[  241.163189] end_request: I/O error, dev sr0, sector 47616
[  241.163200] Buffer I/O error on device sr0, logical block 5952
[  248.171706] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE,SUGGEST_OK
[  248.171726] sr 1:0:0:0: [sr0] Sense Key : Medium Error [current] 
[  248.171738] Info fld=0x2e81
[  248.171742] sr 1:0:0:0: [sr0] Add. Sense: L-EC uncorrectable error
[  248.171754] end_request: I/O error, dev sr0, sector 47616
[  248.171765] Buffer I/O error on device sr0, logical block 5952
[  255.183025] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE,SUGGEST_OK
[  255.183044] sr 1:0:0:0: [sr0] Sense Key : Medium Error [current] 
[  255.183056] Info fld=0x2e81
[  255.183060] sr 1:0:0:0: [sr0] Add. Sense: L-EC uncorrectable error
[  255.183072] end_request: I/O error, dev sr0, sector 47616
[  255.183083] Buffer I/O error on device sr0, logical block 5952
[  262.195902] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE,SUGGEST_OK
[  262.195920] sr 1:0:0:0: [sr0] Sense Key : Medium Error [current] 
[  262.195932] Info fld=0x2e81
[  262.195936] sr 1:0:0:0: [sr0] Add. Sense: L-EC uncorrectable error
[  262.195948] end_request: I/O error, dev sr0, sector 47616
[  262.195961] Buffer I/O error on device sr0, logical block 5952
[  269.198031] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE,SUGGEST_OK
[  269.198051] sr 1:0:0:0: [sr0] Sense Key : Medium Error [current] 
[  269.198063] Info fld=0x2e81
[  269.198067] sr 1:0:0:0: [sr0] Add. Sense: L-EC uncorrectable error
[  269.198079] end_request: I/O error, dev sr0, sector 47616
[  269.198090] Buffer I/O error on device sr0, logical block 5952
[  276.667490] sr 1:0:0:0: [sr0] Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE,SUGGEST_OK
[  276.667509] sr 1:0:0:0: [sr0] Sense Key : Medium Error [current] 
[  276.667521] Info fld=0x2e81
[  276.667525] sr 1:0:0:0: [sr0] Add. Sense: L-EC uncorrectable error
[  276.667536] end_request: I/O error, dev sr0, sector 47616
[  276.667547] Buffer I/O error on device sr0, logical block 5952

* When booting with a CD that doesn't work after an 'empty boot', I get
similar errors as before (and like the last pair of lines above), but
the CD can be read. When I insert another CD that didn't work after an
empty boot afterwards, it still doesn't work.

I guess that this is a state of things I can more or less live with
(unless you have a still better idea), I don't know whether the patch
should go in the trunk. Though it doesn't completely fix things, for me
it's better than before. Obviously, it would be best if the Pioneer
people fixed their broken firmware soon, which I hope they will.

Anyway, thank you very much for your help. With other OSs it's probably
not so easy to get developer support ;-)

Merry christmas,
Moritz



Am Dienstag, den 23.12.2008, 12:03 +0900 schrieb
linux-ide@vger.kernel.org:
> linux-ide@momail.e4ward.com wrote:
> > There's no error in dmesg output. But when I boot with a disk in the
> > drive, I get the following errors in the boot screen:
> > * Loading hardware devices
> > [23.927373] end_request: I/O error, dev sr0, sector 1431744
> > [23.927373] Buffer I/O error on device sr0, logical block 178968
> > and then several more with just a different number in the square
> > brackets. However, that does not seem to affect the operation of the
> > drive.
> 
> Does the attached patch fix the problem?  Please do some data
> integrity checks as it skips setxfermode on the drive.  If it's native
> SATA, it probably should be okay but still it's way out of the spec.
> 
> Thanks.
> 


