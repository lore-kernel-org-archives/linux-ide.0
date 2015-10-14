From: Tang Yuantian <Yuantian.Tang@freescale.com>
Subject: [PATCH] ahci: qoriq: Fix a compiling warning
Date: Wed, 14 Oct 2015 16:46:52 +0800
Message-ID: <1444812412-33321-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bl2on0103.outbound.protection.outlook.com ([65.55.169.103]:47282
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751990AbbJNIxU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Oct 2015 04:53:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hdegoede@redhat.com
Cc: tj@kernel.org, fengguang.wu@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tang Yuantian <Yuantian.Tang@freescale.com>, Arnd Bergmann <arnd@arndb.de>

kbuild test robot reports the warnings:
drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
>> include/asm-generic/io.h:163:2: warning: 'px_is' may be used
>> uninitialized in this function [-Wuninitialized]
drivers/ata/ahci_qoriq.c:70:14: note: 'px_is' was declared here
>> include/asm-generic/io.h:163:2: warning: 'px_cmd' may be used
>> uninitialized in this function [-Wuninitialized]
drivers/ata/ahci_qoriq.c:70:6: note: 'px_cmd' was declared here

This patch fixed it by introducing a local variable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I found this warning again on gcc version 4.8.3 20131202.
So this warning may not go way with newer gcc version.
I verified Arnd's suggestion and it works.
So please apply this patch which I sent on behalf of Arnd.

 drivers/ata/ahci_qoriq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index e5e4988..58c1a94 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -76,6 +76,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 	struct ata_taskfile tf;
 	bool online;
 	int rc;
+	bool ls1021a_workaround = (qoriq_priv->type == AHCI_LS1021A);
 
 	DPRINTK("ENTER\n");
 
@@ -92,7 +93,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 	 * After the sequence is complete, software should restore the
 	 * PxCMD and PxIS with the stored values.
 	 */
-	if (qoriq_priv->type == AHCI_LS1021A) {
+	if (ls1021a_workaround) {
 		px_cmd = readl(port_mmio + PORT_CMD);
 		px_is = readl(port_mmio + PORT_IRQ_STAT);
 	}
@@ -106,7 +107,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 				 ahci_check_ready);
 
 	/* restore the PxCMD and PxIS on ls1021 */
-	if (qoriq_priv->type == AHCI_LS1021A) {
+	if (ls1021a_workaround) {
 		px_val = readl(port_mmio + PORT_CMD);
 		if (px_val != px_cmd)
 			writel(px_cmd, port_mmio + PORT_CMD);
-- 
2.1.0.27.g96db324

