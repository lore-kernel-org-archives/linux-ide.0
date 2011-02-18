From: viresh kumar <viresh.linux@gmail.com>
Subject: Re: [PATCH V2 2/2] pata_arasan_cf: Adding support for arasan compact
 flash host controller
Date: Fri, 18 Feb 2011 22:28:51 +0530
Message-ID: <AANLkTi=bK54_OEFh=Fhx9N8TxVcFxUFYJm8XS=MKZdG2@mail.gmail.com>
References: <cover.1298029161.git.viresh.kumar@st.com>
	<e2f140271f9db752fdc05e348065b23fc4e4aa29.1298029161.git.viresh.kumar@st.com>
	<20110218143438.GK21209@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47735 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202Ab1BRQ6w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2011 11:58:52 -0500
Received: by gxk9 with SMTP id 9so1558233gxk.19
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2011 08:58:52 -0800 (PST)
In-Reply-To: <20110218143438.GK21209@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ejun Heo <tj@kernel.org>
Cc: Viresh Kumar <viresh.kumar@st.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, shiraz.hashim@st.com, armando.visconti@st.com, amit.goel@st.com

On 2/18/11, Tejun Heo <tj@kernel.org> wrote:
> On Fri, Feb 18, 2011 at 05:10:14PM +0530, Viresh Kumar wrote:
>> +static struct scsi_host_template arasan_cf_sht = {
>> +	ATA_PIO_SHT(DRIVER_NAME),
>> +};
>
> Hmmm... You probably have different requirements for .sg_tablesize and
> .dma_boundary, likely to be more lax.
>

I will recheck this structure.

>> +static inline void cf_ctrl_reset(struct arasan_cf_dev *acdev)
>> +{
>> +	writel(readl(acdev->vbase + OP_MODE) & ~CFHOST_ENB, acdev->vbase +
>> +			OP_MODE);
>> +	writel(readl(acdev->vbase + OP_MODE) | CFHOST_ENB, acdev->vbase +
>> +			OP_MODE);
>> +}
>
> No big deal but I think the following is more preferrable.
>
> 	writel(readl(acdev->vbase + OP_MODE) & ~CFHOST_ENB,
> 	       acdev->vbase + OP_MODE);
>
> Applies to other similar line breaks too.
>

Ok

>> +static inline void dma_complete(struct arasan_cf_dev *acdev)
>> +{
>> +	struct ata_queued_cmd *qc = acdev->qc;
>> +
>> +	acdev->qc = NULL;
>> +	ata_sff_interrupt(acdev->irq, acdev->host);
>> +
>> +	if (unlikely(qc->err_mask) && ata_is_dma(qc->tf.protocol))
>> +		ata_ehi_push_desc(&qc->ap->link.eh_info, "DMA stat 0x%x",
>> +				ATA_DMA_INTR | ATA_DMA_ERR);
>> +}
>
> Those are BMDMA status bits, right?  Why not just print out string
> describing what's going on?
>

Ok.

>> +static inline int wait4buf(struct arasan_cf_dev *acdev)
>> +{
>> +	if (!wait_for_completion_timeout(&acdev->cf_completion, TIMEOUT)) {
>> +		u32 rw = acdev->qc->tf.flags & ATA_TFLAG_WRITE;
>> +
>> +		dev_err(acdev->host->dev, "%s TimeOut", rw ? "write" : "read");
>> +		return -ETIMEDOUT;
>> +	}
>
> Like here.
>
> Hmmm... so, now there's a work item which requeues itself.  That can't
> be reliably stopped from freeze() as it's called with host lock held
> without process context.  I think you should override
> ->error_handler() which looks like the following,
>

actually i am disabling controller in freeze. After which we will
surely get timeout here and
so finally we will get an error in this work. Wouldn't that be enough?

> arsan_error_handler(...)
> {
> 	cancel_work_sync(...);
> 	cancel_delayed_work_sync(...);
>
> 	return ata_sff_error_handler(xxx);
> }
>

thanks for your time & feedback.

--
viresh
