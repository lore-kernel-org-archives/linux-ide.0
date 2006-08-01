From: Unicorn Chang <uchang@tw.ibm.com>
Subject: [PATCH] ahci: skip protocol test altogether in spurious interrupt
 code
Date: Tue, 01 Aug 2006 12:18:07 +0800
Message-ID: <44CED5FF.6090701@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:56994 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1160996AbWHAERv
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 00:17:51 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k714HoMp008657
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Tue, 1 Aug 2006 00:17:50 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k714HoeV304966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2006 22:17:50 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k714HnCk015264
	for <linux-ide@vger.kernel.org>; Mon, 31 Jul 2006 22:17:49 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


Skip protocol test altogether in spurious interrupt code. If PIOS is received
when it shouldn't, ahci will raise protocol violation.

Signed-off-by: Unicorn Chang <uchang@tw.ibm.com>
---

Patch for kernel bug 6826 - GoVault spurious interrupts
(http://bugzilla.kernel.org/show_bug.cgi?id=6826)

--- linux-2.6.18-rc2/drivers/scsi/ahci.c.orig	2006-07-24 14:40:41.000000000 -0700
+++ linux-2.6.18-rc2/drivers/scsi/ahci.c	2006-07-31 10:49:30.000000000 -0700
@@ -940,14 +940,8 @@ static void ahci_host_intr(struct ata_po
 		return;
 
 	/* ignore interim PIO setup fis interrupts */
-	if (ata_tag_valid(ap->active_tag)) {
-		struct ata_queued_cmd *qc =
-			ata_qc_from_tag(ap, ap->active_tag);
-
-		if (qc && qc->tf.protocol == ATA_PROT_PIO &&
-		    (status & PORT_IRQ_PIOS_FIS))
-			return;
-	}
+	if (ata_tag_valid(ap->active_tag) && (status & PORT_IRQ_PIOS_FIS)) 
+		return;
 
 	if (ata_ratelimit())
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "

