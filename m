From: Brian King <brking@us.ibm.com>
Subject: [PATCH 01/10] libata: Setup nbytes in ata_sg_init_one
Date: Wed, 29 Mar 2006 08:37:52 -0600
Message-ID: <200603291437.k2TEbq6x012211@d01av01.pok.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, James.Bottomley@steeleye.com, brking@us.ibm.com
List-Id: linux-ide@vger.kernel.org


Setup nbytes in ata_sg_init_one to the total transfer length
of the command.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 libata-dev-bjking1/drivers/scsi/libata-core.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/scsi/libata-core.c~libata_setup_nbytes drivers/scsi/libata-core.c
--- libata-dev/drivers/scsi/libata-core.c~libata_setup_nbytes	2006-03-29 08:18:14.000000000 -0600
+++ libata-dev-bjking1/drivers/scsi/libata-core.c	2006-03-29 08:18:14.000000000 -0600
@@ -2922,6 +2922,7 @@ void ata_sg_init_one(struct ata_queued_c
 	qc->n_elem = 1;
 	qc->orig_n_elem = 1;
 	qc->buf_virt = buf;
+	qc->nbytes = buflen;
 
 	sg = qc->__sg;
 	sg_init_one(sg, buf, buflen);
_
