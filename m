From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] Call flush_dcache_page around PIO data transfers in
 libata-aff.c
Date: Wed, 03 Mar 2010 11:18:25 +0000
Message-ID: <1267615105.15589.68.camel@e102109-lin.cambridge.arm.com>
References: <20100129160150.22571.28609.stgit@pc1117.cambridge.arm.com>
	 <20100303082443.GA11944@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:37335 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750821Ab0CCL1B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Mar 2010 06:27:01 -0500
In-Reply-To: <20100303082443.GA11944@Chamillionaire.breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>

On Wed, 2010-03-03 at 08:24 +0000, Sebastian Andrzej Siewior wrote:
> > drivers/ata/libata-sff.c |    6 ++++++
> > 1 files changed, 6 insertions(+), 0 deletions(-)
> >
> >diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> >index 741065c..3d3c854 100644
> >--- a/drivers/ata/libata-sff.c
> >+++ b/drivers/ata/libata-sff.c
> >@@ -893,6 +896,9 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
> >                                      do_write);
> >       }
> >
> >+      if (!do_write)
> >+              flush_dcache_page(page);
> >+
> >       qc->curbytes += qc->sect_size;
> >       qc->cursg_ofs += qc->sect_size;
> 
> That part got merged and it leads to a BUG if CONFIG_DEBUG_VM is
> enabled. My mips box and arm use page_mapping() in flush_dcache_page()
> which has VM_BUG_ON(PageSlab(page)) in it.
> 
> Any comments on that?

There is a long thread on USB HCD and cache coherency on ARM which I
started pretty much at the same time with the libata-sff change. I need
to do some testing but in the view of the discussions in the other
thread, we may not need this patch at all:

http://thread.gmane.org/gmane.linux.usb.general/27072

Basically, the meaning of PG_arch_1 should be page clean rather than
page dirty.

-- 
Catalin

