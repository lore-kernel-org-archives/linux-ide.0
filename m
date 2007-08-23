From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_marvell: Add another PCI identifier
Date: Thu, 23 Aug 2007 05:30:30 -0400
Message-ID: <46CD53B6.1000906@garzik.org>
References: <20070822232705.2decea96@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48525 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758561AbXHWJaf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Aug 2007 05:30:35 -0400
In-Reply-To: <20070822232705.2decea96@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_marvell.c linux-2.6.23rc3-mm1/drivers/ata/pata_marvell.c
> --- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_marvell.c	2007-08-22 17:23:00.000000000 +0100
> +++ linux-2.6.23rc3-mm1/drivers/ata/pata_marvell.c	2007-08-22 17:46:28.000000000 +0100
> @@ -190,7 +190,8 @@
>  
>  static const struct pci_device_id marvell_pci_tbl[] = {
>  	{ PCI_DEVICE(0x11AB, 0x6101), },
> -	{ PCI_DEVICE(0x11AB, 0x6145), },
> +	{ PCI_DEVICE(0x11AB, 0x6121), },
> +	{ PCI_DEVICE(0x11AB, 0x6123), },
>  	{ }	/* terminate list */

same question as with other poster:  where does 0x6145 go, and why?

Is this for -mm only?


