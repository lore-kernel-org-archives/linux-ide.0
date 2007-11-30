From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] ata_piix: add more toshiba laptops to broken
 suspend list
Date: Fri, 30 Nov 2007 15:28:29 +0900
Message-ID: <474FAD8D.5050403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:48268 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbXK3G2f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Nov 2007 01:28:35 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1819875rvb
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 22:28:35 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, peter@bluetoad.com.au

From: Peter Schwenke <peter@bluetoad.com.au>

Add more toshiba laptops to broken suspend list.  This is from OSDL
bugzilla bug 7780.

tj: re-formatted patch and added description and SOB.

Signed-off-by: Peter Schwenke <peter@bluetoad.com.au>
Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This one is for #upstream-fixes && -stable.  I'll push it to Greg once
it gets to Linus's tree.

Thanks.

 drivers/ata/ata_piix.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 483269d..b538e1d 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -967,6 +967,13 @@ static int piix_broken_suspend(void)
 			},
 		},
 		{
+			.ident = "TECRA M3",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Tecra M3"),
+			},
+		},
+		{
 			.ident = "TECRA M5",
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
@@ -981,6 +988,20 @@ static int piix_broken_suspend(void)
 			},
 		},
 		{
+			.ident = "TECRA A8",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "TECRA A8"),
+			},
+		},
+		{
+			.ident = "Satellite R25",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Satellite R25"),
+			},
+		},
+		{
 			.ident = "Satellite U200",
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
@@ -988,6 +1009,13 @@ static int piix_broken_suspend(void)
 			},
 		},
 		{
+			.ident = "Satellite U200",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE U200"),
+			},
+		},
+		{
 			.ident = "Satellite Pro U200",
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
