From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: add SATELLITE U205 to broken suspend list
Date: Mon, 12 Nov 2007 17:59:52 +0900
Message-ID: <20071112085952.GA15967@htj.mynetwork.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:49415 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbXKLJAB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 04:00:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1460038wah
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 01:00:00 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, me@rpatterson.net

Satellite U205 has alternate product name where the satellite part is
all capatalized.  Add it to the blacklist.

This is reported by Ross Patterson in kernel bugzilla bug #7780.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Ross Patterson <me@rpatterson.net>
---
This patch has been queued in #tj-upstream-fixes and will be merged
into 2.6.24.

 drivers/ata/ata_piix.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 328ce8a..80b735b 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -974,6 +974,13 @@ static int piix_broken_suspend(void)
 			},
 		},
 		{
+			.ident = "SATELLITE U205",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE U205"),
+			},
+		},
+		{
 			.ident = "Portege M500",
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-- 
1.5.2.4

