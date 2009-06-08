From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Subject: [PATCH next] ide: fix PowerMac bootup oops
Date: Mon, 8 Jun 2009 21:45:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0906082137120.22183@sister.anvils>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755482AbZFHU4a@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Joao Ramos <joao.ramos@inov.pt>, Sergei Shtylyov <sshtylyov@ru.montavista.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

PowerMac bootup with CONFIG_IDE=y oopses in ide_pio_cycle_time():
because "ide: try to use PIO Mode 0 during probe if possible" causes
pmac_ide_set_pio_mode() now to be called before drive->id has been set.
It does the right thing if id is not set, so long as we check for that.

Signed-off-by: Hugh Dickins <hugh.dickins@tiscali.co.uk>
---

 drivers/ide/ide-timings.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnext/drivers/ide/ide-timings.c	2009-04-08 18:25:55.000000000 +0100
+++ linux/drivers/ide/ide-timings.c	2009-06-03 19:45:58.000000000 +0100
@@ -84,7 +84,7 @@ u16 ide_pio_cycle_time(ide_drive_t *driv
 	struct ide_timing *t = ide_timing_find_mode(XFER_PIO_0 + pio);
 	u16 cycle = 0;
 
-	if (id[ATA_ID_FIELD_VALID] & 2) {
+	if (id && (id[ATA_ID_FIELD_VALID] & 2)) {
 		if (ata_id_has_iordy(drive->id))
 			cycle = id[ATA_ID_EIDE_PIO_IORDY];
 		else
