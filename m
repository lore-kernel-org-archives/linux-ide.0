From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/6] ide: remove unused ide_hwif_t.sg_mapped field
Date: Mon, 29 Dec 2008 20:04:42 +0100
Message-ID: <20081229190442.1020.69066.sendpatchset@localhost.localdomain>
References: <20081229190415.1020.43119.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:54079 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbYL2TEV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Dec 2008 14:04:21 -0500
In-Reply-To: <20081229190415.1020.43119.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove unused ide_hwif_t.sg_mapped field

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |    1 -
 1 file changed, 1 deletion(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -819,7 +819,6 @@ typedef struct hwif_s {
 	unsigned	extra_ports;	/* number of extra dma ports */
 
 	unsigned	present    : 1;	/* this interface exists */
-	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
 	unsigned	busy	   : 1; /* serializes devices on a port */
 
 	struct device		gendev;
