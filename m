From: Sampei <sampei02@tiscali.it>
Subject: DriveStatusError
Date: Sun, 24 Jul 2005 21:42:52 +0200
Message-ID: <1122234170.2206.49.camel@zio_budda>
Reply-To: sampei02@tiscali.it
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:29867 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262699AbVG2SkR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Jul 2005 14:40:17 -0400
Received: from localhost.localdomain (62.11.100.42) by mail-relay-1.tiscali.it (7.2.063)
        id 42D67C6200150C4E for linux-ide@vger.kernel.org; Fri, 29 Jul 2005 20:40:02 +0200
Received: from localhost.localdomain (zio_budda [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11/sendmail.mc 8.12.11-4.6  05/12/2004) with ESMTP id j6OJgtch003126
	for <linux-ide@vger.kernel.org>; Sun, 24 Jul 2005 21:42:55 +0200
Received: (from shotokan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j6OJgr92003125
	for linux-ide@vger.kernel.org; Sun, 24 Jul 2005 21:42:54 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I bought new Maxtor HD 80 GB but something doesn't work on Fedora Core 3
because it gives this message:


hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: Error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: Error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
.
.
.
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: Error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
ide0: reset: success
Kernel panic - not syncing: mm/mmap.c:534: spin_lock(mm/rmap.c:cb80cf08)


already locked by <NULL>/0. (Not tainted)

[c0120445] panic+0x42/0x1c0
[c015e1e1] vma_prio_tree_insert+017/0x2a
[c01656d3] vma_adjust+0x322/0x556
[c0166f30] split_vma+0xdd/0xf5
[c0167c70] mprotect_fixup+0xf1/0x1ca
[c0167edb] sys_mprotect+0192/0x253
[c010392d] syscall_call+0x7/0xb

This problem occurs in a variable time after boot.
After few hours that pc is turned off.
I already used 80-wire cable and my Maxtor HD plugs are seated properly.
I'm using Kernel 2.6.12-1.1372 on Fedora Core 3
HD is 80 GB Maxtor ATA/133

With hdparm command I can see hda is set in "udma5".
How can I solve it ?

