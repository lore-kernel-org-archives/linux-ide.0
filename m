From: Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Mon, 21 Dec 2015 18:59:44 -0900
Message-ID: <20151222035944.GG20661@kmo-pixel>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <20151221065528.GA3873@htj.duckdns.org>
 <e53cb2f9d5882b0fbe82c589259bf043@lycos.com>
 <20151221193550.GM4026@mtj.duckdns.org>
 <20151221200721.GN4026@mtj.duckdns.org>
 <20151221210811.GO4026@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35491 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbbLVD7t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 22:59:49 -0500
Content-Disposition: inline
In-Reply-To: <20151221210811.GO4026@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Artem S. Tashkinov" <t.artem@lycos.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Whitehouse <swhiteho@redhat.com>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ming Lei <tom.leiming@gmail.com>

On Mon, Dec 21, 2015 at 04:08:11PM -0500, Tejun Heo wrote:

reproduced it with 32 bit pae:

> 1. Exclude memory above 4G line with boot param "max_addr=4G".

doesn't work - max_addr=1G doesn't work either

> 2. Disable highmem with "highmem=0".

works!

> 3. Try booting 64bit kernel.

works

Ok, so maybe it actually is PAE specific... but like you noted the block layer
works entirely in terms of pages so...

The one idea I can think of is - maybe BIOVEC_PHYS_MERGEABLE() is broken in PAE
mode? I am unfamiliar with anything PAE though.

Where does the ahci code consume the sglist?
