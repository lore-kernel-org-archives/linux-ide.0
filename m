From: "Tejun Heo" <htejun@gmail.com>
Subject: Re: Serial ATA (SATA) shutdown info
Date: Tue, 15 May 2007 17:34:31 +0200
Message-ID: <711b967b0705150834sdd14538x459119386c19a7ac@mail.gmail.com>
References: <1179232945.16527.25.camel@quest.netsplit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:49580 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760109AbXEOPed (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 11:34:33 -0400
Received: by an-out-0708.google.com with SMTP id d18so523097and
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 08:34:33 -0700 (PDT)
In-Reply-To: <1179232945.16527.25.camel@quest.netsplit.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Scott James Remnant <scott@ubuntu.com>
Cc: linux-ide@vger.kernel.org, 114683@bugs.launchpad.net

Hello, Scott.

Scott James Remnant wrote:
> The sysvinit in Debian (and Upstart in Ubuntu) use the following
> procedure during shutdown:
>
>  * sync()
>  * Open /proc/ide, iterate all hd* devices found there
>  * Check /proc/ide/*/media is "disk"
>  * Open the device in /dev
>  * Issue WIN_STANDBYNOW1
>  * Issue WIN_STANDBYNOW2
>
> No attempt is made to flush the disk cache, other than calling sync().

Yes, that's exactly why we couldn't implement the workaround entirely
contained in the kernel.  As the userland shutdown issues STANDBYNOW
without preceding FLUSH CACHE, the kernel cannot skip the kernel side
of things.  It's forced to issue FLUSH CACHE and this can spin some
disks back up.

> Firstly, since it appears that the kernel already takes care of flushing
> the cache and standbying the disk, it would appear that this code in our
> halt/reboot binary is entirely useless.  In some cases this would mean
> that the drive was placed into standby, before the kernel flushes its
> caches, bringing the drive out of standby with the clicking sound.  (For
> the *IDE* subsystem, not libata).

Yes.

> Can we simply drop this code entirely? (I've been of the opinion we can,
> but it's nice to get expert confirmation).

Yes, please.

> Secondly, we've never attempted any workarounds for libata.  Our
> halt/reboot only iterates /proc/ide, which should be empty for
> libata-based systems - therefore we've never issued FLUSH CACHE or
> STANDBYNOW on libata drives from userspace.
>
> In this case, how should we proceed?
>
>  * Check whether /sys/modules/libata/parameters/spindown_compat exists.
>    If it does, write 0 to it.
>
> Since we've never been broken, can we not arrange for this to be always
> zero?  Perhaps just writing to it on boot?

Yes, you can clear that node anytime you want and if your shutdown
utilities don't issues FLUSH and STANDBY for libata disks on shutdown,
that's the only thing you'll need to do.  This is still in discussion
but you might not have to do even that.  Please read the following
thread.

  http://article.gmane.org/gmane.linux.ide/18846

I'll update you when things are determined.  It might be that you
don't have to do anything.  Sorry about the fuss.

> For each libata harddisk
>
>       * Check whether /sys/class/scsi_disk/h:c:i:l/manage_start_stop
>         exists. If it doesn't, synchronize cache and spin the disk down
>         as before. If it does, do nothing and continue to the next disk.
>         The file is also accessible
>         as /sys/block/sdX/device/scsi_disk:*/manage_start_stop.
>
> What's the reason for needing to flush the cache and standby the disk by
> hand?  What are the circumstances where the manage_start_stop will not
> exist?

On all kernels upto 2.6.21, libata doesn't issue STANDBYNOW on
shutdown, so some distros including Debian do it during userland
shutdown.  This isn't a complete solution but most disks don't spin up
on the following kernel FLUSH, so it's better than not doing anything
which results in emergency unload for all disks.

> Obviously I'd rather our halt/reboot binary was literally a thin wrapper
> around the reboot() system call, without special logic.  Since we're
> going to have to code the above logic, I'd like to make sure it's going
> in the right place.
>
> Also what's the canon way to synchronise the cache and spin the disk
> down?  How do we iterate libata harddisks, and map to the correct name
> in /dev ?

I think the best way is to update the kernel and not to do anything in
userspace - as you said, thin wrapper around the reboot() syscall.

-- 
tejun
