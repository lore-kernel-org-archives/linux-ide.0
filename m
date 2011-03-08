From: Prabhakar Kushwaha <prabhakar@freescale.com>
Subject: [PATCH][v2] driver/FSL SATA:Fix wrong Device Error Register usage
Date: Tue, 8 Mar 2011 09:01:35 +0530
Message-ID: <1299555095-2967-1-git-send-email-prabhakar@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:45502
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754050Ab1CHDbQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Mar 2011 22:31:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, meet2prabhu@gmail.com, linuxppc-dev@lists.ozlabs.org, Prabhakar Kushwaha <prabhakar@freescale.com>, Ashish Kalra <B00888@freescale.com>

When a single device error is detected, the device under the error is indicated
by the error bit set in the DER. There is a one to one mapping between register
bit and devices on Port multiplier(PMP) i.e. bit 0 represents PMP device 0 and
bit 1 represents PMP device 1 etc.

Current implementation treats Device error register value as device number not
set of bits representing multiple device on PMP. It is changed to consider bit
level.
No need to check for each set bit as all command is going to be aborted.

Signed-off-by: Ashish Kalra <B00888@freescale.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---

 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (branch master)

 This patch is already gone through review of linuxppc-dev mail list.
 Making CC linuxppc-dev@lists.ozlabs.org

 Changes for v2: Incorporated Sergei Shtylyov's comment
	- Put space after -

 Case when ffs return will never arise.This scenario is already been discussed
 on linuxppc-dev@lists.ozlabs.org. Please see below explanation:
 sata_fsl_error_intr() is called during device error.The mentioned scenario
 will never comes. It can be observed via code:-
        if (cereg) {   --> cereg is set on command error. Means there is at least 1 device present.
                abort = 1;
                ---
                ---
                ---
                /* find out the offending link and qc */
                if (ap->nr_pmp_links) {  --> if Port multiplier
                        ---
                        ---
                        if ((ffs(dereg)-1) < ap->nr_pmp_links) {
                ---
                ---
                } else {  -->  Single device
                        dereg = ioread32(hcr_base + DE);
                        iowrite32(dereg, hcr_base + DE);
                        iowrite32(cereg, hcr_base + CE);

 drivers/ata/sata_fsl.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index b0214d0..d71e7c2 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1040,12 +1040,15 @@ static void sata_fsl_error_intr(struct ata_port *ap)
 
 		/* find out the offending link and qc */
 		if (ap->nr_pmp_links) {
+			unsigned int dev_num;
+
 			dereg = ioread32(hcr_base + DE);
 			iowrite32(dereg, hcr_base + DE);
 			iowrite32(cereg, hcr_base + CE);
 
-			if (dereg < ap->nr_pmp_links) {
-				link = &ap->pmp_link[dereg];
+			dev_num = ffs(dereg) - 1;
+			if (dev_num < ap->nr_pmp_links) {
+				link = &ap->pmp_link[dev_num];
 				ehi = &link->eh_info;
 				qc = ata_qc_from_tag(ap, link->active_tag);
 				/*
-- 
1.7.3


