From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement ata_wait_after_reset()
Date: Sun, 20 May 2007 11:50:30 +0200
Message-ID: <465019E6.2000302@gmail.com>
References: <20070510072005.GA27316@linux-sh.org>    <464301D3.5060306@gmail.com> <464307CC.40701@gmail.com>    <20070510124645.GA18534@linux-sh.org> <4643196B.7070806@gmail.com>    <20070511005217.GA23186@li <464B3505.20004@gmail.com>    <1800.81.207.0.53.1179590050.squirrel@secure.samage.net>    <464F409D.9030408@gmail.com> <2318.81.207.0.53.1179615289.squirrel@secure.samage.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:63542 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303AbXETJut (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 May 2007 05:50:49 -0400
Received: by py-out-1112.google.com with SMTP id a73so40223pye
        for <linux-ide@vger.kernel.org>; Sun, 20 May 2007 02:50:48 -0700 (PDT)
In-Reply-To: <2318.81.207.0.53.1179615289.squirrel@secure.samage.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Indan Zupancic <indan@nul.nu>
Cc: Paul Mundt <lethal@linux-sh.org>, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, garyhade@us.ibm.com

Indan Zupancic wrote:
>> 1. We dropped libata specific suspend/resume implementation in favor of
>> sd driven one.  Unfortunately, the new implementation currently can't do
>> background spinup, so that's probably why you can feel the delay.  We
>> need to figure out how to do background spinup with the new implementation.
> 
> What are the advantages of that, except slower resume? ;-)

The change was made primarily to make libata spin down disks properly on
power down and hibernate.  I don't like the added delay either but it's
better than shortening the lifespan of harddisks.  Making resuming
asynchronous is planned but we need more infrastructure to do that
properly.  The previous implementation worked but it also might try to
spin up a lot of disks at once which can't be good for PSU.  I'm not
sure yet how to do that properly with sd driving suspend/resume.

>> 2. To make reset finish in defined time, each reset try now has defined
>> deadlines.  I was trying to be conservative so I chose 10sec for the
>> first try.
> 
> Right. So to me it seems that failed, because the undefined reset time is just
> replaced with a fixed ad hoc sleep, which is longer than any undefined reset
> mechanism. So where did the advantage go? Better to go back to how it was,
> is my impression. Or make that deadline 10 seconds and after that give up,
> instead of the other way round. Or just move to async reset.

Well, yeah, your case degraded for sure but a lot of hotplug or error
handling cases are now much better which often used to take more than 30
secs in many cases.  There are just a lot of cases and a lot of weird
devices.  Aiming generally acceptable delay on most cases is of higher
priority than optimizing specific cases.  That said, the 10 sec delayed
retry you're seeing is primarily caused by incorrect interpretation of
0xff status on sata_sil, so with that fixed, it shouldn't be too much of
a problem.

>>  It's driven by timing table near the top of libata-eh.c, so
>> adjusting the table is easy and maybe we can be a bit more aggressive
>> with the first two tries.  But if we solve #1, this shouldn't matter too
>> much.
> 
> #2 seems totally unrelated to #1, as #1 is about spinup, and #2 about reset.
> Only relation is that #2 slows down #1 because #1 needs to wait on #2.

Not that easy.  Many drives don't respond to reset while they're
spinning up.

>>> Maybe a silly question, but why do we wait for the harddisk to show up? Maybe that
>>> makes a little bit of sense at bootup, but for resume from ram, where nothing is
>>> supposed to have changed, it seems a bit strange. Why not wait when something tries
>>> to access the harddisk or something?
>> I hope it's explained now.
> 
> Almost. Explained is why we wait on the disk, but that's only the sd_resume part.
> It's still unclear why resume must wait till the reset is done.

Port reset itself is asynchronous.  The wait is solely from sd_resume.

>>> I wonder if sil_pci_device_resume() and sd_resume() know about each other...
>>> I'll disable sd_resume() and see how that goes.
>> Yeap, that should work.  In most configurations, devices spin up
>> immediately after power is restored.  sd_resume() just waits for the
>> device to be revalidated in such cases.
> 
> And it kicks the disk into action. Why? Only thing it does is sending a START_STOP
> command. I assume that causes the disk to spin up. But for e.g. laptopmode I can
> imagine that's quite annoying. I think sd_resume() is totally unnecessary and can
> be removed, because it seems wrong to always force the harddisk to spin up,
> background spin up or not.

Most ATA drives would spin up immediately when power is reapplied unless
configured otherwise and you can configure whether sd_resume issues
START_STOP or not by echoing to sysfs node
/sys/class/scsi_disk/h:c:i:l/manage_start_stop.  The drawback here is
you won't get proper spindown if you turn it off.  Adding fine-grained
control can be useful.  Wanna give it a try?  Shouldn't be too difficult
and, as manage_start_stop is just added, I think we can still change its
API.

-- 
tejun
