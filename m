From: <r66093@freescale.com>
Subject: [PATCH 2/2 v2] FSL SATA: fix the controller operating mode
Date: Tue, 20 Dec 2011 14:50:27 +0800
Message-ID: <1324363827-16985-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:49832
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752047Ab1LTHhp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Dec 2011 02:37:45 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Yutaka Ando <r46913@freescale.com>, Jeff Garzik <jgarzik@pobox.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

Configure the FSL SATA controller to the enterprise mode

Signed-off-by: Yutaka Ando <r46913@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Jeff Garzik <jgarzik@pobox.com>
---
changes for v2:
	- change the code style

 drivers/ata/sata_fsl.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 78ae7b6..48c9978 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -140,6 +140,7 @@ enum {
 	 */
 	HCONTROL_ONLINE_PHY_RST = (1 << 31),
 	HCONTROL_FORCE_OFFLINE = (1 << 30),
+	HCONTROL_LEGACY = (1 << 28),
 	HCONTROL_PARITY_PROT_MOD = (1 << 14),
 	HCONTROL_DPATH_PARITY = (1 << 12),
 	HCONTROL_SNOOP_ENABLE = (1 << 10),
@@ -1223,6 +1224,10 @@ static int sata_fsl_init_controller(struct ata_host *host)
 	 * part of the port_start() callback
 	 */
 
+	/* sata controller to operate in enterprise mode */
+	temp = ioread32(hcr_base + HCONTROL);
+	iowrite32(temp & ~HCONTROL_LEGACY, hcr_base + HCONTROL);
+
 	/* ack. any pending IRQs for this controller/port */
 	temp = ioread32(hcr_base + HSTATUS);
 	if (temp & 0x3F)
@@ -1421,6 +1426,12 @@ static int sata_fsl_resume(struct platform_device *op)
 	/* Recovery the CHBA register in host controller cmd register set */
 	iowrite32(pp->cmdslot_paddr & 0xffffffff, hcr_base + CHBA);
 
+	iowrite32((ioread32(hcr_base + HCONTROL)
+				| HCONTROL_ONLINE_PHY_RST
+				| HCONTROL_SNOOP_ENABLE
+				| HCONTROL_PMP_ATTACHED),
+			hcr_base + HCONTROL);
+
 	ata_host_resume(host);
 	return 0;
 }
-- 
1.7.5.4


