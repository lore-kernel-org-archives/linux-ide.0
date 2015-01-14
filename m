From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 3/3] libata: use blk taging
Date: Wed, 14 Jan 2015 00:08:26 -0800
Message-ID: <CAA9_cmeJvjTjovC4VdeH5P2JYWKZK0OQ8Dc1Ts15TvLiS+qrBQ@mail.gmail.com>
References: <e8fb0a8f15f291f6dae88d51295432a2fa7ad71b.1418928090.git.shli@fb.com>
	<546516bb62c91671b1464e6a7c68eebc8422efe5.1418928090.git.shli@fb.com>
	<20150109181529.GA1301458@devbig257.prn2.facebook.com>
	<20150109214307.GE2785@htj.dyndns.org>
	<20150109215919.GA1826518@devbig257.prn2.facebook.com>
	<20150109221209.GA1851286@devbig257.prn2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36439 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331AbbANII1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2015 03:08:27 -0500
Received: by mail-qc0-f174.google.com with SMTP id c9so6138638qcz.5
        for <linux-ide@vger.kernel.org>; Wed, 14 Jan 2015 00:08:26 -0800 (PST)
In-Reply-To: <20150109221209.GA1851286@devbig257.prn2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shli@fb.com>
Cc: Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Kernel-team@fb.com, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>

On Fri, Jan 9, 2015 at 2:12 PM, Shaohua Li <shli@fb.com> wrote:
> On Fri, Jan 09, 2015 at 01:59:19PM -0800, Shaohua Li wrote:
>> On Fri, Jan 09, 2015 at 04:43:07PM -0500, Tejun Heo wrote:
>> > On Fri, Jan 09, 2015 at 10:15:29AM -0800, Shaohua Li wrote:
>> > > Ping!
>> >
>> > I like the idea but it bothers me that we end up with two separate
>> > ways of allocating command tags.  Any chance the old one can be
>> > removed?
>
> Oh, sorry, my reply truncated.
>
> So I checked with IPR driver guys, the ipr doesn't use ncq, so we can
> always use sata tag 0, but not sure for libsas.
>
> Maybe Dan can answer if there is a way we can map SCSI tag to SATA tag.
>

For libsas or for ata drivers?  For libsas, iirc, the internal libata
tag is ignored and we use the scsi tag for the sas task  For ata some
drivers want round robin, but others appear to care about using the
lowest available: https://bugzilla.kernel.org/show_bug.cgi?id=87101.

Is ata using it's own legacy tag ordering scheme getting in the way of
other improvements?  I'd just as soon recommend letting legacy dogs
lie.  In other words what do we gain by switching?

I need to follow up on bz87101, seems I never reworked the patch as
Tejun asked.  However, I'm glad a fix like the one proposed in that
report can be self-contained to libata and need not worry about
supporting ata specific quirks in the block layer tag ordering scheme.
