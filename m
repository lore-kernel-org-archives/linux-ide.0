From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH-RFC] Promise TX4 implement hw-bug workaround
Date: Sun, 28 Oct 2007 04:21:11 -0400
Message-ID: <47244677.6030909@garzik.org>
References: <200710030726.l937QXuV026661@harpo.it.uu.se>	<47035355.2040405@lxnt.info>	<135469746.20071017143929@zonnet.nl>	<47160601.80506@lxnt.info>	<1785297944.20071017170444@zonnet.nl>	<4717CB10.3080509@lxnt.info>	<471807DF.8010100@gmail.com>	<47191C3A.5040909@lxnt.info>	<47194497.3040101@gmail.com>	<471A783E.9060607@lxnt.info>	<47233C10.4020100@lxnt.info>	<472340D3.7090507@lxnt.info>	<47235646.6050202@lxnt.info> <20071027190916.5687fcaa@the-village.bc.nu> <47238104.4000601@lxnt.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47196 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbXJ1IVW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Oct 2007 04:21:22 -0400
In-Reply-To: <47238104.4000601@lxnt.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Sabourenkov <screwdriver@lxnt.info>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, MisterE <MisterE2002@zonnet.nl>, benh@kernel.crashing.org, jgarzik@pobox.com

Alexander Sabourenkov wrote:
> Alan Cox wrote:
>>> I can't think of a way to avoid second pass over scatterlist without
>>> duplicating code (ata_qc_prep() and ata_fill_sg() from libata-core.c).
>> This appears to be incomplete:
>>
> 
> [...]
> 
>> What guarantees you have enough PRD entries to do this without changing
>> the limit in the structures ?
>>
>> Otherwise looks good
> 
> PRD entries count is 256
> include/linux/ata.h:
> 	ATA_MAX_PRD		= 256,
> 	ATA_PRD_TBL_SZ          = (ATA_MAX_PRD * ATA_PRD_SZ),
> 
> drivers/ata/libata-core.c:
>  ap->prd = dmam_alloc_coherent(dev, ATA_PRD_TBL_SZ, &ap->prd_dma,
> 
> sata_promise Scsi_Host declares support for half of that:
> 
> include/linux/libata.h:
> LIBATA_MAX_PRD		= ATA_MAX_PRD / 2,
> 
> drivers/ata/sata_promise.c
>     .sg_tablesize           = LIBATA_MAX_PRD,

Alan's point was that the existing code will give you up to 
LIBATA_MAX_PRD entries.  After the post-virtual-merge splitting code in 
ata_fill_sg() executes, the worst case result is ATA_MAX_PRD entries.

Thus, since your code has the potential to increase the number of s/g 
entries above that, it can potentially corrupt memory, lock up the 
machine, all the wonderful things that can happen when you run off the 
end of the s/g list.

The fix is to decrease .sg_tablesize (LIBATA_MAX_PRD - 2 perhaps?) so 
that you guarantee this worst case never occurs, by guaranteeing that 
the system never sends you enough s/g entries to cause your code to go 
out of bounds.

	Jeff



