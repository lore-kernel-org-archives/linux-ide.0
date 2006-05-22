From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata: add pio flush for via atapi (was: Re: TR: ASUS
 A8V Deluxe, x86_64)
Date: Mon, 22 May 2006 11:43:46 +0800
Message-ID: <44713372.5070804@tw.ibm.com>
References: <8E8F647D7835334B985D069AE964A4F7028FDC29@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:35981 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751141AbWEVDnt
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 May 2006 23:43:49 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4M3hmq6000967
	for <linux-ide@vger.kernel.org>; Sun, 21 May 2006 23:43:48 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4M3hmw5171124
	for <linux-ide@vger.kernel.org>; Sun, 21 May 2006 21:43:48 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4M3hl31002485
	for <linux-ide@vger.kernel.org>; Sun, 21 May 2006 21:43:47 -0600
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7028FDC29@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, =?ISO-8859-1?Q?Reinhard_Brandst=E4dter?= <r.brandstaedter@gmx.at>, Doug Maxey <dwm@maxeymade.com>, Dario Oliva <DOliva@ARCOIDE.COM>

Backport the "pio flush" from the libata major update to 2.6.17 for via atapi.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
According to Vincent's test result, adding the "pio flush"
fixes the via atapi problem. Maybe the VIA adapter caches the written
PIO data/ATAPI CDB packet?

Patch backported for mainline 2.6.17-rcX (f1adad78dd2fc8edaa513e0bde92b4c64340245c).
For your review, thanks.

--- mainline/drivers/scsi/libata-core.c	2006-05-22 10:53:36.000000000 +0800
+++ svia_atapi/drivers/scsi/libata-core.c	2006-05-22 11:25:28.000000000 +0800
@@ -3643,6 +3643,8 @@ static void ata_pio_block(struct ata_por
 
 		ata_pio_sector(qc);
 	}
+
+	ata_altstatus(ap); /* flush */
 }
 
 static void ata_pio_error(struct ata_port *ap)
@@ -3759,11 +3761,14 @@ static void atapi_packet_task(void *_dat
 		spin_lock_irqsave(&ap->host_set->lock, flags);
 		ap->flags &= ~ATA_FLAG_NOINTR;
 		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
+		ata_altstatus(ap); /* flush */
+
 		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
 			ap->ops->bmdma_start(qc);	/* initiate bmdma */
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	} else {
 		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
+		ata_altstatus(ap); /* flush */
 
 		/* PIO commands are handled by polling */
 		ap->hsm_task_state = HSM_ST;


