From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] ata_piix: add another TECRA M3 entry to broken
 suspend list
Date: Sun, 30 Sep 2007 01:11:20 -0700
Message-ID: <46FF5A28.6060005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:40811 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbXI3IM4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Sep 2007 04:12:56 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4139890wah
        for <linux-ide@vger.kernel.org>; Sun, 30 Sep 2007 01:12:55 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Angus Turnbull <angus@twinhelix.com>

There's a different version of DMI table for TECRA M3 where it has
proper vendor and product name entry.  Add the entry to the broken
suspend list.

Angus Turnbull reported and provided initial patch.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Angus Turnbull <angus@twinhelix.com>
---
 drivers/ata/ata_piix.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 3b8bf18..6996eb5 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -921,6 +921,13 @@ static int piix_broken_suspend(void)
 {
 	static struct dmi_system_id sysids[] = {
 		{
+			.ident = "TECRA M3",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "TECRA M3"),
+			},
+		},
+		{
 			.ident = "TECRA M5",
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
