From: Mark Lord <liml@rtr.ca>
Subject: Re: ata_std_qc_defer not good enough for FIS-based switching ?
Date: Mon, 28 Apr 2008 18:08:40 -0400
Message-ID: <48164AE8.4070106@rtr.ca>
References: <48163C5D.9050605@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1898 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965833AbYD1WIj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Apr 2008 18:08:39 -0400
In-Reply-To: <48163C5D.9050605@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> Tejun,
> 
> I've been trying to track down interrupt timeouts here with sata_mv,
> and I think I've found the problem
> 
> With a Marvell 7042 chip and a port-multiplier, the driver selects
> .qc_defer = ata_std_qc_defer, which is supposed to be correct for 
> FIS-based switching.
> 
> But.. There is a mix of NCQ and non-NCQ drives plugged into that PM,
> and ata_std_qc_defer() seems happy to mix things up by issuing NCQ commands
> to some ports while simultaneously sending non-NCQ commands to other ports.
> 
> Needless to say, this confuses the heck out of the hardware,
> which cannot tolerate non-NCQ commands in FIS-based switching mode,
> or NCQ commands in non FIS-based switching mode.
> 
> Are there controllers which *can* handle such a mix (ahci, sil24 ?)
> 
> So it looks like a I need a .qc_defer() function which examines all links
> from the common host port for activity, and then asks for command deferral
> when the new command has a different protocol than those that are 
> outstanding.
> 
> Weird that none of the other LLDs need this.  Or do they?
..

This seems (below) to work for sata_mv.  But I still wonder about other LLDs.


static int mv_qc_defer (struct ata_queued_cmd *qc)
{
	struct ata_link *link = qc->dev->link;
	struct ata_port *ap = link->ap;
	struct mv_port_priv *pp;
	int port_is_using_ncq;

	if (ap->nr_active_links == 0)
		return 0;
	pp = ap->private_data;
	port_is_using_ncq = ((pp->pp_flags & MV_PP_FLAG_NCQ_EN) != 0);
	if (qc->tf.protocol == ATA_PROT_NCQ) {
		if (port_is_using_ncq)
			return ata_std_qc_defer(qc);
	} else {
		if (!port_is_using_ncq)
			return sata_pmp_qc_defer_cmd_switch(qc);
	}
	return ATA_DEFER_LINK;
}
