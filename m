From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] libata - Query the driver for ATAPI DMA support
Date: Fri, 17 Dec 2004 21:01:17 +0100
Message-ID: <58cb370e041217120141c524f9@mail.gmail.com>
References: <002201c4e330$562a61d0$e4574109@tw.ibm.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.200]:38451 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262148AbULQUBS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Dec 2004 15:01:18 -0500
Received: by wproxy.gmail.com with SMTP id 55so94839wri
        for <linux-ide@vger.kernel.org>; Fri, 17 Dec 2004 12:01:17 -0800 (PST)
In-Reply-To: <002201c4e330$562a61d0$e4574109@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

On Thu, 16 Dec 2004 13:28:28 +0800, Albert Lee <albertcc@tw.ibm.com> wrote:
> Hi, Jeff:
> 
> >
> > > After some testing, it seems that some PATA host adapter (ex. pdc20275) cannot
> > > work reliably with specific request buffer sizes under ATAPI DMA mode.
> > >
> > > Detailed test result:
> > > 4096, 2048, 1024, 512, 256: OK
> > > 384, 257, 255, 128, 96, 64, 32:  failed (irq lost)
> > >
> > >  It seems multiple of 256 bytes are the safe ATAPI DMA buffer sizes to use.
> > >
> >
> > Attached please find the patch to fix the pdc2027x ATAPI DMA problem.
> > (The patch is against libata-dev-2.6 tree.)
> >
> > Changes:
> > 1. Add a callback function "check_atapi_dma()" to ata_port_operations such that libata core
> > can ask the driver: "Can this command be processed in ATAPI DMA mode safely? "
> > when the the command is received.
> > 2. ATAPI DMA is off by default if the callback function is not provided by the driver
> 
>     Sorry, there is a mistake in the previous patch. Revised the patch here:
> If the callback function is not provided by the driver, the ATAPI DMA should be as is.
> We should not turn off ATAPI DMA silently as in the previous patch. The ATAPI DMA is
> already controlled by dev->flags.
> 
> BTW, the patch isolates the ATAPI DMA workaround to the pdc20275 driver itself, not impacting libata core .
> Attached please find the revised patch for your review.

Looks fine, only one minor nitpick - it seems some newlines are missed...

> @@ -1947,7 +1947,24 @@
>   if (idx)
>    ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
>  }
> +/**

etc.

All three patches look OK.

Jeff, could you merge them if they are fine with you?
[ 1 and 2 should probably go to libata-2.6 but of course it's up to you ]

Bartlomiej
