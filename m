From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 4/5] ide: Implement disk shock protection support
Date: Mon, 04 Aug 2008 16:15:35 +0200
Message-ID: <87hca0oohk.fsf@denkblock.local>
References: <87prp1kvyy.fsf@denkblock.local>
	<20080726062142.29070.7339.stgit@denkblock.local>
	<20080804063901.GA23933@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:53767 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756536AbYHDOTY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Aug 2008 10:19:24 -0400
In-Reply-To: <20080804063901.GA23933@atrey.karlin.mff.cuni.cz> (Pavel Machek's
	message of "Mon, 4 Aug 2008 08:39:01 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Pavel Machek <pavel@suse.cz> wrote:
> Hi!
>
>>  #include <linux/ide.h>
>>  #include <linux/completion.h>
>>  #include <linux/device.h>
>> +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_HIBERNATION)
>> +# include <linux/suspend.h>
>> +#endif
>
> This ifdef should be unneccessary.

Right.

>
>
>> +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_HIBERNATION)
>> +static int ide_park_count = 1;
>> +DECLARE_WAIT_QUEUE_HEAD(ide_park_wq);
>> +
>> +static inline int suspend_parking(void)
>> +{
>> +	spin_lock_irq(&ide_lock);
>> +	if (ide_park_count == 1)
>> +		ide_park_count = 0;
>> +	spin_unlock_irq(&ide_lock);
>> +	return !ide_park_count;
>> +}
>> +
>> +static int ide_pm_notifier(struct notifier_block *nb, unsigned long val,
>> +			   void *null)
>> +{
>> +	switch (val) {
>> +	case PM_SUSPEND_PREPARE:
>> +		wait_event(ide_park_wq, suspend_parking());
>> +		break;
>> +	case PM_POST_SUSPEND:
>> +		ide_park_count = 1;
>> +		break;
>> +	default:
>> +		return NOTIFY_DONE;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block ide_pm_notifier_block = {
>> +	.notifier_call = ide_pm_notifier,
>> +};
>> +
>> +static inline int ide_register_pm_notifier(void)
>> +{
>> +	return register_pm_notifier(&ide_pm_notifier_block);
>> +}
>> +
>> +static inline int ide_unregister_pm_notifier(void)
>> +{
>> +	return unregister_pm_notifier(&ide_pm_notifier_block);
>> +}
>
> Any reason this does not use normal driver model suspend/resume
> callbacks?

Yes, two in fact. Firstly, it would appear that after freeze_processes()
has completed, timers don't fire anymore. That's why we have to call the
unpark hook manually. The ATA suspend callback would be the place to do
that but the scsi ULD's suspend callback issues a cache sync and a disk
start_stop command before and waits indefinitely for completion.

Secondly and more importantly, using pm_notifiers is the right thing to
do as long as user processes control when to park and unpark the disks.
This way we can hold back from suspending until user space gives the all
clear.

Regards,

Elias
