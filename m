From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 8/9] sata_sil24.c conversion
Date: Thu, 29 Jun 2006 18:10:31 +0200
Message-ID: <20060629161031.GI23122@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp106.plus.mail.re2.yahoo.com ([206.190.53.31]:55433 "HELO
	smtp106.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750860AbWF2QLU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 12:11:20 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Convert the sata-sil24.c to the new scheme.

Signed-off-by: <petkov@math.uni-muenster.de>

--- libata-dev/drivers/scsi/sata_sil24.c.orig	2006-06-29 16:43:10.000000000 +0200
+++ libata-dev/drivers/scsi/sata_sil24.c	2006-06-29 16:52:28.000000000 +0200
@@ -535,10 +535,12 @@ static int sil24_softreset(struct ata_po
 	u32 mask, irq_stat;
 	const char *reason;
 
-	DPRINTK("ENTER\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: ENTER\n", __FUNCTION__);
 
 	if (ata_port_offline(ap)) {
-		DPRINTK("PHY reports no device\n");
+		ata_port_printk(ap, ATA_MSG_VDEBUG, 
+				"%s: PHY reports no device\n",
+				__FUNCTION__);
 		*class = ATA_DEV_NONE;
 		goto out;
 	}
@@ -578,11 +580,11 @@ static int sil24_softreset(struct ata_po
 		*class = ATA_DEV_NONE;
 
  out:
-	DPRINTK("EXIT, class=%u\n", *class);
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT, class=%u\n", __FUNCTION__, *class);
 	return 0;
 
  err:
-	ata_port_printk(ap, KERN_ERR, "softreset failed (%s)\n", reason);
+	ata_port_printk(ap, ATA_MSG_ERR, "softreset failed (%s)\n", reason);
 	return -EIO;
 }
 
@@ -629,7 +631,7 @@ static int sil24_hardreset(struct ata_po
 	return -EAGAIN;
 
  err:
-	ata_port_printk(ap, KERN_ERR, "hardreset failed (%s)\n", reason);
+	ata_port_printk(ap, ATA_MSG_ERR, "hardreset failed (%s)\n", reason);
 	return -EIO;
 }
 
@@ -854,7 +856,7 @@ static inline void sil24_host_intr(struc
 	}
 
 	if (ata_ratelimit())
-		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
+		ata_port_printk(ap, ATA_MSG_INFO, "spurious interrupt "
 			"(slot_stat 0x%x active_tag %d sactive 0x%x)\n",
 			slot_stat, ap->active_tag, ap->sactive);
 }

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

