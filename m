From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.24-rc & SB600 AHCI no go on >=4GB of RAM
Date: Tue, 20 Nov 2007 16:34:30 +0100 (CET)
Message-ID: <alpine.LFD.0.9999.0711201559520.25057@localhost.localdomain>
References: <198606.73895.qm@web52608.mail.re2.yahoo.com> <200711141317.35746.ak@suse.de> <alpine.LFD.0.9999.0711141633400.3265@localhost.localdomain> <200711141746.26793.ak@suse.de> <47423245.1050109@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:51264 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757400AbXKTPes (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Nov 2007 10:34:48 -0500
In-Reply-To: <47423245.1050109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org



On Tue, 20 Nov 2007, Tejun Heo wrote:

> Andi Kleen wrote:
> >  
> >> The AHCI code falls back to 32bit DMA in that case. Which in turn
> >> causes the problem seen by Srihari. There is not much printk sticking
> >> necessary, the code is simply not handling this. 
> > 
> > What code is not handling what? 
> > 
> > IOMMU merging should be always safe. If it is not the driver should
> > not submit things in a single SG list.
> 
> Yeap, a sg merged by IOMMU should be safe.  It's just another contiguous
> memory area from the POV of the controller anyway.  I wonder what went
> wrong here.  What has exactly changed with iommu_merge patch?

Not much:

-int iommu_merge __read_mostly = 0;
+int iommu_merge __read_mostly = 1;
 EXPORT_SYMBOL(iommu_merge);

Which in turn enables the iommu_merge functionality in gart_map_sg().

	for_each_sg(sg, s, nents, i) {
		dma_addr_t addr = sg_phys(s);
		s->dma_address = addr;
		BUG_ON(s->length == 0);

		nextneed = need_iommu(dev, addr, s->length);

		/* Handle the previous not yet processed entries */
		if (i > start) {
			/* Can only merge when the last chunk ends on a page
			   boundary and the new one doesn't have an offset. */
			if (!iommu_merge || !nextneed || !need || s->offset ||
			    (ps->offset + ps->length) % PAGE_SIZE) {
				if (dma_map_cont(start_sg, i - start, sgmap,
						  pages, need) < 0)
					goto error;
				out++;
				sgmap = sg_next(sgmap);
				pages = 0;
				start = i;
				start_sg = s;
			}
		}

		need = nextneed;
		pages += to_pages(s->offset, s->length);
		ps = s;
	}
	if (dma_map_cont(start_sg, i - start, sgmap, pages, need) < 0)
		goto error;

So with iommu_merge off we map for each entry in the sg
list. iommu_merge concatenates into larger segments.

This requires propably working 64bit DMA, which is not possible with
the SB600 controller.

Thanks,

	tglx
