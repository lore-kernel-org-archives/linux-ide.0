From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 01/10] ata: libahci: Ensure the host interrupt status bits
 are cleared
Date: Fri, 22 Mar 2019 14:39:54 +0100
Message-ID: <20190322134003.4893-2-miquel.raynal@bootlin.com>
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

ahci_multi_irqs_intr_hard() is going to be used as interrupt handler
to support SATA per-port interrupts. The current logic is to check and
clear the SATA port interrupt status register only. To avoid spurious
IRQs and interrupt storms, it will be needed to clear the port
interrupt bit in the host interrupt status register as well.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/libahci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 692782dddc0f..9db6f488db59 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1912,7 +1912,10 @@ static void ahci_port_intr(struct ata_port *ap)
 static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 {
 	struct ata_port *ap = dev_instance;
+	struct ata_host *host = ap->host;
+	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *port_mmio = ahci_port_base(ap);
+	void __iomem *mmio = hpriv->mmio;
 	u32 status;
 
 	VPRINTK("ENTER\n");
@@ -1924,6 +1927,8 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	ahci_handle_port_interrupt(ap, port_mmio, status);
 	spin_unlock(ap->lock);
 
+	writel(BIT(ap->port_no), mmio + HOST_IRQ_STAT);
+
 	VPRINTK("EXIT\n");
 
 	return IRQ_HANDLED;
-- 
2.19.1
