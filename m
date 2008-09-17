From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 3/4] ide: Implement disk shock protection support
Date: Wed, 17 Sep 2008 17:28:33 +0200
Message-ID: <87tzcen65a.fsf@denkblock.local>
References: <87wshzplvk.fsf@denkblock.local>
	<200809012129.14979.bzolnier@gmail.com>
	<87ljy90zin.fsf@denkblock.local>
	<200809051933.38888.bzolnier@gmail.com>
	<87vdx1y9gv.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:45419 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262AbYIQP3J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Sep 2008 11:29:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Elias Oltmanns <eo@nebensachen.de> wrote:
> From: Elias Oltmanns <eo@nebensachen.de>
> Subject: [PATCH] ide: Implement disk shock protection support
>
> On user request (through sysfs), the IDLE IMMEDIATE command with UNLOAD
> FEATURE as specified in ATA-7 is issued to the device and processing of
> the request queue is stopped thereafter until the specified timeout
> expires or user space asks to resume normal operation. This is supposed
> to prevent the heads of a hard drive from accidentally crashing onto the
> platter when a heavy shock is anticipated (like a falling laptop expected
> to hit the floor). Port resets are deferred whenever a device on that
> port is in the parked state.
>
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
> ---
[...]
> diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
> index 91182eb..ea75c71 100644
> --- a/drivers/ide/ide-iops.c
> +++ b/drivers/ide/ide-iops.c
> @@ -1079,12 +1079,13 @@ static void pre_reset(ide_drive_t *drive)
>  static ide_startstop_t do_reset1 (ide_drive_t *drive, int do_not_try_atapi)
>  {
>  	unsigned int unit;
> -	unsigned long flags;
> +	unsigned long flags, timeout;
>  	ide_hwif_t *hwif;
>  	ide_hwgroup_t *hwgroup;
>  	struct ide_io_ports *io_ports;
>  	const struct ide_tp_ops *tp_ops;
>  	const struct ide_port_ops *port_ops;
> +	DEFINE_WAIT(wait);
>  
>  	spin_lock_irqsave(&ide_lock, flags);
>  	hwif = HWIF(drive);
> @@ -1111,6 +1112,30 @@ static ide_startstop_t do_reset1 (ide_drive_t *drive, int do_not_try_atapi)
>  		return ide_started;
>  	}
>  
> +	/* We must not disturb devices in the IDE_DFLAG_PARKED state. */
> +	do {
> +		unsigned long now;
> +		int i;
> +
> +		timeout = jiffies;
> +		for (i = 0; i < MAX_DRIVES; i++) {
> +			ide_drive_t *tdrive = &hwif->drives[i];
> +
> +			if (tdrive->dev_flags & IDE_DFLAG_PRESENT &&
> +			    tdrive->dev_flags & IDE_DFLAG_PARKED &&
> +			    time_after(tdrive->sleep, timeout))
> +				timeout = tdrive->sleep;
> +		}
> +
> +		now = jiffies;
> +		if (time_before_eq(timeout, now))
> +			break;
> +
> +		prepare_to_wait(&ide_park_wq, &wait, TASK_UNINTERRUPTIBLE);
> +		timeout = schedule_timeout_uninterruptible(timeout - now);

It has occurred to me that something is wrong here after all: we need to
release the lock before sleeping. I'll change that to

		spin_unlock_irqrestore(&ide_lock, flags);
		prepare_to_wait(&ide_park_wq, &wait, TASK_UNINTERRUPTIBLE);
		timeout = schedule_timeout_uninterruptible(timeout - now);
		spin_lock_irqsave(&ide_lock, flags);

> + } while (timeout);
> +	finish_wait(&ide_park_wq, &wait);
> +
>  	/*
>  	 * First, reset any device state data we were maintaining
>  	 * for any of the drives on this interface.

Hopefully, this meets with your approval. I'll send out the updated
patch series shortly. Even though this is a minor change, I don't feel
comfortable with adding your Acked-by myself now, so please ack the new
patch.

Regards,

Elias
