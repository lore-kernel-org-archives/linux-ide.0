From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] sata_sil: combined irq + LBT DMA patch for testing
Date: Wed, 25 Jan 2006 17:26:07 +0100
Message-ID: <58cb370e0601250826m330984g576839345ed908de@mail.gmail.com>
References: <20051204011953.GA16381@havoc.gtf.org>
	 <7744a2840512061147i5c101455g9ed99624aca344dd@mail.gmail.com>
	 <43987A28.8070509@mandriva.org> <439899B6.2000302@pobox.com>
	 <43B16B06.3000401@mandriva.org> <43CD8E62.7060301@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.198]:25698 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750827AbWAYQ0J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Jan 2006 11:26:09 -0500
Received: by uproxy.gmail.com with SMTP id s2so240503uge
        for <linux-ide@vger.kernel.org>; Wed, 25 Jan 2006 08:26:08 -0800 (PST)
In-Reply-To: <43CD8E62.7060301@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Thomas Backlund <tmb@mandriva.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 1/18/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> Thomas Backlund wrote:
> > Jeff Garzik wrote:
> >
> >> Thomas Backlund wrote:
> >>
> >>> Richard Bollinger wrote:
> >>>
> >>>>> ata1: BUG: SG size underflow
> >>>>> ata1: status=0x50 { DriveReady SeekComplete }
> >>>
> >>>
> >>>
> >>> and onde by one the raid devices got deactivated until the full
> >>> freeze...
> >>
> >>
> >>
> >> I think I know what's going on with the 'SG size underflow' thingy,
> >> give me a few days to come up with a fix.
> >>
> >>     Jeff
> >>
> >>
> >>
> > Any news on this?
> > or is it already fixed ?
>
> Back-burner for the moment :(

I think I have finally found the bug
after auditing the patch for x times...

+       /* Stop DMA, if doing DMA */
+       switch (qc->tf.protocol) {
+       case ATA_PROT_DMA:
+       case ATA_PROT_ATAPI_DMA:
+               ata_bmdma_stop(qc);

It should be sil_bmdma_stop()...

By accident ata_bmdma_stop() is OK for sil3112 so that would
explain why only people with sil3114 reported problems.

My theory is that using ata_bmdma_stop() for sil3114 results
in IRQs for port 2 and 3 not being delivered (because
SIL_INTR_STEERING bit is cleared) and we end up with
dma_stat_mask == 0.

Rest of the patch looks perfectly fine for me.  Could somebody
reporting problems with this patch retest with the above change?

+               break;
+       default:
+               /* do nothing */
+               break;
+       }

Bartlomiej
