From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/4] pata_sc1200: Activate secondary channel
Date: Tue, 24 Mar 2009 10:22:25 +0000
Message-ID: <20090324102154.9152.85281.stgit@localhost.localdomain>
References: <20090324101952.9152.30261.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759291AbZCXKWh@vger.kernel.org>
In-Reply-To: <20090324101952.9152.30261.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: jeff@garzik.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Implement serialize and turn on slave channel

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/ata/pata_sc1200.c |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)


diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 9a4bdca..fd96b96 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -2,7 +2,6 @@
  * New ATA layer SC1200 driver		Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
  * TODO: Mode selection filtering
- * TODO: Can't enable second channel until ATA core has serialize
  * TODO: Needs custom DMA cleanup code
  *
  * Based very heavily on
@@ -178,6 +177,31 @@ static unsigned int sc1200_qc_issue(struct ata_queued_cmd *qc)
 	return ata_sff_qc_issue(qc);
 }
 
+/**
+ *	sc1200_qc_defer	-	implement serialization
+ *	@qc: command
+ *
+ *	Serialize command issue on this controller.
+ */
+
+static int sc1200_qc_defer(struct ata_queued_cmd *qc)
+{
+	struct ata_host *host = qc->ap->host;
+	struct ata_port *alt = host->ports[1 ^ qc->ap->port_no];
+	int rc;
+
+	/* First apply the usual rules */
+	rc = ata_std_qc_defer(qc);
+	if (rc != 0)
+		return rc;
+
+	/* Now apply serialization rules. Only allow a command if the
+	   other channel state machine is idle */
+	if (alt && alt->qc_active)
+		return	ATA_DEFER_PORT;
+	return 0;
+}
+
 static struct scsi_host_template sc1200_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 	.sg_tablesize	= LIBATA_DUMB_MAX_PRD,
@@ -187,6 +211,7 @@ static struct ata_port_operations sc1200_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
 	.qc_prep 	= ata_sff_dumb_qc_prep,
 	.qc_issue	= sc1200_qc_issue,
+	.qc_defer	= sc1200_qc_defer,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= sc1200_set_piomode,
 	.set_dmamode	= sc1200_set_dmamode,
@@ -211,7 +236,7 @@ static int sc1200_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		.port_ops = &sc1200_port_ops
 	};
 	/* Can't enable port 2 yet, see top comments */
-	const struct ata_port_info *ppi[] = { &info, &ata_dummy_port_info };
+	const struct ata_port_info *ppi[] = { &info, };
 
 	return ata_pci_sff_init_one(dev, ppi, &sc1200_sht, NULL);
 }
