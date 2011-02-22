From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V3 2/2] pata_arasan_cf: Adding support for arasan
 compact flash host controller
Date: Tue, 22 Feb 2011 10:14:49 +0100
Message-ID: <20110222091449.GS31267@htj.dyndns.org>
References: <cover.1298358936.git.viresh.kumar@st.com>
 <53bc03306736e6069737aa6344d71d639cea4912.1298358936.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62983 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab1BVJOz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Feb 2011 04:14:55 -0500
Received: by fxm17 with SMTP id 17so2521178fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 22 Feb 2011 01:14:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <53bc03306736e6069737aa6344d71d639cea4912.1298358936.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, shiraz.hashim@st.com, amit.goel@st.com, armando.visconti@st.com, viresh.linux@gmail.com

On Tue, Feb 22, 2011 at 02:32:39PM +0530, Viresh Kumar wrote:
> The Arasan CompactFlash Device Controller has three basic modes of
> operation: PC card ATA using I/O mode, PC card ATA using memory mode, PC card
> ATA using true IDE modes.
> 
> Currently driver supports only True IDE mode.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Looks mostly good to me now but just few more things.

> +static inline void dma_complete(struct arasan_cf_dev *acdev)
> +{
> +	struct ata_queued_cmd *qc = acdev->qc;
> +
> +	acdev->qc = NULL;
> +	ata_sff_interrupt(acdev->irq, acdev->host);
> +
> +	if (unlikely(qc->err_mask) && ata_is_dma(qc->tf.protocol))
> +		ata_ehi_push_desc(&qc->ap->link.eh_info, "DMA Failed: Timeout");
> +}

ata_ehi_push_desc() needs to be called under host lock.  In case I
missed other places, all functions which modify port/host states need
to be called under host lock.  Please make sure they are.

> +void arasan_cf_error_handler(struct ata_port *ap)
> +{
> +	struct arasan_cf_dev *acdev = ap->host->private_data;
> +
> +	cancel_work_sync(&acdev->work);
> +	cancel_delayed_work_sync(&acdev->dwork);
> +	return ata_sff_error_handler(ap);
> +}

Please add some comments explaining what's going on with DMA
processing as this driver is quite unusual.  Here and in the issue
path.

> +static int __devinit arasan_cf_probe(struct platform_device *pdev)
> +{
...
> +	ap->flags |= ATA_FLAG_PIO_POLLING;

Maybe ATA_FLAG_NO_ATAPI too?

Thanks.

-- 
tejun
