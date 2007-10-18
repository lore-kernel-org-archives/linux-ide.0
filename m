From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-sff: Correct use of check_status()
Date: Wed, 17 Oct 2007 20:58:50 -0400
Message-ID: <4716AFCA.4080509@garzik.org>
References: <20071015192529.2365b636@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33988 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757858AbXJRA6w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 20:58:52 -0400
In-Reply-To: <20071015192529.2365b636@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

Alan Cox wrote:
> ata_check_status() does an SFF compliant check
> ata_chk_status() does a generic call to ap->ops->check_status (usually
> ata_check_status)
> 
> libata-sff uses the wrong one. Hardly suprising given the naming here,
> which ought to get fixed to ata_sff_check_status() perhaps ?
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23-mm1/drivers/ata/libata-sff.c linux-2.6.23-mm1/drivers/ata/libata-sff.c
> --- linux.vanilla-2.6.23-mm1/drivers/ata/libata-sff.c	2007-10-15 15:03:26.000000000 +0100
> +++ linux-2.6.23-mm1/drivers/ata/libata-sff.c	2007-10-15 15:16:29.000000000 +0100
> @@ -156,7 +156,7 @@
>  {
>  	struct ata_ioports *ioaddr = &ap->ioaddr;
>  
> -	tf->command = ata_check_status(ap);
> +	tf->command = ata_chk_status(ap);
>  	tf->feature = ioread8(ioaddr->error_addr);
>  	tf->nsect = ioread8(ioaddr->nsect_addr);
>  	tf->lbal = ioread8(ioaddr->lbal_addr);

applied, with a sigh:  it's in SFF, so I saw nothing wrong with 
ata_check_status().  I checked -- no SFF driver overrides it according 
to my audit, therefore the previous version was faster while still correct.


