From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Restore support for AEC6285M cards in aec62xx.c
Date: Thu, 10 Nov 2005 11:50:58 +0100
Message-ID: <58cb370e0511100250q319b32eame8112d2412aba659@mail.gmail.com>
References: <20051029050124.3cee081c@Tatooine.r3z0>
	 <58cb370e0511020902r2f031e7ewa9331723d4183e3c@mail.gmail.com>
	 <20051106144033.45deb874@Tatooine.r3z0>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.205]:27824 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750771AbVKJKu7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 05:50:59 -0500
Received: by nproxy.gmail.com with SMTP id n15so99538nfc
        for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 02:50:58 -0800 (PST)
In-Reply-To: <20051106144033.45deb874@Tatooine.r3z0>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thibaut VARENE <T-Bone@parisc-linux.org>
Cc: linux-ide@vger.kernel.org

On 11/6/05, Thibaut VARENE <T-Bone@parisc-linux.org> wrote:
> Hi,
>
> On Sun, 06 Nov 2005 14:25:40 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
> > Hi,
> >
> > On 10/29/05, Thibaut VARENE <T-Bone@parisc-linux.org> wrote:
>
> > > The attached patch restore the original code, and I took the
> opportunity
> > > to do a very limited cleanup. What's ought to be mentioned is that the
> > > aec62xx_dma_timeout() does actually nothing (it's all #if 0'd), so I
> think
> > > it can be safely either removed or commented out for debugging
> purpose,
> > > and the remaing hwif->dma_timeout assignement can be removed from
> > > init_hwif_aec62xx(). I can produce another patch to do that if needed.
> >
> > Please do so (remove dead code) but leave empty ae62xx_dma_timeout()
> > and do the change from aec62xx_dma_timeout() -> __ide_dma_timeout()
> > in the other patch.
>
> done in patch-2-aec62xxx.c-cleanup.diff

Thanks but obvious cleanups and functional changes (conversion
to use __ide_dma_timout() and PIO fixes) are still mixed.

One of the advantages of separating logical changes is that obvious
things can go to Linus ASAP while more complicated things need
some testing in -mm kernel first.

> > 2-nd argument is PIO mode wanted (255 == best one)
> > 3-rd argument is max PIO mode supported by controller
> >
> > and you should fix ->tuneproc() in aec62xx_config_drive_xfer_rate()
> instead.
>
> That I'm not sure how to do. This is the first time I have a look at the
> IDE layer, so I'm not really "at ease"...

Just change ->tuneproc() argument in aec62xx_config_drive_xfer_rate()
from '5' to '255' so best PIO mode will still be tuned correctly.

> > This will also fix three other bugs:
> > - user wants to ->tuneproc() best PIO but instead PIO 0 is tuned
> > - user wants to ->tuneproc() PIO 5 but instead best PIO is tuned
> > - user wants to ->speedproc() PIO 5 but chipset is configured for
> >   PIO 0 (PCI == 33 MHz) or incorrect PIO timing (PCI == 34 MHz)
> >
> > Please note that this code-path is not executed by default
> > because drive->autotune is set only if DMA base cannot be
> > obtained (his incorrect because we need PIO to be configured
> > properly even if DMA is going to be used).  That would be great
> > if you could also fix this.

by adding

hwif->drives[0].autotune = 1;
hwif->drives[1].autotune = 1;

to init_hwif_aec62xx() and testing this change
(please note that it depends on fixing ->tuneproc() discussed earlier)

> patch-1--aec62xxx.c-maccards.diff:
> - Add missing Macintosh-specific cards initialization sequence

I will add this to development tree (which will show in -mm kernels
soon), thanks.

> Signed-off-by: Thibaut VARENE <varenet@parisc-linux.org>
>
> patch-2-aec62xxx.c-cleanup.diff:
> - Remove dead code

This should really be the first change in the patch series
so I can forward it to Linus immediately.

> - Update aec62xxx_tune_drive()
> - Update aec62xxx_dma_timeout()

These should belong to the last patch in the patch series.

Please also try adding some meaningful descriptions to the patches.

Thanks,
Bartlomiej
