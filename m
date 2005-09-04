From: Tejun Heo <htejun@gmail.com>
Subject: Re: [sata_sil24] v0.10 works, v0.20 doesn't
Date: Sun, 4 Sep 2005 23:02:39 +0900
Message-ID: <20050904140239.GA11855@htj.dyndns.org>
References: <loom.20050904T095233-120@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.206]:12125 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750846AbVIDOCq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Sep 2005 10:02:46 -0400
Received: by zproxy.gmail.com with SMTP id 13so686433nzn
        for <linux-ide@vger.kernel.org>; Sun, 04 Sep 2005 07:02:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20050904T095233-120@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bevand <mb@opensc.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

[CC'ing Jeff]

 Hello, Marc.

 Weird, I can tell you that 0.2 driver works for at least two sil24
controllers - mine and Edward Falk's.  Can you please apply the
following patch to the current ALL head and post dmesg?

diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -512,6 +512,16 @@ static inline void sil24_host_intr(struc
 
 	slot_stat = readl(port + PORT_SLOT_STAT);
 	if (!(slot_stat & HOST_SSTAT_ATTN)) {
+		u32 irq_stat, cmd_err, sstatus, serror;
+
+		irq_stat = readl(port + PORT_IRQ_STAT);
+		cmd_err = readl(port + PORT_CMD_ERR);
+		sstatus = readl(port + PORT_SSTATUS);
+		serror = readl(port + PORT_SERROR);
+		DPRINTK(DRV_NAME " ata%u: normal interrupt on port%d\n"
+			"  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
+			ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, serror);
+
 		if (qc)
 			ata_qc_complete(qc, 0);
 	} else
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -36,8 +36,8 @@
 /*
  * compile-time options
  */
-#undef ATA_DEBUG		/* debugging output */
-#undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
+#define ATA_DEBUG		/* debugging output */
+#define ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
 #undef ATA_NDEBUG		/* define to disable quick runtime checks */
 #undef ATA_ENABLE_ATAPI		/* define to enable ATAPI support */
