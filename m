From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: add TECRA M7 to broken suspend list
Date: Tue, 14 Aug 2007 19:56:04 +0900
Message-ID: <20070814105604.GB21623@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:7901 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423AbXHNK4M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Aug 2007 06:56:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2148475wah
        for <linux-ide@vger.kernel.org>; Tue, 14 Aug 2007 03:56:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, kbug@koreen.com

Add TECRA M7 to broken suspend list.  Reported by Marie Koreen.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Marie Koreen <kbug@koreen.com>
---
 drivers/ata/ata_piix.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index a78832e..4947213 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -901,6 +901,13 @@ static int piix_broken_suspend(void)
 			},
 		},
 		{
+			.ident = "TECRA M7",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "TECRA M7"),
+			},
+		},
+		{
 			.ident = "Satellite U205",
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
