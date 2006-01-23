From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/13] libata: create pio/atapi task queueing wrappers
Date: Mon, 23 Jan 2006 13:09:37 +0900
Message-ID: <11379893773912-git-send-email-htejun@gmail.com>
References: <11379893762140-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:12055 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751412AbWAWEJr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 23:09:47 -0500
Received: by wproxy.gmail.com with SMTP id i3so763645wra
        for <linux-ide@vger.kernel.org>; Sun, 22 Jan 2006 20:09:47 -0800 (PST)
In-Reply-To: <11379893762140-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Wrap pio/atapi task queueing in correspondingly named functions.  This
change doesn't change anything.  It's preparation for follow-up
pio-task/eh sync patch.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

3ebd6e9ce709b8596495a06eeccc4d44ed7117eb
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b2f51bb..10e07db 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1072,6 +1072,24 @@ static unsigned int ata_pio_modes(const 
 	   timing API will get this right anyway */
 }
 
+static inline void
+ata_queue_packet_task(struct ata_port *ap)
+{
+	queue_work(ata_wq, &ap->packet_task);
+}
+
+static inline void
+ata_queue_pio_task(struct ata_port *ap)
+{
+	queue_work(ata_wq, &ap->pio_task);
+}
+
+static inline void
+ata_queue_delayed_pio_task(struct ata_port *ap, unsigned long delay)
+{
+	queue_delayed_work(ata_wq, &ap->pio_task, delay);
+}
+
 void ata_qc_complete_internal(struct ata_queued_cmd *qc)
 {
 	struct completion *waiting = qc->private_data;
@@ -3414,7 +3432,7 @@ fsm_start:
 	}
 
 	if (timeout)
-		queue_delayed_work(ata_wq, &ap->pio_task, timeout);
+		ata_queue_delayed_pio_task(ap, timeout);
 	else if (!qc_completed)
 		goto fsm_start;
 }
@@ -3727,26 +3745,26 @@ unsigned int ata_qc_issue_prot(struct at
 		ata_qc_set_polling(qc);
 		ata_tf_to_host(ap, &qc->tf);
 		ap->hsm_task_state = HSM_ST;
-		queue_work(ata_wq, &ap->pio_task);
+		ata_queue_pio_task(ap);
 		break;
 
 	case ATA_PROT_ATAPI:
 		ata_qc_set_polling(qc);
 		ata_tf_to_host(ap, &qc->tf);
-		queue_work(ata_wq, &ap->packet_task);
+		ata_queue_packet_task(ap);
 		break;
 
 	case ATA_PROT_ATAPI_NODATA:
 		ap->flags |= ATA_FLAG_NOINTR;
 		ata_tf_to_host(ap, &qc->tf);
-		queue_work(ata_wq, &ap->packet_task);
+		ata_queue_packet_task(ap);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
 		ap->flags |= ATA_FLAG_NOINTR;
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
-		queue_work(ata_wq, &ap->packet_task);
+		ata_queue_packet_task(ap);
 		break;
 
 	default:
@@ -4177,7 +4195,7 @@ static void atapi_packet_task(void *_dat
 
 		/* PIO commands are handled by polling */
 		ap->hsm_task_state = HSM_ST;
-		queue_work(ata_wq, &ap->pio_task);
+		ata_queue_pio_task(ap);
 	}
 
 	return;
-- 
1.0.8


