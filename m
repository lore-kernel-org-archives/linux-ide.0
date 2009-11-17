From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: ATA: Make CS5536 PATA driver use 32-bit BM DMA template instead of 16-bit.
Date: Tue, 17 Nov 2009 12:35:50 +0100
Message-ID: <m2tywtidt5.fsf@vador.mandriva.com>
References: <m3my2u0w6f.fsf@intrepid.localdomain> <4B0215EA.9080800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.moondrake.net ([212.85.150.166]:51441 "EHLO
	mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755226AbZKQLee (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2009 06:34:34 -0500
In-Reply-To: <4B0215EA.9080800@pobox.com> (Jeff Garzik's message of "Mon, 16
	Nov 2009 22:18:02 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-ide@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> > diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
> > index 88a7933..0898213 100644
> > --- a/drivers/ata/pata_cs5536.c
> > +++ b/drivers/ata/pata_cs5536.c
> > @@ -232,7 +232,7 @@ static struct scsi_host_template cs5536_sht = {
> >   };
> >
> >   static struct ata_port_operations cs5536_port_ops = {
> > -	.inherits		=&ata_bmdma_port_ops,
> > +	.inherits		=&ata_bmdma32_port_ops,
> >   	.cable_detect		= cs5536_cable_detect,
> >   	.set_piomode		= cs5536_set_piomode,
> >   	.set_dmamode		= cs5536_set_dmamode,
>
> applied

Why not rename ata_bmdma_port_ops as ata_bmdma_port_ops16 for
consistency?
