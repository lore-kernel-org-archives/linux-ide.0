From: Tejun Heo <htejun@gmail.com>
Subject: Re: Possible data corruption sata_sil24?
Date: Wed, 11 Jul 2007 00:28:32 +0900
Message-ID: <4693A5A0.5070306@gmail.com>
References: <20070706012432.GB29789@jabberwocky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:22925 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbXGJP2j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 11:28:39 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1049487nze
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 08:28:38 -0700 (PDT)
In-Reply-To: <20070706012432.GB29789@jabberwocky.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Shaw <dshaw@jabberwocky.com>
Cc: linux-ide@vger.kernel.org

Hello,

David Shaw wrote:
> I'm having a problem with data corruption using devmapper on a SATA
> disk using sata_sil24.  I've done some work tracking it down, and
> hopefully you folks can point me further in the right direction.
> 
> The kernel I'm using is 2.6.21-1.3228.fc7 (i.e. Fedora 7).  LVM2 is
> lvm2-2.02.24-1.fc7.  The dmsetup and libdevmapper is
> device-mapper-1.02.17-7.fc7.
> 
> The original setup that showed the problem is this:
> 
> Starting with two 500GB SATA drives (interface card uses a Silicon
> 3124 chipset), /dev/sdd and /dev/sde.  I partitioned each into two
> 250GB chunks (250*1000*1000*1000, not 250*1024*1024*1024), and set up
> two RAID 1 sets such that /dev/md0 is /dev/sdd1+/dev/sde1 and /dev/md2
> is /dev/sdd2+/dev/sde2.  I then created a volume group ("storage") on
> top of /dev/md0 and /dev/md1.  Finally, I allocated two logical
> volumes on top of that: "one" is -L300GB and "two" is -L100GB.

-ETOOMANYCOMPNONETS.  If it's data corruption with sata_sil24, it's
highly likely that you're gonna be able to regenerate the problem
without using raw /dev/sdd and /dev/sde devices.  Please try that.

> Note that this simplified reproduction case uses only the device
> mapper: RAID is not involved, nor is LVM.  "dmsetup table" says:
> 
> two: 0 209715200 linear 8:32 482345000
> one: 0 482344960 linear 8:32 0

Can you try this on another controller so that we can tell whether the
problem lies with dm or ata?

-- 
tejun
