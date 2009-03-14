From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH,v2][1/2] sata-mv: enable HDD led blinking when NCQ is active for GenIIe
Date: Sat, 14 Mar 2009 12:57:41 +0100
Message-ID: <200903141257.43628.elendil@planet.nl>
References: <200903110813.25650.elendil@planet.nl> <49BA59FA.1020205@rtr.ca> <200903131919.09525.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpm-eml104.kpnxchange.com ([195.121.3.8]:50030 "EHLO
	CPSMTPM-EML104.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752992AbZCNL5q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 07:57:46 -0400
In-Reply-To: <200903131919.09525.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

I seem to have accidentally deleted your reply to this...

On Friday 13 March 2009, Frans Pop wrote:
> On Friday 13 March 2009, Mark Lord wrote:
> > --- old/drivers/ata/sata_mv.c	2009-03-12 10:23:41.000000000 -0400
> > +++ new/drivers/ata/sata_mv.c	2009-03-13 09:03:47.000000000 -0400
> > @@ -1455,9 +1455,8 @@
> >  		struct ata_port *this_ap = host->ports[port];
> >  		struct mv_port_priv *pp = this_ap->private_data;
> >
> > -		if (pp->pp_flags & MV_PP_FLAG_EDMA_EN)
> > -			if (pp->pp_flags & MV_PP_FLAG_NCQ_EN)
> > -				return;
> > +		if (pp->pp_flags & MV_PP_FLAG_NCQ_EN)
> > +			return;
>
> I expect that if NCQ is disabled using the method I've used so far, the
> led behavior would still be correct, but...

I did not mean I did not want to test the patch. Just wanted to verify 
that it was correct first.

> The reason I included the test for both in my patches is that if DMA
> gets disabled (which IIUC also disables NCQ) only the
> MV_PP_FLAG_EDMA_EN flag gets unset in mv_stop_edma, and not the NCQ
> flag (AFAICT). So that would result in blink mode remaining enabled
> while it shouldn't be.

I missed the fact that you now call mv_edma_cfg from mv_stop_edma, so the 
simplification is now indeed possible.

Tested and everything still works.

> I have so far not tested the led bahavior when DMA is disabled (not
> even sure if that's possible for a running system).

It seems that with libata-based drivers disabling dma is only possible at 
boot time and not dynamically, so this isn't possible anyway.
I don't know if access errors could cause the driver to fall back to PIO, 
but I don't really want to test that :-)
