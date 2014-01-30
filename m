From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 1/1] ata: enable quirk from jmicron JMB350 for JMB394
Date: Thu, 30 Jan 2014 15:20:30 +0400
Message-ID: <1391080830-2802-1-git-send-email-den@openvz.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.232.25]:5402 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997AbaA3LWn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Jan 2014 06:22:43 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: den@parallels.com, "Denis V. Lunev" <den@openvz.org>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

From: "Denis V. Lunev" <den@openvz.org>

Without the patch the kernel blames about
 ata11.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 ata11.15: Port Multiplier vendor mismatch '0x197b' != '0x123'
 ata11.15: PMP revalidation failed (errno=-19)
 ata11.15: failed to recover PMP after 5 tries, giving up
This patch helps to bypass this error and the device becomes
functional.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Tejun Heo <tj@kernel.org>
CC: <linux-ide@vger.kernel.org>
---
 drivers/ata/libata-pmp.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 20fd337..4e69945 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -447,8 +447,9 @@ static void sata_pmp_quirks(struct ata_port *ap)
 		 * otherwise.  Don't try hard to recover it.
 		 */
 		ap->pmp_link[ap->nr_pmp_links - 1].flags |= ATA_LFLAG_NO_RETRY;
-	} else if (vendor == 0x197b && devid == 0x2352) {
-		/* chip found in Thermaltake BlackX Duet, jmicron JMB350? */
+	} else if (vendor == 0x197b && (devid == 0x2352 || devid == 0x0325)) {
+		/* chip found in Thermaltake BlackX Duet, jmicron JMB350?
+		 * 0x0325 jmicron JMB394 */
 		ata_for_each_link(link, ap, EDGE) {
 			/* SRST breaks detection and disks get misclassified
 			 * LPM disabled to avoid potential problems
-- 
1.7.7.6

