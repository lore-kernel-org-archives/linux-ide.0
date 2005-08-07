From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: DriveStatusError BadCRC
Date: Sun, 7 Aug 2005 08:38:49 -0600
Message-ID: <311601c905080707384a2def32@mail.gmail.com>
References: <42D7AAD50003D4AA@mail-6.mail.tiscali.sys>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.206]:51649 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751855AbVHGOit convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Aug 2005 10:38:49 -0400
Received: by rproxy.gmail.com with SMTP id i8so784756rne
        for <linux-ide@vger.kernel.org>; Sun, 07 Aug 2005 07:38:49 -0700 (PDT)
In-Reply-To: <42D7AAD50003D4AA@mail-6.mail.tiscali.sys>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "sampei02@tiscali.it" <sampei02@tiscali.it>
Cc: linux-ide@vger.kernel.org

51/84 indicates the crc failed on the incoming write data from your
system.  These failures should be very rare (on PATA), but the bummer
is they don't have anything to do with bad blocks on the media or
degrading heads...

What is the temperature like inside your case?  What host adapter are
you using?  How many drives in the system?



On 8/7/05, sampei02@tiscali.it <sampei02@tiscali.it> wrote:
> I bought new Maxtor HD 80 GB but Fedora Core 3 gives  this message ab=
out
> 1 hour after boot stage (This one occurs in a variable time):
>=20
>=20
> hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: Error=3D0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: Error=3D0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> .
> .
> .
> hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: Error=3D0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> ide0: reset: success
> Kernel panic - not syncing: mm/mmap.c:534: spin_lock(mm/rmap.c:cb80cf=
08)
>=20
>=20
> already locked by /0. (Not tainted)
>=20
> [c0120445] panic+0x42/0x1c0
> [c015e1e1] vma_prio_tree_insert+017/0x2a
> [c01656d3] vma_adjust+0x322/0x556
> [c0166f30] split_vma+0xdd/0xf5
> [c0167c70] mprotect_fixup+0xf1/0x1ca
> [c0167edb] sys_mprotect+0192/0x253
> [c010392d] syscall_call+0x7/0xb
>=20
> I already used 80-wire cable and my Maxtor HD plugs are seated proper=
ly.
> I'm using Kernel 2.6.12-1.1372 on Fedora Core 3
> HD is 80 GB Maxtor ATA/133
>=20
> With hdparm command I can see hda is set in "udma5".
> How can I solve it ?
>=20
> __________________________________________________________________
> TISCALI ADSL 1.25 MEGA
> Solo con Tiscali Adsl navighi senza limiti e telefoni senza canone Te=
lecom
> a partire da 19,95 Euro/mese.
> Attivala entro il 31 agosto, il primo MESE =E8 GRATIS! CLICCA QUI.
> http://abbonati.tiscali.it/adsl/sa/1e25flat_tc/
>=20
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
