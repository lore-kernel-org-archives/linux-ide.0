From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/16] libata-eh-fw: clear IRQ in ata_std_postreset()
Date: Tue, 11 Apr 2006 22:42:54 +0900
Message-ID: <11447629742943-git-send-email-htejun@gmail.com>
References: <11447629733305-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.239]:13463 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750886AbWDKNm4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:42:56 -0400
Received: by wproxy.gmail.com with SMTP id i11so925405wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:42:56 -0700 (PDT)
In-Reply-To: <11447629733305-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Clear IRQ before reenabling in ata_std_postreset().  Reset might have
left pending IRQ.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

ac29aadbf4c791f1f1777d45883c5ac0c39cfbed
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index d2a7b6f..e559347 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2538,7 +2538,8 @@ void ata_std_postreset(struct ata_port *
 	if (ap->cbl == ATA_CBL_SATA)
 		sata_print_link_status(ap);
 
-	/* re-enable interrupts */
+	/* clear & re-enable interrupts */
+	ata_chk_status(ap);
 	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
 		ata_irq_on(ap);
 
-- 
1.2.4


