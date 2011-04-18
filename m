From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot
 on parisc
Date: Mon, 18 Apr 2011 22:20:17 +0100
Message-ID: <20110418222017.4e77fe05@lxorguk.ukuu.org.uk>
References: <1303152147.7167.12.camel@mulgrave.site>
	<20110418205203.56bbdb14@lxorguk.ukuu.org.uk>
	<1303159802.7167.30.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33142 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752496Ab1DRVTV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Apr 2011 17:19:21 -0400
In-Reply-To: <1303159802.7167.30.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>

>	ata_port_desc(host->ports[i], "irq %d", pdev->irq);
> +		}
>  	} else if (legacy_mode) {
>  		if (!ata_port_is_dummy(host->ports[0])) {
>  			rc = devm_request_irq(dev, ATA_PRIMARY_IRQ(pdev),

This bit looks fine - in fact it's a nice clean up anyway

> +	}
> +	if (!(reg & ENPORT_SECONDARY)) {
> +		dev_printk(KERN_NOTICE, &pdev->dev, "Secondary port is disabled\n");
> +		ppi[1] = &ata_dummy_port_info;
> +	}

And you just broke split bridge setups. Also need to check if the bits
are valid for this chipset in native mode officialy - Sergei probably
knows the answer to that.

We can detect the Mobility electronics split bridges at least (and I
suspect they are the only 'common' CMD64x hot plug device indeed possibly
the only one) because the parent bridge of the CMD64x will have a PCI
vendor id of 0x14f2 and a device id 0x0001, 0x0002, or 0x0120.


Alan
