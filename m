From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 09/14] sata: ahci: export ahci_do_hardreset() locally
Date: Mon, 23 Jan 2017 18:00:51 +0100
Message-ID: <1485190856-4711-10-git-send-email-bgolaszewski@baylibre.com>
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

We need a way to retrieve the information about the online state of
the link in the ahci-da850 driver.

Create a new function: ahci_do_hardreset() which is called from
ahci_hardreset() for backwards compatibility, but has an additional
argument: 'online' - which can be used to check if the link is online
after this function returns.

The new routine will be used in the ahci-da850 driver to avoid code
duplication when implementing a workaround for tha da850 SATA
controller quirk/instability.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/ahci.h    |  3 +++
 drivers/ata/libahci.c | 18 +++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 0cc08f8..5db6ab2 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -398,6 +398,9 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 		      int pmp, unsigned long deadline,
 		      int (*check_ready)(struct ata_link *link));
 
+int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
+		      unsigned long deadline, bool *online);
+
 unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
 int ahci_stop_engine(struct ata_port *ap);
 void ahci_start_fis_rx(struct ata_port *ap);
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index ee7db31..3159f9e 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1519,8 +1519,8 @@ static int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
 	return rc;
 }
 
-static int ahci_hardreset(struct ata_link *link, unsigned int *class,
-			  unsigned long deadline)
+int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
+		      unsigned long deadline, bool *online)
 {
 	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
 	struct ata_port *ap = link->ap;
@@ -1528,7 +1528,6 @@ static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 	struct ata_taskfile tf;
-	bool online;
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -1540,17 +1539,26 @@ static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 	tf.command = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
-	rc = sata_link_hardreset(link, timing, deadline, &online,
+	rc = sata_link_hardreset(link, timing, deadline, online,
 				 ahci_check_ready);
 
 	hpriv->start_engine(ap);
 
-	if (online)
+	if (*online)
 		*class = ahci_dev_classify(ap);
 
 	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ahci_do_hardreset);
+
+static int ahci_hardreset(struct ata_link *link, unsigned int *class,
+			  unsigned long deadline)
+{
+	bool online;
+
+	return ahci_do_hardreset(link, class, deadline, &online);
+}
 
 static void ahci_postreset(struct ata_link *link, unsigned int *class)
 {
-- 
2.9.3
