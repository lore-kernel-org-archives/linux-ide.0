From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: disable NCQ support on vt8251
Date: Wed, 21 Jun 2006 23:12:48 +0900
Message-ID: <20060621141248.GA22805@htj.dyndns.org>
References: <1149787827.4180.8.camel@anja> <200606201721.26291.boac@wanadoo.nl> <4498163C.90601@gmail.com> <200606202131.12654.b.jacques@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:11720 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750991AbWFUOMo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jun 2006 10:12:44 -0400
Received: by wr-out-0506.google.com with SMTP id 36so186266wra
        for <linux-ide@vger.kernel.org>; Wed, 21 Jun 2006 07:12:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200606202131.12654.b.jacques@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: boac@wanadoo.nl, b.jacques@planet.nl, linux-ide@vger.kernel.org

vt8251 chokes on NCQ commands.  Two different disks from different
vendors are showing the same symptom and it seems that the windows
driver from via doesn't support NCQ either.  Disable NCQ support on
this controller for the time being.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Aalderd Bouwman <boac@wanadoo.nl>
Cc: Bastiaan Jacques <b.jacques@planet.nl>
---

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index e261b37..8208546 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -164,6 +164,7 @@ enum {
 
 	/* ap->flags bits */
 	AHCI_FLAG_RESET_NEEDS_CLO	= (1 << 24),
+	AHCI_FLAG_NO_NCQ		= (1 << 25),
 };
 
 struct ahci_cmd_hdr {
@@ -277,7 +278,7 @@ static const struct ata_port_info ahci_p
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				  ATA_FLAG_SKIP_D2H_BSY |
-				  AHCI_FLAG_RESET_NEEDS_CLO,
+				  AHCI_FLAG_RESET_NEEDS_CLO | AHCI_FLAG_NO_NCQ,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
@@ -1362,7 +1363,8 @@ static int ahci_init_one (struct pci_dev
 	if (rc)
 		goto err_out_hpriv;
 
-	if (hpriv->cap & HOST_CAP_NCQ)
+	if (!(probe_ent->host_flags & AHCI_FLAG_NO_NCQ) &&
+	    (hpriv->cap & HOST_CAP_NCQ))
 		probe_ent->host_flags |= ATA_FLAG_NCQ;
 
 	ahci_print_info(probe_ent);
