From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/4] libata: Implement disk shock protection support
Date: Wed, 10 Sep 2008 16:40:21 +0200
Message-ID: <48C7DC55.30002@gmail.com>
References: <87wshzplvk.fsf@denkblock.local>	<20080829211345.4355.89284.stgit@denkblock.local>	<48B913E6.1000104@gmail.com> <87k5dym5t9.fsf@denkblock.local>	<48BA638B.2030001@gmail.com> <87ej45mlp3.fsf@denkblock.local>	<48BA969C.4060207@gmail.com> <87abetmaap.fsf@denkblock.local>	<48BBA8D1.8020604@gmail.com> <87myirly1p.fsf@denkblock.local>	<48BC1BB8.2030007@gmail.com> <87fxoh0yil.fsf@denkblock.local>	<48BFA528.2040305@gmail.com> <87ej3zrf3o.fsf@denkblock.local>	<48C0F2F8.1040308@gmail.com> <87ej3snm3s.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:41765 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbYIJOmI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Sep 2008 10:42:08 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1621831tic.23
        for <linux-ide@vger.kernel.org>; Wed, 10 Sep 2008 07:42:06 -0700 (PDT)
In-Reply-To: <87ej3snm3s.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Elias.

Elias Oltmanns wrote:
> Does the following patch look like what you've had in mind (still
> applies to next-20080903)?

Yes, mostly.  Just a few points.

> +static unsigned long ata_eh_park_devs(struct ata_port *ap)
> +{
> +	struct ata_link *link;
> +	struct ata_device *dev;
> +	struct ata_taskfile tf;
> +	unsigned int err_mask;
> +	unsigned long deadline = jiffies;
> +
> +	ata_port_for_each_link(link, ap) {
> +		ata_link_for_each_dev(dev, link) {
> +			struct ata_eh_context *ehc = &link->eh_context;
> +			struct ata_eh_info *ehi = &link->eh_info;
> +
> +			if (dev->class != ATA_DEV_ATA ||
> +			    dev->flags & ATA_DFLAG_NO_UNLOAD)
> +				continue;
> +
> +			if (ehc->i.dev_action[dev->devno] & ATA_EH_PARK ||
> +			    ehi->dev_action[dev->devno] & ATA_EH_PARK) {
> +				unsigned long tmp = dev->unpark_deadline;

The correct way to do this is ata_eh_about_to_do().  After that, you
can just look at ehc->i.dev_action[].  Also, you'll need to call
ata_eh_done() later.

> +				if (time_before(deadline, tmp))
> +					deadline = tmp;
> +				else if (time_before_eq(tmp, jiffies))
> +					continue;
> +			}
> +
> +			if (ehc->did_unload_mask & (1 << dev->devno))
> +				continue;
> +
> +			ata_tf_init(dev, &tf);
> +			tf.command = ATA_CMD_IDLEIMMEDIATE;
> +			tf.feature = 0x44;
> +			tf.lbal = 0x4c;
> +			tf.lbam = 0x4e;
> +			tf.lbah = 0x55;
> +			tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
> +			tf.protocol |= ATA_PROT_NODATA;
> +			err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE,
> +						     NULL, 0, 0);
> +			if (err_mask || tf.lbal != 0xc4)
> +				ata_dev_printk(dev, KERN_ERR,
> +					       "head unload failed!\n");
> +			else
> +				ehc->did_unload_mask |= 1 << dev->devno;
...
> +static void ata_eh_unpark_devs(struct ata_port *ap)
> +{
> +	struct ata_link *link;
> +	struct ata_device *dev;
> +	struct ata_taskfile tf;
> +
> +	ata_port_for_each_link(link, ap) {
> +		ata_link_for_each_dev(dev, link) {
> +			struct ata_eh_context *ehc = &link->eh_context;
> +
> +			if (!(ehc->did_unload_mask & (1 << dev->devno)))
> +				continue;
> +
> +			ata_tf_init(dev, &tf);
> +			tf.command = ATA_CMD_CHK_POWER;
> +			tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
> +			tf.protocol |= ATA_PROT_NODATA;
> +			ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);

And it's probably better to have ehc->unloaded_mask instead of
ehc->did_unload_mask and clear it here so that if unload is scheduled
after this point but before EH completes, it does unloading again.
ie. Something like the following.

	ata_eh_done(ATA_EH_UNLOAD);
	ehc->i.unloaded_mask &= ~(1 << dev->devno);

> @@ -2830,6 +2904,19 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
>  		}
>  	}
>  
> +	do {
> +		unsigned long now;
> +
> +		deadline = ata_eh_park_devs(ap);
> +		now = jiffies;
> +		if (time_before_eq(deadline, now))
> +			break;
> +		prepare_to_wait(&ata_scsi_park_wq, &wait, TASK_UNINTERRUPTIBLE);
> +		deadline = schedule_timeout_uninterruptible(deadline - now);
> +	} while (deadline);
> +	finish_wait(&ata_scsi_park_wq, &wait);
> +	ata_eh_unpark_devs(ap);

I think it would be better to put timeout computation and handling out
here instead of inside ata_eh_park_devs().  ata_eh_park_devs() just
parks the heads if ATA_DEV_UNLOAD and the outer loop controls when it
can continue.

> +static ssize_t ata_scsi_park_store(struct device *device,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
...

> +		switch (input) {
> +		case -1:
> +			dev->flags &= ~ATA_DFLAG_NO_UNLOAD;
> +			break;
> +		case -2:
> +			dev->flags |= ATA_DFLAG_NO_UNLOAD;
> +			break;

Can't we just drop ATA_DFLAG_NO_UNLOAD?  It doesn't provide any real
functionality anymore.

Thanks.

-- 
tejun
