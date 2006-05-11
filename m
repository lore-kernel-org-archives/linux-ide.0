From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/11] libata-eh-fw: clear SError in ata_std_postreset()
Date: Thu, 11 May 2006 21:27:23 +0900
Message-ID: <1147350443202-git-send-email-htejun@gmail.com>
References: <11473504433328-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.199]:29322 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751640AbWEKM13 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:27:29 -0400
Received: by nz-out-0102.google.com with SMTP id 13so175443nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:27:29 -0700 (PDT)
In-Reply-To: <11473504433328-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Clear SError in ata_std_postreset().  This is to clear SError bits
which get set during reset.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

033e89c7ccb4ba7ae815e6b3c2b65e5b0a8e0ce4
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 126adef..554cf8a 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2527,11 +2527,17 @@ int sata_std_hardreset(struct ata_port *
  */
 void ata_std_postreset(struct ata_port *ap, unsigned int *classes)
 {
+	u32 serror;
+
 	DPRINTK("ENTER\n");
 
 	/* print link status */
 	sata_print_link_status(ap);
 
+	/* clear SError */
+	if (ata_scr_read(ap, SCR_ERROR, &serror) == 0)
+		ata_scr_write(ap, SCR_ERROR, serror);
+
 	/* re-enable interrupts */
 	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
 		ata_irq_on(ap);
-- 
1.2.4


