From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: [PATCH] avoid releasing twice the same region on ide_release_iomio_dma()
Date: Mon, 24 Jul 2006 17:23:59 -0400
Message-ID: <87f94c370607241423g71bd17f9tb3b2e4fcf0cbeb5d@mail.gmail.com>
References: <20060724193031.GA18463@cathedrallabs.org>
	 <44C5264D.4040609@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:52268 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751453AbWGXVYA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Jul 2006 17:24:00 -0400
Received: by nf-out-0910.google.com with SMTP id o25so40346nfa
        for <linux-ide@vger.kernel.org>; Mon, 24 Jul 2006 14:23:59 -0700 (PDT)
In-Reply-To: <44C5264D.4040609@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>, linux-ide@vger.kernel.org

On 7/24/06, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Aristeu Sergio Rozanski Filho wrote:
>
> > In ide_release_iomio_dma() it's possible to release twice
> > hwif->dma_base if hwif->dma_base2 is not null and never releasing
> > hwif->dma_base2:
> > int ide_release_iomio_dma (ide_hwif_t *hwif)
> > {
> >         if ((hwif->dma_extra) && (hwif->channel == 0))
> >                 release_region((hwif->dma_base + 16), hwif->dma_extra);
> >         release_region(hwif->dma_base, 8);
> >         if (hwif->dma_base2)
> >                 release_region(hwif->dma_base, 8);
> >                                      ^^^^^^^^^
> >         return 1;
> > }
> > This patch fixes this typo.
>
> > Signed-off-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>
> >
> > Index: ppc-2.6/drivers/ide/ide-dma.c
> > ===================================================================
> > --- ppc-2.6.orig/drivers/ide/ide-dma.c        2006-07-24 12:25:20.000000000 -0300
> > +++ ppc-2.6/drivers/ide/ide-dma.c     2006-07-24 12:26:26.000000000 -0300
> > @@ -802,7 +802,7 @@
> >               release_region((hwif->dma_base + 16), hwif->dma_extra);
> >       release_region(hwif->dma_base, 8);
> >       if (hwif->dma_base2)
> > -             release_region(hwif->dma_base, 8);
> > +             release_region(hwif->dma_base2, 8);
> >       return 1;
> >  }
>
>     dma_base2 should go away altogether -- this is the IDE maintainer's opinion:
>
> http://marc.theaimsgroup.com/?l=linux-ide&m=114345699807546&w=2
>
>     I have posted this patch doing this back in March:
>
> http://marc.theaimsgroup.com/?l=linux-ide&m=114357441529834&w=2
>
> and it was in the -mm tree for some months but has been removed recently -- I
> still need to coordinate it with SGI.
>
> WBR, Sergei
> -

IDE is officially un-maintained as of a couple weeks ago.  (And since
April in reality).

http://marc.theaimsgroup.com/?l=linux-ide&m=115201353310421&w=2

That is likely why your patch disappeared.  Further Alan Cox and Jeff
Garzik are trying to replace the whole IDE subsystem with a libata-ide
subsystem, so IIRC major patches to IDE are being bit-bucketed.

Greg
-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
