From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [BK PATCHES] ide-2.6 update
Date: Fri, 22 Oct 2004 20:17:09 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e0410221117102cf1f6@mail.gmail.com>
References: <58cb370e04102210385ca8b554@mail.gmail.com>
	 <20041022190715.B3459@flint.arm.linux.org.uk>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.192]:19113 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267939AbUJVSRK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Oct 2004 14:17:10 -0400
Received: by rproxy.gmail.com with SMTP id 77so221234rnk
        for <linux-ide@vger.kernel.org>; Fri, 22 Oct 2004 11:17:09 -0700 (PDT)
In-Reply-To: <20041022190715.B3459@flint.arm.linux.org.uk>
List-Id: linux-ide@vger.kernel.org
To: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004 19:07:15 +0100, Russell King
<rmk+lkml@arm.linux.org.uk> wrote:
> On Fri, Oct 22, 2004 at 07:38:44PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > @@ -498,14 +483,6 @@
> >                       ICS_ARCIN_V6_INTRSTAT_1)) & 1;
> >  }
> >
> > -static int icside_dma_verbose(ide_drive_t *drive)
> > -{
> > -     printk(", %s (peak %dMB/s)",
> > -             ide_xfer_verbose(drive->current_speed),
> > -             2000 / drive->drive_data);
> > -     return 1;
> > -}
> > -
> >  static int icside_dma_timeout(ide_drive_t *drive)
> >  {
> >       printk(KERN_ERR "%s: DMA timeout occurred: ", drive->name);
> > @@ -554,7 +531,6 @@
> >       hwif->dma_start         = icside_dma_start;
> >       hwif->ide_dma_end       = icside_dma_end;
> >       hwif->ide_dma_test_irq  = icside_dma_test_irq;
> > -     hwif->ide_dma_verbose   = icside_dma_verbose;
> >       hwif->ide_dma_timeout   = icside_dma_timeout;
> >       hwif->ide_dma_lostirq   = icside_dma_lostirq;
> 
> Why are you denying me the ability to report detailed drive transfer
> speed information?  Would you prefer me to printk a separate line
> and further clutter up the message log instead?

>From the changelog:
> * icside.c version repeated info given by ->ide_dma_check()

If DMA is going to be used:
* ->ide_dma_check is always called
* icside_dma_check() always calls icside_set_speed()
* icside_set_speed() always does

	printk("%s: %s selected (peak %dMB/s)\n", drive->name,
		ide_xfer_verbose(xfer_mode), 2000 / drive->drive_data);

so what am I missing?

Bartlomiej
