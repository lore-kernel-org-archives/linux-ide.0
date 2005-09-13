From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24] sil24: initialization fix
Date: Tue, 13 Sep 2005 13:21:29 +0900
Message-ID: <20050913042129.GA2874@htj.dyndns.org>
References: <20050911071506.GA19236@htj.dyndns.org> <4325B3A3.9060701@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:59692 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750781AbVIMEVm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Sep 2005 00:21:42 -0400
Received: by zproxy.gmail.com with SMTP id 13so388392nzn
        for <linux-ide@vger.kernel.org>; Mon, 12 Sep 2005 21:21:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4325B3A3.9060701@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Edward Falk <efalk@google.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, mb@opensc.org, linux-ide@vger.kernel.org

 Hello, Edward.

> Thanks, I'll try to merge those changes in.  You should bump the version
> number too.

 Yeap, modified patch follows.  Jeff, please ignore the previous
posting.

> I'll have a fully port multiplier-aware driver in a few more days for
> you to look at.

 Great.  I'll be expecting to see it soon.  :-)


 sil24 0.20 didn't use to perform (what seems to be) port multiplier
initialization and controller reset 0.10 driver does.  This makes some
sil24 controllers malfunction.  This patch adds PM initialization and
controller resetting to initilization and bumps version to 0.21.
Please refer to the following thread for more information.

http://marc.theaimsgroup.com/?l=linux-ide&m=112582819830324&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=112636045531060&w=2

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -41,7 +41,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_sil24"
-#define DRV_VERSION	"0.20"	/* Silicon Image's preview driver was 0.10 */
+#define DRV_VERSION	"0.21"	/* Silicon Image's preview driver was 0.10 */
 
 #define NR_PORTS	4
 
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
