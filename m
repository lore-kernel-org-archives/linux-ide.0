From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] ATA_FLAG_IN_EH build fix
Date: Thu, 9 Feb 2006 01:56:50 -0500
Message-ID: <20060209065650.GA13344@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:44970 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1422836AbWBIG4w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 01:56:52 -0500
Received: from havoc.gtf.org (havoc.gtf.org [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by havoc.gtf.org (Postfix) with ESMTP id D20C11C015C5
	for <linux-ide@vger.kernel.org>; Thu,  9 Feb 2006 01:56:50 -0500 (EST)
Received: (from garzik@localhost)
	by havoc.gtf.org (8.13.1/8.13.1/Submit) id k196uoUL013365
	for linux-ide@vger.kernel.org; Thu, 9 Feb 2006 01:56:50 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Just checked in...


diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 3a4f40b..b007bb4 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -732,15 +732,17 @@ int ata_scsi_slave_config(struct scsi_de
 int ata_scsi_error(struct Scsi_Host *host)
 {
 	struct ata_port *ap;
+	unsigned long flags;
 
 	DPRINTK("ENTER\n");
 
+	ap = (struct ata_port *) &host->hostdata[0];
+
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	assert(!(ap->flags & ATA_FLAG_IN_EH));
 	ap->flags |= ATA_FLAG_IN_EH;
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
-	ap = (struct ata_port *) &host->hostdata[0];
 	ap->ops->eng_timeout(ap);
 
 	assert(host->host_failed == 0 && list_empty(&host->eh_cmd_q));
