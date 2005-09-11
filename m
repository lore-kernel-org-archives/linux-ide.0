From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev-2.6:sil24] sil24: initialization fix
Date: Sun, 11 Sep 2005 16:15:06 +0900
Message-ID: <20050911071506.GA19236@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:61604 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932426AbVIKHPQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Sep 2005 03:15:16 -0400
Received: by zproxy.gmail.com with SMTP id 13so113303nzn
        for <linux-ide@vger.kernel.org>; Sun, 11 Sep 2005 00:15:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mb@opensc.org, linux-ide@vger.kernel.org, efalk@google.com

 sil24 0.20 didn't use to perform (what seems to be) port multiplier
initialization and controller reset 0.10 driver does.  This makes some
sil24 controllers malfunction.  This patch adds PM initialization and
controller resetting to initilization.  Please refer to the following
thread for more information.

http://marc.theaimsgroup.com/?l=linux-ide&m=112582819830324&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=112636045531060&w=2

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -426,15 +426,11 @@ static void sil24_irq_clear(struct ata_p
 	/* unused */
 }
 
-static void sil24_reset_controller(struct ata_port *ap)
+static int __sil24_reset_controller(void *port)
 {
-	void *port = (void *)ap->ioaddr.cmd_addr;
 	int cnt;
 	u32 tmp;
 
-	printk(KERN_NOTICE DRV_NAME
-	       " ata%u: resetting controller...\n", ap->id);
-
 	/* Reset controller state.  Is this correct? */
 	writel(PORT_CS_DEV_RST, port + PORT_CTRL_STAT);
 	readl(port + PORT_CTRL_STAT);	/* sync */
@@ -446,9 +442,19 @@ static void sil24_reset_controller(struc
 		if (!(tmp & PORT_CS_DEV_RST))
 			break;
 	}
+
 	if (tmp & PORT_CS_DEV_RST)
-		printk(KERN_ERR DRV_NAME
-		       " ata%u: failed to reset controller\n", ap->id);
+		return -1;
+	return 0;
+}
+
+static void sil24_reset_controller(struct ata_port *ap)
+{
+	printk(KERN_NOTICE DRV_NAME
+	       " ata%u: resetting controller...\n", ap->id);
+	if (__sil24_reset_controller((void *)ap->ioaddr.cmd_addr))
+                printk(KERN_ERR DRV_NAME
+                       " ata%u: failed to reset controller\n", ap->id);
 }
 
 static void sil24_eng_timeout(struct ata_port *ap)
@@ -740,6 +746,15 @@ static int sil24_init_one(struct pci_dev
 		/* Clear interrupts */
 		writel(0x0fff0fff, port + PORT_IRQ_STAT);
 		writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);
+
+		/* Clear port multiplier enable and resume bits */
+		writel(PORT_CS_PM_EN | PORT_CS_RESUME, port + PORT_CTRL_CLR);
+
+		/* Reset itself */
+		if (__sil24_reset_controller(port))
+			printk(KERN_ERR DRV_NAME
+			       "(%s): failed to reset controller\n",
+			       pci_name(pdev));
 	}
 
 	/* Turn on interrupts */
