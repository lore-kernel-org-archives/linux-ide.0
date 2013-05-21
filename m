From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] ipr: qc_fill_rtf() method should not store alternate status register
Date: Tue, 21 May 2013 23:24:22 +0400
Message-ID: <201305212324.22822.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:63562 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab3EUTYY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 May 2013 15:24:24 -0400
Received: by mail-la0-f41.google.com with SMTP id ee20so1132859lab.0
        for <linux-ide@vger.kernel.org>; Tue, 21 May 2013 12:24:22 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: brking@us.ibm.com, JBottomley@parallels.com, linux-scsi@vger.kernel.org
Cc: linux-ide@vger.kernel.org, tj@kernel.org

The 'ctl' field of  the 'struct ata_taskfile' is not really dual purpose, i.e.
it is not intended  for storing the alternate status register (which is mapped
at the same address in the legacy IDE controllers) in the qc_fill_rtf() method.
No other 'libata' driver except 'drivers/scsi/ipr.c' stores the alternate status
register's value in the 'ctl' field of 'qc->result_tf', hence this driver should
not do this as well...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the recent Linus' tree.

 drivers/scsi/ipr.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux/drivers/scsi/ipr.c
===================================================================
--- linux.orig/drivers/scsi/ipr.c
+++ linux/drivers/scsi/ipr.c
@@ -6662,7 +6662,6 @@ static bool ipr_qc_fill_rtf(struct ata_q
 	tf->hob_lbal = g->hob_lbal;
 	tf->hob_lbam = g->hob_lbam;
 	tf->hob_lbah = g->hob_lbah;
-	tf->ctl = g->alt_status;
 
 	return true;
 }
