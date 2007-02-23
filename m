From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH]: pcmcia - spot slave decode flaws (for testing)
Date: Fri, 23 Feb 2007 05:44:48 -0500
Message-ID: <45DEC5A0.7050107@garzik.org>
References: <20070220181836.524e5f9a@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44982 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932217AbXBWKou (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Feb 2007 05:44:50 -0500
In-Reply-To: <20070220181836.524e5f9a@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan wrote:
> If you've got a CF adapter or PCMCIA disc which shows up twice in libata
> pata_pcmcia can you try this patch on top of the updates posted. It tries
> to spot when the slave is a mirror of the master and to fix up problems
> that causes.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-mm2/drivers/ata/pata_pcmcia.c linux-2.6.20-mm2/drivers/ata/pata_pcmcia.c
> --- linux.vanilla-2.6.20-mm2/drivers/ata/pata_pcmcia.c	2007-02-20 13:37:58.000000000 +0000
> +++ linux-2.6.20-mm2/drivers/ata/pata_pcmcia.c	2007-02-20 14:28:13.000000000 +0000
> @@ -54,6 +54,39 @@
>  	dev_node_t	node;
>  };
>  
> +/**
> + *	pcmcia_set_mode	-	PCMCIA specific mode setup
> + *	@ap: Port
> + *	@r_failed_dev: Return pointer for failed device
> + *
> + *	Perform the tuning and setup of the devices and timings, which
> + *	for PCMCIA is the same as any other controller. We wrap it however
> + *	as we need to spot hardware with incorrect or missing master/slave
> + *	decode, which alas is embarrassingly common in the PC world
> + */
> + 
> +static int pcmcia_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev)
> +{
> +	struct ata_device *master = &ap->device[0];
> +	struct ata_device *slave = &ap->device[1];
> +	
> +	if (!ata_dev_enabled(master) || !ata_dev_enabled(slave))
> +		return ata_do_set_mode(ap, r_failed_dev);
> +		
> +	if (memcmp(master->id + ATA_ID_FW_REV,  slave->id + ATA_ID_FW_REV,
> +			   ATA_ID_FW_REV_LEN + ATA_ID_PROD_LEN) == 0)
> +	{
> +		/* Suspicious match, but could be two cards from
> +		   the same vendor - check serial */
> +		if (memcmp(master->id + ATA_ID_SERNO, slave->id + ATA_ID_SERNO,
> +			   ATA_ID_SERNO_LEN) == 0 && master->id[ATA_ID_SERNO] >> 8) {
> +			ata_dev_printk(slave, KERN_WARNING, "is a ghost device, ignoring.\n");
> +			ata_dev_disable(slave);
> +		}	 
> +	}
> +	return ata_do_set_mode(ap, r_failed_dev);

Code looks OK. Not applied due to "for testing" note.

General comment:  it might be nice to do this in the core, just as a 
sanity check for a variety of problems, past, present and future.


