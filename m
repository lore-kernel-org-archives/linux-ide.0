From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH v2] ide: fix for ide_timing quantisation errors
Date: Thu, 13 Oct 2011 15:16:03 +0200
Message-ID: <201110131516.03408.bzolnier@gmail.com>
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
Subject: [PATCH v2] ide: fix for ide_timing quantisation errors

Based on commit 4f701d1 ("ata_timing: ensure t->cycle is always
correct") for libata.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
v2: fixed comment style

earlier references:
https://lkml.org/lkml/2010/1/18/274

 drivers/ide/ide-timings.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: b/drivers/ide/ide-timings.c
===================================================================
--- a/drivers/ide/ide-timings.c
+++ b/drivers/ide/ide-timings.c
@@ -206,6 +206,14 @@ int ide_timing_compute(ide_drive_t *driv
 		t->recover = t->cycle - t->active;
 	}
 
+	/*
+	 * In a few cases quantisation may produce enough errors to
+	 * leave t->cycle too low for the sum of active and recovery
+	 * if so we must correct this
+	 */
+	if (t->active + t->recover > t->cycle)
+		t->cycle = t->active + t->recover;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ide_timing_compute);
