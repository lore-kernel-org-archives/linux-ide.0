From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata DMADIR support
Date: 18 May 2004 17:07:56 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084921676.3135.3.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482 8
		840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com><1084831524.3211
	.67.camel@patibmrh9>  <40A93E85.4010904@pobox.com><1084920024.3191.8.camel@
	patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:20671 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S263714AbUERXIL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 May 2004 19:08:11 -0400
In-Reply-To: <1084920024.3191.8.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> a second sample of hardware ...
> 
> kernel: ata_exec_command_pio: ata2: cmd 0xA1
> kernel: ata2: dev 0 cfg 49:0e00 82:4218 83:4000 84:4000 85:4218 86:0000 87:4000 88:0000
> 
> Its ata_piix.ko op x12 "INQUIRY" doesn't yet work at all ...
> 
> I imagine I'll find I can most concisely make this work by copying into
> words 49 63 88 the bits of word 62.

Yep.

diff -Nurp linux-2.6.6-bk5/drivers/scsi/libata-core.c linux-2.6.6-bk5-pel/drivers/scsi/libata-core.c
--- linux-2.6.6-bk5/drivers/scsi/libata-core.c	2004-05-18 14:20:05.000000000 -0600
+++ linux-2.6.6-bk5-pel/drivers/scsi/libata-core.c	2004-05-18 16:53:29.000000000 -0600
@@ -1076,6 +1076,22 @@ retry:
 
 	ata_irq_on(ap);	/* re-enable interrupts */
 
+	/* see DMADIR as a variation on classic UDMA/ MWDMA */
+
+#ifdef ATAPI_ENABLE_DMADIR
+	printk(KERN_DEBUG "ata%u: dev %u cfg "
+	       "62:%04x\n",
+	       ap->id, device, dev->id[62]);
+	if (dev->id[62] & (1 << 15)) { /* 0x8000 DMADIR */
+		u16 * id = dev->id;
+		if (id[62] & (1 << 10)) { /* 0x0400 DMA */
+			id[49] |= (1 << 8);
+			id[63] |= ((id[62] >> 7) & 0x07); /* 0x0380 MWDMA */
+			id[88] |= ((id[62] >> 0) & 0x3F); /* 0x007F UDMA */
+		}
+	}
+#endif
+
 	/* print device capabilities */
 	printk(KERN_DEBUG "ata%u: dev %u cfg "
 	       "49:%04x 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",


