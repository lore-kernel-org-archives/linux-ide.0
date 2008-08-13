From: Tejun Heo <tj@kernel.org>
Subject: Re: libata problems
Date: Wed, 13 Aug 2008 18:33:39 +0900
Message-ID: <48A2AA73.6010901@kernel.org>
References: <4880BDCD.4030104@gavsworld.net> <4892CDED.6080302@kernel.org> <4898BD4F.90709@gavsworld.net> <4898F11D.1080902@kernel.org> <4899EE03.3060204@gavsworld.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58001 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbYHMJeS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 05:34:18 -0400
In-Reply-To: <4899EE03.3060204@gavsworld.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gavin Cameron <gavin@gavsworld.net>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

(please don't drop linux-ide, use reply-to-all)

Gavin Cameron wrote:
> Tejun Heo wrote:
>> Hmmm... looks like configuration went well but media presence polling is
>> causing the problem.  "hal-disable-polling /dev/sr0" will disable the
>> polling.  Can you please do that and see whether the drive is usable?
> 
> [root@picard ~]# hal-disable-polling --device /dev/sr0
> Polling for drive /dev/sr0 have been disabled. The fdi file written was
> 
> /etc/hal/fdi/information/media-check-disable-storage_model_DVD_A__DH20A3P.fdi

Okay.

> Inserted CD into drive: drive light came on for about 20 seconds, but
> nothing happened.
> 
> Checked /var/log/messages and nothing there.
> 
> Left it sitting there for 5 minutes or so and checked /var/log/messages
> again and still nothing there.

As media presence polling is disabled, the system won't notice whether
the media has changed or not.

> Mounted the CD as root:
> [root@picard ~]# mkdir /mnt/cdrom
> [root@picard ~]# mount -t iso9660 /dev/sr0 /mnt/cdrom/
> mount: block device /dev/sr0 is write-protected, mounting read-only
> 
> The command took about 1 minute to complete. I was then able to browse
> the CD, however each change of directory took approximately 10 seconds
> to read.

Hmmm...

> I then ejected the CD:
> [root@picard ~]# eject /dev/sr0
> 
> again, this took about 20 seconds to eject the CD.
> 
> After the eject, still nothing in /var/log/messages.
> 
> Tried inserting and ejecting another couple of times.
> 
> I verified that the CD was readable in my external CD drive and then put
> the CD back into the main drive and started writing up the results so far.
> 
> As I've been typing, the drive has been spinning up and down several
> times and this time when I checked /var/log/messages I found what is
> attached.
> 
> Is there anything else I can provide in order for you to find the problem?

Can you please try kernel parameter "libata.force=2.00:udma33" and then
"libata.force=2.00:pio4"?  Depending on which distro you're on and
whether libata is built into the kernel or not, you'll need to use
different method to actually get the parameter passed to libata.

Thanks.

-- 
tejun
