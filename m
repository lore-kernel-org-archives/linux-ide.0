From: Tejun Heo <tj@kernel.org>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Sun, 20 Dec 2015 23:26:13 -0500
Message-ID: <20151221042613.GA27493@htj.duckdns.org>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34049 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbbLUE0P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 23:26:15 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello, Linus.

On Sun, Dec 20, 2015 at 09:51:14AM -0800, Linus Torvalds wrote:
...
> (Also Tejun - maybe you can see what's up - maybe that error message
> tells you something)

Hmmm... all it says is that something went wrong on the PCI side.

> I'm not sure what's up with his machine, the disk doesn't seem to be
> anyuthing particularly unusual, it looks like a 1TB Seagate Barracuda:
> 
>   ata1.00: ATA-8: ST1000DM003-1CH162, CC44, max UDMA/133
> 
> which doesn't strike me as odd.
> 
> Looking at the dmesg, it also looks like it's a pretty normal
> Sandybridge setup with Intel chipset. Artem, can you confirm? The PCI
> ID for the AHCI chip seems to be (INTEL, 0x1c02).
> 
> Any ideas? Anybody?

I wonder whether ahci is screwing up command / sg table setup in a way
that e.g. if there are too many segments the sg table overflows into
the neighboring one which is now being exposed by upper layer being
fixed to send down larger commands.  Looking into it.

Thanks.

-- 
tejun
