From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] pata_arasan_cf: Adding support for arasan compact flash
 host controller
Date: Fri, 18 Feb 2011 10:09:50 +0530
Message-ID: <4D5DF816.4010907@st.com>
References: <0f2a633873dd2fa187afd7feef9fd71daa545b84.1297942328.git.viresh.kumar@st.com> <20110217145235.GY19830@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:38124 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752330Ab1BREkI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2011 23:40:08 -0500
In-Reply-To: <20110217145235.GY19830@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, amitgoel <amit.goel@st.com>, Armando VISCONTI <armando.visconti@st.com>, jgarzik@pobox.com, viresh kumar <viresh.linux@gmail.com>

On 02/17/2011 08:22 PM, Tejun Heo wrote:
> Hello,
> 
> It would probably a good idea to add Jeff Garzik <jgarzik@pobox.com>
> to your To: list.
> 

Ok.

> On Thu, Feb 17, 2011 at 05:04:19PM +0530, Viresh Kumar wrote:
>> +/**
>> + * struct arasan_cf_dev - CF controllers dev structure
>> + * @ host: pointer to ata_host structure
>> + * @ clk: clk structure, only if HAVE_CLK is defined
>> + * @ pbase: physical base address of controller
>> + * @ vbase: virtual base address of controller
>> + * @ dma_status: status to be updated to framework regarding DMA transfer
>> + * @ card_present: Card is present or Not
>> + * @ cf_completion: Completion for transfer complete interrupt from controller
>> + * @ dma_completion: Completion for DMA transfer complete.
>> + * @ dma_chan: Dma channel allocated
>> + * @ mask: Mask for DMA transfers
>> + * @ wq: Workqueue for DMA transfers
>> + * @ work: DMA transfer work
>> + * @ qc: qc to be transferred using DMA
>> + */
>> +struct arasan_cf_dev {
>> +	struct ata_host *host;
>> +#if defined(CONFIG_HAVE_CLK)
>> +	struct clk *clk;
>> +#endif
>> +
>> +	dma_addr_t pbase;
>> +	void __iomem *vbase;
>> +
>> +	u8 dma_status;
>> +	u8 card_present;
>> +
>> +	/* dma specific */
>> +	struct completion cf_completion;
>> +	struct completion dma_completion;
>> +	struct dma_chan *dma_chan;
>> +	dma_cap_mask_t mask;
>> +	struct workqueue_struct *wq;
>> +	struct work_struct work;
>> +	struct ata_queued_cmd *qc;
>> +};
> 
> I usually prefer struct field explanations mixed with definition
> itself.  Out-of-line comments like the above often get out of sync
> unnoticed.
> 

Ok. Will do that.

>> +/* Enable/Disable global interrupts shared between CF and XD ctrlr. */
>> +static void cf_ginterrupt_enable(struct arasan_cf_dev *acdev, u8 enable)
>> +{
>> +	/* enable should be 0 or 1 */
>> +	writel(enable, acdev->vbase + GIRQ_STS_EN);
>> +	writel(enable, acdev->vbase + GIRQ_SGN_EN);
>> +}
> 
> Why not take bool?
> 
>> +/* Enable/Disable CF interrupts */
>> +static void
>> +cf_interrupt_enable(struct arasan_cf_dev *acdev, u32 mask, u8 enable)
> 
> Ditto.
> 
>> +static void cf_card_detect(struct arasan_cf_dev *acdev, u32 hotplugged)
> 
> Ditto.
> 

Will use bool

