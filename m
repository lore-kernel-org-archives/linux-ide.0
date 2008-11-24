From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Resurrect IT8172 IDE controller driver
Date: Mon, 24 Nov 2008 09:55:10 +0000
Message-ID: <20081124095510.31cc990f@lxorguk.ukuu.org.uk>
References: <E1L4UpB-0007ro-1g@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37363 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751776AbYKXJzB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Nov 2008 04:55:01 -0500
In-Reply-To: <E1L4UpB-0007ro-1g@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane McDonald <mcdonald.shane@gmail.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> This patch resurrects the IT8172 IDE controller code.  I began with
> the 2.6.18 version of the it8172.c file, and have moved it forward so

This appears to be a PIIX clone, is it different enough to need its own
driver ?

> +static unsigned int __devinit init_chipset_it8172(struct pci_dev *dev)
> +{
> +	unsigned char progif;
> +
> +	/*
> +	 * Place both IDE interfaces into PCI "native" mode
> +	 */
> +	pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
> +	pci_write_config_byte(dev, PCI_CLASS_PROG, progif | 0x05);
> +
> +	return dev->irq;
> +}

NAK. You can't do this here any more. The PCI code now understands
'legacy' PCI IDE header types and resources so you must fix up the
resources as a PCI quirk early on in boot or you will leave bogus
resource assignments around.

Alan
