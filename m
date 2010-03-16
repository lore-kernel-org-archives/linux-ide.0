From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH] ahci: pp->active_link is not reliable when FBS is enabled
Date: Tue, 16 Mar 2010 18:08:55 +0800
Message-ID: <1268734135.3515.4.camel@zm-desktop>
Reply-To: shane.huang@amd.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:16841
	"EHLO VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S937675Ab0CPKJK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Mar 2010 06:09:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

pp->active_link is not reliable when FBS is enabled.
Both PORT_SCR_ACT and PORT_CMD_ISSUE should be checked
because mixed NCQ and non-NCQ commands may be in flight.

Signed-off-by: Shane Huang <shane.huang@amd.com>
---
 drivers/ata/ahci.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6bd930b..e009a66 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2263,7 +2263,7 @@ static void ahci_port_intr(struct ata_port *ap)
 	struct ahci_port_priv *pp = ap->private_data;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	int resetting = !!(ap->pflags & ATA_PFLAG_RESETTING);
-	u32 status, qc_active;
+	u32 status, qc_active = 0;
 	int rc;
 
 	status = readl(port_mmio + PORT_IRQ_STAT);
@@ -2321,11 +2321,22 @@ static void ahci_port_intr(struct ata_port *ap)
 		}
 	}
 
-	/* pp->active_link is valid iff any command is in flight */
-	if (ap->qc_active && pp->active_link->sactive)
-		qc_active = readl(port_mmio + PORT_SCR_ACT);
-	else
-		qc_active = readl(port_mmio + PORT_CMD_ISSUE);
+	/* pp->active_link is not reliable once FBS is enabled, both
+	 * PORT_SCR_ACT and PORT_CMD_ISSUE should be checked because
+	 * NCQ and non-NCQ commands may be in flight at the same time.
+	 */
+	if (pp->fbs_enabled) {
+		if (ap->qc_active) {
+			qc_active = readl(port_mmio + PORT_SCR_ACT);
+			qc_active |= readl(port_mmio + PORT_CMD_ISSUE);
+		}
+	} else {
+		/* pp->active_link is valid iff any command is in flight */
+		if (ap->qc_active && pp->active_link->sactive)
+			qc_active = readl(port_mmio + PORT_SCR_ACT);
+		else
+			qc_active = readl(port_mmio + PORT_CMD_ISSUE);
+	}
 
 	rc = ata_qc_complete_multiple(ap, qc_active);
 


