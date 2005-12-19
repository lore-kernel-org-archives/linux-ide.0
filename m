From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/05] libata: separate out ata_sata_print_link_status
Date: Mon, 19 Dec 2005 22:35:02 +0900
Message-ID: <20051219133502.GA26769@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:56854 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932068AbVLSNfI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 08:35:08 -0500
Received: by zproxy.gmail.com with SMTP id 14so1921107nzn
        for <linux-ide@vger.kernel.org>; Mon, 19 Dec 2005 05:35:07 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Separate out ata_sata_print_link_status() from __sata_phy_reset().

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 9ea1025..fb1e186 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1466,6 +1466,41 @@ void ata_port_probe(struct ata_port *ap)
 }
 
 /**
+ *	ata_sata_print_link_status - Print SATA link status
+ *	@ap: SATA port to printk link status about
+ *
+ *	This function prints link speed and status of a SATA link.
+ *
+ *	LOCKING:
+ *	None.
+ */
+void ata_sata_print_link_status(struct ata_port *ap)
+{
+	u32 sstatus, tmp;
+	const char *speed;
+
+	if (!ap->ops->scr_read)
+		return;
+
+	sstatus = scr_read(ap, SCR_STATUS);
+
+	if (sata_dev_present(ap)) {
+		tmp = (sstatus >> 4) & 0xf;
+		if (tmp & (1 << 0))
+			speed = "1.5";
+		else if (tmp & (1 << 1))
+			speed = "3.0";
+		else
+			speed = "<unknown>";
+		printk(KERN_INFO "ata%u: SATA link up %s Gbps (SStatus %X)\n",
+		       ap->id, speed, sstatus);
+	} else {
+		printk(KERN_INFO "ata%u: SATA link down (SStatus %X)\n",
+		       ap->id, sstatus);
+	}
+}
+
+/**
  *	__sata_phy_reset - Wake/reset a low-level SATA PHY
  *	@ap: SATA port associated with target SATA PHY.
  *
@@ -1499,27 +1534,14 @@ void __sata_phy_reset(struct ata_port *a
 			break;
 	} while (time_before(jiffies, timeout));
 
-	/* TODO: phy layer with polling, timeouts, etc. */
-	sstatus = scr_read(ap, SCR_STATUS);
-	if (sata_dev_present(ap)) {
-		const char *speed;
-		u32 tmp;
+	/* print link status */
+	ata_sata_print_link_status(ap);
 
-		tmp = (sstatus >> 4) & 0xf;
-		if (tmp & (1 << 0))
-			speed = "1.5";
-		else if (tmp & (1 << 1))
-			speed = "3.0";
-		else
-			speed = "<unknown>";
-		printk(KERN_INFO "ata%u: SATA link up %s Gbps (SStatus %X)\n",
-		       ap->id, speed, sstatus);
+	/* TODO: phy layer with polling, timeouts, etc. */
+	if (sata_dev_present(ap))
 		ata_port_probe(ap);
-	} else {
-		printk(KERN_INFO "ata%u: SATA link down (SStatus %X)\n",
-		       ap->id, sstatus);
+	else
 		ata_port_disable(ap);
-	}
 
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;
@@ -4980,6 +5002,7 @@ EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
 EXPORT_SYMBOL_GPL(ata_bmdma_status);
 EXPORT_SYMBOL_GPL(ata_bmdma_stop);
 EXPORT_SYMBOL_GPL(ata_port_probe);
+EXPORT_SYMBOL_GPL(ata_sata_print_link_status);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e828e17..7e38705 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -427,6 +427,7 @@ struct ata_timing {
 #define FIT(v,vmin,vmax)	max_t(short,min_t(short,v,vmax),vmin)
 
 extern void ata_port_probe(struct ata_port *);
+extern void ata_sata_print_link_status(struct ata_port *ap);
 extern void __sata_phy_reset(struct ata_port *ap);
 extern void sata_phy_reset(struct ata_port *ap);
 extern void ata_bus_reset(struct ata_port *ap);
