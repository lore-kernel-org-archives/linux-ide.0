From: Prabhakar Kushwaha <prabhakar@freescale.com>
Subject: [PATCH] driver/FSL SATA: Update RX_WATER_MARK for TRANSCFG
Date: Mon, 7 Mar 2011 09:28:10 +0530
Message-ID: <1299470290-3451-1-git-send-email-prabhakar@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:21546
	"EHLO VA3EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754959Ab1CGD5W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Mar 2011 22:57:22 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, meet2prabhu@gmail.com, Prabhakar Kushwaha <prabhakar@freescale.com>

RX_WATER_MARK sets the number of locations in Rx FIFO that can be used before
the transport layer instructs the link layer to transmit HOLDS. Note that it
can take some time for the HOLDs to get to the other end, and that in the
interim there must be enough room in the FIFO to absorb all data that could
arrive.

Update the new recommended value to 16.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (branch master)

 This patch is already gone through review of linuxppc-dev mail list.

 drivers/ata/sata_fsl.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 895771c..29d2f29 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -186,6 +186,11 @@ enum {
 	COMMANDSTAT = 0x20,
 };
 
+/* TRANSCFG (transport-layer) configuration control */
+enum {
+	TRANSCFG_RX_WATER_MARK = (1 << 4),
+};
+
 /* PHY (link-layer) configuration control */
 enum {
 	PHY_BIST_ENABLE = 0x01,
@@ -1305,6 +1310,7 @@ static int sata_fsl_probe(struct platform_device *ofdev,
 	struct sata_fsl_host_priv *host_priv = NULL;
 	int irq;
 	struct ata_host *host;
+	u32 temp;
 
 	struct ata_port_info pi = sata_fsl_port_info[0];
 	const struct ata_port_info *ppi[] = { &pi, NULL };
@@ -1319,6 +1325,12 @@ static int sata_fsl_probe(struct platform_device *ofdev,
 	ssr_base = hcr_base + 0x100;
 	csr_base = hcr_base + 0x140;
 
+	if (!of_device_is_compatible(ofdev->dev.of_node, "fsl,mpc8315-sata")) {
+		temp = ioread32(csr_base + TRANSCFG);
+		temp = temp & 0xffffffe0;
+		iowrite32(temp | TRANSCFG_RX_WATER_MARK, csr_base + TRANSCFG);
+	}
+
 	DPRINTK("@reset i/o = 0x%x\n", ioread32(csr_base + TRANSCFG));
 	DPRINTK("sizeof(cmd_desc) = %d\n", sizeof(struct command_desc));
 	DPRINTK("sizeof(#define cmd_desc) = %d\n", SATA_FSL_CMD_DESC_SIZE);
-- 
1.7.3


