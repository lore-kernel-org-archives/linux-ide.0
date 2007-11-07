From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: add SATELLITE PRO U200 to broken suspend list
Date: Wed, 07 Nov 2007 12:02:27 +0900
Message-ID: <47312AC3.6010100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:7463 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbXKGDCd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 22:02:33 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1927890rvb
        for <linux-ide@vger.kernel.org>; Tue, 06 Nov 2007 19:02:33 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Yann Chachkoff <yann.chachkoff@myrealbox.com>

From: Yann Chachkoff <yann.chachkoff@myrealbox.com>

Please warmly welcome the PRO variant of Satellite U200 to the broken
suspend list.

Original patch is from Yann Chachkoff.  Patch reformatted and
forwarded by Tejun Heo.

Signed-off-by: Yann Chachkoff <yann.chachkoff@myrealbox.com>
Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 ata_piix.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index f08cca2..328ce8a 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -960,6 +960,13 @@ static int piix_broken_suspend(void)
 			},
 		},
 		{
+			.ident = "Satellite Pro U200",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE PRO U200"),
+			},
+		},
+		{
 			.ident = "Satellite U205",
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
