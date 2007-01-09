From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.20-rc4 1/2] sata_promise: TX2plus PATA support
Date: Tue, 09 Jan 2007 05:16:08 -0500
Message-ID: <45A36B68.1080204@garzik.org>
References: <200701090950.l099oRPU011573@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33346 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbXAIKQK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Jan 2007 05:16:10 -0500
In-Reply-To: <200701090950.l099oRPU011573@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> @@ -271,6 +272,11 @@ static int pdc_port_start(struct ata_por
>  	struct pdc_port_priv *pp;
>  	int rc;
>  
> +	/* fix up port flags and cable type for SATA+PATA chips */
> +	ap->flags |= hp->port_flags[ap->port_no];
> +	if (ap->flags & ATA_FLAG_SATA)
> +		ap->cbl = ATA_CBL_SATA;
> +
>  	rc = ata_port_start(ap);
>  	if (rc)
>  		return rc;
> @@ -377,7 +383,7 @@ static void pdc_pata_phy_reset(struct at
>  
>  static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
>  {
> -	if (sc_reg > SCR_CONTROL)
> +	if (sc_reg > SCR_CONTROL || ap->cbl != ATA_CBL_SATA)
>  		return 0xffffffffU;
>  	return readl((void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
>  }
> @@ -386,7 +392,7 @@ static u32 pdc_sata_scr_read (struct ata
>  static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg,
>  			       u32 val)
>  {
> -	if (sc_reg > SCR_CONTROL)
> +	if (sc_reg > SCR_CONTROL || ap->cbl != ATA_CBL_SATA)
>  		return;
>  	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
>  }


It would be nice to see a [tested] follow-up patch that separates SATA 
and PATA into two separate sets of ata_port_operations hooks.  That 
should eliminate these 'ap->cbl' tests, and some other tests.

You should be able to set ap->ops in the same manner as you are setting 
the flags now.

	Jeff


