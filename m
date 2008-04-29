From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] libata.h: reorganize ata_device a bit
Date: Tue, 29 Apr 2008 17:50:15 -0400
Message-ID: <20080429215015.GA25220@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:42512 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756823AbYD2VuQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 17:50:16 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>


commit f7e989301b6c232dec5489e94ee7741c85cb11ba
Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Apr 29 17:47:34 2008 -0400

    [libata] linux/libata.h: reorganize ata_device struct members a bit
    
    Put the big stuff at the end, to prepare for upcoming changes (and
    also hopefully achieve nicer packing of remaining members).
    
    Signed-off-by: Jeff Garzik <jgarzik@redhat.com>

 include/linux/libata.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

f7e989301b6c232dec5489e94ee7741c85cb11ba
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 395a523..d1dfe87 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -548,11 +548,6 @@ struct ata_device {
 	u64			n_sectors;	/* size of device, if ATA */
 	unsigned int		class;		/* ATA_DEV_xxx */
 
-	union {
-		u16		id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
-		u32		gscr[SATA_PMP_GSCR_DWORDS]; /* PMP GSCR block */
-	};
-
 	u8			pio_mode;
 	u8			dma_mode;
 	u8			xfer_mode;
@@ -574,8 +569,13 @@ struct ata_device {
 	u16			sectors;	/* Number of sectors per track */
 
 	/* error history */
-	struct ata_ering	ering;
 	int			spdn_cnt;
+	struct ata_ering	ering;
+
+	union {
+		u16		id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
+		u32		gscr[SATA_PMP_GSCR_DWORDS]; /* PMP GSCR block */
+	};
 };
 
 /* Offset into struct ata_device.  Fields above it are maintained
