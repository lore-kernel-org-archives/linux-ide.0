From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Sun, 20 Dec 2015 21:10:19 -0800
Message-ID: <CA+55aFw+4yR01ZUPbFhCKg4fDVWqomQKMx6ZhjM0SfZc0fZncw@mail.gmail.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
	<20151221042613.GA27493@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:32987 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbbLUFKU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 00:10:20 -0500
In-Reply-To: <20151221042613.GA27493@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Dec 20, 2015 at 8:26 PM, Tejun Heo <tj@kernel.org> wrote:
>
> I wonder whether ahci is screwing up command / sg table setup in a way
> that e.g. if there are too many segments the sg table overflows into
> the neighboring one which is now being exposed by upper layer being
> fixed to send down larger commands.  Looking into it.

That would explain the

  Corrupted low memory at c0001000 ...

that Artem also saw.

Anyway, it would be lovely to have some verification in the ATA
routines that the passed-on IO actually h9onors the limits it set.
Could you add a WARN_ON_ONCE(check_io_limits())" or similar, and maybe
we could catch whatever causes the overflow red-handed?

On a totally separate issue:

Just looking at some of the merging code, and I have to say that it
strikes me as insane. This in particular:

  #define __BIO_SEG_BOUNDARY(addr1, addr2, mask) \
        (((addr1) | (mask)) == (((addr2) - 1) | (mask)))
  #define BIOVEC_SEG_BOUNDARY(q, b1, b2) \
        __BIO_SEG_BOUNDARY(bvec_to_phys((b1)), bvec_to_phys((b2)) +
(b2)->bv_len, queue_segment_boundary((q)))

seems just *stupid*.

Why does it do that "bvec_to_phys((b2)) + (b2)->bv_len -1" on the
second bvec? That's the :"physical address of the last byte of the
second bvec".

I understand the "round both addresses up by the mask, and we want to
make sure that they are in the same segment" part.

But since an individual bvec had better be fully inside one segment
(since we split at bvec boundaries anyway, so if ). why do all that
crap anyway? The end address doesn't matter, you could just use the
beginning.

So remove the "-1" and remove the "+bv_len".

At which it would become just

  #define __BIO_SEG_BOUNDARY(addr1, addr2, mask) \
        ((addr1) | (mask) == (addr2)|(mask))
  #define BIOVEC_SEG_BOUNDARY(q, b1, b2) \
        __BIO_SEG_BOUNDARY(bvec_to_phys((b1)), bvec_to_phys((b2)),
queue_segment_boundary((q)))

which seems simpler and more understandable. "Are the beginning
addresses in within the same segment"

Or are there ever bv_len == 0 things at the boundary that we want to
merge. Because then the "-1+bv_len" case migth make sense.

Anyway, that shouldn't change the end result in any way, so that
doesn't all *matter*, but it worries me when things look more
complicated than I think they should be.

Is there something I'm missing?

               Linus
