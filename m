From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/6] ide: always set nIEN on idle devices
Date: Mon, 03 Nov 2008 21:02:53 +0100
Message-ID: <20081103200253.5098.17871.sendpatchset@localhost.localdomain>
References: <20081103200244.5098.29817.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:51038 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420AbYKCUFN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Nov 2008 15:05:13 -0500
In-Reply-To: <20081103200244.5098.29817.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: always set nIEN on idle devices

* Set nIEN for previous port/device in ide_do_request()
  also if port uses a non-shared IRQ.

* Remove no longer needed ide_hwif_t.sharing_irq.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c    |    2 +-
 drivers/ide/ide-probe.c |    4 +---
 include/linux/ide.h     |    1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1009,7 +1009,7 @@ void do_ide_request(struct request_queue
 again:
 		hwif = drive->hwif;
 
-		if (hwgroup->hwif->sharing_irq && hwif != hwgroup->hwif) {
+		if (hwif != hwgroup->hwif) {
 			/*
 			 * set nIEN for previous hwif, drives in the
 			 * quirk_list may not like intr setups/cleanups
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1059,7 +1059,6 @@ static int init_irq (ide_hwif_t *hwif)
 
 		if (h && h->hwgroup) {  /* scan only initialized ports */
 			if (hwif->irq == h->irq) {
-				hwif->sharing_irq = h->sharing_irq = 1;
 				if (hwif->chipset != ide_pci ||
 				    h->chipset != ide_pci) {
 					save_match(hwif, h, &match);
@@ -1152,8 +1151,7 @@ static int init_irq (ide_hwif_t *hwif)
 		io_ports->data_addr, hwif->irq);
 #endif /* __mc68000__ */
 	if (match)
-		printk(KERN_CONT " (%sed with %s)",
-			hwif->sharing_irq ? "shar" : "serializ", match->name);
+		printk(KERN_CONT " (serialized with %s)", match->name);
 	printk(KERN_CONT "\n");
 
 	mutex_unlock(&ide_cfg_mtx);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -835,7 +835,6 @@ typedef struct hwif_s {
 
 	unsigned	present    : 1;	/* this interface exists */
 	unsigned	serialized : 1;	/* serialized all channel operation */
-	unsigned	sharing_irq: 1;	/* 1 = sharing irq with another hwif */
 	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
 
 	struct device		gendev;
