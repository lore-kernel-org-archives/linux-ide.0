From: Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Mon, 21 Dec 2015 19:45:14 -0900
Message-ID: <20151222044514.GA10013@kmo-pixel>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <20151221065528.GA3873@htj.duckdns.org>
 <e53cb2f9d5882b0fbe82c589259bf043@lycos.com>
 <20151221193550.GM4026@mtj.duckdns.org>
 <20151221200721.GN4026@mtj.duckdns.org>
 <20151221210811.GO4026@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34796 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbbLVEpT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 23:45:19 -0500
Content-Disposition: inline
In-Reply-To: <20151221210811.GO4026@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Artem S. Tashkinov" <t.artem@lycos.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Whitehouse <swhiteho@redhat.com>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ming Lei <tom.leiming@gmail.com>

So what I _really_ want to know is - how the fuck is the actual ATA command
itself malformed?

You told me at one point that the error code indicated the controller was
claiming it overran the end of the sglist - well, if that's the case we ought to
be able to prove it with an assertion (I already tried; qc->nbytes does match
the sglist, checking from ata_sg_setup()).

Ignore bvec merging, PAE, all that crap - the controller doesn't know about any
of that. _WHAT_ are we feeding it that it doesn't like?

There shouldn't even be that much stuff to check, since in theory the only
possible thing that could be at fault is the sglist. Maybe they're too big, too
small, misaligned, too many of them, god knows what, but somehow the sglist
we're feeding the device has to be at fault, right?

But the sglists in Artem's debugging output look pretty uninteresting (one
of them has _no_ merged segments - it's just 18 4k pages - how could THAT be an
issue?)

Gonna apply your debugging patch and start throwing stuff at the wall next, I
guess...
