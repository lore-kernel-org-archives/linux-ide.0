From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] Re: SATA ATAPI work in progress
Date: Fri, 14 May 2004 20:46:33 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A56869.2030608@pobox.com>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com><108455 9	000.4017.52.camel@patibmrh9>  <40A51604.8070208@pobox.com><1084578453.5343.	26.camel@patibmrh9> <1084579362.3271.5.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060008030805040605070402"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33740 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264677AbUEOAqp
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 20:46:45 -0400
In-Reply-To: <1084579362.3271.5.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060008030805040605070402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here you go, this will help too.


--------------060008030805040605070402
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/libata-core.c 1.57 vs edited =====
--- 1.57/drivers/scsi/libata-core.c	Thu May 13 22:45:55 2004
+++ edited/drivers/scsi/libata-core.c	Fri May 14 20:45:44 2004
@@ -2664,6 +2667,7 @@
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
+	case ATA_PROT_ATAPI_DMA:
 		if (ap->flags & ATA_FLAG_MMIO) {
 			void *mmio = (void *) ap->ioaddr.bmdma_addr;
 			host_stat = readb(mmio + ATA_DMA_STATUS);

--------------060008030805040605070402--

