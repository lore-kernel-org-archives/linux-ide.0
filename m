From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: skip 0xff polling for PATA controllers
Date: Thu, 08 Nov 2007 11:20:18 +0900
Message-ID: <47327262.9020004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:9027 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbXKHCU0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Nov 2007 21:20:26 -0500
Received: by rv-out-0910.google.com with SMTP id k20so16371rvb
        for <linux-ide@vger.kernel.org>; Wed, 07 Nov 2007 18:20:25 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>

In a presentation of true workmanship, pata_ali asserts IRQ
permanantly if the TF status register is read more than once when
there's no device attached to the port.

Avoid waiting polling for !0xff if it's PATA.  It's needed only for
some rare SATA devices anyway.

This problem is reported by Luca Tettamanti in bugzilla bug 9298.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Tested-By: Luca Tettamanti <kronos.it@gmail.com>
---
 drivers/ata/libata-core.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 009bd60..fd73f0b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3383,14 +3383,20 @@ void ata_wait_after_reset(struct ata_port *ap, unsigned long deadline)
 	 * to clear 0xff after reset.  For example, HHD424020F7SV00
 	 * iVDR needs >= 800ms while.  Quantum GoVault needs even more
 	 * than that.
+	 *
+	 * Note that some PATA controllers (pata_ali) explode if
+	 * status register is read more than once when there's no
+	 * device attached.
 	 */
-	while (1) {
-		u8 status = ata_chk_status(ap);
+	if (ap->flags & ATA_FLAG_SATA) {
+		while (1) {
+			u8 status = ata_chk_status(ap);
 
-		if (status != 0xff || time_after(jiffies, deadline))
-			return;
+			if (status != 0xff || time_after(jiffies, deadline))
+				return;
 
-		msleep(50);
+			msleep(50);
+		}
 	}
 }
 
