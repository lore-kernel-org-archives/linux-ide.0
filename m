From: Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Sun, 20 Dec 2015 09:44:04 -0900
Message-ID: <20151220184404.GA18035@kmo-pixel>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <20151220181801.GA12402@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35979 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbbLTSoL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 13:44:11 -0500
Content-Disposition: inline
In-Reply-To: <20151220181801.GA12402@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Dec 20, 2015 at 07:18:01PM +0100, Christoph Hellwig wrote:
> On Sun, Dec 20, 2015 at 09:51:14AM -0800, Linus Torvalds wrote:
> > Kent, Jens, Christoph et al,
> ie  please see this bugzilla:
> >o 
> >   httpps://bugzilla.kernel.org/show_bug.cgi?id=109661
> > 
> > where Artem Tashkinov bisected his problems with 4.3 down to commit
> > b54ffb73cadc ("block: remove bio_get_nr_vecs()") that you've all
> > signed off on.
> 
> Artem,
> 
> can you re-check the commits around this series again?  I would be
> extremtly surprised if it's really this particular commit and not
> one just before it causing the problem - it just allocates bios
> to the biggest possible instead of only allocating up to what
> bio_add_page would accept.

pretty sure it's something with how blk_bio_segment_split() decides what
segments are mergable and not. bio_get_nr_vecs() was just returning nr_pages ==
queue_max_segments (ignoring sectors for the moment) - so wait, wtf? that's
basically assuming no segment merging can ever happen, if it does then this was
causing us to send smaller requests to the device than we could have been.

so actually two possibilities I can see:
 - in blk_bio_segment_split(), something's screwed up with how it decides what
   segments are going to be mergable or not. but I don't think that's likely
   since it's doing the exact same thing the rest of the segment merging code
   does.
 - or, the driver was lying in its queue limits, using queue_max_segments for
   "the maximum number of pages I can possibly take", and that bug lurked
   undiscovered because of the screwed-upness in bio_get_nr_vecs().

Offhand I don't know where to start digging in the driver code to look into the
second theory though. Tejun, you got any ideas?
