From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 08/14] sata: ahci-da850: implement a workaround for the
 softreset quirk
Date: Mon, 23 Jan 2017 18:00:50 +0100
Message-ID: <1485190856-4711-9-git-send-email-bgolaszewski@baylibre.com>
References: <1485190856-4711-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1485190856-4711-1-git-send-email-bgolaszewski@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

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
index 7f5328f..11dd87e 100644
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
