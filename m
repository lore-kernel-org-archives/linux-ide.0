From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/6] ide: fix setting nIEN on idle devices
Date: Sun, 14 Dec 2008 00:39:32 +0100
Message-ID: <20081213233932.4653.97088.sendpatchset@localhost.localdomain>
References: <20081213233925.4653.58008.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:63262 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbYLMXjr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Dec 2008 18:39:47 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so329971bwz.13
        for <linux-ide@vger.kernel.org>; Sat, 13 Dec 2008 15:39:46 -0800 (PST)
In-Reply-To: <20081213233925.4653.58008.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix setting nIEN on idle devices

Fix do_ide_request() to operate on previous device / port instead of
the current one.  The original code was wrong since at least Feb 2002
(2.4.0 timeframe).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
all patches are for pata-2.6 tree

 drivers/ide/ide-io.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -724,7 +724,9 @@ void do_ide_request(struct request_queue
 	spin_lock_irq(&hwgroup->lock);
 
 	if (!ide_lock_hwgroup(hwgroup)) {
+		ide_hwif_t *prev_port;
 repeat:
+		prev_port = hwgroup->hwif;
 		hwgroup->rq = NULL;
 
 		if (drive->dev_flags & IDE_DFLAG_SLEEPING) {
@@ -734,13 +736,13 @@ repeat:
 			}
 		}
 
-		if (hwif != hwgroup->hwif) {
+		if (hwif != prev_port) {
 			/*
-			 * set nIEN for previous hwif, drives in the
+			 * set nIEN for previous port, drives in the
 			 * quirk_list may not like intr setups/cleanups
 			 */
-			if (drive->quirk_list == 0)
-				hwif->tp_ops->set_irq(hwif, 0);
+			if (hwgroup->drive->quirk_list == 0)
+				prev_port->tp_ops->set_irq(prev_port, 0);
 		}
 		hwgroup->hwif = hwif;
 		hwgroup->drive = drive;
