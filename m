From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/4] ide: Implement disk shock protection support
Date: Mon, 1 Sep 2008 21:29:14 +0200
Message-ID: <200809012129.14979.bzolnier@gmail.com>
References: <87wshzplvk.fsf@denkblock.local> <20080829211345.4355.93873.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.183]:7393 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbYIATcP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Sep 2008 15:32:15 -0400
Received: by ik-out-1112.google.com with SMTP id c28so867292ika.5
        for <linux-ide@vger.kernel.org>; Mon, 01 Sep 2008 12:32:13 -0700 (PDT)
In-Reply-To: <20080829211345.4355.93873.stgit@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Friday 29 August 2008, Elias Oltmanns wrote:
> On user request (through sysfs), the IDLE IMMEDIATE command with UNLOAD
> FEATURE as specified in ATA-7 is issued to the device and processing of
> the request queue is stopped thereafter until the speified timeout
> expires or user space asks to resume normal operation. This is supposed
> to prevent the heads of a hard drive from accidentally crashing onto the
> platter when a heavy shock is anticipated (like a falling laptop
> expected to hit the floor). In fact, the whole port stops processing
> commands until the timeout has expired in order to avoid resets due to
> failed commands on another device.
> 
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>

[ continuing the discussion from 'patch #2' thread ]

While I'm still not fully convinced this is the best way to go in
the long-term I'm well aware that if we won't get in 2.6.28 it will
mean at least 3 more months until it hits users so lets concentrate
on existing user/kernel-space solution first...

There are some issues to address before it can go in but once they
are fixed I'm fine with the patch and I'll merge it as soon as patches
#1-2 are in.

[...]

> @@ -842,6 +842,9 @@ static void ide_port_tune_devices(ide_hwif_t *hwif)
>  
>  			if (hwif->dma_ops)
>  				ide_set_dma(drive);
> +
> +			if (!ata_id_has_unload(drive->id))
> +				drive->dev_flags |= IDE_DFLAG_NO_UNLOAD;

ide_port_tune_devices() is not a best suited place for it,
please move it to ide_port_init_devices().

[...]

> +static int issue_park_cmd(ide_drive_t *drive, struct completion *wait,
> +			  u8 op_code)
> +{
> +	ide_drive_t *odrive = drive;
> +	ide_hwif_t *hwif = drive->hwif;
> +	ide_hwgroup_t *hwgroup = hwif->hwgroup;
> +	struct request_queue *q;
> +	struct request *rq;
> +	gfp_t gfp_mask = (op_code == REQ_PARK_HEADS) ? __GFP_WAIT : GFP_NOWAIT;
> +	int count = 0;
> +
> +	do {
> +		q = drive->queue;
> +		if (drive->dev_flags & IDE_DFLAG_SLEEPING
> +		    && op_code == REQ_PARK_HEADS) {
> +			drive->sleep = hwif->park_timer.expires;
> +			goto next_step;
> +		}
> +
> +		if (unlikely(drive->dev_flags & IDE_DFLAG_NO_UNLOAD
> +			     && op_code == REQ_UNPARK_HEADS))
> +			goto resume;
> +
> +		spin_unlock_irq(&ide_lock);
> +		rq = blk_get_request(q, READ, gfp_mask);
> +		spin_lock_irq(&ide_lock);
> +		if (unlikely(!rq))
> +			goto resume;
> +
> +		rq->cmd[0] = op_code;
> +		rq->cmd_len = 1;
> +		rq->cmd_type = REQ_TYPE_SPECIAL;
> +		rq->cmd_flags |= REQ_SOFTBARRIER;

No need to hold ide_lock for rq manipulations.

> +		__elv_add_request(q, rq, ELEVATOR_INSERT_FRONT, 0);
> +		if (op_code == REQ_PARK_HEADS) {
> +			rq->end_io_data = wait;
> +			blk_stop_queue(q);
> +			q->request_fn(q);
> +			count++;
> +		} else {
> +resume:
> +			drive->dev_flags &= ~IDE_DFLAG_SLEEPING;
> +			if (hwgroup->sleeping) {
> +				del_timer(&hwgroup->timer);
> +				hwgroup->sleeping = 0;
> +				hwgroup->busy = 0;
> +			}
> +			blk_start_queue(q);
> +		}
> +
> +next_step:
> +		do {
> +			drive = drive->next;
> +		} while (drive->hwif != hwif);
> +	} while (drive != odrive);
> +
> +	return count;
> +}
> +
> +static void unpark_work(struct work_struct *work)
> +{
> +	ide_hwif_t *hwif = container_of(work, ide_hwif_t, unpark_work);
> +	ide_drive_t *drive;
> +
> +	mutex_lock(&ide_setting_mtx);

No need to hold ide_setting_mtx here.

> +	spin_lock_irq(&ide_lock);
> +	if (unlikely(!hwif->present || timer_pending(&hwif->park_timer)))
> +		goto done;
> +
> +	drive = hwif->hwgroup->drive;
> +	while (drive->hwif != hwif)
> +		drive = drive->next;

How's about just looping on hwif->drives[] instead?

[ this would also allow removal of loops in issue_park_cmd()
  and simplify locking there ]

> +
> +	issue_park_cmd(drive, NULL, REQ_UNPARK_HEADS);
> +done:
> +	signal_unpark();
> +	spin_unlock_irq(&ide_lock);
> +	mutex_unlock(&ide_setting_mtx);
> +	put_device(&hwif->gendev);
> +}
> +
> +static void park_timeout(unsigned long data)
> +{
> +	ide_hwif_t *hwif = (ide_hwif_t *)data;
> +
> +	/* FIXME: Which work queue would be the right one? */

There is only one in ide. ;)

