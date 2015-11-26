From: Xiangliang Yu <Xiangliang.Yu@amd.com>
Subject: [PATCH 1/1] AHCI: Fix softreset failed issue of Port Multiplier
Date: Thu, 26 Nov 2015 20:27:02 +0800
Message-ID: <1448540822-24175-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: SPG_Linux_Kernel@amd.com, Xiangliang Yu <Xiangliang.Yu@amd.com>
List-Id: linux-ide@vger.kernel.org

Current code doesn't update port value of Port Multiplier(PM) when
sending FIS of softreset to device, command will fail if FBS is
enabled.

There are two ways to fix the issue: the first is to disable FBS
before sending softreset command to PM device and the second is
to update port value of PM when sending command.

For the first way, i can't find any related rule in AHCI Spec. The
second way can avoid disabling FBS and has better performance.

Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
---
 drivers/ata/libahci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 096064c..4665512 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1273,6 +1273,15 @@ static int ahci_exec_polled_cmd(struct ata_port *ap, int pmp,
 	ata_tf_to_fis(tf, pmp, is_cmd, fis);
 	ahci_fill_cmd_slot(pp, 0, cmd_fis_len | flags | (pmp << 12));
 
+	/* set port value for softreset of Port Multiplier */
+	if (pp->fbs_enabled && pp->fbs_last_dev != pmp) {
+		tmp = readl(port_mmio + PORT_FBS);
+		tmp &= ~(PORT_FBS_DEV_MASK | PORT_FBS_DEC);
+		tmp |= pmp << PORT_FBS_DEV_OFFSET;
+		writel(tmp, port_mmio + PORT_FBS);
+		pp->fbs_last_dev = pmp;
+	}
+
 	/* issue & wait */
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 
-- 
1.9.1
