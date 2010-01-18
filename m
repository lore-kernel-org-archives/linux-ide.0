From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 24/64] ide: fix for ide_timing quantisation errors
Date: Mon, 18 Jan 2010 18:17:20 +0100
Message-ID: <20100118171720.14623.86072.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754933Ab0ARRSi@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix for ide_timing quantisation errors

Based on commit 4f701d1 for libata.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-timings.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: b/drivers/ide/ide-timings.c
===================================================================
--- a/drivers/ide/ide-timings.c
+++ b/drivers/ide/ide-timings.c
@@ -206,6 +206,12 @@ int ide_timing_compute(ide_drive_t *driv
 		t->recover = t->cycle - t->active;
 	}
 
+	/* In a few cases quantisation may produce enough errors to
+	   leave t->cycle too low for the sum of active and recovery
+	   if so we must correct this */
+	if (t->active + t->recover > t->cycle)
+		t->cycle = t->active + t->recover;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ide_timing_compute);
