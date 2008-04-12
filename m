From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 1/2] pata_atiixp: simplex clear
Date: Sat, 12 Apr 2008 00:33:21 -0400
Message-ID: <48003B91.4070701@garzik.org>
References: <200803282133.m2SLXupx011467@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33823 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbYDLEdZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Apr 2008 00:33:25 -0400
In-Reply-To: <200803282133.m2SLXupx011467@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, Tejun Heo <htejun@gmail.com>

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> Some of the other quirks changes seem to have left some users with the simplex
> bits mis-set by the time the driver loads.  Clear simplex mode before we probe
> the controller therefore.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_atiixp.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/ata/pata_atiixp.c~pata_atiixp-simplex-clear drivers/ata/pata_atiixp.c
> --- a/drivers/ata/pata_atiixp.c~pata_atiixp-simplex-clear
> +++ a/drivers/ata/pata_atiixp.c
> @@ -22,7 +22,7 @@
>  #include <linux/libata.h>
>  
>  #define DRV_NAME "pata_atiixp"
> -#define DRV_VERSION "0.4.6"
> +#define DRV_VERSION "0.4.7"
>  
>  enum {
>  	ATIIXP_IDE_PIO_TIMING	= 0x40,
> @@ -243,6 +243,9 @@ static int atiixp_init_one(struct pci_de
>  		.port_ops = &atiixp_port_ops
>  	};
>  	const struct ata_port_info *ppi[] = { &info, NULL };
> +	/* Some of the quirk reconfiguration messes up the simplex
> +	   flag, so clear it again */
> +	ata_pci_clear_simplex(dev);
>  	return ata_pci_init_one(dev, ppi, &atiixp_sht, NULL);
>  }
>  
> @@ -279,7 +282,7 @@ static void __exit atiixp_exit(void)
>  }
>  
>  MODULE_AUTHOR("Alan Cox");
> -MODULE_DESCRIPTION("low-level driver for ATI IXP200/300/400");
> +MODULE_DESCRIPTION("low-level driver for ATI IXP series");
>  MODULE_LICENSE("GPL");
>  MODULE_DEVICE_TABLE(pci, atiixp);

Since I saw some automated akpm mail about this...  this patch is 
obsolete.  Needs ata_pci_bmdma_clear_simplex() at least.

Also, Tejun, you had some thoughts on this?

In current #upstream, we still call ata_pci_bmdma_clear_simplex() before 
pcim_enable_device() in some cases, so the problem remains...

	Jeff


