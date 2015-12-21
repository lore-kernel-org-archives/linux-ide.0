From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Sun, 20 Dec 2015 20:32:20 -0800
Message-ID: <CA+55aFz+sW4NjHZJP8mdLaqR8O0A8S4jVp=hT21tTjweOb1t8Q@mail.gmail.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
	<CACVXFVOZ+8AJwn=qyPOjzpAdfTu=AAa_oUGhqnWvU2WTANCzHg@mail.gmail.com>
	<20aa515947cdc15799f520f904ad99a2@lycos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36642 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbbLUEcV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 23:32:21 -0500
In-Reply-To: <20aa515947cdc15799f520f904ad99a2@lycos.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Artem S. Tashkinov" <t.artem@lycos.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Dec 20, 2015 at 5:50 PM, Artem S. Tashkinov <t.artem@lycos.com> wrote:
>
> P.S. I know Linus doesn't condone PAE but I still find it more preferrable
> than running a mixed environment with almost zero benefit in regard to
> performance and quite obvious performance regressions related to an
> increased number of libraries being loaded (i686 + x86_64) and slightly
> bloated code which sometimes cannot fit in the CPU cache. Call me old
> fashioned but I won't upgrade to x86_64 until most of the things that I run
> locally are available for x86_64 and that won't happen any time soon.

Don't upgrade *user* land. User land doesn't use the braindamage that is PAE.

Just run a 64-bit kernel. Keep all your 32-bit userland apps and libraries.

Trust me, that *will* be faster. PAE works really horribly badly,
because all your really important data structures like your inodes and
directory cache will all be in the low 1GB even if you have 16BG of
RAM.

Of course, I'd also like more people to run things that way just to
get more coverage of the whole "yes, we do all the compat stuff
correctly". So I have some other reasons to prefer people running
64-bit kernels with 32-bit user land. But PAE really is a disaster.

                 Linus
