From: <tchalamarla@caviumnetworks.com>
Subject: [PATCH] AHCI: Workaround for ThunderX Errata#22536
Date: Wed, 3 Feb 2016 14:37:45 -0800
Message-ID: <1454539065-16891-1-git-send-email-tchalamarla@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tchalamarla@caviumnetworks.com
List-Id: linux-ide@vger.kernel.org

From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>

Due to Errata in some versions of ThunderX,
HOST_IRQ_STAT is neither EDGE nor LEVEL,
ThunderX needs a special sequence for handling interrupt.
The patch attempts to satisfy the need.

Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
---
 drivers/ata/ahci.c    |  3 +++
 drivers/ata/ahci.h    |  4 ++++
 drivers/ata/libahci.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 594fcab..6416af7 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1534,6 +1534,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ahci_sb600_enable_64bit(pdev))
 		hpriv->flags &= ~AHCI_HFLAG_32BIT_ONLY;
 
+	if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
+		hpriv->flags |= AHCI_HFLAG_CAVIUM_ERRATA_22536;
+
 	hpriv->mmio = pcim_iomap_table(pdev)[ahci_pci_bar];
 
 	/* must set flag prior to save config in order to take effect */
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index a44c75d..50b2afd 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -252,6 +252,10 @@ enum {
 #endif
 	AHCI_HFLAG_WAKE_BEFORE_STOP	= (1 << 22), /* wake before DMA stop */
 
+	AHCI_HFLAG_CAVIUM_ERRATA_22536	= (1 << 23), /* Thunder HOST_IRQ_STAT
+						      *	is not Level or EDGE
+						      */
+
 	/* ap->flags bits */
 
 	AHCI_FLAG_COMMON		= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA |
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 4029679..e186482 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1952,6 +1952,55 @@ static irqreturn_t ahci_single_level_irq_intr(int irq, void *dev_instance)
 	return IRQ_RETVAL(rc);
 }
 
+
+static irqreturn_t ahci_level_irq_with_errata(int irq, void *dev_instance)
+{
+	struct ata_host *host = dev_instance;
+	struct ahci_host_priv *hpriv;
+	unsigned int rc = 0;
+	void __iomem *mmio;
+	u32 irq_stat, irq_masked;
+	unsigned int handled = 1;
+
+	VPRINTK("ENTER\n");
+
+	hpriv = host->private_data;
+	mmio = hpriv->mmio;
+
+	/* sigh.  0xffffffff is a valid return from h/w */
+	irq_stat = readl(mmio + HOST_IRQ_STAT);
+	if (!irq_stat)
+		return IRQ_NONE;
+redo:
+
+	irq_masked = irq_stat & hpriv->port_map;
+
+	spin_lock(&host->lock);
+
+	rc = ahci_handle_port_intr(host, irq_masked);
+
+	if (!rc)
+		handled = 0;
+
+	writel(irq_stat, mmio + HOST_IRQ_STAT);
+
+	/* Due to ERRATA#22536, ThunderX need to handle
+	 * HOST_IRQ_STAT differently.
+	 * Work around is to make sure all pending IRQs
+	 * are served before leaving handler
+	 */
+	irq_stat = readl(mmio + HOST_IRQ_STAT);
+
+	spin_unlock(&host->lock);
+
+	if (irq_stat)
+		goto redo;
+
+	VPRINTK("EXIT\n");
+
+	return IRQ_RETVAL(handled);
+}
+
 unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -2540,6 +2589,9 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
 	else if (hpriv->flags & AHCI_HFLAG_EDGE_IRQ)
 		rc = ata_host_activate(host, irq, ahci_single_edge_irq_intr,
 				       IRQF_SHARED, sht);
+	else if (hpriv->flags & AHCI_HFLAG_CAVIUM_ERRATA_22536)
+		rc = ata_host_activate(host, irq, ahci_level_irq_with_errata,
+					IRQF_SHARED, sht);
 	else
 		rc = ata_host_activate(host, irq, ahci_single_level_irq_intr,
 				       IRQF_SHARED, sht);
-- 
2.1.0
