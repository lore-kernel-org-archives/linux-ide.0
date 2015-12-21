From: Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Sun, 20 Dec 2015 17:32:37 -0900
Message-ID: <20151221023237.GB20661@kmo-pixel>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <CACVXFVOZ+8AJwn=qyPOjzpAdfTu=AAa_oUGhqnWvU2WTANCzHg@mail.gmail.com>
 <20aa515947cdc15799f520f904ad99a2@lycos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34748 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbbLUCcl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 21:32:41 -0500
Content-Disposition: inline
In-Reply-To: <20aa515947cdc15799f520f904ad99a2@lycos.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Artem S. Tashkinov" <t.artem@lycos.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>

On Mon, Dec 21, 2015 at 06:50:21AM +0500, Artem S. Tashkinov wrote:
> On 2015-12-21 06:38, Ming Lei wrote:
> >On Mon, Dec 21, 2015 at 1:51 AM, Linus Torvalds wrote:
> >>Kent, Jens, Christoph et al,
> >> please see this bugzilla:
> >>
> >>  https://bugzilla.kernel.org/show_bug.cgi?id=109661
> >>
> >>where Artem Tashkinov bisected his problems with 4.3 down to commit
> >>b54ffb73cadc ("block: remove bio_get_nr_vecs()") that you've all
> >>signed off on.
> >>
> >>(Also Tejun - maybe you can see what's up - maybe that error message
> >>tells you something)
> >>
> >>I'm not sure what's up with his machine, the disk doesn't seem to be
> >>anyuthing particularly unusual, it looks like a 1TB Seagate Barracuda:
> >>
> >>  ata1.00: ATA-8: ST1000DM003-1CH162, CC44, max UDMA/133
> >>
> >>which doesn't strike me as odd.
> >>
> >>Looking at the dmesg, it also looks like it's a pretty normal
> >>Sandybridge setup with Intel chipset. Artem, can you confirm? The PCI
> >>ID for the AHCI chip seems to be (INTEL, 0x1c02).
> >>
> >>Any ideas? Anybody?
> >
> >BTW, I have posted very similar issue in the link:
> >
> >http://marc.info/?l=linux-ide&m=145066119623811&w=2
> >
> >Artem, I noticed from bugzillar that the hardware is i386, just
> >wondering if PAE is enabled?  If yes, I am more confident
> >that both the two kinds of report are similar or same.
> >
> 
> Yes, I'm on i686 with PAE (16GB of RAM here) - it's specifically mentioned
> in the corresponding bug report.
> 
> P.S. I know Linus doesn't condone PAE but I still find it more preferrable
> than running a mixed environment with almost zero benefit in regard to
> performance and quite obvious performance regressions related to an
> increased number of libraries being loaded (i686 + x86_64) and slightly
> bloated code which sometimes cannot fit in the CPU cache. Call me old
> fashioned but I won't upgrade to x86_64 until most of the things that I run
> locally are available for x86_64 and that won't happen any time soon.

oy vey. WTF's been happening in blk-merge.c?

Theyy're not the same bug. The bug in your thread was introduced by Jens in
5014c311ba "block: fix bogus compiler warnings in blk-merge.c", where he screwed
up the bvprv handling - but that patch comes after the patch Artem bisected to.

blk_bio_segment_split() looks correct in b54ffb73ca. 

What we need to do is:
 in the _driver_, immediately before handing the sglist off to the device, walk
 the sglist and verify it obeys all the restrictions for that particular device
 - and if it's not, print out exactly what we screwed up.

I don't know where that code lives in the ahci driver, and more importantly I
don't know where the dma restrictions come from, but if someone who knows the
driver code can walk me through it I'll write the patch.

--------------

Also - Ming, Christoph, anyone else who might be working on this stuff in the
future:

The way all the queue limits stuff works is still way too fragile; this has been
a recurring source of bugs. There's way too many different restrictions
different devices need, and it's easy for a driver to specify the restrictions
incorrectly in a way that just happens to work, but for the wrong reasons - e.g.
"I can't handle more than x segments, but saying I can't handle more than x
sectors happens to work for now because of some other bug in the upper layers" -
and then when we have to debug that later, we're screwed.

My intent when I was working on this was to eventually push the implementation
of the limits down as much as possible to the actual drivers - i.e. there the
limitations come from, so the driver can say, for example:

"ok, my device can only do scatter/gather dma to max 20 different addresses, so
I'll allocate sglists with 20 entries, and it doesn't matter if the bio or
request or whatever is bigger because when I call blk_rq_map_sg() it's just
going to map as much of the request as will fit in a given sglist and requests
will get processed incrementally until they're finished - and if a particular sg
entry can only be a particular size, or has alignment restrictions or whatever,
I'll just pass that directly to blk_rq_map_sg()"

so that the driver is ideally specifying _only_ its real restrictions, and
they're being specified in the code exactly where they're being used.

-------

Basically, blk_queue_split() was only meant to be an interim solution, so I'd
suggest that instead of doing performance optimizations on that codepath a
better use of time and effort would be to work towards ripping it out entirely.
