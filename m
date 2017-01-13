From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 05/10] sata: ahci_da850: add device tree match table
Date: Fri, 13 Jan 2017 13:37:59 +0100
Message-ID: <1484311084-31547-6-git-send-email-bgolaszewski@baylibre.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
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

We're using device tree for da850-lcdk. Add the match table to allow
to probe the driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/ata/ahci_da850.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 267a3d3..5930af81 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -105,11 +105,18 @@ static int ahci_da850_probe(struct platform_device *pdev)
 static SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
 			 ahci_platform_resume);
 
+static const struct of_device_id ahci_da850_of_match[] = {
+	{ .compatible = "ti,da850-ahci", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ahci_da850_of_match);
+
 static struct platform_driver ahci_da850_driver = {
 	.probe = ahci_da850_probe,
 	.remove = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
+		.of_match_table = ahci_da850_of_match,
 		.pm = &ahci_da850_pm_ops,
 	},
 };
-- 
2.9.3
