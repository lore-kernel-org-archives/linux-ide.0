From: Tejun Heo <htejun@gmail.com>
Subject: Re: [sata_sil24] v0.10 works, v0.20 doesn't
Date: Sun, 11 Sep 2005 15:15:39 +0900
Message-ID: <20050911061539.GA18393@htj.dyndns.org>
References: <20050905134311.GA15419@est.epita.fr> <20050905230234.GA543@htj.dyndns.org> <20050905231753.GA1003@htj.dyndns.org> <20050906011254.GA23144@est.epita.fr> <20050906015428.GA13521@htj.dyndns.org> <20050906093659.GB14270@est.epita.fr> <20050907013917.GA2803@htj.dyndns.org> <20050907093712.GA20006@est.epita.fr> <20050910135350.GA20877@htj.dyndns.org> <20050911050021.GA619@wc.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:9961 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964790AbVIKGPt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Sep 2005 02:15:49 -0400
Received: by zproxy.gmail.com with SMTP id r28so1569004nza
        for <linux-ide@vger.kernel.org>; Sat, 10 Sep 2005 23:15:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20050911050021.GA619@wc.epita.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bevand <mb@opensc.org>
Cc: linux-ide@vger.kernel.org

 Hello, Marc.

On Sun, Sep 11, 2005 at 07:00:21AM +0200, Marc Bevand wrote:
> Hello Tejun.
> 
> Tejun Heo wrote:
> | 
> |  I compared original and new sil24 and here are things that are done
> | differently upto the point where identify command is issued.
> | 
> |  a. Stuff done inside sil_init_pm() in the original driver is not done
> |     in the new driver.  This includes clearing PM_EN and RESUME bits
> |     in the ctrl/stat register and DVR_RST'ing the port.
> | [...]
> |  Here's a patch for #a.
> |  This patch is on top of previous test patch which backported
> | sil24_new.  Please try this one out and let me know the result.
> 
> Yes ! With this patch, my disk is recognized. Congratulations :-)

 Great. :-)

> See below for the dmesg. Let me know if you want me to try anything
> else. I would be happy to help you.

 Everything looks dandy.  Here's a patch against the current sil24
head of libata-dev tree.  It should also apply cleanly to ALL head.
Please try this one and let me know how it works; then, the patch will
go to Jeff & upstream.


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
