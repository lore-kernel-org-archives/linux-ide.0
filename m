From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 01 Jun 2004 18:01:27 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1086134487.12245.0.camel@patibmrh9>
References: <068F5E91-B237-11D8-819C-000393A22C62@ieee.org><1085930101.3135.
	4.camel@patibmrh9>  <1086019779.3144.6.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:14758 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265284AbUFBABb
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Jun 2004 20:01:31 -0400
Received: from royntex01.iomegacorp.com (edison [10.1.1.82])
	by email.iomega.com (Postfix) with ESMTP id AA71C1B66
	for <linux-ide@vger.kernel.org>; Tue,  1 Jun 2004 18:01:30 -0600 (MDT)
In-Reply-To: <1086019779.3144.6.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> > > we have NOT yet explained
> > > how to insert an ATA op x00 "NOP" ...
> > > Instead, my kernel goes down ... if I try ...

More is going on than I yet know to suspect.

With SATAPI, merely inserting a fetch from an i port, which in the PATA/
PATAPI legacy was almost completely non-invasive, still produces a
complaint, specifically:

kernel: irq event 18: bogus return value 3

Pat LaVarre

diff -urp o/drivers/scsi/libata-core.c linux-2.6.7-rc2-pel/drivers/scsi/libata-core.c
--- o/drivers/scsi/libata-core.c	2004-05-30 08:53:41.000000000 -0600
+++ linux-2.6.7-rc2-pel/drivers/scsi/libata-core.c	2004-06-01 17:54:26.791846440 -0600
@@ -2636,6 +2636,12 @@ inline unsigned int ata_host_intr (struc
 	case ATA_PROT_ATAPI_DMA:
 		host_stat = ata_check_bmdma(ap);
 		VPRINTK("BUS_DMA (host_stat 0x%X)\n", host_stat);
+do {
+		struct ata_taskfile *tf = &qc->tf;
+		DPRINTK("before tf_read\n");
+		ap->ops->tf_read(ap, &tf);
+		DPRINTK("after tf_read\n");
+} while (0);
 
 		if (!(host_stat & ATA_DMA_INTR)) {
 			ap->stats.idle_irq++;


