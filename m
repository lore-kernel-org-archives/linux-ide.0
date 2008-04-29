From: Mark Lord <liml@rtr.ca>
Subject: Re: ata_std_qc_defer not good enough for FIS-based switching ?
Date: Tue, 29 Apr 2008 13:09:56 -0400
Message-ID: <48175664.5030702@rtr.ca>
References: <48163C5D.9050605@rtr.ca> <48164AE8.4070106@rtr.ca> <481659B5.7090703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3300 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753790AbYD2RJ6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 13:09:58 -0400
In-Reply-To: <481659B5.7090703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Tejun Heo wrote:
> Hello, Mark.
> 
> Mark Lord wrote:
>>> Are there controllers which *can* handle such a mix (ahci, sil24 ?)
> 
> Yeap, sil24 can.  ahci can currently only do device based switching but 
> ahci 2.0 can do it too.
> 
>>> So it looks like a I need a .qc_defer() function which examines all 
>>> links
>>> from the common host port for activity, and then asks for command 
>>> deferral
>>> when the new command has a different protocol than those that are 
>>> outstanding.
>>>
>>> Weird that none of the other LLDs need this.  Or do they?
> 
> So, none of the others needs this.
> 
>> This seems (below) to work for sata_mv.  But I still wonder about 
>> other LLDs.
..

Mmm.. Found another problem with sata_mv vs. the standard .qc_defer ops:
they don't prevent PIO commands from getting into the mix.

So now I have this in sata_mv, for all chip versions:

static int mv_qc_defer (struct ata_queued_cmd *qc)
{
	struct ata_link *link = qc->dev->link;
	struct ata_port *ap = link->ap;
	struct mv_port_priv *pp;

	/*
	 * If the port is completely idle, then allow the new qc.
	 */
	if (ap->nr_active_links == 0)
		return 0;
	/*
	 * If the port is not in host-queue mode (EDMA), then defer the new qc.
	 */
	pp = ap->private_data;
	if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN))
		return ATA_DEFER_PORT;

	if (pp->pp_flags & MV_PP_FLAG_NCQ_EN) {
		/*
		 * The host queue (EDMA) is in NCQ mode.
		 * If the new qc is also an NCQ command,
		 * then allow the new qc.
		 */
		if (qc->tf.protocol == ATA_PROT_NCQ)
			return 0;
	} else {
		/*
		 * The host queue (EDMA) is in non-NCQ, DMA mode.
		 * If the new qc is also a non-NCQ, DMA command,
		 * then allow the new qc.
		 */
		if (qc->tf.protocol == ATA_PROT_DMA)
			return 0;
	}
	return ATA_DEFER_PORT;
}


For the first time ever, I can now *heavily* mix PIO commands
with NCQ/non-NCQ DMA commands, to drives on an attached PM
(well, two attached PMs even), and the thing doesn't croak.
Woo-hoo!


Time to batch up some patches for Jeff.  But sadly, just in time
to have missed his weekly visit to linux-ide.  :)


I wonder if something like that is what bit sata_sil24 the other day
when I had it plugged in, mixing DMA, NCQ, and PIO commands to drives
on an attached PM?

Cheers
