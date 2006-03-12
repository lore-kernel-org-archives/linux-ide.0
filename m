From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: enable prefetching
Date: Sun, 12 Mar 2006 11:30:03 +0900
Message-ID: <20060312023003.GB29870@htj.dyndns.org>
References: <20060304173505.GA28643@havoc.gtf.org> <20060310043717.GA7510@htj.dyndns.org> <44136C13.4020002@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:27264 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750868AbWCLCaJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2006 21:30:09 -0500
Received: by pproxy.gmail.com with SMTP id d42so656667pyd
        for <linux-ide@vger.kernel.org>; Sat, 11 Mar 2006 18:30:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <44136C13.4020002@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Enable prefetching.  This hints AHCI controller that it can prefetch
PRT entries and CDB (for PACKET commands).  This is a hint.  AHCI
controller is free to ignore it or prefetch regardless of this bit.

Note that prefetching bit should be turned off for NCQ commands or
FIS-based switching PM support.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

And this is the second version.

 ahci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 00dfdef..454a393 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -66,6 +66,7 @@ enum {
 	AHCI_IRQ_ON_SG		= (1 << 31),
 	AHCI_CMD_ATAPI		= (1 << 5),
 	AHCI_CMD_WRITE		= (1 << 6),
+	AHCI_CMD_PREFETCH	= (1 << 7),
 	AHCI_CMD_RESET		= (1 << 8),
 	AHCI_CMD_CLR_BUSY	= (1 << 10),
 
@@ -627,7 +628,7 @@ static void ahci_qc_prep(struct ata_queu
 	/*
 	 * Fill in command slot information.
 	 */
-	opts = cmd_fis_len | n_elem << 16;
+	opts = AHCI_CMD_PREFETCH | cmd_fis_len | n_elem << 16;
 	if (qc->tf.flags & ATA_TFLAG_WRITE)
 		opts |= AHCI_CMD_WRITE;
 	if (is_atapi)
