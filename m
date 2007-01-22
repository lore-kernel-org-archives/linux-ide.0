From: Jeff Garzik <jeff@garzik.org>
Subject: [git patches] libata fixes
Date: Mon, 22 Jan 2007 13:55:36 -0500
Message-ID: <20070122185536.GA4773@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932244AbXAVSzj@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 Documentation/DocBook/libata.tmpl |    2 +-
 drivers/ata/libata-eh.c           |    4 ++++
 drivers/ata/sata_mv.c             |    5 +++--
 drivers/ata/sata_via.c            |    1 +
 include/linux/libata.h            |    1 +
 5 files changed, 10 insertions(+), 3 deletions(-)

Luca Pedrielli (1):
      sata_via: add PCI ID 0x5337

Olof Johansson (1):
      sata_mv HighPoint 2310 support (88SX7042)

Robert P. J. Day (1):
      libata doc: "error : unterminated entity reference exceptions"

Tejun Heo (2):
      libata: initialize qc->dma_dir to DMA_NONE
      libata: fix handling of port actions in per-dev action mask

diff --git a/Documentation/DocBook/libata.tmpl b/Documentation/DocBook/libata.tmpl
index 07a6355..e2e24b4 100644
--- a/Documentation/DocBook/libata.tmpl
+++ b/Documentation/DocBook/libata.tmpl
@@ -883,7 +883,7 @@ and other resources, etc.
   </chapter>
 
   <chapter id="ataExceptions">
-     <title>ATA errors &amp; exceptions</title>
+     <title>ATA errors and exceptions</title>
 
   <para>
   This chapter tries to identify what error/exception conditions exist
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 08ad44b..56cf59b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1979,6 +1979,10 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 
 		ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
 
+		/* collect port action mask recorded in dev actions */
+		ehc->i.action |= ehc->i.dev_action[i] & ~ATA_EH_PERDEV_MASK;
+		ehc->i.dev_action[i] &= ATA_EH_PERDEV_MASK;
+
 		/* process hotplug request */
 		if (dev->flags & ATA_DFLAG_DETACH)
 			ata_eh_detach_dev(dev);
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 1b8e0eb..aae0b52 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -523,8 +523,7 @@ static const struct ata_port_info mv_port_info[] = {
 	},
 	{  /* chip_7042 */
 		.sht		= &mv_sht,
-		.flags		= (MV_COMMON_FLAGS | MV_6XXX_FLAGS |
-				   MV_FLAG_DUAL_HC),
+		.flags		= (MV_COMMON_FLAGS | MV_6XXX_FLAGS),
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
 		.port_ops	= &mv_iie_ops,
@@ -545,6 +544,8 @@ static const struct pci_device_id mv_pci_tbl[] = {
 
 	{ PCI_VDEVICE(ADAPTEC2, 0x0241), chip_604x },
 
+	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },
+
 	{ }			/* terminate list */
 };
 
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 1c7f19a..88f0565 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -77,6 +77,7 @@ static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void vt6420_error_handler(struct ata_port *ap);
 
 static const struct pci_device_id svia_pci_tbl[] = {
+	{ PCI_VDEVICE(VIA, 0x5337), vt6420 },
 	{ PCI_VDEVICE(VIA, 0x0591), vt6420 },
 	{ PCI_VDEVICE(VIA, 0x3149), vt6420 },
 	{ PCI_VDEVICE(VIA, 0x3249), vt6421 },
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ab27548..e53a13b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1143,6 +1143,7 @@ static inline void ata_tf_init(struct ata_device *dev, struct ata_taskfile *tf)
 
 static inline void ata_qc_reinit(struct ata_queued_cmd *qc)
 {
+	qc->dma_dir = DMA_NONE;
 	qc->__sg = NULL;
 	qc->flags = 0;
 	qc->cursect = qc->cursg = qc->cursg_ofs = 0;
