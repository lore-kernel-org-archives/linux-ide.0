From: David Shaw <dshaw@jabberwocky.com>
Subject: Re: Possible data corruption sata_sil24?
Date: Thu, 12 Jul 2007 21:42:52 -0400
Message-ID: <20070713014252.GA17811@jabberwocky.com>
References: <20070706012432.GB29789@jabberwocky.com> <4693A5A0.5070306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from foobar.cs.jhu.edu ([128.220.13.173]:3019 "EHLO
	foobar.cs.jhu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbXGMBnE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jul 2007 21:43:04 -0400
Content-Disposition: inline
In-Reply-To: <4693A5A0.5070306@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

On Wed, Jul 11, 2007 at 12:28:32AM +0900, Tejun Heo wrote:
> Hello,
> 
> David Shaw wrote:
> > I'm having a problem with data corruption using devmapper on a SATA
> > disk using sata_sil24.  I've done some work tracking it down, and
> > hopefully you folks can point me further in the right direction.
> > 
> > The kernel I'm using is 2.6.21-1.3228.fc7 (i.e. Fedora 7).  LVM2 is
> > lvm2-2.02.24-1.fc7.  The dmsetup and libdevmapper is
> > device-mapper-1.02.17-7.fc7.
> > 
> > The original setup that showed the problem is this:
> > 
> > Starting with two 500GB SATA drives (interface card uses a Silicon
> > 3124 chipset), /dev/sdd and /dev/sde.  I partitioned each into two
> > 250GB chunks (250*1000*1000*1000, not 250*1024*1024*1024), and set up
> > two RAID 1 sets such that /dev/md0 is /dev/sdd1+/dev/sde1 and /dev/md2
> > is /dev/sdd2+/dev/sde2.  I then created a volume group ("storage") on
> > top of /dev/md0 and /dev/md1.  Finally, I allocated two logical
> > volumes on top of that: "one" is -L300GB and "two" is -L100GB.
> 
> -ETOOMANYCOMPNONETS.  If it's data corruption with sata_sil24, it's
> highly likely that you're gonna be able to regenerate the problem
> without using raw /dev/sdd and /dev/sde devices.  Please try that.

It fails whether I use a raw /dev/sdd or partition it into one large
/dev/sdd1, or partition into multiple partitions.  sata_sil24 seems to
work by itself, as does dm, but as soon as I mix sata_sil24+dm, I get
corruption.

> > Note that this simplified reproduction case uses only the device
> > mapper: RAID is not involved, nor is LVM.  "dmsetup table" says:
> > 
> > two: 0 209715200 linear 8:32 482345000
> > one: 0 482344960 linear 8:32 0
> 
> Can you try this on another controller so that we can tell whether the
> problem lies with dm or ata?

I have tried this on a different machine (also Fedora 7) that has an
Intel ICH5 controller on the motherboard (ata_piix driver).  This
works correctly, and there is no corruption either with or without dm.

David
