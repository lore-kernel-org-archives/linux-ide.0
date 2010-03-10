From: Tomasz Palac <palac@uci.agh.edu.pl>
Subject: Re: Comment on ATA 4 KiB sector issues
Date: Wed, 10 Mar 2010 09:15:35 +0100 (CET)
Message-ID: <Pine.GSO.4.63.1003100853360.21647@galaxy.agh.edu.pl>
References: <Pine.GSO.4.63.1003080933100.4114@galaxy.agh.edu.pl>
 <4B95AEF6.8030906@kernel.org> <Pine.GSO.4.63.1003090947570.29136@galaxy.agh.edu.pl>
 <4B97323E.1040807@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from galaxy.agh.edu.pl ([149.156.96.9]:38532 "EHLO galaxy.agh.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab0CJIPh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Mar 2010 03:15:37 -0500
In-Reply-To: <4B97323E.1040807@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Wed, 10 Mar 2010, Tejun Heo wrote:

> Yes, the geometry is basically arbitrary values which can be queried
> using a BIOS call and the reason why SCSI hosts can choose them is
> they implement BIOS extensions themselves.

I mentioned SCSI host adapters to show that 64/32 geometry is no problem 
for Linux (and other OS-es). Really is 255/63 hardcoded in many places?

>> If not, then geometry can be read from partition table.
>
> From where?

>From the ending CHS values of partition if it ends at cylinder boundary.
How do you calculate geometry from newer Windows partition tables (cases 
W-1, W-2 and W-3)?

> For modern OSes, geometry doesn't matter at all.  Older ones are the
> ones having problems (I've been corrected: XP seems okay while 2000
> depends on CHS).

You are proposing "doing what Windows is doing". This way:

1. Partitions are aligned at 1 MiB (which is very good).
2. Geometry is "standard", i.e. 255/63 (which is good).
3. Partitions don't start and end at cylinder boundary (which is not so
    good).

With 64/32 you can have:

1. Partitions aligned at 1 MiB.
2. Geometry is not standard, but is widely used (SCSI disks, USB flash
    disks).
3. Partitions start and end at cylinder boundary.

-- 
Tomasz Palac, AGH University of Science and Technology
