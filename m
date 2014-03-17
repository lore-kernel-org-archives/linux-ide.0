From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ata: ahci_sunxi: disable resources on driver removal
Date: Mon, 17 Mar 2014 14:05:15 +0100
Message-ID: <4639408.hubNkUp5Oa@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Oliver Schinagl <oliver@schinagl.nl>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Add custom ->host_stop method to disable resources on driver removal.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Compile tested only.

 drivers/ata/ahci_sunxi.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

Index: b/drivers/ata/ahci_sunxi.c
===================================================================
--- a/drivers/ata/ahci_sunxi.c	2014-03-17 13:48:26.292485389 +0100
+++ b/drivers/ata/ahci_sunxi.c	2014-03-17 13:55:48.912477842 +0100
@@ -156,13 +156,25 @@ static void ahci_sunxi_start_engine(stru
 	sunxi_setbits(port_mmio + PORT_CMD, PORT_CMD_START);
 }
 
+static void ahci_sunxi_host_stop(struct ata_host *host)
+{
+	struct ahci_host_priv *hpriv = host->private_data;
+
+	ahci_platform_disable_resources(hpriv);
+}
+
+static struct ata_port_operations ahci_sunxi_port_ops = {
+	.inherits	= &ahci_platform_ops,
+	.host_stop	= ahci_sunxi_host_stop,
+};
+
 static const struct ata_port_info ahci_sunxi_port_info = {
 	AHCI_HFLAGS(AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_MSI |
 			  AHCI_HFLAG_NO_PMP | AHCI_HFLAG_YES_NCQ),
 	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NCQ,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
-	.port_ops	= &ahci_platform_ops,
+	.port_ops	= &ahci_sunxi_port_ops,
 };
 
 static int ahci_sunxi_probe(struct platform_device *pdev)