>> +static int
>> +dma_xfer(struct arasan_cf_dev *acdev, dma_addr_t src, dma_addr_t dest, u32 len)
>> +{
>> +	struct dma_async_tx_descriptor *tx;
>> +	struct dma_chan *chan = acdev->dma_chan;
>> +	dma_cookie_t cookie;
>> +	unsigned long flags = DMA_PREP_INTERRUPT | DMA_COMPL_SKIP_SRC_UNMAP |
>> +		DMA_COMPL_SKIP_DEST_UNMAP;
>> +	int ret = 0;
>> +
>> +	tx = chan->device->device_prep_dma_memcpy(chan, dest, src, len, flags);
>> +	if (!tx) {
>> +		dev_err(acdev->host->dev, "device_prep_dma_memcpy failed\n");
>> +		return -EAGAIN;
>> +	}
>> +
>> +	tx->callback = dma_callback;
>> +	tx->callback_param = acdev;
>> +	cookie = tx->tx_submit(tx);
>> +
>> +	ret = dma_submit_error(cookie);
>> +	if (ret) {
>> +		dev_err(acdev->host->dev, "dma_submit_error\n");
>> +		return ret;
>> +	}
>> +
>> +	chan->device->device_issue_pending(chan);
>> +
>> +	/* Wait for DMA to complete */
>> +	if (!wait_for_completion_timeout(&acdev->dma_completion, TIMEOUT)) {
>> +		chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
>> +		dev_err(acdev->host->dev, "wait_for_completion_timeout\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	return ret;
>> +}
> 
> Interesting.  I think this would be the first driver to use workqueue
> to execute DMA.  Why do you need process context?  I'm not against it
> but just curious.  Is it because iterating through the transfer list
> asynchronously is too hairy?  Or do some of the dma operations
> actually require process context?  It would be nice to add comments
> explaining why it's done differently in this driver.
> 

dma_request_channel calls kzalloc and thus i needed process context.
Ya. i will added comment for that.

>> +static void data_xfer(struct work_struct *work)
>> +{
>> +	struct arasan_cf_dev *acdev = container_of(work, struct arasan_cf_dev,
>> +			work);
>> +	struct ata_queued_cmd *qc = acdev->qc;
>> +	struct scatterlist *sg;
>> +	u32 temp;
>> +	int ret = 0;
>> +
>> +	/* request dma channels */
>> +	acdev->dma_chan = dma_request_channel(acdev->mask, filter, NULL);
>> +	if (!acdev->dma_chan) {
>> +		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
>> +		goto chan_request_fail;
>> +	}
>> +
>> +	for_each_sg(qc->sg, sg, qc->n_elem, temp) {
>> +		ret = sg_xfer(acdev, sg);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +	dma_release_channel(acdev->dma_chan);
>> +
>> +	if (!ret) {
>> +		acdev->dma_status |= ATA_DMA_INTR;
>> +		goto bmdma_port_intr;
>> +	}
>> +
>> +	cf_ctrl_reset(acdev);
>> +	cf_dumpregs(acdev);
>> +chan_request_fail:
>> +	acdev->dma_status = ATA_DMA_INTR | ATA_DMA_ERR;
>> +bmdma_port_intr:
>> +	ata_bmdma_port_intr(qc->ap, qc);
>> +}
> 
> Hmmm... You should be holding ap->lock before calling into
> ata_bmdma_port_intr().  Also, how is the exclusion achieved against
> EH?  What guarantees that when EH kicks in this work item is not
> executing concurrently?  For other drivers, ap->lock, freeze() method
> and the default ata_sff_flush_pio_task(ap) call are used for that
> purpose but I don't see anything equivalent here.
> 

Ok. I will check that with other drivers and will fix this issue.

>> +static irqreturn_t arasan_cf_interrupt(int irq, void *dev)
>> +{
>> +	struct arasan_cf_dev *acdev = ((struct ata_host *)dev)->private_data;
>> +	u32 irqsts;
>> +
>> +	irqsts = readl(acdev->vbase + GIRQ_STS);
>> +	if (!(irqsts & GIRQ_CF))
>> +		return IRQ_NONE;
>> +
>> +	irqsts = readl(acdev->vbase + IRQ_STS);
>> +	writel(irqsts, acdev->vbase + IRQ_STS);		/* clear irqs */
>> +	writel(GIRQ_CF, acdev->vbase + GIRQ_STS);	/* clear girqs */
>> +
>> +	/* handle only relevant interrupts */
>> +	irqsts &= ~IGNORED_IRQS;
>> +
>> +	if (irqsts & CARD_DETECT_IRQ) {
>> +		cf_card_detect(acdev, 1);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	if (irqsts & PIO_XFER_ERR_IRQ) {
>> +		acdev->dma_status = ATA_DMA_INTR | ATA_DMA_ERR;
>> +		writel(readl(acdev->vbase + XFER_CTR) & ~XFER_START,
>> +				acdev->vbase + XFER_CTR);
>> +		complete(&acdev->cf_completion);
>> +		dev_err(acdev->host->dev, "pio xfer err irq\n");
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	if (irqsts & BUF_AVAIL_IRQ) {
>> +		complete(&acdev->cf_completion);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	if (irqsts & XFER_DONE_IRQ) {
>> +		struct ata_queued_cmd *qc = acdev->qc;
>> +
>> +		/* Send Complete only for write */
>> +		if (qc->tf.flags & ATA_TFLAG_WRITE)
>> +			complete(&acdev->cf_completion);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
> Again, no exclusion?  cf_card_detect() may call ata_ehi_hotplugged()
> which definitely should be called under the host lock.  Also, all the
> hardware accesses should occur while holding the host lock.
> 

Will check that too.

>> +static void arasan_cf_bmdma_setup(struct ata_queued_cmd *qc)
>> +static void arasan_cf_bmdma_start(struct ata_queued_cmd *qc)
>> +static void arasan_cf_bmdma_stop(struct ata_queued_cmd *qc)
>> +static u8 arasan_cf_bmdma_status(struct ata_port *ap)
>> +static int arasan_cf_port_start(struct ata_port *ap)
>> +static void arasan_cf_bmdma_irq_clear(struct ata_port *ap)
> 
> Hmm... the controller doesn't really have BMDMA, right?  Is there any
> reason to emulate BMDMA behavior?  Why not just override qc_issue?  Do
> some parts behave like standard BMDMA?
> 

No. It doesn't have BMDMA. I just wanted to use existing framework and
routines. And i wasn't sure if just overriding qc_issue alone will be enough.
Should i keep it as it is or modify?

>> +	acdev->wq = create_singlethread_workqueue(DRIVER_NAME);
>> +	if (!acdev->wq) {
>> +		ret = -ENOMEM;
>> +		goto err_wq;
>> +	}
> 
> I think it might be better to add ata_sff_queue_work() and thus use
> ata_sff_wq.  That way, you don't have to worry about flushing it on EH
> entry.
> 

Ok. I will add this routine in libata-sff.c.

>> +	if (ap->mwdma_mask | ap->udma_mask) {
>> +		ap->ops->inherits = &ata_bmdma_port_ops;
>> +		ap->ops->set_dmamode = arasan_cf_set_dmamode;
>> +		ap->ops->bmdma_setup = arasan_cf_bmdma_setup;
>> +		ap->ops->bmdma_start = arasan_cf_bmdma_start;
>> +		ap->ops->bmdma_stop = arasan_cf_bmdma_stop;
>> +		ap->ops->bmdma_status = arasan_cf_bmdma_status;
>> +		ap->ops->port_start = arasan_cf_port_start;
>> +		ap->ops->sff_irq_clear = arasan_cf_bmdma_irq_clear;
>> +	}
> 
> Hmmm... I don't think it would be necessary to change these
> operations.  There's only one copy of this operation and it doesn't
> make much sense to override them dynamically depending on the specific
> controller.  You can just clear the dma_mask's and libata should
> behave correctly.
> 

Ok.

>> +	ap->flags |= ATA_FLAG_NO_LEGACY | ATA_FLAG_PIO_POLLING;
> 
> IIRC, NO_LEGACY flag is no longer necessary.
> 

will be removed.

>> +#if defined(CONFIG_HAVE_CLK)
>> +	clk_put(acdev->clk);
>> +#endif
> 
> It might be better to create a wrapper at the top so that you don't
> have to do #ifdeffery many times?
> 

Actually there are different routines to call, clk_enable, clk_disable, clk_get, 
clk_put, struct clk *clk.

And i am not getting how to create a single macro to suit all these routines.

>> diff --git a/drivers/ata/pata_arasan_cf.h b/drivers/ata/pata_arasan_cf.h
>> diff --git a/include/linux/pata_arasan_cf_data.h b/include/linux/pata_arasan_cf_data.h
> 
> Why do these header files needed?  Unless the driver is gonna be put
> in multiple .c files, there's no reason to separate out header files.
> 

Ok. include/linux/pata_arasan_cf_data.h is surely required as it will be
used by platforms also. I kept register macros in a separate file to keep .c
clean. I will merge drivers/ata/pata_arasan_cf.h in .c, if you want me to.

-- 
viresh
