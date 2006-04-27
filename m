From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET 9/9] add hotplug support
Date: Thu, 27 Apr 2006 07:29:44 -0400
Message-ID: <4450AB28.2030801@pobox.com>
References: <1144764846705-git-send-email-htejun@gmail.com> <44508F12.8010705@pobox.com> <4450A2C0.4090401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:24743 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964932AbWD0L3w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Apr 2006 07:29:52 -0400
In-Reply-To: <4450A2C0.4090401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> In my working repo, hardware debouncing is done by invoking the 
> following function in ->prereset() with the port frozen.  I'm not very 
> sure whether debouncing user request is necessary though.

Agreed, I'm not sure either.


> /**
>  *    sata_debounce - debounce SATA phy status
>  *    @link: ATA link to debounce SATA phy status for
>  *    @interval_msec: polling interval in millisecs
>  *    @duration_msec: debounce duration in millisecs
>  *    @timeout_msec: timeout in millisecs
>  *
>  *    Make sure SStatus of @link reaches stable state, determined by
>  *    holding the same value where DET is not 1 for @duration_msec
>  *    polled every @interval_msec, before @timeout_msec.  Note the
>  *    timeout constraints the beginning of the stable state.
>  *
>  *    LOCKING:
>  *    Kernel thread context (may sleep)
>  *
>  *    RETURNS:
>  *    0 on success, -errno on failure.
>  */
> int sata_debounce(struct ata_link *link, unsigned long interval_msec,
>           unsigned long duration_msec, unsigned long timeout_msec)
> {
>     unsigned long duration = duration_msec * HZ / 1000;
>     unsigned long timeout = jiffies + timeout_msec * HZ / 1000;
>     unsigned long last_jiffies;
>     u32 last, cur;
>     int rc;
> 
>     if ((rc = ata_scr_read(link, SCR_STATUS, &cur)))
>         return rc;
>     cur &= 0xf;
> 
>     last = cur;
>     last_jiffies = jiffies;
> 
>     while (1) {
>         msleep(interval_msec);
>         if ((rc = ata_scr_read(link, SCR_STATUS, &cur)))
>             return rc;
>         cur &= 0xf;
> 
>         /* DET stable? */
>         if (cur == last && cur != 1) {
>             if (time_after(jiffies, last_jiffies + duration))
>                 return 0;
>             continue;
>         }
> 
>         /* unstable, start over */
>         last = cur;
>         last_jiffies = jiffies;
> 
>         /* check timeout */
>         if (time_after(jiffies, timeout))
>             return -EBUSY;
>     }
> }

hmmm, I would think something more along the lines of

	get HP irq
	ack HP irq
	ata_I_got_hotplug_event()
		if test_and_clear_bit(got_hotplug)
			start 1-second timer

	timer fires...
	clear got_hotplug
	handle hotplug, revalidate port

There's not much point in polling, the reason for the debounce period is 
to throw away spurious hotplug/unplug/hotplug events the hardware throws 
while it is figuring shit out.

Should just need a pause, following by port recovery/revalidate.


>> I'm careful to use "revalidate", because that covers all cases:
>>
>>     - existing device goes away
>>     - new device appears
>>     - existing device "blipped", but its still there, so
>>       we can keep talking to it.
>>
> 
> Yeap, all bases covered.
> 
> I'm currently finishing up PM support.  It took a lot longer than I 
> though but it's shaping up pretty good.  Everything is handled nicely, 
> hotplug, EH, qc deferring (e.g. not issuing ATAPI command if commands 
> are outstanding to more than three devices for sil24...) are all handled 
> in generic and unified way.  Adding PM support necessitated quite a bit 
> of changes to EH and hotplug.  Currently, major changes in my repo are...
> 
> - boot scan, hotplug, EH all rolled up into single EH revive operation.
> - simpler EH/irq synchronization.  EH now works on its own copy of EH 
> info created on entry to EH.
> - much tighter event handling (almost no EH/hotplug event/info loss 
> except for pathological cases)
> - fine-grained user scan request (user can request scan of specific device)
> - ata_link abstraction for PM

that's nice


> - PM support with the same level of EH/NCQ/hotplug support as host ports 
> (sil24 and working on AHCI)

what kind of PM are you testing on?


> Above list is what comes to my mind ATM.  I probably have forgotten a 
> lot.  I'll make a full list when I post the next round of patches.
> 
> Jeff, until when are you available?  I think I can post the next round 
> in a few days (I'm pretty sure this time :).  I'm thinking of setting up 
> a git repo and merge irq-pio there too in the order you requested.  If 
> schedule isn't too tight, it would be nice to push this thing to some 
> branch in libata-dev.

I leave May 3rd.  So sometime between now and then.  The goal should be 
to get #irq-pio and whatever other work you want into #upstream before I 
leave, so that people have a nice long period for testing in -mm. 
irq-pio will definitely want some testing, as will your work.  Its a lot 
to throw at people all at once.

	Jeff


