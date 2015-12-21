From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Mon, 21 Dec 2015 09:38:48 +0800
Message-ID: <CACVXFVOZ+8AJwn=qyPOjzpAdfTu=AAa_oUGhqnWvU2WTANCzHg@mail.gmail.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33651 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbbLUBit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 20:38:49 -0500
In-Reply-To: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Dec 21, 2015 at 1:51 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Kent, Jens, Christoph et al,
>  please see this bugzilla:
>
>   https://bugzilla.kernel.org/show_bug.cgi?id=109661
>
> where Artem Tashkinov bisected his problems with 4.3 down to commit
> b54ffb73cadc ("block: remove bio_get_nr_vecs()") that you've all
> signed off on.
>
> (Also Tejun - maybe you can see what's up - maybe that error message
> tells you something)
>
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

BTW, I have posted very similar issue in the link:

http://marc.info/?l=linux-ide&m=145066119623811&w=2

Artem, I noticed from bugzillar that the hardware is i386, just
wondering if PAE is enabled?  If yes, I am more confident
that both the two kinds of report are similar or same.

Thanks,

>
>                        Linus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Ming Lei
