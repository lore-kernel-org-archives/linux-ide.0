From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_sis: FIFO whack
Date: Mon, 28 May 2007 18:01:53 -0400
Message-ID: <465B5151.4090504@garzik.org>
References: <20070525205024.2f83995d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48622 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490AbXE1WB6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 May 2007 18:01:58 -0400
In-Reply-To: <20070525205024.2f83995d@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
> If you are using a SiS controller and the BIOS didn't set it up then the
> FIFO may be left active when we try and set up the CD. Not convinced this
> matters but I'd prefer to be safe
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc2-mm1/drivers/ata/pata_sis.c linux-2.6.22-rc2-mm1/drivers/ata/pata_sis.c
> --- linux.vanilla-2.6.22-rc2-mm1/drivers/ata/pata_sis.c	2007-05-25 17:39:06.000000000 +0100
> +++ linux-2.6.22-rc2-mm1/drivers/ata/pata_sis.c	2007-05-25 18:22:21.000000000 +0100
> @@ -149,6 +149,9 @@
>  	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no]))
>  		return -ENOENT;
>  
> +	/* Clear the FIFO settings. We can't enable the FIFO until
> +	   we know we are poking at a disk */
> +	pci_write_config_byte(pdev, 0x4B, 0);
>  	return ata_std_prereset(ap, deadline);


Should I queue this into #upstream (2.6.23) or #upstream-fixes 
(2.6.22-rc) branch?

I lean towards #upstream since it is so late in the 2.6.22-rc cycle, 
because of your comment "Not convinced this matters".

	Jeff


