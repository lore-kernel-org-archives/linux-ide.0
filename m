From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot
 on parisc
Date: Wed, 20 Apr 2011 10:35:11 +0100
Message-ID: <20110420103511.2242577e@lxorguk.ukuu.org.uk>
References: <1303152147.7167.12.camel@mulgrave.site>
	<20110418205203.56bbdb14@lxorguk.ukuu.org.uk>
	<1303159802.7167.30.camel@mulgrave.site>
	<20110418222017.4e77fe05@lxorguk.ukuu.org.uk>
	<4DADF798.6010705@ru.mvista.com>
	<20110419221900.67528a07@lxorguk.ukuu.org.uk>
	<4DADFD2E.9070809@ru.mvista.com>
	<20110419222838.6a6f36aa@lxorguk.ukuu.org.uk>
	<1303254709.11237.34.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1303254709.11237.34.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

> +	struct pci_dev *bridge = pdev->bus->self;
> +	/* mobility split bridges don't report enabled ports correctly */
> +	int port_ok = !(bridge && bridge->vendor ==
> +			PCI_VENDOR_ID_MOBILITY_ELECTRONICS);
>  

The logic seems wrong even by inspection

port_ok will be 1 if it isn't a M/E bridge.

> +	/* check for enabled ports */
> +	pci_read_config_byte(pdev, CNTRL, &reg);
> +	if (port_ok)
> +		dev_printk(KERN_NOTICE, &pdev->dev, "Mobility Bridge detected, ignoring CNTRL port enable/disable\n");

If its *not* an ME bridge then print the warning ????


Otherwise looks right
