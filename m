From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [libata] make ATAPI PIO work
Date: Mon, 18 Oct 2004 23:29:42 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e041018142912220913@mail.gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.193]:6525 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267511AbUJRV3p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Oct 2004 17:29:45 -0400
Received: by mproxy.gmail.com with SMTP id 77so235890rnk
        for <linux-ide@vger.kernel.org>; Mon, 18 Oct 2004 14:29:42 -0700 (PDT)
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

If "BSY=0, DRQ=0" condition happens on ATAPI just
complete the command as this condition happens for:
* the end of the PIO transfer (ie. REQUEST_SENSE
  seems to return only 18 of 96 requested bytes)
* unsupported ATAPI commands (ie. REPORT_LUNS)

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-10-18 23:10:12 +02:00
+++ b/drivers/scsi/libata-core.c	2004-10-18 23:10:12 +02:00
@@ -2327,19 +2327,30 @@
 		}
 	}
 
-	/* handle BSY=0, DRQ=0 as error */
-	if ((status & ATA_DRQ) == 0) {
-		ap->pio_task_state = PIO_ST_ERR;
-		return;
-	}
-
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
-	if (is_atapi_taskfile(&qc->tf))
+	if (is_atapi_taskfile(&qc->tf)) {
+		/* no more data to transfer or unsupported ATAPI command */
+		if ((status & ATA_DRQ) == 0) {
+			ap->pio_task_state = PIO_ST_IDLE;
+
+			ata_irq_on(ap);
+
+			ata_qc_complete(qc, status);
+			return;
+		}
+
 		atapi_pio_bytes(qc);
-	else
+	} else {
+		/* handle BSY=0, DRQ=0 as error */
+		if ((status & ATA_DRQ) == 0) {
+			ap->pio_task_state = PIO_ST_ERR;
+			return;
+		}
+
 		ata_pio_sector(qc);
+	}
 }
 
 static void ata_pio_error(struct ata_port *ap)
