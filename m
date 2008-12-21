From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/7] ide: NUMA aware allocation of host and port structures
Date: Sun, 21 Dec 2008 22:00:35 +0100
Message-ID: <20081221210035.23795.39294.sendpatchset@localhost.localdomain>
References: <20081221210007.23795.27999.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:34166 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbYLUVAf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Dec 2008 16:00:35 -0500
In-Reply-To: <20081221210007.23795.27999.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: NUMA aware allocation of host and port structures

kzalloc() -> kzalloc_node() in ide_host_alloc().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1391,9 +1391,11 @@ static void ide_free_port_slot(int idx)
 struct ide_host *ide_host_alloc(const struct ide_port_info *d, hw_regs_t **hws)
 {
 	struct ide_host *host;
+	struct device *dev = hws[0] ? hws[0]->dev : NULL;
+	int node = dev ? dev_to_node(dev) : -1;
 	int i;
 
-	host = kzalloc(sizeof(*host), GFP_KERNEL);
+	host = kzalloc_node(sizeof(*host), GFP_KERNEL, node);
 	if (host == NULL)
 		return NULL;
 
@@ -1404,7 +1406,7 @@ struct ide_host *ide_host_alloc(const st
 		if (hws[i] == NULL)
 			continue;
 
-		hwif = kzalloc(sizeof(*hwif), GFP_KERNEL);
+		hwif = kzalloc_node(sizeof(*hwif), GFP_KERNEL, node);
 		if (hwif == NULL)
 			continue;
 
@@ -1429,8 +1431,7 @@ struct ide_host *ide_host_alloc(const st
 		return NULL;
 	}
 
-	if (hws[0])
-		host->dev[0] = hws[0]->dev;
+	host->dev[0] = dev;
 
 	if (d) {
 		host->init_chipset = d->init_chipset;
