From: Luis Henriques <luis.henriques@canonical.com>
Subject: [3.11.y.z extended stable] Patch "ata: enable quirk from jmicron JMB350 for JMB394" has been added to staging queue
Date: Wed, 26 Feb 2014 12:21:42 +0000
Message-ID: <1393417302-28304-1-git-send-email-luis.henriques@canonical.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50334 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbaBZMVt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Feb 2014 07:21:49 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Denis V. Lunev" <den@openvz.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Luis Henriques <luis.henriques@canonical.com>, kernel-team@lists.ubuntu.com

This is a note to let you know that I have just added a patch titled

    ata: enable quirk from jmicron JMB350 for JMB394

to the linux-3.11.y-queue branch of the 3.11.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.11.y-queue

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.11.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

>From e8d8dbd7d88602b38411aa309a8ffcbcef850dab Mon Sep 17 00:00:00 2001
From: "Denis V. Lunev" <den@openvz.org>
Date: Thu, 30 Jan 2014 15:20:30 +0400
Subject: ata: enable quirk from jmicron JMB350 for JMB394

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
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/ata/libata-pmp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 20fd337..7ccc084 100644
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

