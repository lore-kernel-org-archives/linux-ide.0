From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 08/64] pata_cmd64x: fix PIO setup
Date: Mon, 18 Jan 2010 18:14:55 +0100
Message-ID: <20100118171455.14623.81852.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754506Ab0ARRQ3@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cmd64x: fix PIO setup

Fix incorrect handling of recovery clocks value == 16 resulting
in overclocked recovery timings & potentially underclocked active
timings.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cmd64x.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_cmd64x.c
===================================================================
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -2,7 +2,7 @@
  * pata_cmd64x.c 	- CMD64x PATA for new ATA layer
  *			  (C) 2005 Red Hat Inc
  *			  Alan Cox <alan@lxorguk.ukuu.org.uk>
- *			  (C) 2009 Bartlomiej Zolnierkiewicz
+ *			  (C) 2009-2010 Bartlomiej Zolnierkiewicz
  *
  * Based upon
  * linux/drivers/ide/pci/cmd64x.c		Version 1.30	Sept 10, 2002
@@ -182,7 +182,9 @@ static void cmd64x_set_timing(struct ata
 	/* Now convert the clocks into values we can actually stuff into
 	   the chip */
 
-	if (t.recover > 1)
+	if (t.recover == 16)
+		t.recover = 0;
+	else if (t.recover > 1)
 		t.recover--;
 	else
 		t.recover = 15;
