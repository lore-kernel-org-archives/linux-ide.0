From: Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Sun, 20 Dec 2015 14:42:35 -0900
Message-ID: <20151220234235.GA20661@kmo-pixel>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <20151220181801.GA12402@lst.de>
 <37aeccfa37bb49823a62ae24be554a5a@lycos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36425 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbbLTXmk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 18:42:40 -0500
Content-Disposition: inline
In-Reply-To: <37aeccfa37bb49823a62ae24be554a5a@lycos.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Artem S. Tashkinov" <t.artem@lycos.com>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Dec 21, 2015 at 04:25:12AM +0500, Artem S. Tashkinov wrote:
> On 2015-12-20 23:18, Christoph Hellwig wrote:
> >On Sun, Dec 20, 2015 at 09:51:14AM -0800, Linus Torvalds wrote:
> >>Kent, Jens, Christoph et al,
> >> please see this bugzilla:
> >>
> >>  https://bugzilla.kernel.org/show_bug.cgi?id=109661
> >>
> >>where Artem Tashkinov bisected his problems with 4.3 down to commit
> >>b54ffb73cadc ("block: remove bio_get_nr_vecs()") that you've all
> >>signed off on.
> >
> >Artem,
> >
> >can you re-check the commits around this series again?  I would be
> >extremtly surprised if it's really this particular commit and not
> >one just before it causing the problem - it just allocates bios
> >to the biggest possible instead of only allocating up to what
> >bio_add_page would accept.
> 
> I'm positive about this particular commit. Of course, it might be another
> GCC 4.7.4 miscompilation which causes the errors which shouldn't be there
> but
> I'm not an expert, so.

I believe you on the commit, and I doubt this has anything to do with gcc - the
errors you're getting are exactly what you normally get when you send the device
an sglist to dma to/from that it doesn't like.

The queue limits stuff is annoyingly fragile, you'd think we'd be able to check
directly in the driver that the stuff we're sending the device is sane but we
don't.

If I came up with a debug patch could you try it out? I don't have any ideas for
one yet, but if someone who knows the ATA code doesn't jump in I'll call up
Tejun and make him walk me through it.
