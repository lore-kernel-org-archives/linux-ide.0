From: Prabhakar Kushwaha <prabhakar@freescale.com>
Subject: [PATCH] driver/FSL SATA:Fix wrong Device Error Register usage
Date: Mon, 7 Mar 2011 09:27:04 +0530
Message-ID: <1299470224-3399-1-git-send-email-prabhakar@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:15387 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959Ab1CGD4c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Mar 2011 22:56:32 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, meet2prabhu@gmail.com, Prabhakar Kushwaha <prabhakar@freescale.com>, Ashish Kalra <B00888@freescale.com>

When a single device error is detected, the device under the error is indicated
by the error bit set in the DER. There is a one to one mapping between register
bit and devices on Port multiplier(PMP) i.e. bit 0 represents PMP device 0 and
bit 1 represents PMP device 1 etc.

Current implementation treats Device error register value as device number not
set of bits representing multiple device on PMP. It is changed to consider bit
level.
No need to check for each set bit as all command is going to be aborted.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
Signed-off-by: Ashish Kalra <B00888@freescale.com>
---
 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (branch master)

 This patch is already gone through review of linuxppc-dev mail list.

 drivers/ata/sata_fsl.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index b0214d0..895771c 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1040,12 +1040,14 @@ static void sata_fsl_error_intr(struct ata_port *ap)
 
 		/* find out the offending link and qc */
 		if (ap->nr_pmp_links) {
+			unsigned int dev_num;
 			dereg = ioread32(hcr_base + DE);
 			iowrite32(dereg, hcr_base + DE);
 			iowrite32(cereg, hcr_base + CE);
 
-			if (dereg < ap->nr_pmp_links) {
-				link = &ap->pmp_link[dereg];
+			dev_num = ffs(dereg)-1;
+			if (dev_num < ap->nr_pmp_links) {
+				link = &ap->pmp_link[dev_num];
 				ehi = &link->eh_info;
 				qc = ata_qc_from_tag(ap, link->active_tag);
 				/*
-- 
1.7.3


