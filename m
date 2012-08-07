From: Mark Lord <kernel@teksavvy.com>
Subject: Re: sata_mv query
Date: Tue, 07 Aug 2012 13:16:06 -0400
Message-ID: <50214D56.9090907@teksavvy.com>
References: <006c01cd74ac$a06edf30$e14c9d90$@sturgeon@perpetual-data.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182]:27655 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753032Ab2HGRQI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2012 13:16:08 -0400
In-Reply-To: <006c01cd74ac$a06edf30$e14c9d90$@sturgeon@perpetual-data.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Barry J Sturgeon <barry.sturgeon@perpetual-data.com>
Cc: linux-ide@vger.kernel.org

On 12-08-07 10:54 AM, Barry J Sturgeon wrote:
> when loading the 3.2.1. kernel onto my supermicro pdsm4 motherboard (with
> marvell 8 port sata controller) i have encountered performance degradation
> due to excessive cpu usage (i.e. three busy kworkers). after some
> investigation i have tracked down the problem to:
> 
> +static void mv_wait_for_edma_empty_idle(struct ata_port *ap)
> +{
> +       void __iomem *port_mmio = mv_ap_base(ap);
> +       const u32 empty_idle = (edma_status_cache_empty | edma_status_idle);
> +       const int per_loop = 5, timeout = (15 * 1000 / per_loop);
> +       int i;
> +
> +       /*
> +        * wait for the edma engine to finish transactions in progress.
> +        */
> +       for (i = 0; i < timeout; ++i) {
> +               u32 edma_stat = readl(port_mmio + edma_status_ofs);
> +               if ((edma_stat & empty_idle) == empty_idle)
> +                       break;
> *+               udelay(per_loop);*
> +       }
> +       /* ata_port_printk(ap, kern_info, "%s: %u+ usecs\n", __func__, i); */
> +}
>  
> it appears that we always reach the timeout value.
> note that empty_idle = 0xc0 (as you know),
> but most edma_stat values are (1100 or 1000).

Okay, that's weird.
mv_wait_for_edma_empty_idle() is called from mv_stop_edma(),
which happens whenever we transition between sending NCQ commands
(eg. read/write) and non-NCQ commands (eg. flush cache).

The mv_qc_defer() function is supposed to ensure that things are
more or less idle before it even gets to mv_stop_edma().
So we'd expect the mv_wait_for_edma_empty_idle() function to be quick,
which is a big part of why we're willing to tolerate an inline busy-wait.

But here it seems to be waiting MUCH longer, as if it has to wait for
some IO-in-progress to complete before continuing.  Which means that
the mv_qc_defer() function isn't being as effective as it should be.

The idea is, before any new command is queued, libata invokes the defer
function to see if the driver is ready to accept the new command.
The sata_mv driver normally says "yes" (go ahead) for a new NCQ command
whenever it currently has existing NCQ commands in-flight.
Otherwise it always says "no" (please defer) unless completely idle.
That's how mv_qc_defer() is supposed to work, and that should minimize
the time spent inside mv_wait_for_edma_empty_idle() by ensuring the
edma engine is already idle whenever that gets called.

This in turn suggests two possibilities:
(1) perhaps ap->nr_active_links has an accounting glitch somewhere. Or
(2) maybe there's a locking bug somewhere around the invocation
of mv_qc_defer().

Or something else is wrong.  :)

So, focus your attentions on mv_qc_defer().
Also, you could try mounting the filesystem with the "barrier=0" option,
just to see if that makes the problem go away -- confirming the analysis above.
-- 
mark lord
real-time remedies inc.
mlord@pobox.com
