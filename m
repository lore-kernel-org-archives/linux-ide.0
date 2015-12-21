From: Tejun Heo <tj@kernel.org>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Mon, 21 Dec 2015 14:35:50 -0500
Message-ID: <20151221193550.GM4026@mtj.duckdns.org>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <20151221065528.GA3873@htj.duckdns.org>
 <e53cb2f9d5882b0fbe82c589259bf043@lycos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36247 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbbLUTfw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 14:35:52 -0500
Content-Disposition: inline
In-Reply-To: <e53cb2f9d5882b0fbe82c589259bf043@lycos.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Artem S. Tashkinov" <t.artem@lycos.com>
Cc: "Artem S. Tashkinov" <t.artem@mailcity.com>, Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Whitehouse <swhiteho@redhat.com>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ming Lei <tom.leiming@gmail.com>

Hello, Artem.

On Mon, Dec 21, 2015 at 12:25:06PM +0500, Artem S. Tashkinov wrote:
> I've applied this patch on top of vanilla 4.3.3 kernel (without Linus'es
> revert). Hopefully it's how you intended it to be.
> 
> Here's the result (I skipped the beginning of dmesg - it's the same as
> always - see bugzilla).

I added some debug messages during init.  It isn't critical but it'd
be great if you attach the full log from now on.  Something seemingly
unrelated surprisingly often turns out to be an important clue.

> [   60.387407] Corrupted low memory at c0001000 (1000 phys) = cba3d25f
...
> [   60.389131] Corrupted low memory at c0001ffc (1ffc phys) = 2712322a

It looks like the controller shat on the entire second page, which is
really puzzling.  Looks like the controller is being fed corrupt DMA
SG table.

...
> [   74.367608] ata1.00: exception Emask 0x3 SAct 0x180000 SErr 0x3040400 action 0x6 frozen
> [   74.367613] ata1.00: irq_stat 0x45000008

The intresting bit here is that the controller is indicating OVERFLOW
which means that it consumed all PRD entries (ahci's DMA SG table) for
the command but the disk is still sending data to the host.

> [   74.367617] ata1: SError: { Proto CommWake TrStaTrns UnrecFIS }
> [   74.367621] ata1.00: failed command: READ FPDMA QUEUED
> [   74.367627] ata1.00: cmd 60/00:98:00:89:21/07:00:04:00:00/40 tag 19 ncq 917504 in
> [   74.367627]          res 40/00:98:00:89:21/00:00:04:00:00/40 Emask 0x3 (HSM violation)
> [   74.367630] ata1.00: status: { DRDY }

The followings are the data fed to the controller as seen from the
CPU.

> [   74.367632] XXX cmd=ee9e0260 cmd_tbl=ee9ed600 ahci_sg=ee9ed680
> [   74.367634] XXX opts=140005 st=0 addr=2e9ed600 addr_hi=0 rsvd=0:0:0:0
> [   74.367637] XXX fis=00608027:40218900:07000004:08000098 00000000:00000000:00000000:00001fff
> [   74.367639] XXX qc->n_elem=20 fis_len=5 prdtl=20
> [   74.367641] XXX sg[0] = 29007000 0 8fff (36864)
> [   74.367643] XXX sg[1] = 29218000 0 7fff (32768)
> [   74.367645] XXX sg[2] = 29298000 0 7fff (32768)
> [   74.367646] XXX sg[3] = 29ad8000 0 7fff (32768)
> [   74.367648] XXX sg[4] = 29338000 0 7fff (32768)
> [   74.367650] XXX sg[5] = 29370000 0 2fff (12288)
> [   74.367652] XXX sg[6] = 219000 0 2fff (12288)
> [   74.367653] XXX sg[7] = 230000 0 3fff (16384)
> [   74.367655] XXX sg[8] = 29373000 0 4fff (20480)
> [   74.367657] XXX sg[9] = 29130000 0 ffff (65536)
> [   74.367659] XXX sg[10] = 29170000 0 ffff (65536)
> [   74.367660] XXX sg[11] = 29280000 0 ffff (65536)
> [   74.367662] XXX sg[12] = 29200000 0 ffff (65536)
> [   74.367664] XXX sg[13] = 29320000 0 ffff (65536)
> [   74.367666] XXX sg[14] = 29360000 0 ffff (65536)
> [   74.367667] XXX sg[15] = 29340000 0 ffff (65536)
> [   74.367669] XXX sg[16] = 29350000 0 ffff (65536)
> [   74.367671] XXX sg[17] = 29300000 0 ffff (65536)
> [   74.367672] XXX sg[18] = 29310000 0 ffff (65536)
> [   74.367674] XXX sg[19] = 29020000 0 7fff (32768)

And everything checks out.  Data lenghts are consistent and all the
addresses look kosher - at least nothing should upset the data
transfer itself.

> [   74.367677] ata1.00: failed command: READ FPDMA QUEUED
> [   74.367682] ata1.00: cmd 60/90:a0:c0:fe:23/00:00:04:00:00/40 tag 20 ncq 73728 in
> [   74.367682]          res 40/00:00:00:00:00/00:00:00:00:00/40 Emask 0x7 (timeout)

This one looks like a collateral damage.

...
> [   74.763895] ata1.00: exception Emask 0x3 SAct 0x800000 SErr 0x3040400 action 0x6
> [   74.763900] ata1.00: irq_stat 0x45000008
> [   74.763903] ata1: SError: { Proto CommWake TrStaTrns UnrecFIS }
> [   74.763907] ata1.00: failed command: READ FPDMA QUEUED
> [   74.763913] ata1.00: cmd 60/98:b8:00:c9:20/03:00:04:00:00/40 tag 23 ncq 471040 in
> [   74.763913]          res 40/00:b8:00:c9:20/00:00:04:00:00/40 Emask 0x3 (HSM violation)
> [   74.763916] ata1.00: status: { DRDY }
> [   74.763918] XXX cmd=ee9e02e0 cmd_tbl=ee9f0200 ahci_sg=ee9f0280
> [   74.763921] XXX opts=160005 st=0 addr=2e9f0200 addr_hi=0 rsvd=0:0:0:0
> [   74.763924] XXX fis=98608027:4020c900:03000004:080000b8 00000000:00000000:00000000:00000fff
> [   74.763925] XXX qc->n_elem=22 fis_len=5 prdtl=22
> [   74.763928] XXX sg[0] = 2ab1b000 0 fff (4096)
...
> [   74.763964] XXX sg[21] = 29170000 0 dfff (57344)

This is a separate failure and shares the same pattern as before.
Everything looks proper.

The thing is ahci doesn't have much restrictions in terms of its DMA
capabilities.  It can digest pretty much anything.  The only
restriction is that each entry can't be larger than 4M - but our
segment maximum is 64k.  There's no noticeable boundary crossing
happening both in target DMA regions and command tables.  All
addresses are in linear mapped normal area.

If the controller is seeing what the host is seeing in the command
area, I can't see why it would be declaring overflow or dumping stuff
into the lowest pages.

Ming Lei reported a similar issue on 32bit ARM w/ PAE.  I don't
understand why PAE is making any difference.  Native 64bit machines
should be generating IOs just as large.  Maybe iommu is hiding the
issue?

I'm afraid we'll have to go brute force with the problem - dump more
information on both 32 and 64bits and see where the differences lie.
At the moment, given that the DMA table looks completely fine and ahci
isn't picky about the shape of data areas, I think it's more likely
some obscure issue in address mapping under PAE or a silly bug in ahci
than block layer screwing up merging.

Thanks.

-- 
tejun
