From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATA: Make CS5536 PATA driver use 32-bit BM DMA template instead
 of 16-bit.
Date: Tue, 17 Nov 2009 11:56:56 +0000
Message-ID: <20091117115656.743701b1@lxorguk.ukuu.org.uk>
References: <m3my2u0w6f.fsf@intrepid.localdomain>
	<4B0215EA.9080800@pobox.com>
	<m2tywtidt5.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36846 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755573AbZKQLzi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2009 06:55:38 -0500
In-Reply-To: <m2tywtidt5.fsf@vador.mandriva.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Krzysztof Halasa <khc@pm.waw.pl>, linux-ide@vger.kernel.org

On Tue, 17 Nov 2009 12:35:50 +0100
Thierry Vignaud <tvignaud@mandriva.com> wrote:

> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> > > diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
> > > index 88a7933..0898213 100644
> > > --- a/drivers/ata/pata_cs5536.c
> > > +++ b/drivers/ata/pata_cs5536.c
> > > @@ -232,7 +232,7 @@ static struct scsi_host_template cs5536_sht = {
> > >   };
> > >
> > >   static struct ata_port_operations cs5536_port_ops = {
> > > -	.inherits		=&ata_bmdma_port_ops,
> > > +	.inherits		=&ata_bmdma32_port_ops,
> > >   	.cable_detect		= cs5536_cable_detect,
> > >   	.set_piomode		= cs5536_set_piomode,
> > >   	.set_dmamode		= cs5536_set_dmamode,
> >
> > applied
> 
> Why not rename ata_bmdma_port_ops as ata_bmdma_port_ops16 for
> consistency?

Because 16bit is the normal default for ATA BMDMA, and because its a ton
of unneccessary churn ?
