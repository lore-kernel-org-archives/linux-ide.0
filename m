From: <xswang@marvell.com>
Subject: [PATCH 1/2] libahci: Allow drivers to override stop_engine
Date: Tue, 24 Apr 2018 12:06:44 +0800
Message-ID: <1524542805-11349-2-git-send-email-xswang@marvell.com>
References: <1524542805-11349-1-git-send-email-xswang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1524542805-11349-1-git-send-email-xswang@marvell.com>
Sender: stable-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: oferh@marvell.com, dingwei@marvell.com, xigu@marvell.com, nadavh@marvell.com, Evan Wang <xswang@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-ide@vger.kernel.org

From: Evan Wang <xswang@marvell.com>

Marvell armada37xx, armada7k and armada8k share the same
AHCI sata controller IP, and currently there is an issue
(Errata Ref#226)that the SATA can not be detected via SATA
Port-MultiPlayer(PMP). After debugging, the reason is
found that the value of Port-x FIS-based Switching Control
(PxFBS@0x40) became wrong.
According to design, the bits[11:8, 0] of register PxFBS
are cleared when Port Command and Status (0x18) bit[0]
changes its value from 1 to 0, i.e. falling edge of Port
Command and Status bit[0] sends PULSE that resets PxFBS
bits[11:8; 0].
So it needs save the port PxFBS register before PxCMD
ST write and restore the port PxFBS register afterwards
in ahci_stop_engine().

This commit allows drivers to override ahci_stop_engine
behavior for use by the Marvell AHCI driver(and potentially
other drivers in the future).

Signed-off-by: Evan Wang <xswang@marvell.com>
Suggested-by: Ofer Heifetz <oferh@marvell.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/ata/ahci.c          |  6 +++---
 drivers/ata/ahci.h          |  7 +++++++
 drivers/ata/ahci_qoriq.c    |  2 +-
 drivers/ata/ahci_xgene.c    |  4 ++--
 drivers/ata/libahci.c       | 20 ++++++++++++--------
 drivers/ata/sata_highbank.c |  2 +-
 6 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1ff1779..6389c88 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -698,7 +698,7 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
 				 deadline, &online, NULL);
@@ -724,7 +724,7 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 	bool online;
 	int rc;
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
@@ -788,7 +788,7 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	for (i = 0; i < 2; i++) {
 		u16 val;
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 4356ef1..7d88ede 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -366,6 +366,13 @@ struct ahci_host_priv {
 	 * be overridden anytime before the host is activated.
 	 */
 	void			(*start_engine)(struct ata_port *ap);
+	/*
+	 * Optional ahci_stop_engine override, if not set this gets set to the
+	 * default ahci_stop_engine during ahci_save_initial_config, this can
+	 * be overridden anytime before the host is activated.
+	 */
+	int			(*stop_engine)(struct ata_port *ap);
+
 	irqreturn_t 		(*irq_handler)(int irq, void *dev_instance);
 
 	/* only required for per-port MSI(-X) support */
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 2685f28..cfdef4d 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -96,7 +96,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	/*
 	 * There is a errata on ls1021a Rev1.0 and Rev2.0 which is:
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index c2b5941..ad58da7 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -165,7 +165,7 @@ static int xgene_ahci_restart_engine(struct ata_port *ap)
 				    PORT_CMD_ISSUE, 0x0, 1, 100))
 		  return -EBUSY;
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 	ahci_start_fis_rx(ap);
 
 	/*
@@ -421,7 +421,7 @@ static int xgene_ahci_hardreset(struct ata_link *link, unsigned int *class,
 	portrxfis_saved = readl(port_mmio + PORT_FIS_ADDR);
 	portrxfishi_saved = readl(port_mmio + PORT_FIS_ADDR_HI);
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	rc = xgene_ahci_do_hardreset(link, deadline, &online);
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 7adcf3c..e5d9097 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -560,6 +560,9 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 	if (!hpriv->start_engine)
 		hpriv->start_engine = ahci_start_engine;
 
+	if (!hpriv->stop_engine)
+		hpriv->stop_engine = ahci_stop_engine;
+
 	if (!hpriv->irq_handler)
 		hpriv->irq_handler = ahci_single_level_irq_intr;
 }
@@ -897,9 +900,10 @@ static void ahci_start_port(struct ata_port *ap)
 static int ahci_deinit_port(struct ata_port *ap, const char **emsg)
 {
 	int rc;
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 
 	/* disable DMA */
-	rc = ahci_stop_engine(ap);
+	rc = hpriv->stop_engine(ap);
 	if (rc) {
 		*emsg = "failed to stop engine";
 		return rc;
@@ -1310,7 +1314,7 @@ int ahci_kick_engine(struct ata_port *ap)
 	int busy, rc;
 
 	/* stop engine */
-	rc = ahci_stop_engine(ap);
+	rc = hpriv->stop_engine(ap);
 	if (rc)
 		goto out_restart;
 
@@ -1549,7 +1553,7 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
@@ -2075,14 +2079,14 @@ void ahci_error_handler(struct ata_port *ap)
 
 	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 		/* restart engine */
-		ahci_stop_engine(ap);
+		hpriv->stop_engine(ap);
 		hpriv->start_engine(ap);
 	}
 
 	sata_pmp_error_handler(ap);
 
 	if (!ata_dev_enabled(ap->link.device))
-		ahci_stop_engine(ap);
+		hpriv->stop_engine(ap);
 }
 EXPORT_SYMBOL_GPL(ahci_error_handler);
 
@@ -2129,7 +2133,7 @@ static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
 		return;
 
 	/* set DITO, MDAT, DETO and enable DevSlp, need to stop engine first */
-	rc = ahci_stop_engine(ap);
+	rc = hpriv->stop_engine(ap);
 	if (rc)
 		return;
 
@@ -2189,7 +2193,7 @@ static void ahci_enable_fbs(struct ata_port *ap)
 		return;
 	}
 
-	rc = ahci_stop_engine(ap);
+	rc = hpriv->stop_engine(ap);
 	if (rc)
 		return;
 
@@ -2222,7 +2226,7 @@ static void ahci_disable_fbs(struct ata_port *ap)
 		return;
 	}
 
-	rc = ahci_stop_engine(ap);
+	rc = hpriv->stop_engine(ap);
 	if (rc)
 		return;
 
diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index aafb8cc..e67815b 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -410,7 +410,7 @@ static int ahci_highbank_hardreset(struct ata_link *link, unsigned int *class,
 	int rc;
 	int retry = 100;
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
-- 
1.9.1
