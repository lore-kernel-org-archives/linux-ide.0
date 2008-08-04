From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 4/5] ide: Implement disk shock protection support
Date: Mon, 4 Aug 2008 08:39:01 +0200
Message-ID: <20080804063901.GA23933@atrey.karlin.mff.cuni.cz>
References: <87prp1kvyy.fsf@denkblock.local> <20080726062142.29070.7339.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760191AbYHDGjW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080726062142.29070.7339.stgit@denkblock.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-ide@vger.kernel.org

Hi!

>  #include <linux/ide.h>
>  #include <linux/completion.h>
>  #include <linux/device.h>
> +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_HIBERNATION)
> +# include <linux/suspend.h>
> +#endif

This ifdef should be unneccessary.


> +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_HIBERNATION)
> +static int ide_park_count = 1;
> +DECLARE_WAIT_QUEUE_HEAD(ide_park_wq);
> +
> +static inline int suspend_parking(void)
> +{
> +	spin_lock_irq(&ide_lock);
> +	if (ide_park_count == 1)
> +		ide_park_count = 0;
> +	spin_unlock_irq(&ide_lock);
> +	return !ide_park_count;
> +}
> +
> +static int ide_pm_notifier(struct notifier_block *nb, unsigned long val,
> +			   void *null)
> +{
> +	switch (val) {
> +	case PM_SUSPEND_PREPARE:
> +		wait_event(ide_park_wq, suspend_parking());
> +		break;
> +	case PM_POST_SUSPEND:
> +		ide_park_count = 1;
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block ide_pm_notifier_block = {
> +	.notifier_call = ide_pm_notifier,
> +};
> +
> +static inline int ide_register_pm_notifier(void)
> +{
> +	return register_pm_notifier(&ide_pm_notifier_block);
> +}
> +
> +static inline int ide_unregister_pm_notifier(void)
> +{
> +	return unregister_pm_notifier(&ide_pm_notifier_block);
> +}

Any reason this does not use normal driver model suspend/resume
callbacks?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
