From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [libata] arbitrary size ATAPI PIO support bugfixes
Date: Mon, 18 Oct 2004 23:26:52 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e04101814263985aded@mail.gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.192]:18505 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267452AbUJRV0w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Oct 2004 17:26:52 -0400
Received: by mproxy.gmail.com with SMTP id 77so235628rnk
        for <linux-ide@vger.kernel.org>; Mon, 18 Oct 2004 14:26:52 -0700 (PDT)
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

* sg was incorrectly used instead of qc->sg in __atapi_pio_bytes()
* due to obvious typo qc->curbytes wasn't zeroed in ata_qc_new_init()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-10-18 22:31:59 +02:00
+++ b/drivers/scsi/libata-core.c	2004-10-18 22:31:59 +02:00
@@ -2238,7 +2238,7 @@
 		ap->pio_task_state = PIO_ST_LAST;
 
 next_sg:
-	sg = &sg[qc->cursg];
+	sg = &qc->sg[qc->cursg];
 	page = sg->page;
 
 	count = min(sg_dma_len(sg) - qc->cursg_ofs, bytes);
@@ -2616,7 +2616,7 @@
 		qc->dev = dev;
 		qc->cursect = qc->cursg = qc->cursg_ofs = 0;
 		qc->nsect = 0;
-		qc->nbytes = qc->nbytes = 0;
+		qc->nbytes = qc->curbytes = 0;
 
 		ata_tf_init(ap, &qc->tf, dev->devno);
