From: brking@us.ibm.com
Subject: [patch 01/15] libata: Setup nbytes in ata_sg_init_one
Date: Mon, 06 Feb 2006 09:42:14 -0600
Message-ID: <200602061542.k16FgM45024404@d03av04.boulder.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:5344 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932153AbWBFPm0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Feb 2006 10:42:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, brking@us.ibm.com


Setup nbytes in ata_sg_init_one to the total transfer length
of the command.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 drivers/scsi/libata-core.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/scsi/libata-core.c~libata_setup_nbytes drivers/scsi/libata-core.c
--- libata-dev/drivers/scsi/libata-core.c~libata_setup_nbytes	2006-02-03 12:31:49.000000000 -0600
+++ libata-dev-bjking1/drivers/scsi/libata-core.c	2006-02-03 12:31:49.000000000 -0600
@@ -2996,6 +2996,7 @@ void ata_sg_init_one(struct ata_queued_c
 	qc->n_elem = 1;
 	qc->orig_n_elem = 1;
 	qc->buf_virt = buf;
+	qc->nbytes = buflen;
 
 	sg = qc->__sg;
 	sg_init_one(sg, buf, buflen);
_
