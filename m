From: Robert Hancock <hancockrwd@gmail.com>
Subject: [PATCH] libata: fix reporting of drained bytes when clearing DRQ
Date: Tue, 08 Dec 2009 20:48:10 -0600
Message-ID: <4B1F0FEA.7070403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:57239 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbZLICsI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Dec 2009 21:48:08 -0500
Received: by gxk26 with SMTP id 26so5739709gxk.1
        for <linux-ide@vger.kernel.org>; Tue, 08 Dec 2009 18:48:15 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

When we drain data from a device to clear DRQ during error recovery, the number
of bytes reported as drained is too low by a factor of 2 because the count
is actually reporting the number of words drained, not bytes. Fix this.

Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 51eb1e2..3afa21b 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2275,7 +2275,7 @@ void ata_sff_drain_fifo(struct ata_queued_cmd *qc)
 	ap = qc->ap;
 	/* Drain up to 64K of data before we give up this recovery method */
 	for (count = 0; (ap->ops->sff_check_status(ap) & ATA_DRQ)
-						&& count < 32768; count++)
+						&& count < 65536; count += 2)
 		ioread16(ap->ioaddr.data_addr);
 
 	/* Can become DEBUG later */
