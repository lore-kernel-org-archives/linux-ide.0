From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Mon, 21 Dec 2015 11:21:35 +0800
Message-ID: <CACVXFVNw69HHR0e_T+ai-R_qf41cWNZn6_73-Dc5aSRLPuWN2g@mail.gmail.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
	<CACVXFVOZ+8AJwn=qyPOjzpAdfTu=AAa_oUGhqnWvU2WTANCzHg@mail.gmail.com>
	<20aa515947cdc15799f520f904ad99a2@lycos.com>
	<20151221023237.GB20661@kmo-pixel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35227 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbbLUDVg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 22:21:36 -0500
In-Reply-To: <20151221023237.GB20661@kmo-pixel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: "Artem S. Tashkinov" <t.artem@lycos.com>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>

On Mon, Dec 21, 2015 at 10:25 AM, Artem S. Tashkinov <t.artem@lycos.com> wrote:
> # cat
> /sys/block/sda/queue/{max_hw_sectors_kb,max_sectors_kb,max_segments,max_segment_size}
> 32767
> 32767
> 168
> 65536

Looks it is fine, then maybe it is related with BIOVEC_PHYS_MERGEABLE(),
BIOVEC_SEG_BOUNDARY() or sort of thing, because dma_addr_t and
phys_addr_t turn to 64-bit with PAE, but 'unsigned long' and 'void *'
is still 32bit.

It was confirmed that there isn't the issue if PAE is disabled.

Dumping both sata/ahci hw sg table and bio's bvec might be helpful.

On Mon, Dec 21, 2015 at 10:32 AM, Kent Overstreet
<kent.overstreet@gmail.com> wrote:
>
> oy vey. WTF's been happening in blk-merge.c?
>
> Theyy're not the same bug. The bug in your thread was introduced by Jens in
> 5014c311ba "block: fix bogus compiler warnings in blk-merge.c", where he screwed
> up the bvprv handling - but that patch comes after the patch Artem bisected to.
>
> blk_bio_segment_split() looks correct in b54ffb73ca.

Yes, that is why reverting 578270bfb(block: fix segment split) can make the
issue disappear, because 5014c311ba "block: fix bogus compiler
warnings in blk-merge.c" basically disables sg-merge and prevents the
issue from being
triggered.



Thanks,
Ming Lei
