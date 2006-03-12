From: Dan Aloni <da-x@monatomic.org>
Subject: Re: [PATCH] sata_mv: stabilize for 5081 and other fixes
Date: Sun, 12 Mar 2006 07:24:33 +0200
Message-ID: <20060312052433.GA22418@localdomain>
References: <20060308194627.GA22346@localdomain> <44137D39.3000704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751425AbWCLFYO@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <44137D39.3000704@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Sat, Mar 11, 2006 at 08:45:29PM -0500, Jeff Garzik wrote:
> Dan Aloni wrote:
> >Hello,
> >
> >With the patch below I've managed to stabilize the sata_mv driver 
> >running a Marvell 5081 SATA controller. Prior to these changes it
> >would cause sporadic memory corruptions right after insmod. I prefer 
> >this driver over Marvell's own driver which have all sorts of weird
> >bugs.
> >
> >The patch also increases the maximum possible number of SG entries 
> >per IO to 256 (this large sg_tablesize is a requirement for the 
> >application we are developing at my company, XIV). Notice that it 
> >also zeros-out a reserved field in the SG, I'm not sure how it 
> >affected stability but something did. I've also added the 'volatile' 
> >qualifier to some fields that belong to structs involved with I/O.
> 
> Adding 'volatile' is to be avoided.  This is simply hiding bugs 
> elsewhere.  volatile is an "atom bomb" that kills quite valid 
> optimizations, needlessly.  Most likely you need to sprinkle rmb(), 
> wmb(), and/or mb() in the correct locations.

I'm not sure if these memory barriers are even needed, or whether
volatile made any impact on stability - but I can isolate these 
changes today and see if it has any impact simply by experimenting.
 
> Also, it isn't clear at all from your description precisely which 
> changes are fixes, and which are cleanups and optimizations.  It would 
> be nice to get each category of changes split into two separate patches.
 
I would prefer to just minimize the whole thing to a patch that 
only fixes the stabilty problem, less paranoidically. If you can
suggest such patch for me to test I'd be happy to give it a try.
 
> > struct mv_host_priv;
> >@@ -365,7 +371,7 @@
> > 	.eh_strategy_handler	= ata_scsi_error,
> > 	.can_queue		= MV_USE_Q_DEPTH,
> > 	.this_id		= ATA_SHT_THIS_ID,
> >-	.sg_tablesize		= MV_MAX_SG_CT / 2,
> >+	.sg_tablesize		= MV_MAX_SG_CT,
> 
> This is adding a bug.
> 
> The IOMMU worst case requires a split for each s/g entry, due to DMA 
> boundary issues.  See mv_fill_sg() or ata_fill_sg().
> 
> Thus, the above "/ 2" is required.

Interesting, I'll look into that. I wonder how it managed to work 
so far. 
 
> > 	.max_sectors		= ATA_MAX_SECTORS,
> > 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
> > 	.emulated		= ATA_SHT_EMULATED,
> >@@ -509,10 +515,7 @@
> > 	.reset_bus		= mv_reset_pci_bus,
> > };
> > 
> >-/*
> >- * module options
> >- */
> >-static int msi;	      /* Use PCI msi; either zero (off, default) or 
> >non-zero */
> >+static int msi;              /* Use PCI msi; either zero (off, default) 
> >or non-zero */
> 
> what changed here?

Nothing, that's just a diff hunk I should have cleaned away.

> > /*
> >@@ -770,7 +773,8 @@
> > 
> > static inline void mv_priv_free(struct mv_port_priv *pp, struct device 
> > *dev)
> > {
> >-	dma_free_coherent(dev, MV_PORT_PRIV_DMA_SZ, pp->crpb, pp->crpb_dma);
> >+	dma_free_coherent(dev, MV_PORT_PRIV_DMA1_SZ, pp->crpb, pp->crpb_dma);
> >+	dma_free_coherent(dev, MV_PORT_PRIV_DMA2_SZ, pp->sg_tbl, 
> >pp->sg_tbl_dma);
> > }
> > 
> > /**
> >@@ -788,8 +792,8 @@
> > 	struct device *dev = ap->host_set->dev;
> > 	struct mv_port_priv *pp;
> > 	void __iomem *port_mmio = mv_ap_base(ap);
> >-	void *mem;
> >-	dma_addr_t mem_dma;
> >+	void *mem, *mem2;
> >+	dma_addr_t mem_dma, mem_dma2;
> > 	int rc = -ENOMEM;
> > 
> > 	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
> >@@ -797,11 +801,17 @@
> > 		goto err_out;
> > 	memset(pp, 0, sizeof(*pp));
> > 
> >-	mem = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA_SZ, &mem_dma,
> >+	mem = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA1_SZ, &mem_dma,
> > 				 GFP_KERNEL);
> > 	if (!mem)
> > 		goto err_out_pp;
> >-	memset(mem, 0, MV_PORT_PRIV_DMA_SZ);
> >+	memset(mem, 0, MV_PORT_PRIV_DMA1_SZ);
> >+
> >+	mem2 = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA2_SZ, &mem_dma2,
> >+				 GFP_KERNEL);
> >+	if (!mem2)
> >+		goto err_out_pp_2;
> >+	memset(mem2, 0, MV_PORT_PRIV_DMA2_SZ);
> > 
> > 	rc = ata_pad_alloc(ap, dev);
> > 	if (rc)
> >@@ -820,14 +830,12 @@
> > 	 */
> > 	pp->crpb = mem;
> > 	pp->crpb_dma = mem_dma;
> >-	mem += MV_CRPB_Q_SZ;
> >-	mem_dma += MV_CRPB_Q_SZ;
> > 
> > 	/* Third item:
> > 	 * Table of scatter-gather descriptors (ePRD), 16 bytes each
> > 	 */
> >-	pp->sg_tbl = mem;
> >-	pp->sg_tbl_dma = mem_dma;
> >+	pp->sg_tbl = mem2;
> >+	pp->sg_tbl_dma = mem_dma2;
> 
> why two allocations?

A 256 entry SG array takes a PAGE_SIZE, I didn't want to allocate more
than PAGE_SIZE to avoid fragmentation problems.
 
> why not just fix the [probable] alignment issue?

Yes, I forgot these allocations should be aligned (by 16, right?).
 
> I also agree with John Stoffel's comments.

Me too.

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
