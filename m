From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/11] ahci: add PIOS interim interrupt handling
Date: Thu, 11 May 2006 22:21:29 +0900
Message-ID: <11473536891627-git-send-email-htejun@gmail.com>
References: <11473536873966-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.206]:45348 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751734AbWEKNVl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 09:21:41 -0400
Received: by wx-out-0102.google.com with SMTP id t5so1388wxc
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 06:21:41 -0700 (PDT)
In-Reply-To: <11473536873966-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

During multiblock PIO, multiple PIOS interrupts are generated before
qc compltion.  Current code prints unnecessary message for such cases.
This is exposed when new EH slows down attached device into PIO mode.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

ad7facff3665ce6527929ec5b9c6b2a04689010c
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index c2b9c93..680dd5b 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -899,7 +899,18 @@ static void ahci_host_intr(struct ata_po
 		}
 	}
 
-	/* spurious interrupt */
+	/* hmmm... a spurious interupt */
+
+	/* ignore interim PIO setup fis interrupts */
+	if (ata_tag_valid(ap->active_tag)) {
+		struct ata_queued_cmd *qc =
+			ata_qc_from_tag(ap, ap->active_tag);
+
+		if (qc && qc->tf.protocol == ATA_PROT_PIO &&
+		    (status & PORT_IRQ_PIOS_FIS))
+			return;
+	}
+
 	if (ata_ratelimit())
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
 				"(irq_stat 0x%x active_tag %d)\n",
-- 
1.2.4


