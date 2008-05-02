From: "Grant Grundler" <grundler@google.com>
Subject: Re: [PATCH 03/12] sata_mv wait for empty+idle
Date: Fri, 2 May 2008 09:42:27 -0700
Message-ID: <da824cf30805020942q27466cbbk5c7877d6caa6c3d1@mail.gmail.com>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca>
	 <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:22986 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757382AbYEBQmj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 May 2008 12:42:39 -0400
Received: from zps76.corp.google.com (zps76.corp.google.com [172.25.146.76])
	by smtp-out.google.com with ESMTP id m42GgVwT014464
	for <linux-ide@vger.kernel.org>; Fri, 2 May 2008 17:42:31 +0100
Received: from yw-out-1718.google.com (ywa6.prod.google.com [10.192.1.6])
	by zps76.corp.google.com with ESMTP id m42GgToe024084
	for <linux-ide@vger.kernel.org>; Fri, 2 May 2008 09:42:30 -0700
Received: by yw-out-1718.google.com with SMTP id 6so124915ywa.78
        for <linux-ide@vger.kernel.org>; Fri, 02 May 2008 09:42:29 -0700 (PDT)
In-Reply-To: <481AB00A.3000206@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, May 1, 2008 at 11:09 PM, Mark Lord <liml@rtr.ca> wrote:
> When performing EH, it is recommended to wait for the EDMA engine
>  to empty out requests-in-progress before disabling EDMA.
>
>  Introduce code to poll the EDMA_STATUS register for idle/empty bits
>  before disabling EDMA.  For non-EH operation, this will normally exit
>  without delay, other than the register read.
>
>  A later series of patches may focus on eliminating this and various
>  other register reads (when possible) throughout the driver,
>  but for now we're focussing on solid reliablity.

Anything related to EH can do as many MMIO reads as necessary.
I'm just not going to worry about it since once we've entered EH, any
latency "guarantees" are already lost.

>
>  Signed-off-by: Mark Lord <mlord@pobox.com>
>
>  --- old/drivers/ata/sata_mv.c   2008-05-01 17:49:53.000000000 -0400
>  +++ linux/drivers/ata/sata_mv.c 2008-05-01 17:56:54.000000000 -0400
>  @@ -888,6 +888,25 @@
>         }
>  }
>
>  +static void mv_wait_for_edma_empty_idle(struct ata_port *ap)
>  +{
>  +       void __iomem *port_mmio = mv_ap_base(ap);
>  +       const u32 empty_idle = (EDMA_STATUS_CACHE_EMPTY |
> EDMA_STATUS_IDLE);
>  +       const int per_loop = 5, timeout = (15 * 1000 / per_loop);

I reccomend setting per_loop to 10 or 20 at least. 5us is not very long.
It takes about 1us to do an MMIO read. Each additional MMIO read will exacerbate
the problem of DMA not finishing since MMIO reads interfere with DMA streams.

Also can you add a comment why 15ms is right amount of time to wait?

.e.g. 4 ports/SATAHC w/31 (NCQ) IOs @ 128KB == ~15MB of transfer time.
PCI-e 4X can transfer 1MB/s (roughly).
So this wouldn't be true for PCI-X devices running at 66Mhz.
Or if the ports are only running at 1.5Gb/s, etc.

BTW, I have no idea when EDMA stops on it's own or if we could
safely get EDMA to stop "prematurely" (e.g. disable PCI Bus Master).

hth,
grant

>  +       int i;
>  +
>  +       /*
>  +        * Wait for the EDMA engine to finish transactions in progress.
>  +        */
>  +       for (i = 0; i < timeout; ++i) {
>  +               u32 edma_stat = readl(port_mmio + EDMA_STATUS_OFS);
>  +               if ((edma_stat & empty_idle) == empty_idle)
>  +                       break;
>  +               udelay(per_loop);
>  +       }
>  +       /* ata_port_printk(ap, KERN_INFO, "%s: %u+ usecs\n", __func__, i);
> */
>  +}
>  +
>  /**
>   *      mv_stop_edma_engine - Disable eDMA engine
>   *      @port_mmio: io base address
>  @@ -920,6 +939,7 @@
>         if (!(pp->pp_flags & MV_PP_FLAG_EDMA_EN))
>                 return 0;
>         pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
>  +       mv_wait_for_edma_empty_idle(ap);
>         if (mv_stop_edma_engine(port_mmio)) {
>                 ata_port_printk(ap, KERN_ERR, "Unable to stop eDMA\n");
>                 return -EIO;
>  --
>  To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
