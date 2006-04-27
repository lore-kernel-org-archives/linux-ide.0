From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET 9/9] add hotplug support
Date: Thu, 27 Apr 2006 19:53:52 +0900
Message-ID: <4450A2C0.4090401@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com> <44508F12.8010705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:20137 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965092AbWD0Kxc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Apr 2006 06:53:32 -0400
Received: by pproxy.gmail.com with SMTP id i49so2018778pye
        for <linux-ide@vger.kernel.org>; Thu, 27 Apr 2006 03:53:32 -0700 (PDT)
In-Reply-To: <44508F12.8010705@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Hellooooo, all.
>>
>> Finally, the last one.  This is the first take of add-hotplug-support
>> patchset.  This patchset includes 13 patches.
>>
>> #01-04    implement hotplug framework
>> #05-07    implement warm plug (SCSI scan/delete callbacks)
>> #08-10    hook and activate hotplug
>> #11-13    add LLDD hotplug supports (PHY status change notifications)
>>
>> Hotplugging is implemented as an integral part of EH.  A new EH helper
>> ata_eh_hotplug() is defined which should be called after all regular
>> EH is done.  LLDDs have to do very little to support hotplug.
> 
> I'm going to leave the substantive review of this patchset for the next 
> time it gets resent.

Yeap, please don't spend too much time on it.  Hotplug has been changed 
quite a bit in my current repo.

> Overall,
> 
> * my quick review didn't turn up any obvious problems, but that was just 
> looking at each patch, not looking at the end result (big picture) at all.
> 
> * hotplug design I want to see is (also mentioned in another email):
> 
>     1a) user requests bus scan
>         or
>     1b) hotplug interrupt
>     2) wait a bit, swallowing any 1a- or 1b-type events that
>        appear during the wait (debounce).
>     3) rescan bus, revalidate device(s)

In my working repo, hardware debouncing is done by invoking the 
following function in ->prereset() with the port frozen.  I'm not very 
sure whether debouncing user request is necessary though.

/**
  *	sata_debounce - debounce SATA phy status
  *	@link: ATA link to debounce SATA phy status for
  *	@interval_msec: polling interval in millisecs
  *	@duration_msec: debounce duration in millisecs
  *	@timeout_msec: timeout in millisecs
  *
  *	Make sure SStatus of @link reaches stable state, determined by
  *	holding the same value where DET is not 1 for @duration_msec
  *	polled every @interval_msec, before @timeout_msec.  Note the
  *	timeout constraints the beginning of the stable state.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
  *
  *	RETURNS:
  *	0 on success, -errno on failure.
  */
int sata_debounce(struct ata_link *link, unsigned long interval_msec,
		  unsigned long duration_msec, unsigned long timeout_msec)
{
	unsigned long duration = duration_msec * HZ / 1000;
	unsigned long timeout = jiffies + timeout_msec * HZ / 1000;
	unsigned long last_jiffies;
	u32 last, cur;
	int rc;

	if ((rc = ata_scr_read(link, SCR_STATUS, &cur)))
		return rc;
	cur &= 0xf;

	last = cur;
	last_jiffies = jiffies;

	while (1) {
		msleep(interval_msec);
		if ((rc = ata_scr_read(link, SCR_STATUS, &cur)))
			return rc;
		cur &= 0xf;

		/* DET stable? */
		if (cur == last && cur != 1) {
			if (time_after(jiffies, last_jiffies + duration))
				return 0;
			continue;
		}

		/* unstable, start over */
		last = cur;
		last_jiffies = jiffies;

		/* check timeout */
		if (time_after(jiffies, timeout))
			return -EBUSY;
	}
}

> I'm careful to use "revalidate", because that covers all cases:
> 
>     - existing device goes away
>     - new device appears
>     - existing device "blipped", but its still there, so
>       we can keep talking to it.
> 

Yeap, all bases covered.

I'm currently finishing up PM support.  It took a lot longer than I 
though but it's shaping up pretty good.  Everything is handled nicely, 
hotplug, EH, qc deferring (e.g. not issuing ATAPI command if commands 
are outstanding to more than three devices for sil24...) are all handled 
in generic and unified way.  Adding PM support necessitated quite a bit 
of changes to EH and hotplug.  Currently, major changes in my repo are...

- boot scan, hotplug, EH all rolled up into single EH revive operation.
- simpler EH/irq synchronization.  EH now works on its own copy of EH 
info created on entry to EH.
- much tighter event handling (almost no EH/hotplug event/info loss 
except for pathological cases)
- fine-grained user scan request (user can request scan of specific device)
- ata_link abstraction for PM
- PM support with the same level of EH/NCQ/hotplug support as host ports 
(sil24 and working on AHCI)

Above list is what comes to my mind ATM.  I probably have forgotten a 
lot.  I'll make a full list when I post the next round of patches.

Jeff, until when are you available?  I think I can post the next round 
in a few days (I'm pretty sure this time :).  I'm thinking of setting up 
a git repo and merge irq-pio there too in the order you requested.  If 
schedule isn't too tight, it would be nice to push this thing to some 
branch in libata-dev.

Thanks.

-- 
tejun
