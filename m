From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC] sata_promise: handle TX2plus PATA locally
Date: Sun, 07 Jan 2007 20:38:56 -0500
Message-ID: <45A1A0B0.8060109@garzik.org>
References: <200701071832.l07IWHa2027464@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51439 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030377AbXAHBi7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Jan 2007 20:38:59 -0500
In-Reply-To: <200701071832.l07IWHa2027464@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Mikael Pettersson wrote:
> This is an RFC on a simpler and less intrusive way of setting
> up port flags on the mixed SATA/PATA Promise TX2plus chips.
> 
> The #promise-sata-pata branch requires libata core to be updated
> with a per-port flags array in the ata_probe_ent structure. I
> guess you don't approve of that solution.

Correct.

The long explanation:  struct ata_host/ata_port support different cable 
types and ata_port_operations sets.  Unfortunately, struct ata_probe_ent 
does a very poor job of making this capability available to drivers. 
The long term plan to support PATA+SATA combinations like sata_promise, 
sata_sis, sata_via etc. is to kill ata_probe_ent, and move to a 
commonly-understood probe+init model:  (1) allocate struct, (2) probe 
hardware and fill in struct, and (3) register struct with kernel 
subsystem.  Both net drivers and SCSI drivers use this model of API.


> This alternative patch is based on the observation that ap->flags
> isn't really used until after ->port_start() has been invoked.
> So this patch places the "exceptional" per-port flags array in
> the driver's private host structure, and uses it in ->port_start()
> to finalise the flags.

I agree with this approach, modulo a minor change...


> @@ -377,7 +383,7 @@ static void pdc_pata_phy_reset(struct at
>  
>  static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
>  {
> -	if (sc_reg > SCR_CONTROL)
> +	if ((sc_reg > SCR_CONTROL) || (ap->flags & ATA_FLAG_SLAVE_POSS))
>  		return 0xffffffffU;
>  	return readl((void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
>  }
> @@ -386,7 +392,7 @@ static u32 pdc_sata_scr_read (struct ata
>  static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg,
>  			       u32 val)
>  {
> -	if (sc_reg > SCR_CONTROL)
> +	if ((sc_reg > SCR_CONTROL) || (ap->flags & ATA_FLAG_SLAVE_POSS))
>  		return;
>  	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
>  }

Seems like a better test than ATA_FLAG_SLAVE_POSS would be to test the 
cable type.

	Jeff


