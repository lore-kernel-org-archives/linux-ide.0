From: Christoph Hellwig <hch@lst.de>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Sun, 20 Dec 2015 19:18:01 +0100
Message-ID: <20151220181801.GA12402@lst.de>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Sun, Dec 20, 2015 at 09:51:14AM -0800, Linus Torvalds wrote:
> Kent, Jens, Christoph et al,
>  please see this bugzilla:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=109661
> 
> where Artem Tashkinov bisected his problems with 4.3 down to commit
> b54ffb73cadc ("block: remove bio_get_nr_vecs()") that you've all
> signed off on.

Artem,

can you re-check the commits around this series again?  I would be
extremtly surprised if it's really this particular commit and not
one just before it causing the problem - it just allocates bios
to the biggest possible instead of only allocating up to what
bio_add_page would accept.
