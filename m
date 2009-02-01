From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 06/15] ide: remove now superfluous check from ide_host_register()
Date: Sun, 01 Feb 2009 18:49:51 +0100
Message-ID: <20090201174951.19144.78464.sendpatchset@localhost.localdomain>
References: <20090201174909.19144.67767.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f12.google.com ([209.85.218.12]:45568 "EHLO
	mail-bw0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756012AbZBARs6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 12:48:58 -0500
In-Reply-To: <20090201174909.19144.67767.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove now superfluous check from ide_host_register()

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1333,20 +1333,15 @@ int ide_host_register(struct ide_host *h
 		ide_init_port_hw(hwif, hws[i]);
 		ide_port_apply_params(hwif);
 
-		if (d == NULL) {
-			mate = NULL;
-		} else {
-			if ((i & 1) && mate) {
-				hwif->mate = mate;
-				mate->mate = hwif;
-			}
-
-			mate = (i & 1) ? NULL : hwif;
-
-			ide_init_port(hwif, i & 1, d);
-			ide_port_cable_detect(hwif);
+		if ((i & 1) && mate) {
+			hwif->mate = mate;
+			mate->mate = hwif;
 		}
 
+		mate = (i & 1) ? NULL : hwif;
+
+		ide_init_port(hwif, i & 1, d);
+		ide_port_cable_detect(hwif);
 		ide_port_init_devices(hwif);
 	}
 
