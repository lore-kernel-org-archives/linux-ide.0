From: Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to the 3.12 stable tree] ata: enable quirk from jmicron JMB350 for JMB394
Date: Wed,  5 Mar 2014 11:46:03 +0100
Message-ID: <1394016418-9495-20-git-send-email-jslaby@suse.cz>
References: <1394016418-9495-1-git-send-email-jslaby@suse.cz>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1394016418-9495-1-git-send-email-jslaby@suse.cz>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: jslaby@suse.cz, "Denis V. Lunev" <den@openvz.org>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: "Denis V. Lunev" <den@openvz.org>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

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
