From: Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Mon, 21 Dec 2015 18:43:19 -0900
Message-ID: <20151222034319.GF20661@kmo-pixel>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <20151221065528.GA3873@htj.duckdns.org>
 <e53cb2f9d5882b0fbe82c589259bf043@lycos.com>
 <20151221193550.GM4026@mtj.duckdns.org>
 <20151221200721.GN4026@mtj.duckdns.org>
 <20151221210811.GO4026@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33439 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbbLVDnY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 22:43:24 -0500
Content-Disposition: inline
In-Reply-To: <20151221210811.GO4026@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, "Artem S. Tashkinov" <t.artem@mailcity.com>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Whitehouse <swhiteho@redhat.com>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ming Lei <tom.leiming@gmail.com>

I just reproduced it - Artem, I'll let you know when we have a possible fix but
hopefully there won't be any need for you to beat up your hardware any more :)

On Mon, Dec 21, 2015 at 04:08:11PM -0500, Tejun Heo wrote:
> Hello, again.
> 
> On Mon, Dec 21, 2015 at 03:07:21PM -0500, Tejun Heo wrote:
> > Hello, Artem.
> > 
> > Can you please apply the following patch on top and see whether
> > anything changes?  If it does make the issue go away, can you please
> > revert the ".can_queue" part and test again?
> 
> If the patch doesn't change anything, can you please try the
> followings and see which one makes difference?
> 
> 1. Exclude memory above 4G line with boot param "max_addr=4G".
> 2. Disable highmem with "highmem=0".
> 3. Try booting 64bit kernel.
> 
> At the moment, the only thing I can think of which can explain the PAE
> + bio_get_nr_vecs() situation is that the bio split code which is
> activated by the bio_get_nr_vecs() somehow messes up 64bit or high
> addresses on 32bit kernels.  I scanned for the obvious but at bio
> layer, memory is represented by struct page, so nothing obvious seems
> broken.
> 
> Note that for now I'm ignoring the debug dumps from the ahci debug
> patch which indicates that the passed in addresses are all fine.  It
> is possible that the controller gets confused with certain receiving
> addresses and reports failure on later commands or maybe there is a
> different sequence of events which can encompass both that we don't
> know of yet.

It repros pretty easily, I should be able to just write some test code that
sends down single specific IOs so no matter what the controller is doing we know
exactly what IO triggered the error.

I'm checking all the 64 bit/pae/etc. stuff now.
