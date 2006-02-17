From: Brian King <brking@us.ibm.com>
Subject: [PATCH 01/16] libata: Setup nbytes in ata_sg_init_one
Date: Fri, 17 Feb 2006 16:19:42 -0600
Message-ID: <200602172219.k1HMJhqq031572@d01av01.pok.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:47781 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751816AbWBQWTp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2006 17:19:45 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, brking@us.ibm.com


Setup nbytes in ata_sg_init_one to the total transfer length
of the command.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 libata-dev-bjking1/drivers/scsi/libata-core.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/scsi/libata-core.c~libata_setup_nbytes drivers/scsi/libata-core.c
--- libata-dev/drivers/scsi/libata-core.c~libata_setup_nbytes	2006-02-14 09:27:34.000000000 -0600
+++ libata-dev-bjking1/drivers/scsi/libata-core.c	2006-02-14 09:27:34.000000000 -0600
@@ -2737,6 +2737,7 @@ void ata_sg_init_one(struct ata_queued_c
 	qc->n_elem = 1;
 	qc->orig_n_elem = 1;
 	qc->buf_virt = buf;
+	qc->nbytes = buflen;
 
 	sg = qc->__sg;
 	sg_init_one(sg, buf, buflen);
_
