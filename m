From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH-stable] ahci: skip SRST for offline port
Date: Thu, 29 Jun 2006 04:10:10 +0900
Message-ID: <20060628191010.GC21435@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:9515 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751013AbWF1TJu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 15:09:50 -0400
Received: by wr-out-0506.google.com with SMTP id i24so452495wra
        for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 12:09:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Skip SRST if phy is offline.  It has been in libata-dev#upstream for
quite some time but somehow didn't make into 2.6.17.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, after review, please forward to -stable.  Thanks.

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index b4f8fb1..1b01c4d 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -548,6 +548,12 @@ static int ahci_softreset(struct ata_por
 
 	DPRINTK("ENTER\n");
 
+	if (!sata_dev_present(ap)) {
+		*class = ATA_DEV_NONE;
+		DPRINTK("EXIT, link offline\n");
+		return 0;
+	}
+
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
 	rc = ahci_stop_engine(ap);
 	if (rc) {
