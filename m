From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Keep shadow last_ctl up to date during resets
Date: Fri, 13 Mar 2009 14:58:01 -0400
Message-ID: <49BAACB9.2090007@garzik.org>
References: <49B65125.7030201@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51693 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbZCMS6H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Mar 2009 14:58:07 -0400
In-Reply-To: <49B65125.7030201@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stuart MENEFY <stuart.menefy@st.com>
Cc: linux-ide@vger.kernel.org

Stuart MENEFY wrote:
> libata keeps a shadow copy of the ATA CTL register (which is write only),
> and only writes to the hardware when the required value doesn't match
> the shadow. However this copy wasn't being maintained when performing
> reset functions. This could cause problems for the first operation after
> a reset when the correct value might not be written to the CTL register.
> 
> This problem was observed when hotplugging a drive: the identify command
> was being issued with interrupts enabled, when they should have been
> disabled.
> 
> Signed-off-by: Stuart Menefy <stuart.menefy@st.com>
> ---
>  linux-2.6/drivers/ata/libata-sff.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/ide/ide-dma-sff.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/libata-sff.c
> +++ linux-2.6/drivers/ata/libata-sff.c
> @@ -2066,6 +2066,7 @@ static int ata_bus_softreset(struct ata_
>  	iowrite8(ap->ctl | ATA_SRST, ioaddr->ctl_addr);
>  	udelay(20);	/* FIXME: flush */
>  	iowrite8(ap->ctl, ioaddr->ctl_addr);
> +	ap->last_ctl = ap->ctl;
> 
>  	/* wait the port to become ready */
>  	return ata_sff_wait_after_reset(&ap->link, devmask, deadline);
> @@ -2190,8 +2191,10 @@ void ata_sff_postreset(struct ata_link *
>  	}
> 
>  	/* set up device control */
> -	if (ap->ioaddr.ctl_addr)
> +	if (ap->ioaddr.ctl_addr) {
>  		iowrite8(ap->ctl, ap->ioaddr.ctl_addr);
> +		ap->last_ctl = ap->ctl;
> +	}
>  }
>  EXPORT_SYMBOL_GPL(ata_sff_postreset);
> 
> @@ -2534,6 +2537,7 @@ void ata_bus_reset(struct ata_port *ap)
>  	if (ap->flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST)) {
>  		/* set up device control for ATA_FLAG_SATA_RESET */
>  		iowrite8(ap->ctl, ioaddr->ctl_addr);
> +		ap->last_ctl = ap->ctl;
>  	}

applied, good catch!


