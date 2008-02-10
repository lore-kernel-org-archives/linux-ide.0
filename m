From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix comment in init_irq()
Date: Mon, 11 Feb 2008 00:23:48 +0100
Message-ID: <200802110023.50771.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:21461 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755640AbYBJXRK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Feb 2008 18:17:10 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3601133fga.17
        for <linux-ide@vger.kernel.org>; Sun, 10 Feb 2008 15:17:09 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

APUS support is gone...

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1051,7 +1051,7 @@ static int init_irq (ide_hwif_t *hwif)
 		int sa = 0;
 #if defined(__mc68000__)
 		sa = IRQF_SHARED;
-#endif /* __mc68000__ || CONFIG_APUS */
+#endif /* __mc68000__ */
 
 		if (IDE_CHIPSET_IS_PCI(hwif->chipset))
 			sa = IRQF_SHARED;
