From: Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH 1/1] libata: Initialize nbytes for internal sg commands
Date: Tue, 30 Jan 2007 11:32:26 -0600
Message-ID: <27101.1048964739$1170178371@news.gmane.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:34913 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965445AbXA3Rca (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Jan 2007 12:32:30 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0UHWSnB030128
	for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 12:32:28 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0UHWSCB158886
	for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 12:32:28 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0UHWSod013767
	for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 12:32:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, brazilnut@linux.vnet.ibm.com, brking@linux.vnet.ibm.com


Some LLDDs, like ipr, use nbytes and pad_len to determine
the total data transfer length of a command. Make sure
nbytes gets initialized for internally generated commands.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

Jeff,

This bug is already fixed in #upstream, with Tejun's patch,
which does away with nsect, but it is still broken in 2.6.20.
This is a resend of my original, 1 line patch. If this doesn't
make 2.6.20, it might be a candidate for -stable, since without
it, libata is not able to find SATA devices attached with ipr.

Thanks,

Brian

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 linux-2.6-bjking1/drivers/ata/libata-core.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/ata/libata-core.c~libata_fix_nbytes drivers/ata/libata-core.c
--- linux-2.6/drivers/ata/libata-core.c~libata_fix_nbytes	2007-01-30 11:24:20.000000000 -0600
+++ linux-2.6-bjking1/drivers/ata/libata-core.c	2007-01-30 11:24:20.000000000 -0600
@@ -1250,6 +1250,7 @@ unsigned ata_exec_internal_sg(struct ata
 
 		ata_sg_init(qc, sg, n_elem);
 		qc->nsect = buflen / ATA_SECT_SIZE;
+		qc->nbytes = buflen;
 	}
 
 	qc->private_data = &wait;
_
