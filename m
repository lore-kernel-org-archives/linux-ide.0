From: sampei02@tiscali.it
Subject: DriveStatusError
Date: Fri, 29 Jul 2005 21:02:38 +0200
Message-ID: <42D7AAD50002B6A4@mail-6.mail.tiscali.sys>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mrqout2.tiscali.it ([195.130.225.12]:36756 "EHLO
	mrqout2.tiscali.it") by vger.kernel.org with ESMTP id S262738AbVG2TCn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Jul 2005 15:02:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I bought new Maxtor HD 80 GB but something doesn't work on Fedora Core =
3
because it gives this message:


hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
hda: dma_intr: Error=3D0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
hda: dma_intr: Error=3D0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
=2E
=2E
=2E
hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
hda: dma_intr: Error=3D0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
ide0: reset: success
Kernel panic - not syncing: mm/mmap.c:534: spin_lock(mm/rmap.c:cb80cf08=
)


already locked by /0. (Not tainted)

[c0120445] panic+0x42/0x1c0
[c015e1e1] vma_prio_tree_insert+017/0x2a
[c01656d3] vma_adjust+0x322/0x556
[c0166f30] split_vma+0xdd/0xf5
[c0167c70] mprotect_fixup+0xf1/0x1ca
[c0167edb] sys_mprotect+0192/0x253
[c010392d] syscall_call+0x7/0xb

This problem occurs in a variable time after boot.
After few hours that pc is turned off.
I already used 80-wire cable and my Maxtor HD plugs are seated properly=
=2E
I'm using Kernel 2.6.12-1.1372 on Fedora Core 3
HD is 80 GB Maxtor ATA/133

With hdparm command I can see hda is set in "udma5".
How can I solve it ?

__________________________________________________________________
TISCALI ADSL 1.25 MEGA
Solo con Tiscali Adsl navighi senza limiti e telefoni senza canone Tele=
com
a partire da  19,95 Euro/mese.
Attivala entro il 28 luglio, il primo MESE =E8 GRATIS! CLICCA QUI.
http://abbonati.tiscali.it/adsl/sa/1e25flat_tc/



