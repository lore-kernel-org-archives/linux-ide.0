From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/16] libata-eh-fw: clear SError in ata_std_postreset()
Date: Tue, 11 Apr 2006 22:42:54 +0900
Message-ID: <11447629741959-git-send-email-htejun@gmail.com>
References: <11447629733305-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.239]:13463 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750885AbWDKNnA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:43:00 -0400
Received: by wproxy.gmail.com with SMTP id i11so925405wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:43:00 -0700 (PDT)
In-Reply-To: <11447629733305-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Clear SError in ata_std_postreset().  This is to clear SError bits
which get set during reset.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

23283e46f471fc36974603136f72212d26ac76c1
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e559347..7907f9a 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2538,6 +2538,10 @@ void ata_std_postreset(struct ata_port *
 	if (ap->cbl == ATA_CBL_SATA)
 		sata_print_link_status(ap);
 
+	/* clear SError */
+	if (ap->cbl == ATA_CBL_SATA && ap->ops->scr_read)
+		scr_write(ap, SCR_ERROR, scr_read(ap, SCR_ERROR));
+
 	/* clear & re-enable interrupts */
 	ata_chk_status(ap);
 	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
-- 
1.2.4


