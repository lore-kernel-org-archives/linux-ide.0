From: Brian King <brking@us.ibm.com>
Subject: [PATCH 1/4] libata: Setup nbytes in ata_sg_init_one (resend)
Date: Thu, 13 Apr 2006 14:52:03 -0500
Message-ID: <200604131952.k3DJq4oE014160@d01av03.pok.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:62937 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964953AbWDMTw0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Apr 2006 15:52:26 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3DJqFSl032491
	for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 15:52:15 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3DJq5Ww195980
	for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 15:52:05 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3DJq458014172
	for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 15:52:05 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, brking@us.ibm.com


Setup nbytes in ata_sg_init_one to the total transfer length
of the command. This is needed by some HBAs that need to know
the total transfer length of each command.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 libata-dev-bjking1/drivers/scsi/libata-core.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/scsi/libata-core.c~libata_setup_nbytes drivers/scsi/libata-core.c
--- libata-dev/drivers/scsi/libata-core.c~libata_setup_nbytes	2006-04-13 13:41:36.000000000 -0500
+++ libata-dev-bjking1/drivers/scsi/libata-core.c	2006-04-13 13:47:28.000000000 -0500
@@ -3208,6 +3208,7 @@ void ata_sg_init_one(struct ata_queued_c
 	qc->n_elem = 1;
 	qc->orig_n_elem = 1;
 	qc->buf_virt = buf;
+	qc->nbytes = buflen;
 
 	sg = qc->__sg;
 	sg_init_one(sg, buf, buflen);
_
