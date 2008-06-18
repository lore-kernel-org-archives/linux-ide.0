From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement	ATAPI_HORKAGE_NOPIO
 and apply it to GGW-H10N
Date: Wed, 18 Jun 2008 07:59:16 -0400
Message-ID: <4858F894.6030409@garzik.org>
References: <4857313A.1000405@kernel.org> <48573174.9050103@kernel.org> <20080617094354.338e186b@lxorguk.ukuu.org.uk> <48578080.5030605@kernel.org> <20080617095439.GA9359@lukeross.name> <20080617110450.668f37e2@lxorguk.ukuu.org.uk> <4857ADC3.3040106@kernel.org> <20080618114828.GB19903@lukeross.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59351 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754768AbYFRL72 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jun 2008 07:59:28 -0400
In-Reply-To: <20080618114828.GB19903@lukeross.name>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luke Ross <luke@lukeross.name>
Cc: Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Luke Ross wrote:
> Hi,
> 
> On Tue, Jun 17, 2008 at 09:27:47PM +0900, Tejun Heo wrote:
>> Alan Cox wrote:
>>>> Originally the drive was bought for a different PC with a Silicon Image
>>>> 3114 controller. The drive worked fine with this (sata_sil). Then I
>>> Ok that proves the point quite nicely. If there is a problem it is not
>>> the one suggested.
>> Yeah, indeed.  It's still weird tho.  The difference between
>> ATAPI_PROT_PIO and ATAPI_PROT_DMA is very small especially on ahci.  The
>> data are still transferred using the same FIS.  Only the completion
>> mechanism is different.  It would be great to try the drive on another
>> ahci controller preferably intel one.  Luke, do you have access to any
>> machine which has intel ahci?
> 
> I tried it out on a machine with an Intel ICH7 controller using the AHCI
> driver (using a Fedora 9 LiveCD). On the ICH7 the drive wrote a CD
> without issue, so possibly it's the drive/controller pair that causes
> the problem. I was careful to ensure I was using the ahci driver and not 
> the ata_piix driver.

I really think it's more generalized ATAPI brokenness, perhaps specific 
to AHCI.

I'm going to allocate some time to dig into this, if Tejun doesn't find 
the problem, because it's not just limited to a few models.  We've been 
getting _tons_ of timeout bug reports, and in fact, my own AHCI-based 
workstation cannot rip audio CDs at all:


ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part

	...

ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATAPI: PLEXTOR DVDR   PX-755A, 1.03, max UDMA/66
ata4.00: configured for UDMA/66

	...

scsi 3:0:0:0: CD-ROM            PLEXTOR  DVDR   PX-755A   1.03 PQ: 0 ANSI: 5

	...

ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata4.00: cmd a0/01:00:00:30:09/00:00:00:00:00/a0 tag 0 dma 2352 in
          cdb be 00 00 00 0d 6d 00 00  01 f8 00 00 00 00 00 00
          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata4.00: status: { DRDY }
ata4: soft resetting link
ata4: port is slow to respond, please be patient (Status 0xd0)
ata4: softreset failed (device not ready)
ata4: hard resetting link
ata4: port is slow to respond, please be patient (Status 0x80)
ata4: COMRESET failed (errno=-16)
ata4: hard resetting link
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/66
ata4: EH complete
scsi: unknown opcode 0xd4
scsi: unknown opcode 0xd5
scsi: unknown opcode 0xd8
