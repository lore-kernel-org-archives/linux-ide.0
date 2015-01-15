From: Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH v2 3/3] libata: use blk taging
Date: Thu, 15 Jan 2015 15:28:14 -0700
Message-ID: <54B83EFE.9000000@fb.com>
References: <20150109181529.GA1301458@devbig257.prn2.facebook.com>	<20150109214307.GE2785@htj.dyndns.org>	<20150109215919.GA1826518@devbig257.prn2.facebook.com>	<20150109221209.GA1851286@devbig257.prn2.facebook.com>	<CAA9_cmeJvjTjovC4VdeH5P2JYWKZK0OQ8Dc1Ts15TvLiS+qrBQ@mail.gmail.com>	<20150114163006.GA3575264@devbig257.prn2.facebook.com>	<CAPcyv4hMwpGzeaovnXtqyYFM46wodRamZd7CNVoR43JJYh0Tjg@mail.gmail.com>	<20150114171328.GA3636164@devbig257.prn2.facebook.com>	<CAPcyv4geWdT7hEzeuVgLO8X5GKy1ez93uK_vxBOmdZWAK94ngw@mail.gmail.com>	<20150115092836.GA14051@infradead.org>	<20150115184008.GA2222288@devbig257.prn2.facebook.com>	<CAPcyv4imdCq83gN+KOWsu4=0arB59um8upnaGRV0UxhBwc6T4A@mail.gmail.com>	<54B811C7.8000700@fb.com> <CAPcyv4iu4jwJsfuYTBgY1yfxts2NgvSfYhKo_wegT5r3E7N2yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61562 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752057AbbAOW2q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2015 17:28:46 -0500
In-Reply-To: <CAPcyv4iu4jwJsfuYTBgY1yfxts2NgvSfYhKo_wegT5r3E7N2yQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Shaohua Li <shli@fb.com>, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Kernel-team@fb.com

On 01/15/2015 12:51 PM, Dan Williams wrote:
> On Thu, Jan 15, 2015 at 11:15 AM, Jens Axboe <axboe@fb.com> wrote:
>> On 01/15/2015 11:59 AM, Dan Williams wrote:
>>> I still don't understand what we get by adding this new allocator
>>> besides complexity, am I missing something?
>>
>>
>> Two things:
>>
>> - libata tag allocator sucks. Like seriously sucks, it's almost a worst case
>> implementation.
>
> Not questioning its suckiness, but I thought the SATA suckiness made
> it moot.  Apparently not in all cases...

The laptop I'm typing this from does 145K 4k random read IOPS, it's 
definitely into the area of it mattering.

>> - Much better to have a single unified allocator to tweak and tune, than
>> having separate version.
>>
>> #2 is still lacking a bit, but I don't think it'd be impossible to unify it
>> all.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=87101 has gone silent, I
> need to ping it.  That's my primary concern with the current proposal,
> supporting controllers that have weird/unnatural relationships  with
> the value of the tag.

Unfortunately parts of SATA is as crappy as USB when it comes to things 
like that. I can understand why some controllers would like to see a 
natural ordering of the tags (even if it is stupid to require, but AHCI 
doesn't help there), but it makes very little sense why it would break 
others. Looks like this particular case was likely a different bug, the 
ordering just made it show up more easily.

And speaking of strict ordering, the blk-mq tagging should actually 
improve ordering. The libata implementation orders globally, but that'll 
equally break down on multiple processes accessing the device. For that 
case, you end up interleaving, and if the drive does strict by-tag 
ordering of what IO to do, it'll go random pretty quickly. The blk-mq 
implementation preserves ordering between threads in that case, due to 
how the last tag is cached. So I would expect to see an improvement in 
behavior with that for use cases that offload IO to thread pools (like 
posix aio, or private implementations in programs).

-- 
Jens Axboe

