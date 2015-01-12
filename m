From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: sata_dwc_460ex build failures in -next
Date: Mon, 12 Jan 2015 12:50:37 +0000
Message-ID: <20150112125037.GH12302@n2100.arm.linux.org.uk>
References: <E1YAZyB-0007iE-CZ@debutante>
 <20150112123655.GF4160@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:34257 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752282AbbALMur (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jan 2015 07:50:47 -0500
Content-Disposition: inline
In-Reply-To: <20150112123655.GF4160@sirena.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-ide@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

On Mon, Jan 12, 2015 at 12:36:55PM +0000, Mark Brown wrote:
> On Mon, Jan 12, 2015 at 08:03:27AM +0000, Build bot for Mark Brown wrote:
> 
> > 	arm64-allmodconfig
> > ../drivers/ata/sata_dwc_460ex.c:719:3: error: implicit declaration of function 'dma_cache_sync' [-Werror=implicit-function-declaration]
> > 
> > 	arm-allmodconfig
> > ../drivers/ata/sata_dwc_460ex.c:719:3: error: implicit declaration of function 'dma_cache_sync' [-Werror=implicit-function-declaration]
> 
> Since commit 84683a7e081ff60e (sata_dwc_460ex: enable COMPILE_TEST for
> the driver) the sata_dwc_460ex has been breaking the all*config builds
> for arm and arm64 as the driver uses dma_cache_sync() but this function
> is not provided on those architectures.
> 
> Either a more specific dependency is needed or the function shouldn't be
> used, I've not looked at the code.

The driver does look rather broken.  Let's first read up when dma_cache_sync()
should be used:

  void
  dma_cache_sync(struct device *dev, void *vaddr, size_t size,
                 enum dma_data_direction direction)
  
  Do a partial sync of memory that was allocated by
  dma_alloc_noncoherent(), starting at virtual address vaddr and
  continuing on for size.  Again, you *must* observe the cache line
  boundaries when doing this.

Note "memory that was allocated by dma_alloc_noncoherent()".

Now, let's look at the driver:

static int map_sg_to_lli(struct scatterlist *sg, int num_elems,
                        struct lli *lli, dma_addr_t dma_lli,
                        void __iomem *dmadr_addr, int dir)
{
...
                dma_cache_sync(NULL, lli, (sizeof(struct lli) * idx),
                               DMA_BIDIRECTIONAL);
}

static int dma_dwc_xfer_setup(struct scatterlist *sg, int num_elems,
                              struct lli *lli, dma_addr_t dma_lli,
                              void __iomem *addr, int dir)
{
        /* Convert SG list to linked list of items (LLIs) for AHB DMA */
        num_lli = map_sg_to_lli(sg, num_elems, lli, dma_lli, addr, dir);
}

        dma_chan = dma_dwc_xfer_setup(sg, qc->n_elem, hsdevp->llit[tag],
                                      hsdevp->llit_dma[tag],
                                      (void *__iomem)(&hsdev->sata_dwc_regs->\
                                      dmadr), qc->dma_dir);

        for (i = 0; i < SATA_DWC_QCMD_MAX; i++) {
                hsdevp->llit[i] = dma_alloc_coherent(pdev,
                                                     SATA_DWC_DMAC_LLI_TBL_SZ,
                                                     &(hsdevp->llit_dma[i]),
                                                     GFP_ATOMIC);

So, hsdevp->llit[x] is allocated using dma_alloc_*coherent*(), not
dma_alloc_*noncohernet*(), so dma_cache_sync() should not be used
according to the DMA API documentation.

Moreover, that GFP_ATOMIC flag looks mightily suspicious - we've done
a previous allocation using kzalloc(, GFP_KERNEL), so we aren't in an
atomic region, so why use GFP_ATOMIC there?

It doesn't look like it'll pass sparse checks either:

struct sata_dwc_device {
        u8                      *reg_base;
        struct sata_dwc_regs    *sata_dwc_regs; /* DW Synopsys SATA specific */
};

        u8 *base = NULL;

        base = of_iomap(ofdev->dev.of_node, 0);
        hsdev->reg_base = base;
        hsdev->sata_dwc_regs = (void *__iomem)(base + SATA_DWC_REG_OFFSET);

Maybe it should be moved to drivers/staging? :)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
