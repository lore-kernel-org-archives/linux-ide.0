From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_via: convert to new EH, take #2
Date: Wed, 14 Jun 2006 06:46:09 +0900
Message-ID: <20060613214609.GB10142@htj.dyndns.org>
References: <20060613115155.GB17964@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.192]:4929 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932342AbWFMVpy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 17:45:54 -0400
Received: by nz-out-0102.google.com with SMTP id s18so2082758nze
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2006 14:45:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060613115155.GB17964@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Convert sata_via to new EH.  The driver used SRST for vt6420 and sata
hardreset for vt6421.  This patch preserves the behavior using private
port flag SVIA_FORCE_SATA_RESET and private error handler.

Once it's determined that vt6421 can do SRST, the flag and private
error handler can be replaced with stock bmdma EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

freeze/thaw() added.  Again, only compile tested.

Thanks.

 drivers/scsi/sata_via.c |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

e3a255c119c63f938a1481c1e2fcd1db8a406383
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index c6975c5..dc487b7 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -69,11 +69,15 @@ enum {
 
 	SATA_EXT_PHY		= (1 << 6), /* 0==use PATA, 1==ext phy */
 	SATA_2DEV		= (1 << 5), /* SATA is master/slave */
+
+	/* private host flags */
+	SVIA_FORCE_SATA_RESET	= (1 << 24),
 };
 
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static void svia_error_handler (struct ata_port *ap);
 
 static const struct pci_device_id svia_pci_tbl[] = {
 	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
@@ -116,8 +120,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.phy_reset		= sata_phy_reset,
-
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -127,7 +129,10 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	.eng_timeout		= ata_eng_timeout,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= svia_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -142,7 +147,7 @@ static const struct ata_port_operations 
 
 static struct ata_port_info svia_port_info = {
 	.sht		= &svia_sht,
-	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST | ATA_FLAG_NO_LEGACY,
+	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 	.pio_mask	= 0x1f,
 	.mwdma_mask	= 0x07,
 	.udma_mask	= 0x7f,
@@ -169,6 +174,17 @@ static void svia_scr_write (struct ata_p
 	outl(val, ap->ioaddr.scr_addr + (4 * sc_reg));
 }
 
+static void svia_error_handler (struct ata_port *ap)
+{
+	ata_reset_fn_t softreset = ata_std_softreset;
+
+	if (ap->flags & SVIA_FORCE_SATA_RESET)
+		softreset = NULL;
+
+	ata_bmdma_drive_eh(ap, ata_std_prereset, softreset, sata_std_hardreset,
+			   ata_std_postreset);
+}
+
 static const unsigned int svia_bar_sizes[] = {
 	8, 4, 8, 4, 16, 256
 };
@@ -237,8 +253,8 @@ static struct ata_probe_ent *vt6421_init
 	INIT_LIST_HEAD(&probe_ent->node);
 
 	probe_ent->sht		= &svia_sht;
-	probe_ent->host_flags	= ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
-				  ATA_FLAG_NO_LEGACY;
+	probe_ent->host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  SVIA_FORCE_SATA_RESET;
 	probe_ent->port_ops	= &svia_sata_ops;
 	probe_ent->n_ports	= N_PORTS;
 	probe_ent->irq		= pdev->irq;
-- 
1.3.2

