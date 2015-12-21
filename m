From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Sun, 20 Dec 2015 21:23:18 -0800
Message-ID: <CA+55aFzEzm0fQ20GTNMuSKsymQVzYnP3DdDo5HinXjek5Dtmzg@mail.gmail.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
	<CACVXFVOZ+8AJwn=qyPOjzpAdfTu=AAa_oUGhqnWvU2WTANCzHg@mail.gmail.com>
	<20aa515947cdc15799f520f904ad99a2@lycos.com>
	<CA+55aFz+sW4NjHZJP8mdLaqR8O0A8S4jVp=hT21tTjweOb1t8Q@mail.gmail.com>
	<3c353dc4883c60ee99caa4555c81b6a1@lycos.com>
	<CA+55aFyMPXK6VusHvNKim75O1ytXme7tA2g5+XQAziXuwUdHLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36467 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbbLUFXS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 00:23:18 -0500
In-Reply-To: <CA+55aFyMPXK6VusHvNKim75O1ytXme7tA2g5+XQAziXuwUdHLA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Artem S. Tashkinov" <t.artem@lycos.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Dec 20, 2015 at 8:47 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That said, we obviously need to figure out this current problem
> regardless first..

... although maybe it *would* be interesting to hear what happens if
you just compile a 64-bit kernel instead?

Do you still see the problem? Because if not, then we should look very
specifically for some 32-bit PAE issue.

For example, maybe we use "unsigned long" somewhere where we should
use "phys_addr_t". On x86-64, they obviously end up being the same. On
normal non-PAE x86-32, they are also the same. But ..

                 Linus
