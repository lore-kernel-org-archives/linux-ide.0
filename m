From: <Yuantian.Tang@freescale.com>
Subject: [PATCH] ahci: qoriq: fixed using uninitialized variable warnings
Date: Wed, 9 Sep 2015 17:16:22 +0800
Message-ID: <1441790182-20248-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-by2on0105.outbound.protection.outlook.com ([207.46.100.105]:35415
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751374AbbIIJyw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Sep 2015 05:54:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hdegoede@redhat.com
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tang Yuantian <Yuantian.Tang@freescale.com>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

kbuild test robot reports the warnings:
drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
>> include/asm-generic/io.h:163:2: warning: 'px_is' may be used
>> uninitialized in this function [-Wuninitialized]
drivers/ata/ahci_qoriq.c:70:14: note: 'px_is' was declared here
>> include/asm-generic/io.h:163:2: warning: 'px_cmd' may be used
>> uninitialized in this function [-Wuninitialized]
drivers/ata/ahci_qoriq.c:70:6: note: 'px_cmd' was declared here

This patch fixed it by assigning 0 to px_is and px_cmd variables.
This patch also remove line 'struct ccsr_ahci *reg_base' which is
not referred by any other codes and thus a dead one.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 drivers/ata/ahci_qoriq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index e5e4988..f790852 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -49,7 +49,6 @@ enum ahci_qoriq_type {
 };
 
 struct ahci_qoriq_priv {
-	struct ccsr_ahci *reg_base;
 	enum ahci_qoriq_type type;
 	void __iomem *ecc_addr;
 };
@@ -67,7 +66,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 {
 	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
 	void __iomem *port_mmio = ahci_port_base(link->ap);
-	u32 px_cmd, px_is, px_val;
+	u32 px_cmd = 0, px_is = 0, px_val;
 	struct ata_port *ap = link->ap;
 	struct ahci_port_priv *pp = ap->private_data;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
-- 
2.1.0.27.g96db324

