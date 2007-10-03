From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] pata_cs5536: ATA driver for Geode companion chip
Date: Wed, 03 Oct 2007 14:20:48 -0400
Message-ID: <4703DD80.4030307@garzik.org>
References: <yq14ph8xg3z.fsf@sermon.lab.mkp.net> <20071003192232.558ec72b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47127 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759252AbXJCSUv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 14:20:51 -0400
In-Reply-To: <20071003192232.558ec72b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Martin K. Petersen" <mkp@mkp.net>, linux-ide@vger.kernel.org, info-linux@geode.amd.com

Alan Cox wrote:
>> pata_cs5536.c relies on Geode Machine Specific Registers to configure
>> the ATA function and uses the correct PIO timings for the chip.
>>
>> Signed-off-by: Martin K. Petersen <mkp@mkp.net>
> 
> I'm basically happy with this but would appreciate some feedback from AMD
> on the subject.
> 
> (cc added therefore : info-linux@geode.amd.com)
> 
>> +	.qc_issue	= ata_qc_issue_prot,
> 
> The older AMD ex NS ex Cyrix chipsets mishandle 64K DMA blocks - is that
> the case for the CS5536 or not - does it consider a PRD entry with zero
> length as 64K or 0 bytes

Good point.


>> +	if ((cfg & IDE_CFG_CHANEN) == 0) {
>> +		printk(KERN_ERR "CS5536: disabled by BIOS\n");
> 
> To save Jeff whining - he'll want that to be DRV_NAME or similar and to
> call it pata_cs5536

Now I'm embarrassed... I looked over the driver and missed this ;-) ;-)

	Jeff


