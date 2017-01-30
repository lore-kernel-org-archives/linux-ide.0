From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v7 08/14] sata: ahci-da850: implement a workaround for the softreset quirk
Date: Mon, 30 Jan 2017 11:02:05 +0100
Message-ID: <1485770531-6772-9-git-send-email-bgolaszewski@baylibre.com>
References: <1485770531-6772-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35745 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752233AbdA3KCf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2017 05:02:35 -0500
Received: by mail-wm0-f43.google.com with SMTP id b65so25104663wmf.0
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2017 02:02:30 -0800 (PST)
In-Reply-To: <1485770531-6772-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's an issue with the da850 SATA controller: if port multiplier
support is compiled in, but we're connecting the drive directly to
the SATA port on the board, the drive can't be detected.

To make SATA work on the da850-lcdk board: first try to softreset
with pmp - if the operation fails with -EBUSY, retry without pmp.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/ahci_da850.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 72126a0..84c7805 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -54,11 +54,42 @@ static void da850_sata_init(struct device *dev, void __iomem *pwrdn_reg,
 	writel(val, ahci_base + SATA_P0PHYCR_REG);
 }
 
+static int ahci_da850_softreset(struct ata_link *link,
+				unsigned int *class, unsigned long deadline)
+{
+	int pmp, ret;
+
+	pmp = sata_srst_pmp(link);
+
+	/*
+	 * There's an issue with the SATA controller on da850 SoCs: if we
+	 * enable Port Multiplier support, but the drive is connected directly
+	 * to the board, it can't be detected. As a workaround: if PMP is
+	 * enabled, we first call ahci_do_softreset() and pass it the result of
+	 * sata_srst_pmp(). If this call fails, we retry with pmp = 0.
+	 */
+	ret = ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
+	if (pmp && ret == -EBUSY)
+		return ahci_do_softreset(link, class, 0,
+					 deadline, ahci_check_ready);
+
+	return ret;
+}
+
+static struct ata_port_operations ahci_da850_port_ops = {
+	.inherits = &ahci_platform_ops,
+	.softreset = ahci_da850_softreset,
+	/*
+	 * No need to override .pmp_softreset - it's only used for actual
+	 * PMP-enabled ports.
+	 */
+};
+
 static const struct ata_port_info ahci_da850_port_info = {
 	.flags		= AHCI_FLAG_COMMON,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
-	.port_ops	= &ahci_platform_ops,
+	.port_ops	= &ahci_da850_port_ops,
 };
 
 static struct scsi_host_template ahci_platform_sht = {
-- 
2.9.3

