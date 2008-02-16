From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/9] au1xxx-ide: use ide_find_port()
Date: Sat, 16 Feb 2008 21:26:40 +0100
Message-ID: <20080216202640.25536.99766.sendpatchset@localhost.localdomain>
References: <20080216202634.25536.78915.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:14715 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508AbYBPUMK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 15:12:10 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1181336fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 12:12:06 -0800 (PST)
In-Reply-To: <20080216202634.25536.78915.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/mips/au1xxx-ide.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -603,9 +603,11 @@ static int au_ide_probe(struct device *d
 		goto out;
 	}
 
-	/* FIXME:  This might possibly break PCMCIA IDE devices */
-
-	hwif                            = &ide_hwifs[pdev->id];
+	hwif = ide_find_port();
+	if (hwif == NULL) {
+		ret = -ENOENT;
+		goto out;
+	}
 
 	memset(&hw, 0, sizeof(hw));
 	auide_setup_ports(&hw, ahwif);
