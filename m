From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/4] libata: Implement disk shock protection support
Date: Sat, 30 Aug 2008 11:33:26 +0200
Message-ID: <48B913E6.1000104@gmail.com>
References: <87wshzplvk.fsf@denkblock.local> <20080829211345.4355.89284.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:62231 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbYH3Jes (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Aug 2008 05:34:48 -0400
Received: by ti-out-0910.google.com with SMTP id b6so670129tic.23
        for <linux-ide@vger.kernel.org>; Sat, 30 Aug 2008 02:34:46 -0700 (PDT)
In-Reply-To: <20080829211345.4355.89284.stgit@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

Elias Oltmanns wrote:
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index c729e69..78281af 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -316,6 +316,8 @@ static struct device_attribute *ahci_shost_attrs[] = {
>  
>  static struct device_attribute *ahci_sdev_attrs[] = {
>  	&dev_attr_sw_activity,
> +	&dev_attr_unload_feature,
> +	&dev_attr_unload_heads,
>  	NULL

Ehhh... This really should be in libata core layer.  Please create the
default attrs and let ahci define its own.

> index b1d08a8..9b42f8d 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -298,8 +298,15 @@ static struct pci_driver piix_pci_driver = {
>  #endif
>  };
>  
> +static struct device_attribute *piix_sdev_attrs[] = {
> +	&dev_attr_unload_feature,
> +	&dev_attr_unload_heads,
> +	NULL
> +};
> +
>  static struct scsi_host_template piix_sht = {
>  	ATA_BMDMA_SHT(DRV_NAME),
> +	.sdev_attrs		= piix_sdev_attrs,
>  };

Which would make this unnecessary and make disk unloading available to
all libata drivers.

> @@ -5267,6 +5267,8 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>  	init_timer_deferrable(&ap->fastdrain_timer);
>  	ap->fastdrain_timer.function = ata_eh_fastdrain_timerfn;
>  	ap->fastdrain_timer.data = (unsigned long)ap;
> +	ap->park_timer.function = ata_scsi_park_timeout;
> +	init_timer(&ap->park_timer);

Why do you need a timeout when you can just msleep()?

> +static void ata_eh_park_devs(struct ata_port *ap, int park)
> +{
> +	struct ata_link *link;
> +	struct ata_device *dev;
> +	struct ata_taskfile tf;
> +	struct request_queue *q;
> +	unsigned int err_mask;
> +
> +	ata_port_for_each_link(link, ap) {
> +		ata_link_for_each_dev(dev, link) {
> +			if (!dev->sdev)
> +				continue;

You probably want to do if (dev->class != ATA_DEV_ATA) here.

> +			ata_tf_init(dev, &tf);
> +			q = dev->sdev->request_queue;
> +			spin_lock_irq(q->queue_lock);
> +			if (park) {
> +				blk_stop_queue(q);

Queue is already plugged when EH is entered.  No need for this.

> +				tf.command = ATA_CMD_IDLEIMMEDIATE;
> +				tf.feature = 0x44;
> +				tf.lbal = 0x4c;
> +				tf.lbam = 0x4e;
> +				tf.lbah = 0x55;
n> +			} else {
> +				blk_start_queue(q);

Neither this.

> +				tf.command = ATA_CMD_CHK_POWER;
> +			}
> +			spin_unlock(q->queue_lock);
> +			spin_lock(ap->lock);

And no need to play with locks at all.

> +			if (dev->flags & ATA_DFLAG_NO_UNLOAD) {
> +				spin_unlock_irq(ap->lock);
> +				continue;
> +			}
> +			spin_unlock_irq(ap->lock);
> +
> +			tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
> +			tf.protocol |= ATA_PROT_NODATA;
> +			err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE,
> +						     NULL, 0, 0);
> +			if ((err_mask || tf.lbal != 0xc4) && park)
> +				ata_dev_printk(dev, KERN_ERR,
> +					       "head unload failed\n");
> +		}
> +	}
> +}
> +
>  static int ata_eh_revalidate_and_attach(struct ata_link *link,
>  					struct ata_device **r_failed_dev)
>  {
> @@ -2829,6 +2874,12 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
>  		}
>  	}
>  
> +	if (ap->link.eh_context.i.action & ATA_EH_PARK) {
> +		ata_eh_park_devs(ap, 1);
> +		wait_event(ata_scsi_park_wq, !timer_pending(&ap->park_timer));

I would just msleep() here.

> +		ata_eh_park_devs(ap, 0);

And does the device need this explicit wake up?  It will wake up when
it's necessary.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 4d066ad..ffcc016 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -46,6 +46,7 @@
>  #include <linux/libata.h>
>  #include <linux/hdreg.h>
>  #include <linux/uaccess.h>
> +#include <linux/suspend.h>
>  
>  #include "libata.h"
>  
> @@ -113,6 +114,77 @@ static struct scsi_transport_template ata_scsi_transport_template = {
>  	.user_scan		= ata_scsi_user_scan,
>  };
>  
> +DECLARE_WAIT_QUEUE_HEAD(ata_scsi_park_wq);
> +
> +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_HIBERNATION)
> +static atomic_t ata_scsi_park_count = ATOMIC_INIT(0);
> +
> +static int ata_scsi_pm_notifier(struct notifier_block *nb, unsigned long val,
> +				void *null)
> +{
> +	switch (val) {
> +	case PM_SUSPEND_PREPARE:
> +		atomic_dec(&ata_scsi_park_count);
> +		wait_event(ata_scsi_park_wq,
> +			   atomic_read(&ata_scsi_park_count) == -1);
> +		break;
> +	case PM_POST_SUSPEND:
> +		atomic_inc(&ata_scsi_park_count);
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block ata_scsi_pm_notifier_block = {
> +	.notifier_call = ata_scsi_pm_notifier,
> +};
> +
> +int ata_scsi_register_pm_notifier(void)
> +{
> +	return register_pm_notifier(&ata_scsi_pm_notifier_block);
> +}
> +
> +int ata_scsi_unregister_pm_notifier(void)
> +{
> +	return unregister_pm_notifier(&ata_scsi_pm_notifier_block);
> +}

Why are these PM notifiers necessary?

> +static inline void ata_scsi_signal_unpark(void)
> +{
> +	atomic_dec(&ata_scsi_park_count);
> +	wake_up_all(&ata_scsi_park_wq);
> +}
> +
> +static inline int ata_scsi_mod_park_timer(struct timer_list *timer,
> +					  unsigned long timeout)
> +{
> +	if (unlikely(atomic_inc_and_test(&ata_scsi_park_count))) {
> +		ata_scsi_signal_unpark();
> +		return -EBUSY;
> +	}
> +	if (mod_timer(timer, timeout)) {
> +		atomic_dec(&ata_scsi_park_count);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
>
> +#else /* defined(CONFIG_PM_SLEEP) || defined(CONFIG_HIBERNATION) */
> +static inline void ata_scsi_signal_unpark(void)
> +{
> +	wake_up_all(&ata_scsi_park_wq);
> +}
> +
> +static inline int ata_scsi_mod_park_timer(struct timer_list *timer,
> +					  unsigned long timeout)
> +{
> +	return mod_timer(timer, timeout);
> +}
> +#endif /* defined(CONFIG_PM_SLEEP) || defined(CONFIG_HIBERNATION) */

And these all can go.  If you're worried about recurring events you
can just update timestamp from the sysfs write function and do...

    deadline = last_timestamp + delay;
    while ((now = jiffies) < deadline) {
        set_current_state(TASK_UNINTERRUPTIBLE);
	schedule_timeout(deadline - now);
	set_current_state(TASK_RUNNING);
    }

> +static ssize_t ata_scsi_unload_feature_store(struct device *device,
> +					     struct device_attribute *attr,
> +					     const char *buf, size_t len)
> +{
> +	struct scsi_device *sdev = to_scsi_device(device);
> +	struct ata_port *ap;
> +	struct ata_device *dev;
> +	int val;
> +
> +	val = buf[0] - '0';
> +	if ((val != 0 && val != 1) || (buf[1] != '\0' && buf[1] != '\n')
> +	    || buf[2] != '\0')
> +		return -EINVAL;
> +	ap = ata_shost_to_port(sdev->host);
> +	dev = ata_scsi_find_dev(ap, sdev);
> +	if (!dev)
> +		return -ENODEV;
> +	if (dev->class != ATA_DEV_ATA && dev->class != ATA_DEV_ATAPI)
> +		return -EOPNOTSUPP;
> +
> +	spin_lock_irq(ap->lock);
> +	if (val == 1)
> +		dev->flags &= ~ATA_DFLAG_NO_UNLOAD;
> +	else
> +		dev->flags |= ATA_DFLAG_NO_UNLOAD;
> +	spin_unlock_irq(ap->lock);
> +
> +	return len;
> +}
> +DEVICE_ATTR(unload_feature, S_IRUGO | S_IWUSR,
> +	    ata_scsi_unload_feature_show, ata_scsi_unload_feature_store);
> +EXPORT_SYMBOL_GPL(dev_attr_unload_feature);

Hmmm.... Maybe you can just disable it by echoing -1 to the unload file?

Thanks.

-- 
tejun
