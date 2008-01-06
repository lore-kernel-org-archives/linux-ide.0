From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/8] au1xxx-ide: fix ->io_32bit handling
Date: Sun, 06 Jan 2008 18:02:34 +0100
Message-ID: <20080106170234.6861.14452.sendpatchset@localhost.localdomain>
References: <20080106170220.6861.4814.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:19805 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758533AbYAFQus (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jan 2008 11:50:48 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3036619ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jan 2008 08:50:47 -0800 (PST)
In-Reply-To: <20080106170220.6861.4814.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

The host driver must set hwif's ->no_io_32bit setting not drive's one
(ide_port_tune_devices() overrides drive's setting).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/mips/au1xxx-ide.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -658,8 +658,7 @@ static int au_ide_probe(struct device *d
 	hwif->drives[0].autotune        = 1;    /* 1=autotune, 2=noautotune, 0=default */
 	hwif->drives[1].autotune	= 1;
 
-	hwif->drives[0].no_io_32bit	= 1;
-	hwif->drives[1].no_io_32bit	= 1;
+	hwif->no_io_32bit		= 1;
 
 	auide_hwif.hwif                 = hwif;
 	hwif->hwif_data                 = &auide_hwif;
