From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Port Multiplier access with Sil 3124
Date: Mon, 9 Feb 2009 18:01:34 -0500
Message-ID: <87f94c370902091501h96ecb8dp7acac1fa80a82d8a@mail.gmail.com>
References: <498F42B6.8030607@tlinx.org>
	 <87f94c370902090635h2fc3e604n990bdd70be9c48cd@mail.gmail.com>
	 <4990AC91.8010104@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:49064 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbZBIXBg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Feb 2009 18:01:36 -0500
Received: by an-out-0708.google.com with SMTP id c2so897365anc.1
        for <linux-ide@vger.kernel.org>; Mon, 09 Feb 2009 15:01:34 -0800 (PST)
In-Reply-To: <4990AC91.8010104@tlinx.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linda Walsh <suse@tlinx.org>
Cc: linux-ide@vger.kernel.org

On Mon, Feb 9, 2009 at 5:22 PM, Linda Walsh <suse@tlinx.org> wrote:
> Greg Freemyer wrote:
>>
>> On Sun, Feb 8, 2009 at 3:38 PM, Linda Walsh <lkml@tlinx.org> wrote:
>>>
>>> My ultimate aim is to use it in a RAID-0, mirror config (my luck
>>> with SATA disk drives has been abysmal, of late (*sigh*)).
>>
>> I assume you mean raid-1.
>
> Whichever is the mirror mode.  I always have to look it up.
>
>>  I'm seeing a lot of people lose data even
>> with that.  There seem to be a lot of firmware specific bugs recently
>> (not just seagate). Be sure and mix vendors / batches / etc. in an
>> effort to keep away from near simultaneous double disk failure.
>
> ----
>   Now wait a second -- DIFFERENT vendors?  That goes against the
> normal "best practices" with RAID -- to use the same Make/Model for
> RAID.  I've never heard of anyone suggesting using different vendors
> for RAID disks.

A year ago, neither had I.  SATA drive reliability is in the crapper
in the last 18 months.  I've personally had a double drive failure
that caused data loss.  And I'm hearing lots of similar war stories.

I'm hearing of people saying a 2 disk mirror (raid-1) is not safe
enough.  Go with either a 3 disk mirror or to raid-6.  Even with
raid-6 I personally would not let it have too many spindles. (Whatever
too many means?)

>  Theoretically (and often in practice), each vendor varies
> in speed -- even internal layout.

You will likely be limited by the speed of your slowest disk, so get
ones with similar specs.

> You can have 2 disks of same size
> from different vendors, but there's no guarantee that they are laid
> out the same internally.  If they aren't matched your RAID performance
> will be significantly slower than a single hard disk.

I don't understand that.  Back in the pre-LBA days of 10+ years ago
geometry was a huge issue.  Today, I can't see why it would matter.
Someone please correct me if I'm wrong.

I don't really keep up with drive geometry any more.  Are some
manufactures putting the low sector numbers on the inside and some on
the outside of the platter?  If so, I could see that being an issue.


>>
>>> Anyone with any real-world experience about when the 3Gb SAS
>>> starts to become a bottleneck?  I know that theoretically, it could
>>> support a hair over 350MB/s if there was no overhead, which would
>>> reliably only support 2 hard disks at full speed (assuming ~120MB/s
>>> max linear read speed/disk).
>>
>> In my real world tests I've never seen a single drive achieve beyond
>> about 80MB/sec.  (5GB/min is the way I actually measure it.  That was
>> using SATA directly on the MB which I assume is as fast a PCIe.)
>
> ---
>   Sorry...I must have been misremembering or thinking of SAS drives. For my
> current drives I'm topping out at 80, some in the 70's.  Weird.
> I thought I remembered some benchmarking I did that ran faster than
> that.  I must be remembering something else.
>   For "top speed, linear read" tests, I use "hdparm -t --direct
> /dev/[sh]d[a-z]".  Next fastest is using "dd" with the iflag/oflag
> direct and large block sizes.

I do most of my tests with dd, but then my actual use case is normally
using dd as well, so it only makes sense for me to test that way.

>>
>> But very few people have a heavy linear read / write load (I do, but
>> my use case is unusual).
>>
>> Most apps use random i/o.  That is where raid in general should shine.
>>  That includes a PMP setup I assume.
>
> ----
>   PMP?

PMP == Port Multiplier

> The only reduction in RAID seek time I can think of would be
> having the linear seek time reduced by 2 or 3 (for data spread out over
> 2 or 3 disks).  Is that what you mean?  I wouldn't see much improvement
> in rotational or head-settle delay components of seek times.

It's been 10 years since I took my raid training classes from Compaq
(previously DEC, now HP).  We covered performance as part of that.  At
that time we did not even discuss linear read speed.  It was all io's
/ second.

So assume with one disk you can do 2,000 ios/second and each io is
16K.  (A database might do something like this.)   That is only 32
MB/sec.

Now assume you do a 8-disk raid-0 (pure stripping, very dangerous).

You should be able to get 8x the ios.  So 16,000 ios/second and 248 MB / sec.

I haven't done the benchmarks but the above seems pretty reasonable to
actually achieve.

OTOH, if you are just looking at linear disk speed, then a 8-disk
array is likely not going to perform anywhere near as fast as 8x a
single drive.  ie. The drives are no longer the bottleneck.

>   It is likely most of my apps are random-seek and get considerably
> less throughput -- and going over a network slows things down as well
> I drop to about 20-21MB/s for large  writes to a single HD.
>
>   However, my most time consuming operations involve *backups*.  My
> worst partitions are not really worth gzipping -- about 6-7% size benefit
> on my biggest partition (mostly media files).

If you combine LVM (or Device Mapper) snapshots with raid you have a
pretty ideal situation.

Add enough drives (spindles) to your setup so that you can easily
handle both your primary load and your backup load and the load
associated with having a snapshot in place.  I would bet 5 or 6 drives
total would do the trick.

Then use snapshots to give you a "instant in time" snapshot to backup from.

If you can get the backup done in under 24 hours, then you can make a
backup every day with little or no interference with your primary
load.

HTH
Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
