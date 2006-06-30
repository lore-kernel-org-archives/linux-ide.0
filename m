From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 8/9] sata_sil24.c conversion
Date: Fri, 30 Jun 2006 08:50:54 +0200
Message-ID: <20060630065053.GA17782@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp105.plus.mail.re2.yahoo.com ([206.190.53.30]:20906 "HELO
	smtp105.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751212AbWF3Gu5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jun 2006 02:50:57 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Convert the sata-sil24.c to the new scheme.

Signed-off-by: <petkov@math.uni-muenster.de>

diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index b5f8fa9..ec1a7f3 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
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

