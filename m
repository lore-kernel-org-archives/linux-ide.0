From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata DMADIR support
Date: 19 May 2004 16:47:21 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085006841.3141.20.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482  
	8		840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com><1084831524.32
	 11	.67.camel@patibmrh9>  <40A93E85.4010904@pobox.com><1084920024.3191.8.ca
	m el@	patibmrh9> <1084921676.3135.3.camel@patibmrh9><40AAA129.7050600@pobox
	.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:30957 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264645AbUESWrd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2004 18:47:33 -0400
In-Reply-To: <40AAA129.7050600@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> Yeah, something like this needs to be done for DMADIR bridges.

Do you like FIXME?  Merging the following would help me remember where
to bring this up again after we get more of ATAPI_ENABLE_DMADIR working.

Pat LaVarre

diff -Nurp linux-2.6.6-bk6/drivers/scsi/libata-core.c linux-2.6.6-bk6-pel/drivers/scsi/libata-core.c
--- linux-2.6.6-bk6/drivers/scsi/libata-core.c	2004-05-19 13:35:25.000000000 -0600
+++ linux-2.6.6-bk6-pel/drivers/scsi/libata-core.c	2004-05-19 16:44:52.974294696 -0600
@@ -1059,6 +1059,8 @@ retry:
 
 	ata_irq_on(ap);	/* re-enable interrupts */
 
+	/* FIXME: infer UDMA/ MWDMA from new DMADIR dev->id[62] (was SWDMA) */
+
 	/* print device capabilities */
 	printk(KERN_DEBUG "ata%u: dev %u cfg "
 	       "49:%04x 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",


