From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 08/14] libata-eh: implement ata_eh_revive()
Date: Wed, 19 Apr 2006 17:08:41 +0800
Message-ID: <1145437721.3417.16.camel@forrest26.sh.intel.com>
References: <11447633023982-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15960 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750806AbWDSJTB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Apr 2006 05:19:01 -0400
In-Reply-To: <11447633023982-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

On Tue, 2006-04-11 at 22:48 +0900, Tejun Heo wrote:
> +
> +/**
> + *	ata_eh_revive - revive host port after error
> + *	@ap: host port to revive
> + *	@action: action to perform to revive @ap
> + *	@softreset: softreset method (can be NULL)
> + *	@hardreset: hardreset method (can be NULL)
> + *	@postreset: postreset method (can be NULL)
> + *
> + *	Perform action specified by @action to revive host port @ap
> + *	after error.
> + *
> + *	LOCKING:
> + *	Kernel thread context (may sleep).
> + */
> +int ata_eh_revive(struct ata_port *ap, unsigned int action,
> +		  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
> +		  ata_postreset_fn_t postreset)
> +{
> +	int scr_valid = ap->cbl == ATA_CBL_SATA && ap->ops->scr_read;
> +	unsigned int classes[ATA_MAX_DEVICES];
> +	int tries[ATA_MAX_DEVICES], reset_tries, nr_enabled;
> +	struct ata_device *dev;
> +	ata_reset_fn_t reset;
> +	int i, down_xfermask, rc = 0;
> +
> +	if (!action)
> +		goto out;
> +
> +	reset_tries = ATA_EH_MAX_TRIES;
> +	nr_enabled = 0;
> +	for (i = 0; i < ATA_MAX_DEVICES; i++) {
> +		tries[i] = ATA_EH_MAX_TRIES;
> +		if (ata_dev_enabled(&ap->device[i]))
> +			nr_enabled++;
> +	}
> +
> +	/* revalidate */
> +	if (action == ATA_PORT_REVALIDATE) {
> +		for (i = 0; i < ATA_MAX_DEVICES; i++) {
> +			struct ata_device *dev = &ap->device[i];
> +			if (!ata_dev_enabled(dev) ||
> +			    !(dev->flags & ATA_DFLAG_FAILED))
> +				continue;
> +			if (ata_dev_revalidate(ap, dev, 0))
> +				break;
> +		}
> +		if (i == ATA_MAX_DEVICES) {
> +			rc = 0;
> +			goto out;
> +		}
> +
> +		action |= ATA_PORT_SOFTRESET;
> +	}
> +	action &= ~ATA_PORT_REVALIDATE;
> +
> +	/* Skip reset if possible. */
> +	if (!nr_enabled && !(ap->flags & ATA_FLAG_FROZEN))
> +		goto out;
> +
> +	/* give devices some time to breath */
> +	ata_eh_wait_before_reset(ap);
> +
> +	if (softreset && (!hardreset || (!ata_set_sata_spd_needed(ap) &&
> +					 action == ATA_PORT_SOFTRESET)))
> +		reset = softreset;
> +	else
> +		reset = hardreset;
> +
> + retry:
> +	down_xfermask = 0;
> +
> +	/* reset.  postreset is responsible for thawing the port. */
> +	printk("ata%u: %s resetting channel for error handling\n",
> +	       ap->id, reset == softreset ? "soft" : "hard");
> +
> +	rc = ata_do_reset(ap, reset, postreset, classes);
> +	if (rc)
> +		goto fail_reset;
> +
> +	/* revalidate and reconfigure devices */
> +	for (i = 0; i < ATA_MAX_DEVICES; i++) {
> +		dev = &ap->device[i];
> +
> +		if (!ata_dev_enabled(dev))
> +			continue;
> +
> +		if (scr_valid && !sata_dev_present(ap)) {
> +			rc = -EIO;
> +			goto fail;
> +		}
> +
> +		rc = ata_dev_revalidate(ap, dev, 1);
> +		if (rc)
> +			goto fail;
> +	}
> +
> +	/* configure transfer mode */
> +	if (ap->ops->set_mode) {
> +		/* FIXME: make ->set_mode handle no device case and
> +		 * return error code and failing device on failure as
> +		 * ata_set_mode() does.
> +		 */
> +		for (i = 0; i < ATA_MAX_DEVICES; i++)
> +			if (ata_dev_enabled(&ap->device[i])) {
> +				ap->ops->set_mode(ap);
> +				break;
> +			}
> +		rc = 0;
> +	} else
> +		rc = ata_set_mode(ap, &dev);
> +
> +	if (rc) {
> +		down_xfermask = 1;
> +		goto fail;
> +	}
> +
> +	goto out;
> +
> + fail_reset:
> +	if (!--reset_tries) {
> +		printk(KERN_ERR "ata%u: EH reset failed, giving up\n", ap->id);
> +		goto out;
> +	}
> +	if (reset == hardreset)
> +		ata_down_sata_spd_limit(ap);
> +	if (hardreset)
> +		reset = hardreset;
> +
> +	printk(KERN_WARNING "ata%u: EH reset failed, will retry in 5 secs\n",
> +	       ap->id);
> +	ssleep(5);
> +	goto retry;
> +
> + fail:
> +	switch (rc) {
> +	case -EINVAL:
> +	case -ENODEV:
> +		tries[dev->devno] = 0;
> +		break;
> +	case -EIO:
> +		ata_down_sata_spd_limit(ap);
> +	default:
> +		tries[dev->devno]--;
> +		if (down_xfermask &&
> +		    ata_down_xfermask_limit(ap, dev, tries[dev->devno] == 1))
> +			tries[dev->devno] = 0;
> +	}
> +
> +	if (!tries[dev->devno]) {
> +		ata_dev_disable(ap, dev);
> +		nr_enabled--;
> +	}
> +
> +	if (nr_enabled) {
> +		printk(KERN_WARNING "ata%u: some devices seem to be offline, "
> +		       "will retry in 5 secs\n", ap->id);
> +		ssleep(5);
> +	} else {
> +		/* no device left, repeat fast */
> +		msleep(500);
> +	}
> +
> +	if (hardreset)
> +		reset = hardreset;
> +	goto retry;
> +
> + out:
> +	for (i = 0; i < ATA_MAX_DEVICES; i++) {
> +		dev = &ap->device[i];
> +		dev->flags &= ~ATA_DFLAG_FAILED;
> +		if (rc)
> +			ata_dev_disable(ap, dev);
> +	}
> +
> +	return rc;
> +}
Tejun,

I did some initial hotplug test in our lab today. And
this is the printk output in dmesg when I unplug the
SATA disk at port 2:

ata2: stat 0x50 err 0x0 SError 0x90402 action 0x2
      (irq_stat 0x04400000, PHY RDY changed)
ata2: soft resetting channel for error handling
ata2: SATA link down (SStatus 21 SControl 300)
ata2: limiting SATA link speed to 1.5 Gbps
ata2: some devices seem to be offline, will retry in 5 secs
ata2: hard resetting channel for error handling
ata2: SATA link down (SStatus 0 SControl 310)
ata2: some devices seem to be offline, will retry in 5 secs
ata2: hard resetting channel for error handling
ata2: SATA link down (SStatus 0 SControl 310)
ata2: dev 0 disabled
// why hard reset again??
ata2: hard resetting channel for error handling
ata2: SATA link down (SStatus 0 SControl 310)
// ??
ata2: dev 0 detaching (SCSI 1:0:0:0)


My question is: why hard-reset is executed again after
dev0 at ata2 has been disabled?

Could you help me understand the idea behind this logic?

Thanks,
Forrest



