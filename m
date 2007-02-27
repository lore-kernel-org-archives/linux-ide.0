From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] sata_promise: intermittent errors bug hunting
Date: Tue, 27 Feb 2007 18:16:11 -0500
Message-ID: <45E4BBBB.90504@garzik.org>
References: <200702272225.l1RMPfSt021674@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55873 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbXB0XQO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Feb 2007 18:16:14 -0500
In-Reply-To: <200702272225.l1RMPfSt021674@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> +	if (hp->flags & PDC_FLAG_GEN_II) {
> +		/* record ASIC rev */
> +		pci_read_config_byte(pdev, PCI_REVISION_ID, &hp->asic_rev);
> +
> +#if 1
> +		/* set cache line size = 1 */
> +		pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &tmp);
> +		printk("%s: changing pci_cache_line_size from %#02x to 0x01\n",
> +		       __FUNCTION__, tmp);
> +		pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x01);
> +#endif


This bit strikes me as somewhat dubious.  If this proves to actually fix 
something, I would start by exporting pci_set_cacheline_size() in 
drivers/pci/pci.c, using it, and seeing if that helps.

	Jeff


