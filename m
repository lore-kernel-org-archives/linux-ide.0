From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: flush is an IO command
Date: Fri, 26 Oct 2007 15:53:59 +0900
Message-ID: <20071026065359.GL11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:50994 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbXJZGyH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 02:54:07 -0400
Received: by rv-out-0910.google.com with SMTP id k20so705647rvb
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 23:54:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: ballen@gravity.phys.uwm.edu

ATA_QCFLAG_IO is used to mark commands which are used to perform
regluar IO transfers via block layer.  These commands are assumed to
be valid and taken more seriously during error handling.  Cache flush
is used by regular IO path and necessary for data integrity.  Mark it
with ATA_QCFLAG_IO.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |    3 +++
 1 file changed, 3 insertions(+)

Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -1040,6 +1040,9 @@ static unsigned int ata_scsi_flush_xlat(
 	else
 		tf->command = ATA_CMD_FLUSH;
 
+	/* flush is critical for IO integrity, consider it an IO command */
+	qc->flags |= ATA_QCFLAG_IO;
+
 	return 0;
 }
 
