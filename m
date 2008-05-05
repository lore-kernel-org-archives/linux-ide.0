From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: Fix falconide `data_adr' typo
Date: Mon, 5 May 2008 21:15:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805052114380.15634@anakin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761283AbYEETPl@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

    commit 9567b349f7e7dd7e2483db99ee8e4a6fe0caca38
    Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
    Date:   Mon Apr 28 23:44:36 2008 +0200

    ide: merge ->atapi_*put_bytes and ->ata_*put_data methods

introduced a typo (`data_adr' instead of `data_addr'), leading to a compile
failure.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/ide/legacy/falconide.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ide/legacy/falconide.c
+++ b/drivers/ide/legacy/falconide.c
@@ -61,7 +61,7 @@ static void falconide_output_data(ide_dr
 	unsigned long data_addr = drive->hwif->io_ports.data_addr;
 
 	if (drive->media == ide_disk && rq && rq->cmd_type == REQ_TYPE_FS)
-		return outsw(data_adr, buf, (len + 1) / 2);
+		return outsw(data_addr, buf, (len + 1) / 2);
 
 	outsw_swapw(data_addr, buf, (len + 1) / 2);
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
