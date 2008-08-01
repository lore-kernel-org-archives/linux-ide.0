From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFC/Review] libata driver for Apple "macio" pata
Date: Fri, 01 Aug 2008 18:59:24 +0900
Message-ID: <4892DE7C.2040708@gmail.com>
References: <1217581709.11188.489.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:51046 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbYHAJ7u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2008 05:59:50 -0400
Received: by rv-out-0506.google.com with SMTP id k40so984498rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 01 Aug 2008 02:59:50 -0700 (PDT)
In-Reply-To: <1217581709.11188.489.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: list linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>

Hello,

I don't know anything about ppc macs or macio controllers and only
tentatively reviewed common libata stuff.  I couldn't spot any major
problem.  A few nits follow.

Benjamin Herrenschmidt wrote:
> +#include "pata_macio.h"

In libata, LLDs usually don't use header files for constants and stuff
unless they need to be shared.

> +static void pata_macio_apply_timings(struct ata_port *ap, unsigned int device)
> +{
> +	struct pata_macio_priv *priv = ap->private_data;
> +	void __iomem *rbase = ap->ioaddr.cmd_addr;
> +
> +	if (device != 0 && device != 1)
> +		return;

This condition is guaranteed not to be triggered by the core layer.

> +static void pata_macio_set_timings(struct ata_port *ap,
> +				   struct ata_device *adev)

Using single function for ->set_piomode and ->set_dmamode might not be
a good idea as libata core might call ->set_piomode with pio mode set
to PIO0 before reset but leaving the dma mode as is expecting the
transfer mode to be configured to PIO0.  However, this function would
configure considering the left-over DMA mode.

Hmmm... I guess we need to clear the DMA mode on reset, but anyways
that's what libata has been assuming till now.  set_piomode only deals
with pio mode.

> +{
> +	struct pata_macio_priv *priv = ap->private_data;
> +	const struct pata_macio_timing *t;
> +
> +	dev_dbg(priv->dev, "Set timings: DEV=%d, PIO=0x%x (%s), DMA=0x%x (%s)\n",
> +		adev->devno,
> +		adev->pio_mode, ata_mode_string(ata_xfer_mode2mask(adev->pio_mode)),
> +		adev->dma_mode, ata_mode_string(ata_xfer_mode2mask(adev->dma_mode)));
> +
> +	if (adev->devno != 0 && adev->devno != 1)
> +		return;

This condition is guaranteed not to be triggered by the core layer.

> +static unsigned long pata_macio_mode_filter(struct ata_device *adev,
> +					    unsigned long xfer_mask)
> +{
> +	struct pata_macio_priv *priv = adev->link->ap->private_data;
> +
> +	if (priv->dma_regs == NULL)
> +		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
> +	return xfer_mask;
> +}

Wouldn't it be better to clear these during initialization?

> +static int pata_macio_cable_detect(struct ata_port *ap)
> +{
> +	struct pata_macio_priv *priv = ap->private_data;
> +
> +	return priv->cable_80 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
> +}
> +
> +static void pata_macio_qc_prep(struct ata_queued_cmd *qc)
> +{
> +	unsigned int write = (qc->tf.flags & ATA_TFLAG_WRITE);
> +	struct ata_port *ap = qc->ap;
> +	struct pata_macio_priv *priv = ap->private_data;
> +	struct scatterlist *sg;
> +	struct dbdma_cmd *table;
> +	unsigned int si, pi;
> +
> +	dev_dbgdma(priv->dev, "%s: qc %p flags %lx, write %d dev %d\n",
> +		   __func__, qc, qc->flags, write, qc->dev->devno);
> +
> +	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
> +		return;
> +
> +	table = (struct dbdma_cmd *) priv->dma_table_cpu;
> +
> +	pi = 0;
> +	for_each_sg(qc->sg, sg, qc->n_elem, si) {
> +		u32 addr, sg_len, len;
> +
> +		/* determine if physical DMA addr spans 64K boundary.
> +		 * Note h/w doesn't support 64-bit, so we unconditionally
> +		 * truncate dma_addr_t to u32.
> +		 */
> +		addr = (u32) sg_dma_address(sg);
> +		sg_len = sg_dma_len(sg);
> +
> +		while (sg_len) {
> +			/* table overflow should never happen */
> +			BUG_ON (pi++ >= MAX_DCMDS);
> +
> +			len = (sg_len < 0xfe00) ? sg_len : 0xfe00;
> +			st_le16(&table->command, write ? OUTPUT_MORE: INPUT_MORE);
> +			st_le16(&table->req_count, len);
> +			st_le32(&table->phy_addr, addr);
> +			table->cmd_dep = 0;
> +			table->xfer_status = 0;
> +			table->res_count = 0;
> +			addr += len;
> +			sg_len -= len;
> +			++table;
> +		}
> +	}
> +
> +	/* Convert the last command to an input/output */
> +	if (pi) {
> +		table--;
> +		st_le16(&table->command, write ? OUTPUT_LAST: INPUT_LAST);
> +		table++;
> +	}

libata guarantees that pi is not zero here.

> +	/* Add the stop command to the end of the list */
> +	memset(table, 0, sizeof(struct dbdma_cmd));
> +	st_le16(&table->command, DBDMA_STOP);
> +
> +	dev_dbgdma(priv->dev, "%s: %d DMA list entries\n", __func__, pi);
> +}
> +
> +static void pata_macio_bmdma_setup (struct ata_queued_cmd *qc)

                                     ^ Heh heh.  On other BMDMA ops too.

> +static u8 pata_macio_bmdma_status (struct ata_port *ap)
> +{
> +	struct pata_macio_priv *priv = ap->private_data;
> +	u32 dstat, rstat = ATA_DMA_INTR;
> +	unsigned long timeout = 0;
> +
> +	dstat = readl(&priv->dma_regs->status);
> +
> +	dev_dbgdma(priv->dev, "%s: dstat=%x\n", __func__, dstat);
> +
> +	/* We have to things to deal with here:
> +	 *
> +	 * - The dbdma won't stop if the command was started
> +	 * but completed with an error without transferring all
> +	 * datas. This happens when bad blocks are met during
> +	 * a multi-block transfer.
> +	 *
> +	 * - The dbdma fifo hasn't yet finished flushing to
> +	 * to system memory when the disk interrupt occurs.
> +	 *
> +	 */
> +
> +	/* First check for errors */
> +	if ((dstat & (RUN|DEAD)) != RUN)
> +		rstat |= ATA_DMA_ERR;
> +
> +	/* If ACTIVE is cleared, the STOP command have passed and
> +	 * transfer is complete. If not, we to flush the channel.

					missing have?

> +	 */
> +	if ((dstat & ACTIVE) == 0)
> +		return rstat;
> +
> +	dev_dbgdma(priv->dev, "%s: DMA still active, flushing...\n", __func__);
> +
> +	/* If dbdma didn't execute the STOP command yet, the
> +	 * active bit is still set. We consider that we aren't
> +	 * sharing interrupts (which is hopefully the case with

Wouldn't it be better to clear IRQF_SHARED for those?  Also, what
happens w/ irqpoll?

> +	 * those controllers) and so we just try to flush the
> +	 * channel for pending data in the fifo
> +	 */
> +	udelay(1);
> +	writel((FLUSH << 16) | FLUSH, &priv->dma_regs->control);
> +	for (;;) {
> +		udelay(1);
> +		dstat = readl(&priv->dma_regs->status);
> +		if ((dstat & FLUSH) == 0)
> +			break;
> +		if (++timeout > 1000) {
> +			dev_warn(priv->dev, "timeout flushing DMA\n");
> +			rstat |= ATA_DMA_ERR;
> +			break;
> +		}
> +	}
> +	return rstat;
> +}
> +
> +/* port_start is when we allocate the DMA command list */
> +static int pata_macio_port_start (struct ata_port *ap)
> +{
> +	struct pata_macio_priv *priv = ap->private_data;
> +
> +	if (priv->dma_regs == NULL)
> +		return 0;
> +
> +	/* Make sure DMA controller is stopped */
> +	writel((RUN|PAUSE|FLUSH|WAKE|DEAD) << 16, &priv->dma_regs->control);
> +	while (readl(&priv->dma_regs->status) & RUN)
> +		udelay(1);
> +
> +	/* Allocate space for the DBDMA commands.
> +	 *
> +	 * The +2 is +1 for the stop command and +1 to allow for
> +	 * aligning the start address to a multiple of 16 bytes.
> +	 */
> +	priv->dma_table_cpu = dma_alloc_coherent(priv->dev,
> +						 (MAX_DCMDS + 2) * sizeof(struct dbdma_cmd),
> +						 &priv->dma_table_dma, GFP_KERNEL);

dmam_alloc_coherent() maybe?

> +	if (priv->dma_table_cpu == NULL) {
> +		dev_err(priv->dev, "Unable to allocate DMA command list\n");
> +		priv->dma_regs = NULL;
> +	}
> +	return 0;
> +}

> +static int __devinit pata_macio_pci_attach(struct pci_dev *pdev,
> +					   const struct pci_device_id *id)
> +{
> +	struct pata_macio_priv	*priv;
> +	struct device_node	*np;
> +	resource_size_t		rbase;
> +
> +	/* We cannot use a MacIO controller without its OF device node */
> +	np = pci_device_to_OF_node(pdev);
> +	if (np == NULL) {
> +		dev_err(&pdev->dev,
> +			"Cannot find OF device node for controller\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Check that it can be enabled */
> +	if (pci_enable_device(pdev)) {
> +		dev_err(&pdev->dev,
> +			"Cannot enable controller PCI device\n");
> +		return -ENXIO;
> +	}

Maybe pcim_enable_device() can be used?  Or is it difficult because of
the macio stuff?

> +
> +	/* Allocate and init private data structure */
> +	priv = devm_kzalloc(&pdev->dev,
> +			    sizeof(struct pata_macio_priv), GFP_KERNEL);
> +	if (priv == NULL) {
> +		dev_err(&pdev->dev,
> +			"Failed to allocate private memory\n");
> +		return -ENOMEM;
> +	}
> +	priv->node = of_node_get(np);
> +	priv->pdev = pdev;
> +	priv->dev = &pdev->dev;
> +
> +	/* Get MMIO regions */
> +	if (pci_request_regions(pdev, "pata-macio")) {
> +		dev_err(&pdev->dev,
> +			"Cannot obtain PCI resources\n");
> +		return -EBUSY;
> +	}
> +
> +	/* Get register addresses and call common initialization */
> +	rbase = pci_resource_start(pdev, 0);
> +	if (pata_macio_common_init(priv,
> +				   rbase + 0x2000,	/* Taskfile regs */
> +				   rbase + 0x1000,	/* DBDMA regs */
> +				   rbase,		/* Feature control */
> +				   pdev->irq)) {
> +		pci_release_regions(pdev);
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}

Thanks.

-- 
tejun
