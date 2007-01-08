From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [RFC] sata_promise: handle TX2plus PATA locally
Date: Mon, 8 Jan 2007 09:06:41 +0100 (MET)
Message-ID: <200701080806.l0886fZA001270@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:51300 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161182AbXAHIG5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Jan 2007 03:06:57 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Sun, 07 Jan 2007 20:38:56 -0500, Jeff Garzik wrote:
> > This alternative patch is based on the observation that ap->flags
> > isn't really used until after ->port_start() has been invoked.
> > So this patch places the "exceptional" per-port flags array in
> > the driver's private host structure, and uses it in ->port_start()
> > to finalise the flags.
> 
> I agree with this approach, modulo a minor change...

Excellent.

> > @@ -386,7 +392,7 @@ static u32 pdc_sata_scr_read (struct ata
> >  static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg,
> >  			       u32 val)
> >  {
> > -	if (sc_reg > SCR_CONTROL)
> > +	if ((sc_reg > SCR_CONTROL) || (ap->flags & ATA_FLAG_SLAVE_POSS))
> >  		return;
> >  	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
> >  }
> 
> Seems like a better test than ATA_FLAG_SLAVE_POSS would be to test the 
> cable type.

Agreed. This test is what #promise-sata-pata does now, but
I'll change it inspect the cable type instead.

/Mikael
