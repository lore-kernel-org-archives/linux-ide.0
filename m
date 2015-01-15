From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 3/3] libata: use blk taging
Date: Thu, 15 Jan 2015 11:51:37 -0800
Message-ID: <CAPcyv4iu4jwJsfuYTBgY1yfxts2NgvSfYhKo_wegT5r3E7N2yQ@mail.gmail.com>
References: <20150109181529.GA1301458@devbig257.prn2.facebook.com>
	<20150109214307.GE2785@htj.dyndns.org>
	<20150109215919.GA1826518@devbig257.prn2.facebook.com>
	<20150109221209.GA1851286@devbig257.prn2.facebook.com>
	<CAA9_cmeJvjTjovC4VdeH5P2JYWKZK0OQ8Dc1Ts15TvLiS+qrBQ@mail.gmail.com>
	<20150114163006.GA3575264@devbig257.prn2.facebook.com>
	<CAPcyv4hMwpGzeaovnXtqyYFM46wodRamZd7CNVoR43JJYh0Tjg@mail.gmail.com>
	<20150114171328.GA3636164@devbig257.prn2.facebook.com>
	<CAPcyv4geWdT7hEzeuVgLO8X5GKy1ez93uK_vxBOmdZWAK94ngw@mail.gmail.com>
	<20150115092836.GA14051@infradead.org>
	<20150115184008.GA2222288@devbig257.prn2.facebook.com>
	<CAPcyv4imdCq83gN+KOWsu4=0arB59um8upnaGRV0UxhBwc6T4A@mail.gmail.com>
	<54B811C7.8000700@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:58659 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787AbbAOTvj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2015 14:51:39 -0500
Received: by mail-wi0-f175.google.com with SMTP id l15so37507243wiw.2
        for <linux-ide@vger.kernel.org>; Thu, 15 Jan 2015 11:51:38 -0800 (PST)
In-Reply-To: <54B811C7.8000700@fb.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@fb.com>
Cc: Shaohua Li <shli@fb.com>, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Kernel-team@fb.com

On Thu, Jan 15, 2015 at 11:15 AM, Jens Axboe <axboe@fb.com> wrote:
> On 01/15/2015 11:59 AM, Dan Williams wrote:
>> I still don't understand what we get by adding this new allocator
>> besides complexity, am I missing something?
>
>
> Two things:
>
> - libata tag allocator sucks. Like seriously sucks, it's almost a worst case
> implementation.

Not questioning its suckiness, but I thought the SATA suckiness made
it moot.  Apparently not in all cases...

> - Much better to have a single unified allocator to tweak and tune, than
> having separate version.
>
> #2 is still lacking a bit, but I don't think it'd be impossible to unify it
> all.

https://bugzilla.kernel.org/show_bug.cgi?id=87101 has gone silent, I
need to ping it.  That's my primary concern with the current proposal,
supporting controllers that have weird/unnatural relationships  with
the value of the tag.
