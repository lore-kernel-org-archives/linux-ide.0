From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 3.2 069/200] ata: enable quirk from jmicron JMB350 for JMB394
Date: Mon, 31 Mar 2014 00:23:35 +0100
Message-ID: <lsq.1396221815.552151989@decadent.org.uk>
References: <lsq.1396221814.369444335@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36325 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752956AbaC3XZA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Mar 2014 19:25:00 -0400
Content-Disposition: inline
In-Reply-To: <lsq.1396221814.369444335@decadent.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, "Denis V. Lunev" <den@openvz.org>

3.2.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Denis V. Lunev" <den@openvz.org>

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/ata/libata-pmp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -447,8 +447,11 @@ static void sata_pmp_quirks(struct ata_p
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

