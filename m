From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 2/3] ide-cd: small drive type print fix
Date: Mon, 29 Sep 2008 08:29:58 +0200
Message-ID: <1222669799-6565-3-git-send-email-petkovbb@gmail.com>
References: <1222669799-6565-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:54095 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbYI2GaF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 02:30:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1325409fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 28 Sep 2008 23:30:04 -0700 (PDT)
In-Reply-To: <1222669799-6565-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 9ffce7f..e41b94d 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1784,7 +1784,7 @@ static int ide_cdrom_probe_capabilities(ide_drive_t *drive)
 	if ((cdi->mask & CDC_DVD_R) == 0 || (cdi->mask & CDC_DVD_RAM) == 0)
 		printk(KERN_CONT " DVD%s%s",
 				 (cdi->mask & CDC_DVD_R) ? "" : "-R",
-				 (cdi->mask & CDC_DVD_RAM) ? "" : "-RAM");
+				 (cdi->mask & CDC_DVD_RAM) ? "" : "/RAM");
 
 	if ((cdi->mask & CDC_CD_R) == 0 || (cdi->mask & CDC_CD_RW) == 0)
 		printk(KERN_CONT " CD%s%s",
-- 
1.5.5.4

