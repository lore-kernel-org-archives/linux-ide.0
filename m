From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 091/146] ata: enable quirk from jmicron JMB350 for JMB394
Date: Wed,  5 Mar 2014 17:31:37 +0100
Message-ID: <d5772bfe2ddd46c0a59bae0f776be249f48a9db0.1394036335.git.jslaby@suse.cz>
References: <b19c399da7b857c8d9fd899a42bee0144e03465a.1394036335.git.jslaby@suse.cz>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ip4-83-240-18-248.cust.nbox.cz ([83.240.18.248]:48876 "EHLO
	ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756238AbaCEQbw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Mar 2014 11:31:52 -0500
In-Reply-To: <b19c399da7b857c8d9fd899a42bee0144e03465a.1394036335.git.jslaby@suse.cz>
In-Reply-To: <cover.1394036335.git.jslaby@suse.cz>
References: <cover.1394036335.git.jslaby@suse.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stable@vger.kernel.org
Cc: "Denis V. Lunev" <den@openvz.org>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

From: "Denis V. Lunev" <den@openvz.org>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit efb9e0f4f43780f0ae0c6428d66bd03e805c7539 upstream.

Without the patch the kernel generates the following error.

 ata11.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 ata11.15: Port Multiplier vendor mismatch '0x197b' != '0x123'
 ata11.15: PMP revalidation failed (errno=-19)
 ata11.15: failed to recover PMP after 5 tries, giving up

This patch helps to bypass this error and the device becomes
functional.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: <linux-ide@vger.kernel.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/ata/libata-pmp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 20fd337a5731..7ccc084bf1df 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -447,8 +447,11 @@ static void sata_pmp_quirks(struct ata_port *ap)
 		 * otherwise.  Don't try hard to recover it.
 		 */
 		ap->pmp_link[ap->nr_pmp_links - 1].flags |= ATA_LFLAG_NO_RETRY;
-	} else if (vendor == 0x197b && devid == 0x2352) {
-		/* chip found in Thermaltake BlackX Duet, jmicron JMB350? */
+	} else if (vendor == 0x197b && (devid == 0x2352 || devid == 0x0325)) {
+		/*
+		 * 0x2352: found in Thermaltake BlackX Duet, jmicron JMB350?
+		 * 0x0325: jmicron JMB394.
+		 */
 		ata_for_each_link(link, ap, EDGE) {
 			/* SRST breaks detection and disks get misclassified
 			 * LPM disabled to avoid potential problems
-- 
1.9.0

