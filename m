From: Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH 2/3] libata: Initialize nbytes for internal sg commands
Date: Wed, 17 Jan 2007 12:32:19 -0600
Message-ID: <200701171832.l0HIWMB7025070@d03av04.boulder.ibm.com>
References: <11690587311891-patch-mail.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:34780 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932614AbXAQScY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jan 2007 13:32:24 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0HIWNDD027293
	for <linux-ide@vger.kernel.org>; Wed, 17 Jan 2007 13:32:23 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0HIWNbU547136
	for <linux-ide@vger.kernel.org>; Wed, 17 Jan 2007 11:32:23 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0HIWMSq025347
	for <linux-ide@vger.kernel.org>; Wed, 17 Jan 2007 11:32:23 -0700
In-Reply-To: <11690587311891-patch-mail.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, htejun@gmail.com, brking@linux.vnet.ibm.com


Some LLDDs, like ipr, use nbytes and pad_len to determine
the total data transfer length of a command. Make sure
nbytes gets initialized for internally generated commands.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 linux-2.6-bjking1/drivers/ata/libata-core.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/ata/libata-core.c~libata_fix_nbytes drivers/ata/libata-core.c
--- linux-2.6/drivers/ata/libata-core.c~libata_fix_nbytes	2007-01-17 11:15:17.000000000 -0600
+++ linux-2.6-bjking1/drivers/ata/libata-core.c	2007-01-17 11:15:17.000000000 -0600
@@ -1250,6 +1250,7 @@ unsigned ata_exec_internal_sg(struct ata
 
 		ata_sg_init(qc, sg, n_elem);
 		qc->nsect = buflen / ATA_SECT_SIZE;
+		qc->nbytes = buflen;
 	}
 
 	qc->private_data = &wait;
_
