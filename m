From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] [libata] sata_mv: Remove PCI dependency
Date: Wed, 16 Jan 2008 05:01:57 -0500
Message-ID: <478DD615.1050309@garzik.org>
References: <11966101971581-git-send-email-saeed.bishara@gmail.com>	 <1196610199229-git-send-email-saeed.bishara@gmail.com>	 <47684270.5030405@garzik.org> <c70ff3ad0712250842n5c5383b1x2f53406fbf34dfb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53176 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbYAPKCA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Jan 2008 05:02:00 -0500
In-Reply-To: <c70ff3ad0712250842n5c5383b1x2f53406fbf34dfb5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>

saeed bishara wrote:
> -	if (unlikely(irq_stat & PCI_ERR)) {
> +	if (unlikely(irq_stat & PCI_ERR) && HAS_PCI(host)) {
>  		mv_pci_error(host, mmio);
>  		handled = 1;
>  		goto out_unlock;	/* skip all other HC irq handling */

the unlikely() should cover the entire expression.



>  static int __init mv_init(void)
>  {
> -	return pci_register_driver(&mv_pci_driver);
> +	int rc;
> +#ifdef CONFIG_PCI
> +	rc = pci_register_driver(&mv_pci_driver);
> +	if (rc)
> +		return rc;
> +#endif
> +	return 0;
>  }

I would do

{
	int rc = -ENODEV;

	#ifdef CONFIG_PCI
	rc = pci_register_driver(...);
	#endif

	return rc;
}

to ensure sane non-SoC, non-PCI behavior (which this patch now enables).

Finally, in Kconfig, even when removing the CONFIG_PCI dependency, the 
driver suddenly has other unsatified dependencies:  CONFIG_HAS_DMA and 
CONFIG_HAS_IOMEM.  Those two need to be added to the Kconfig dep list.

I would have made these minor corrections myself, but git-am (main 
kernel patch-apply tool, for git users) doesn't seem to like the patch:

Applying sata_mv: Remove PCI dependency

fatal: corrupt patch at line 59


