From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 07/10] ata: ahci: mvebu: Support A8k compatible
Date: Fri, 22 Mar 2019 14:40:00 +0100
Message-ID: <20190322134003.4893-8-miquel.raynal@bootlin.com>
References: <20190322134003.4893-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190322134003.4893-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
Cc: devicetree@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, Antoine Tenart <antoine.tenart@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

The ahci_platform.c driver was historically the one bound to the A8k
AHCI compatible string, but before adding a quirk for this compatible,
it is probably cleaner to put all Marvell EBU code in one place: the
ahci_mvebu.c driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 507ee7c5437c..8671aa8179fa 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -98,6 +98,12 @@ static int ahci_mvebu_armada_3700_config(struct ahci_host_priv *hpriv,
 	return 0;
 }
 
+static int ahci_mvebu_armada_8k_config(struct ahci_host_priv *hpriv,
+				       struct device *dev)
+{
+	return 0;
+}
+
 /**
  * ahci_mvebu_stop_engine
  *
@@ -232,6 +238,10 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
 	.host_flags = AHCI_HFLAG_SUSPEND_PHYS,
 };
 
+static const struct ahci_mvebu_plat_data ahci_mvebu_armada_8k_plat_data = {
+	.plat_config = ahci_mvebu_armada_8k_config,
+};
+
 static const struct of_device_id ahci_mvebu_of_match[] = {
 	{
 		.compatible = "marvell,armada-380-ahci",
@@ -241,6 +251,10 @@ static const struct of_device_id ahci_mvebu_of_match[] = {
 		.compatible = "marvell,armada-3700-ahci",
 		.data = &ahci_mvebu_armada_3700_plat_data,
 	},
+	{
+		.compatible = "marvell,armada-8k-ahci",
+		.data = &ahci_mvebu_armada_8k_plat_data,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ahci_mvebu_of_match);
-- 
2.19.1
