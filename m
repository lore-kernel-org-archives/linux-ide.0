From: Benjamin Larsson <benjamin@southpole.se>
Subject: [PATCH 1/1] Add Toshiba Satellite Pro A120 to the list with broken suspend functionality.
Date: Sun,  8 Jan 2012 00:39:10 +0100
Message-ID: <1325979550-7974-1-git-send-email-benjamin@southpole.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.bredband2.com ([83.219.192.166]:56064 "EHLO
	smtp.bredband2.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab2AGXrz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jan 2012 18:47:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: Benjamin Larsson <benjamin@southpole.se>


Signed-off-by: Benjamin Larsson <benjamin@southpole.se>
---
 drivers/ata/ata_piix.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 6da6deb..3a4dd74 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1151,6 +1151,13 @@ static int piix_broken_suspend(void)
 			},
 		},
 		{
+			.ident = "Satellite Pro A120",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Satellite Pro A120"),
+			},
+		},
+		{
 			.ident = "Portege M500",
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-- 
1.7.5.4

