From: Tejun Heo <tj@kernel.org>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Thu, 10 Feb 2011 20:07:08 +0100
Message-ID: <20110210190708.GM3770@htj.dyndns.org>
References: <4D51A648.20707@cfl.rr.com>
 <20110209085935.GE6558@htj.dyndns.org>
 <4D52B0B3.40900@cfl.rr.com>
 <20110209153714.558133d7@lxorguk.ukuu.org.uk>
 <20110209153601.GJ3770@htj.dyndns.org>
 <4D52E180.6020908@garzik.org>
 <4D52EEEC.1020602@cfl.rr.com>
 <20110210094440.GL3770@htj.dyndns.org>
 <4D5432D4.60108@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46004 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab1BJTHO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2011 14:07:14 -0500
Received: by bwz15 with SMTP id 15so2429688bwz.19
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2011 11:07:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D5432D4.60108@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hey, Phillip.

On Thu, Feb 10, 2011 at 01:47:48PM -0500, Phillip Susi wrote:
> On 2/10/2011 4:44 AM, Tejun Heo wrote:
> > I thought it would be a good and safe compromise for distros which
> > don't want to unlock by default but look at where we are.  We just
> > ended up with failures which are more obscure.  Your proposed addition
> > will only push things further that direction.  It might not
> > necessarily be a bad thing.  Maybe the level of obscurity then goes
> > beyond certain level and we wouldn't have to care about that.
> 
> Exactly.  With this additional refinement, it should push the failure
> cases so far into the obscure that we don't really need to worry about
> it, and there isn't anything that can be done about it anyhow without
> causing worse problems.

That's a big maybe and the failures would be far more obscure and
unpredictable.  Think about RAID5.  If we're gonna head that way, I
would rather just say we're already beyond the necessary obscurity and
leave things be.

> > But much better solution seems to be exporting the bios size to others
> > and letting the ones which understand storage configuration better
> > deal with it.  At the block or libata layer, we simply don't have
> > enough information to make those decisions in a reliable manner.
> 
> Then you are back to doing something that from the perspective of the
> standards, the bios, and Windows, is wrong and at least in theory can
> cause data loss.  Why would that be better than unlocking when there is
> good reason to believe that it 1) won't cause data loss, and 2) is
> necessary to access user data?

But as I wrote before, there are noticeable advantages to unlocking
unconditionally - regarding hotplugs, moving hard drives to different
machines and general unpredictability of BIOS behaviors, which are far
more important than the fringe downsides.  Hard drives changing sizes
depending on to which machine and when they're connected are simply
bad.  Confused linux systems are far more grave in my book than
confused BIOSen or whatever other operating systems.

Besides, as some distros (including ubuntu and openSUSE) are already
unlocking hard drives unconditionally, being smarter about auto
unlocking doesn't buy us much.  We need something which help fakeraid
work on those setups.

> My personal preference would be to get the HPA and partition table code
> out of the kernel entirely and leave it up to udev and friends, which
> have the ability to recognize complex situations like the disk being a
> fakeraid member, and choose to ignore the partition table on the
> underlying disk entirely, but that doesn't seem likely to happen soon.

I don't think that's gonna fly.  There are cases disks need to be
accessed directly by the kernel while userland is still not
operational.  The suggested solution where disks are always unlocked
and the alt size is exported via sysfs allows about the same
capability without the downsides of not unlocking HPA.  The whole disk
is always accessible and userland tools can choose between the two
sizes.

The problem is updating the tools.  Well, we can start by exporting
the alt size and not changing unlocking logic for now so that nothing
is further broken but the extra information is still available.  Down
the road, after the tools are all updated, we can flip the switch and
unconditionally unlock HPA and kill all the ugly workaround logics.

Thanks.

-- 
tejun
