From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: print SControl in SATA link status info message
Date: Mon, 3 Apr 2006 00:09:41 +0900
Message-ID: <20060402150941.GL13172@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:22430 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932361AbWDBPJr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 11:09:47 -0400
Received: by zproxy.gmail.com with SMTP id o37so1504947nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 08:09:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Now that libata mangles with SControl, it's helpful to print out
SControl in link status message.  Add it.

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8beba3c..966be30 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1503,20 +1503,23 @@ void ata_port_probe(struct ata_port *ap)
  */
 static void sata_print_link_status(struct ata_port *ap)
 {
-	u32 sstatus, tmp;
+	u32 sstatus, scontrol, tmp;
 
 	if (!ap->ops->scr_read)
 		return;
 
 	sstatus = scr_read(ap, SCR_STATUS);
+	scontrol = scr_read(ap, SCR_CONTROL);
 
 	if (sata_dev_present(ap)) {
 		tmp = (sstatus >> 4) & 0xf;
-		printk(KERN_INFO "ata%u: SATA link up %s (SStatus %X)\n",
-		       ap->id, sata_spd_string(tmp), sstatus);
+		printk(KERN_INFO
+		       "ata%u: SATA link up %s (SStatus %X SControl %X)\n",
+		       ap->id, sata_spd_string(tmp), sstatus, scontrol);
 	} else {
-		printk(KERN_INFO "ata%u: SATA link down (SStatus %X)\n",
-		       ap->id, sstatus);
+		printk(KERN_INFO
+		       "ata%u: SATA link down (SStatus %X SControl %X)\n",
+		       ap->id, sstatus, scontrol);
 	}
 }
 