> +	kblockd_schedule_work(NULL, &hwif->unpark_work);
> +}
> +
>  static void ide_port_init_devices_data(ide_hwif_t *);
>  
>  /*

> @@ -581,6 +746,118 @@ static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>  	return sprintf(buf, "%s\n", (char *)&drive->id[ATA_ID_SERNO]);
>  }
>  
> +static ssize_t park_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	ide_drive_t *drive = to_ide_device(dev);
> +	ide_hwif_t *hwif = drive->hwif;
> +	unsigned int seconds;
> +
> +	spin_lock_irq(&ide_lock);
> +	if (!(drive->dev_flags & IDE_DFLAG_PRESENT)) {
> +		spin_unlock_irq(&ide_lock);
> +		return -ENODEV;
> +	}

This is unnecessary (IDE_DFLAG_PRESENT won't be cleared as long
as there are references on &drive->gendev and we should have such
reference if we got here).

> +	if (timer_pending(&hwif->park_timer))
> +		/*
> +		 * Adding 1 in order to guarantee nonzero value until timer
> +		 * has actually expired.
> +		 */
> +		seconds = jiffies_to_msecs(hwif->park_timer.expires - jiffies)
> +			  / 1000 + 1;
> +	else
> +		seconds = 0;
> +	spin_unlock_irq(&ide_lock);
> +
> +	return snprintf(buf, 20, "%u\n", seconds);
> +}
> +
> +static ssize_t park_store(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t len)
> +{
> +#define MAX_PARK_TIMEOUT 30
> +	ide_drive_t *drive = to_ide_device(dev);
> +	ide_hwif_t *hwif = drive->hwif;
> +	DECLARE_COMPLETION_ONSTACK(wait);
> +	unsigned long timeout;
> +	int rc, count = 0;
> +
> +	rc = strict_strtoul(buf, 10, &timeout);
> +	if (rc || timeout > MAX_PARK_TIMEOUT)
> +		return -EINVAL;
> +
> +	mutex_lock(&ide_setting_mtx);

No need to hold ide_settings_mtx here.

> +	spin_lock_irq(&ide_lock);
> +	if (unlikely(!(drive->dev_flags & IDE_DFLAG_PRESENT))) {
> +		rc = -ENODEV;
> +		goto unlock;
> +	}

Same comment as in park_show().

> +	if (drive->dev_flags & IDE_DFLAG_NO_UNLOAD) {
> +		rc = -EOPNOTSUPP;
> +		goto unlock;
> +	}
> +
> +	if (timeout) {
> +		timeout = msecs_to_jiffies(timeout * 1000) + jiffies;
> +		rc = ide_mod_park_timer(&hwif->park_timer, timeout);
> +		if (unlikely(rc < 0))
> +			goto unlock;
> +		else if (rc)
> +			rc = 0;
> +		else
> +			get_device(&hwif->gendev);

No need for getting additional reference on hwif, it won't go away
as long as we have references on its child devices.

> +		count = issue_park_cmd(drive, &wait, REQ_PARK_HEADS);
> +	} else {
> +		if (del_timer(&hwif->park_timer)) {
> +			issue_park_cmd(drive, NULL, REQ_UNPARK_HEADS);
> +			signal_unpark();
> +			put_device(&hwif->gendev);
> +		}
> +	}
> +
> +unlock:
> +	spin_unlock_irq(&ide_lock);
> +
> +	for (; count; count--)
> +		wait_for_completion(&wait);
> +	mutex_unlock(&ide_setting_mtx);
> +
> +	return rc ? rc : len;
> +}
> +
> +ide_devset_rw_flag(no_unload, IDE_DFLAG_NO_UNLOAD);
> +
> +static ssize_t unload_feature_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	ide_drive_t *drive = to_ide_device(dev);
> +	unsigned int val;
> +
> +	spin_lock_irq(&ide_lock);
> +	val = !get_no_unload(drive);
> +	spin_unlock_irq(&ide_lock);

ide_lock taking here is superfluous (as it doesn't protect against
changing IDE settings, hwgroup->busy does)

Also could you please move the new code to a separate file (i.e.
ide-park.c) instead of stuffing it all in ide.c?

Otherwise it looks OK (modulo PM notifiers concerns raised by Tejun
but the code is identical to libata's version so it is sufficient to
duplicate the potential fixes here).
