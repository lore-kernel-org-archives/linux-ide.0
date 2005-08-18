From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: when are buffers/caches flushed?
Date: Thu, 18 Aug 2005 14:24:25 +0200
Message-ID: <58cb370e0508180524145d846a@mail.gmail.com>
References: <43046817.803@imc-berlin.de> <43046FD2.4080401@gmail.com>
	 <43047229.7010007@imc-berlin.de> <43047830.4060705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.195]:13066 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932221AbVHRMY0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Aug 2005 08:24:26 -0400
Received: by nproxy.gmail.com with SMTP id x37so109307nfc
        for <linux-ide@vger.kernel.org>; Thu, 18 Aug 2005 05:24:25 -0700 (PDT)
In-Reply-To: <43047830.4060705@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>, linux-ide@vger.kernel.org

Hi,

On 8/18/05, Tejun Heo <htejun@gmail.com> wrote:
> Steven Scholz wrote:
> > Tejun Heo wrote:
> >
> >> Steven Scholz wrote:
> >>
> >>> Hi there,
> >>>
> >>> According to an (old) man page of sync(2)
> >>>
> >>>        According to  the  standard  specification  (e.g.,  SVID),
> >>>        sync()  schedules  the  writes,  but may return before the
> >>>        actual writing is done.   However,  since  version  1.3.20
> >>>        Linux  does actually wait.  (This still does not guarantee
> >>>        data integrity: modern disks have large caches.)
> >>>
> >>> How about recent kernels? Does sync() block until buffers are flushed?
> >>> How can I find out if the disk caches are actually flushed?
> >>>
> >>> I want to make sure that all data is flushed to my disk drive before
> >>> powering down the system.
> >>>
> >>> Thanks.
> >>>
> >>
> >>  All disk caches are flushed before shutdown via the following path.
> >>
> >> kernel/sys.c::sys_reboot()
> >> kernel/drivers/base/power/shutdown.c::device_shutdown()
> >>  driver specific ->shutdown callback, for ide disks, the path is
> >> drivers/ide/ide-disk.c::ide_device_shutdown()
> >> drivers/ide/ide-disk.c::ide_cacheflush_p()
> >> drivers/ide/ide-disk.c::do_idedisk_flushcache()
> >>
> >>  And, AFAIK, sync() doesn't flush disk caches.
> >
> >
> > How about umount?
> >
> 
> [CC'ing Bartlomiej (Hi!)]
> 
>   Hmmm, umount doesn't.  I think maybe adding cache flushing to sync and
> umount can be helpful.

I think that cache is flushed on umount through idedisk_release().

>   And one more thing, ide-disk doesn't flush cache when shutting down.
> It flushes only when rebooting.

Please see ide_disk_remove().
 
> from ide_device_shutdown()...
> 
> #ifdef  CONFIG_ALPHA
>         /* On Alpha, halt(8) doesn't actually turn the machine off,
>            it puts you into the sort of firmware monitor. Typically,
>            it's used to boot another kernel image, so it's not much
>            different from reboot(8). Therefore, we don't need to
>            spin down the disk in this case, especially since Alpha
>            firmware doesn't handle disks in standby mode properly.
>            On the other hand, it's reasonably safe to turn the power
>            off when the shutdown process reaches the firmware prompt,
>            as the firmware initialization takes rather long time -
>            at least 10 seconds, which should be sufficient for
>            the disk to expire its write cache. */
>         if (system_state != SYSTEM_POWER_OFF) {
> #else
>         if (system_state == SYSTEM_RESTART) {
> #endif
>                 ide_cacheflush_p(drive);
>                 return;
>         }
> 
>   It seems that the if clause are there due to some historic thing.  The
> comment suggests that the body in the if clause spun down the drive
> previously, and we needed the if to avoid spinning down unnecessarily,
> and the if is left there after we changed the body to flush cache.

It is a correct workaround for Alpha firmware, please see the original patch:
http://linux.bkbits.net:8080/linux-2.6/cset@40bec934PKpDSgX_q3NCTdKXxyk6bw?nav=index.html|src/|src/drivers|src/drivers/ide|related/drivers/ide/ide-disk.c

The thing is that we want to avoid calling dev->bus->suspend() on
system_state == SYSTEM_HALT.

Bartlomiej
