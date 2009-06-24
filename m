From: Saeed Bishara <saeed@marvell.com>
Subject: Re: [PATCH 1/3] sata_mv: increase PIO IORDY timeout
Date: Wed, 24 Jun 2009 13:23:41 +0300 (IDT)
Message-ID: <alpine.DEB.2.00.0906241135270.31324@ubuntu-saeed.il.marvell.com>
References: <1245771838-1332-1-git-send-email-saeed@marvell.com> <4A41E4C4.7050508@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host2.marvell.com ([65.219.4.2]:20638 "EHLO maili.marvell.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751460AbZFXKXk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Jun 2009 06:23:40 -0400
In-Reply-To: <4A41E4C4.7050508@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "liml@rtr.ca" <liml@rtr.ca>, "saeed.bishara@gmail.com" <saeed.bishara@gmail.com>



On Wed, 24 Jun 2009, Jeff Garzik wrote:

> Saeed Bishara wrote:
> > The old value (0xbc) in cycles of the IORDY timeout is suitable for
> > devices with core clock of 166 MHz, but some SoC controllers have
> > faster core clocks. The new value will make the IORDY timeout large
> > enough also for all SoC devices.
> >
> > Signed-off-by: Saeed Bishara <saeed@marvell.com>
> > ---
> >  drivers/ata/sata_mv.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> > index 23714ae..644436e 100644
> > --- a/drivers/ata/sata_mv.c
> > +++ b/drivers/ata/sata_mv.c
> > @@ -3368,7 +3368,7 @@ static void mv_soc_reset_hc_port(struct mv_host_priv *hpriv,
> >       ZERO(0x024);            /* respq outp */
> >       ZERO(0x020);            /* respq inp */
> >       ZERO(0x02c);            /* test control */
> > -     writel(0xbc, port_mmio + EDMA_IORDY_TMOUT);
> > +     writel(0x800, port_mmio + EDMA_IORDY_TMOUT);
>
> Do we really want to increase the timeout for older devices?  How does
> this change behavior for existing devices?
This patch affects only soc devices, the 0xbc value sets the IORDY timeout
to 1.25 micro seconds when the core clock is 150MHz (not 166MHz as I
mentioned in the commit's message). This timeout defines the maximum time
the cpu will be held when reading the PIO data register and no data is
available. Sata devices usually fine with timeout, this means that
during PIO data fises, the device will send the data dword within 1.25
micro seconds from the last one.

Recent Marvell soc devices uses higher core clocks (e.g. 200MHz in
kirkwood), so the IORDY timeout must be increased accordingly as it's
defined in core clock cycle. I choose to use the value 0x800 so it will be
good enough also for future devices, and, this large timeout will be good
in case some sata device has big delays within its DATA fises.

 >
>         Jeff
>
>
>
>
>
