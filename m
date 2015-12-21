From: Tejun Heo <tj@kernel.org>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Mon, 21 Dec 2015 16:08:11 -0500
Message-ID: <20151221210811.GO4026@mtj.duckdns.org>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <20151221065528.GA3873@htj.duckdns.org>
 <e53cb2f9d5882b0fbe82c589259bf043@lycos.com>
 <20151221193550.GM4026@mtj.duckdns.org>
 <20151221200721.GN4026@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151221200721.GN4026@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Artem S. Tashkinov" <t.artem@lycos.com>
Cc: "Artem S. Tashkinov" <t.artem@mailcity.com>, Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Whitehouse <swhiteho@redhat.com>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ming Lei <tom.leiming@gmail.com>
List-Id: linux-ide@vger.kernel.org

Hello, again.

On Mon, Dec 21, 2015 at 03:07:21PM -0500, Tejun Heo wrote:
> Hello, Artem.
> 
> Can you please apply the following patch on top and see whether
> anything changes?  If it does make the issue go away, can you please
> revert the ".can_queue" part and test again?

If the patch doesn't change anything, can you please try the
followings and see which one makes difference?

1. Exclude memory above 4G line with boot param "max_addr=4G".
2. Disable highmem with "highmem=0".
3. Try booting 64bit kernel.

At the moment, the only thing I can think of which can explain the PAE
+ bio_get_nr_vecs() situation is that the bio split code which is
activated by the bio_get_nr_vecs() somehow messes up 64bit or high
addresses on 32bit kernels.  I scanned for the obvious but at bio
layer, memory is represented by struct page, so nothing obvious seems
broken.

Note that for now I'm ignoring the debug dumps from the ahci debug
patch which indicates that the passed in addresses are all fine.  It
is possible that the controller gets confused with certain receiving
addresses and reports failure on later commands or maybe there is a
different sequence of events which can encompass both that we don't
know of yet.

Thanks.

-- 
tejun
