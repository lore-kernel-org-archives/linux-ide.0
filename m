From: Linda Walsh <suse@tlinx.org>
Subject: Re: Port Multiplier access with Sil 3124
Date: Mon, 09 Feb 2009 14:22:09 -0800
Message-ID: <4990AC91.8010104@tlinx.org>
References: <498F42B6.8030607@tlinx.org> <87f94c370902090635h2fc3e604n990bdd70be9c48cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ishtar.tlinx.org ([64.81.245.74]:33449 "EHLO ishtar.tlinx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbZBIWit (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Feb 2009 17:38:49 -0500
In-Reply-To: <87f94c370902090635h2fc3e604n990bdd70be9c48cd@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: linux-ide@vger.kernel.org

Greg Freemyer wrote:
> On Sun, Feb 8, 2009 at 3:38 PM, Linda Walsh <lkml@tlinx.org> wrote:
>>
>> My ultimate aim is to use it in a RAID-0, mirror config (my luck
>> with SATA disk drives has been abysmal, of late (*sigh*)).
>
> I assume you mean raid-1. 
Whichever is the mirror mode.  I always have to look it up.

>  I'm seeing a lot of people lose data even
> with that.  There seem to be a lot of firmware specific bugs recently
> (not just seagate). Be sure and mix vendors / batches / etc. in an
> effort to keep away from near simultaneous double disk failure.
----
    Now wait a second -- DIFFERENT vendors?  That goes against the
normal "best practices" with RAID -- to use the same Make/Model for
RAID.  I've never heard of anyone suggesting using different vendors
for RAID disks.  Theoretically (and often in practice), each vendor varies
in speed -- even internal layout.  You can have 2 disks of same size
from different vendors, but there's no guarantee that they are laid
out the same internally.  If they aren't matched your RAID performance
will be significantly slower than a single hard disk.
>
>> Anyone with any real-world experience about when the 3Gb SAS
>> starts to become a bottleneck?  I know that theoretically, it could
>> support a hair over 350MB/s if there was no overhead, which would
>> reliably only support 2 hard disks at full speed (assuming ~120MB/s
>> max linear read speed/disk).
>
> In my real world tests I've never seen a single drive achieve beyond
> about 80MB/sec.  (5GB/min is the way I actually measure it.  That was
> using SATA directly on the MB which I assume is as fast a PCIe.)
---
    Sorry...I must have been misremembering or thinking of SAS drives. 
For my current drives I'm topping out at 80, some in the 70's.  Weird.
I thought I remembered some benchmarking I did that ran faster than
that.  I must be remembering something else. 

    For "top speed, linear read" tests, I use "hdparm -t --direct
/dev/[sh]d[a-z]".  Next fastest is using "dd" with the iflag/oflag
direct and large block sizes. 

> But very few people have a heavy linear read / write load (I do, but
> my use case is unusual).
>
> Most apps use random i/o.  That is where raid in general should shine.
>  That includes a PMP setup I assume.
----
    PMP?  The only reduction in RAID seek time I can think of would be
having the linear seek time reduced by 2 or 3 (for data spread out over
2 or 3 disks).  Is that what you mean?  I wouldn't see much improvement
in rotational or head-settle delay components of seek times.

    It is likely most of my apps are random-seek and get considerably
less throughput -- and going over a network slows things down as well
I drop to about 20-21MB/s for large  writes to a single HD.

    However, my most time consuming operations involve *backups*.  My
worst partitions are not really worth gzipping -- about 6-7% size benefit
on my biggest partition (mostly media files).




