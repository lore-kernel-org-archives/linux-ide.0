From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] libata updates
Date: Wed, 7 Oct 2009 00:26:15 +0200
Message-ID: <200910070026.15259.bzolnier@gmail.com>
References: <20090917204935.GA7432@havoc.gtf.org> <200909281734.11090.bzolnier@gmail.com> <4ACAC665.7070109@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:60902 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933336AbZJFW1J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Oct 2009 18:27:09 -0400
In-Reply-To: <4ACAC665.7070109@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Jung-Ik (John) Lee" <jilee@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Grant Grundler <grundler@google.com>, Gwendal Gringo <gwendal@google.com>

On Tuesday 06 October 2009 06:24:05 Jeff Garzik wrote:
> On 09/28/2009 11:34 AM, Bartlomiej Zolnierkiewicz wrote:
> > Thanks, your patch looks good to me but since there are still some
> > leftover issues left we would also need something like the incremental
> > patch below:
> >
> > From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> > Subject: [PATCH] pata_atp867x: PIO support fixes
> >
> > * use  8 clk setting for active clocks == 7 (was 12 clk)
> > * use 12 clk setting for active clocks>  12 (was  8 clk)
> > * do 66MHz bus fixup before mapping active clocks
> > * fix setup of PIO command timings
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> > ---
> >   drivers/ata/pata_atp867x.c |   36 +++++++++++++++++++-----------------
> >   1 file changed, 19 insertions(+), 17 deletions(-)
> >
> > Index: b/drivers/ata/pata_atp867x.c
> > ===================================================================
> > --- a/drivers/ata/pata_atp867x.c
> > +++ b/drivers/ata/pata_atp867x.c
> > @@ -155,30 +155,31 @@ static int atp867x_get_active_clocks_shi
> >   	struct atp867x_priv *dp = ap->private_data;
> >   	unsigned char clocks = clk;
> >
> > +	/*
> > +	 * Doc 6.6.9: increase the clock value by 1 for safer PIO speed
> > +	 * on 66MHz bus
> > +	 */
> > +	if (dp->pci66mhz)
> > +		clocks++;
> > +
> >   	switch (clocks) {
> >   	case 0:
> >   		clocks = 1;
> >   		break;
> > -	case 1 ... 7:
> > -		break;
> > -	case 9 ... 12:
> > -		clocks = 7;
> > +	case 1 ... 6:
> >   		break;
> >   	default:
> >   		printk(KERN_WARNING "ATP867X: active %dclk is invalid. "
> > -			"Using default 8clk.\n", clk);
> > +			"Using 12clk.\n", clk);
> > +	case 9 ... 12:
> > +		clocks = 7;	/* 12 clk */
> > +		break;
> > +	case 7:
> >   	case 8:	/* default 8 clk */
> >   		clocks = 0;
> >   		goto active_clock_shift_done;
> >   	}
> >
> > -	/*
> > -	 * Doc 6.6.9: increase the clock value by 1 for safer PIO speed
> > -	 * on 66MHz bus
> > -	 */
> > -	if (dp->pci66mhz&&  clocks<  7)
> > -		clocks++;
> > -
> >   active_clock_shift_done:
> >   	return clocks<<  ATP867X_IO_PIOSPD_ACTIVE_SHIFT;
> >   }
> > @@ -193,7 +194,8 @@ static int atp867x_get_recover_clocks_sh
> >   		break;
> >   	case 1 ... 11:
> >   		break;
> > -	case 13: case 14:
> > +	case 13:
> > +	case 14:
> >   		--clocks;	/* by the spec */
> >   		break;
> >   	case 15:
> > @@ -235,16 +237,16 @@ static void atp867x_set_piomode(struct a
> >   	iowrite8(b, dp->dma_mode);
> >
> >   	b = atp867x_get_active_clocks_shifted(ap, t.active) |
> > -		atp867x_get_recover_clocks_shifted(t.recover);
> > +	    atp867x_get_recover_clocks_shifted(t.recover);
> >
> >   	if (adev->devno&  1)
> >   		iowrite8(b, dp->slave_piospd);
> >   	else
> >   		iowrite8(b, dp->mstr_piospd);
> >
> > -	/*
> > -	 * use the same value for comand timing as for PIO timimg
> > -	 */
> > +	b = atp867x_get_active_clocks_shifted(ap, t.act8b) |
> > +	    atp867x_get_recover_clocks_shifted(t.rec8b);
> > +
> >   	iowrite8(b, dp->eightb_piospd);
> >   }
> >
> >
> 
> This was incremental to the previous patch, or upstream?

To the previous patch.  For your convenience I'll re-post all overdue
pata_atp867x patches to the date on linux-ide ML..
