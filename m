From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] ata_piix: add Toshiba Tecra M4 to broken
 suspend list
Date: Wed, 05 Dec 2007 10:39:49 +0900
Message-ID: <47560165.3070008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:31333 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbXLEBj4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 20:39:56 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6659548wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 17:39:56 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

From: Peter Schwenke <peter@bluetoad.com.au>

Add Toshiba Tecra M4 to broken suspend list.  This is from OSDL
bugzilla bug 7780.

Signed-off-by: Peter Schwenke <peter@bluetoad.com.au>
Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_piix.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index b538e1d..bb62a58 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -974,6 +974,13 @@ static int piix_broken_suspend(void)
 			},
 		},
 		{
+			.ident = "TECRA M4",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Tecra M4"),
+			},
+		},
+		{
 			.ident = "TECRA M5",
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-- 
1.5.2.5
