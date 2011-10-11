From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: ide_port_wait_ready() fix
Date: Tue, 11 Oct 2011 19:13:18 +0200
Message-ID: <201110111913.18492.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: ide_port_wait_ready() fix

Fix for commit a20b2a4 ("ide: skip probe if there are no devices on
the port (v2)").  We must check for slave device before failing.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -598,7 +598,7 @@ static int ide_port_wait_ready(ide_hwif_
 {
 	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
 	ide_drive_t *drive;
-	int i, rc;
+	int i, rc, prev_rc = 0;
 
 	printk(KERN_DEBUG "Probing IDE interface %s...\n", hwif->name);
 
@@ -623,8 +623,10 @@ static int ide_port_wait_ready(ide_hwif_
 			tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
 			mdelay(2);
 			rc = ide_wait_not_busy(hwif, 35000);
-			if (rc)
+			if (prev_rc && rc)
 				goto out;
+			prev_rc = rc;
+			rc = 0;
 		} else
 			printk(KERN_DEBUG "%s: ide_wait_not_busy() skipped\n",
 					  drive->name);
