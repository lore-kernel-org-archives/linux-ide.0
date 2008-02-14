From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: align ap->sector_buf to cacheline
Date: Thu, 14 Feb 2008 18:44:03 +0900
Message-ID: <47B40D63.6060507@gmail.com>
References: <20080212180254.GA28237@postdiluvian.org>	<20080212221257.12eeab13@core>	<20080213184702.GA13458@postdiluvian.org>	<20080213202151.34b7e5bc@core>	<20080213212549.GA14732@postdiluvian.org> <20080214002135.065dd322@core> <47B3AFDC.5040605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:55743 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbYBNJoL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 04:44:11 -0500
Received: by wr-out-0506.google.com with SMTP id c48so523866wra.23
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 01:44:10 -0800 (PST)
In-Reply-To: <47B3AFDC.5040605@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Mason <mason@postdiluvian.org>, linux-ide@vger.kernel.org, jgarzik@pobox.com, James Bottomley <James.Bottomley@HansenPartnership.com>, Jens Axboe <jens.axboe@oracle.com>

ap->sector_buf is used as DMA target and misalignment can cause data
corruption on non-coherent architectures.  This problem is spotted and
initial patch is submitted by Mark Mason.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Mark Mason <mason@postdiluvian.org>
---
I thought about it more and marking up with ___cacheline_aligned seems
to be the right thing to do.  For older ones where ata_port is
allocated as part of scsi_host, I think what should be done is to
align private area of scsi_host to cacheline.  Will post another patch
for that.

Thanks.

 include/linux/libata.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bc5a8d0..7604763 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -671,7 +671,8 @@ struct ata_port {
 	acpi_handle		acpi_handle;
 	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
 #endif
-	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
+	/* owned by EH, must be cache line aligned as it's used as DMA target */
+	u8			sector_buf[ATA_SECT_SIZE] ____cacheline_aligned;
 };
 
 struct ata_port_operations {
