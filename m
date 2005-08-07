From: Tyler <pml@dtbb.net>
Subject: Re: DriveStatusError BadCRC
Date: Sun, 07 Aug 2005 03:47:21 -0700
Message-ID: <42F5E6B9.8050700@dtbb.net>
References: <42D7AAD50003D4AA@mail-6.mail.tiscali.sys>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound01.telus.net ([199.185.220.220]:13982 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S1751422AbVHGKpW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Aug 2005 06:45:22 -0400
In-Reply-To: <42D7AAD50003D4AA@mail-6.mail.tiscali.sys>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sampei02@tiscali.it
Cc: linux-ide@vger.kernel.org

I would suggest using the smartmontools to read the SMART registers on=20
the drive, it sounds like your drive is bad.  The other way to verify i=
f=20
the drive is bad or not, is to simply put it in another computer and tr=
y=20
running it there, and see if it has the same problems.  Process of=20
elimination.

Tyler.

sampei02@tiscali.it wrote:

>I bought new Maxtor HD 80 GB but Fedora Core 3 gives  this message abo=
ut
>1 hour after boot stage (This one occurs in a variable time):
>
>
>hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
>hda: dma_intr: Error=3D0x84 { DriveStatusError BadCRC }
>ide: failed opcode was: unknown
>hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
>hda: dma_intr: Error=3D0x84 { DriveStatusError BadCRC }
>ide: failed opcode was: unknown
>.
>.
>.
>hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
>hda: dma_intr: Error=3D0x84 { DriveStatusError BadCRC }
>ide: failed opcode was: unknown
>ide0: reset: success
>Kernel panic - not syncing: mm/mmap.c:534: spin_lock(mm/rmap.c:cb80cf0=
8)
>
>
>already locked by /0. (Not tainted)
>
>[c0120445] panic+0x42/0x1c0
>[c015e1e1] vma_prio_tree_insert+017/0x2a
>[c01656d3] vma_adjust+0x322/0x556
>[c0166f30] split_vma+0xdd/0xf5
>[c0167c70] mprotect_fixup+0xf1/0x1ca
>[c0167edb] sys_mprotect+0192/0x253
>[c010392d] syscall_call+0x7/0xb
>
>I already used 80-wire cable and my Maxtor HD plugs are seated properl=
y.
>I'm using Kernel 2.6.12-1.1372 on Fedora Core 3
>HD is 80 GB Maxtor ATA/133
>
>With hdparm command I can see hda is set in "udma5".
>How can I solve it ?
>
>__________________________________________________________________
>TISCALI ADSL 1.25 MEGA
>Solo con Tiscali Adsl navighi senza limiti e telefoni senza canone Tel=
ecom
>a partire da 19,95 Euro/mese.
>Attivala entro il 31 agosto, il primo MESE =E8 GRATIS! CLICCA QUI.
>http://abbonati.tiscali.it/adsl/sa/1e25flat_tc/
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" i=
n
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> =20
>
