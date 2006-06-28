From: Martin Hicks <mort@bork.org>
Subject: [PATCH] sata_vsc: data_xfer should use mmio
Date: Wed, 28 Jun 2006 12:17:47 -0400
Message-ID: <20060628161747.GC16658@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from galileo.bork.org ([134.117.69.57]:40592 "EHLO galileo.bork.org")
	by vger.kernel.org with ESMTP id S932489AbWF1QRs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Jun 2006 12:17:48 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org


Hi,


sata_vsc is an MMIO device, and should use the correct data_xfer
function.  This problem was introduced by:

   commit a6b2c5d4754dc539a560fdf0d3fb78a14174394a
   Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date:   Mon May 22 16:59:59 2006 +0100

        [PATCH] PATCH: libata. Add ->data_xfer method

Signed-off-by: Martin Hicks <mort@bork.org>

---

 drivers/scsi/sata_vsc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

e00c172b64186a6ff08e7f09086f89bedac4cc6d
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 6d0c4f1..d97af87 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -297,7 +297,7 @@ static const struct ata_port_operations 
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.data_xfer		= ata_pio_data_xfer,
+	.data_xfer		= ata_mmio_data_xfer,
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
-- 
1.3.2


-- 
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE
