From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_via: convert to new EH, take #3
Date: Fri, 16 Jun 2006 15:13:53 +0900
Message-ID: <20060616061353.GD10142@htj.dyndns.org>
References: <20060613115155.GB17964@htj.dyndns.org> <20060613214609.GB10142@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:52112 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751064AbWFPGN7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Jun 2006 02:13:59 -0400
Received: by nz-out-0102.google.com with SMTP id s18so742889nze
        for <linux-ide@vger.kernel.org>; Thu, 15 Jun 2006 23:13:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060613214609.GB10142@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Convert sata_via to new EH.  vt6420 used ATA_FLAG_SRST while vt6421
used ATA_FLAG_SATA_RESET.  This difference seems to be an accident
rather than intended.  This patch makes both flavors use
ata_bmdma_error_handler() which makes use of both SRST and SATA
hardreset.  This behavior change is intended and if it breaks
anything, it should be very easy to spot.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_via.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

8b4fa8a307bc348a0c20f8c6e6ec75292c13f052
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index c6975c5..322890b 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -116,8 +116,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.phy_reset		= sata_phy_reset,
-
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -127,7 +125,10 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	.eng_timeout		= ata_eng_timeout,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -142,7 +143,7 @@ static const struct ata_port_operations 
 
 static struct ata_port_info svia_port_info = {
 	.sht		= &svia_sht,
-	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST | ATA_FLAG_NO_LEGACY,
+	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 	.pio_mask	= 0x1f,
 	.mwdma_mask	= 0x07,
 	.udma_mask	= 0x7f,
@@ -237,8 +238,7 @@ static struct ata_probe_ent *vt6421_init
 	INIT_LIST_HEAD(&probe_ent->node);
 
 	probe_ent->sht		= &svia_sht;
-	probe_ent->host_flags	= ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
-				  ATA_FLAG_NO_LEGACY;
+	probe_ent->host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY;
 	probe_ent->port_ops	= &svia_sata_ops;
 	probe_ent->n_ports	= N_PORTS;
 	probe_ent->irq		= pdev->irq;
-- 
1.3.2

