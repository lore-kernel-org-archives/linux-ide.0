From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 08/14] ide-h8300: print driver banner message early
Date: Tue, 10 Jun 2008 22:52:09 +0200
Message-ID: <20080610205209.18469.99360.sendpatchset@localhost.localdomain>
References: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.190]:30333 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757578AbYFJUud (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 16:50:33 -0400
Received: by gv-out-0910.google.com with SMTP id e6so669647gvc.37
        for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 13:50:32 -0700 (PDT)
In-Reply-To: <20080610205059.18469.44856.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Print driver banner message early and without interface number.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/h8300/ide-h8300.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/ide/h8300/ide-h8300.c
===================================================================
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -189,6 +189,8 @@ static int __init h8300_ide_init(void)
 	int index;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
+	printk(KERN_INFO DRV_NAME ": H8/300 generic IDE interface\n");
+
 	if (!request_region(CONFIG_H8300_IDE_BASE, H8300_IDE_GAP*8, "ide-h8300"))
 		goto out_busy;
 	if (!request_region(CONFIG_H8300_IDE_ALT, H8300_IDE_GAP, "ide-h8300")) {
@@ -205,7 +207,6 @@ static int __init h8300_ide_init(void)
 	index = hwif->index;
 	ide_init_port_hw(hwif, &hw);
 	hwif_setup(hwif);
-	printk(KERN_INFO "ide%d: H8/300 generic IDE interface\n", index);
 
 	idx[0] = index;
 
