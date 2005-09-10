From: Tejun Heo <htejun@gmail.com>
Subject: Re: [sata_sil24] v0.10 works, v0.20 doesn't
Date: Sat, 10 Sep 2005 22:53:50 +0900
Message-ID: <20050910135350.GA20877@htj.dyndns.org>
References: <loom.20050905T024247-999@post.gmane.org> <431BC732.2010907@gmail.com> <20050905134311.GA15419@est.epita.fr> <20050905230234.GA543@htj.dyndns.org> <20050905231753.GA1003@htj.dyndns.org> <20050906011254.GA23144@est.epita.fr> <20050906015428.GA13521@htj.dyndns.org> <20050906093659.GB14270@est.epita.fr> <20050907013917.GA2803@htj.dyndns.org> <20050907093712.GA20006@est.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:63906 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750872AbVIJNx7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Sep 2005 09:53:59 -0400
Received: by zproxy.gmail.com with SMTP id 13so49937nzn
        for <linux-ide@vger.kernel.org>; Sat, 10 Sep 2005 06:53:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20050907093712.GA20006@est.epita.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bevand <mb@opensc.org>
Cc: linux-ide@vger.kernel.org

 Hi again, Marc.

On Wed, Sep 07, 2005 at 11:37:12AM +0200, Marc Bevand wrote:
> Hi Tejun.
> 
> Tejun Heo wrote:
> | 
> |  Here's a big patch against sil24-original branch.  It contains the
> | followings.
> | 
> |  a. build fix & oops fix for sil24-original branch
> |  b. backported sata_sil24_new driver
> |  c. debug messages (you don't need to turn on ATA_DEBUG)
> |  d. 50ms sleep after completion of IDENTIFY before actually reading data
> | 
> |  Building both sata_sil24 and sata_sil24_new as modules and
> | loading/unloading them work on my machine.  Can you please try this
> | and let me know how it goes?
> 
> Real quick update on this (it's 2:40 am here): sata_sil24_new still
> does not detects my disks while sata_sil24 works perfectly. I will post
> the full dmesg's + the various things I tried tomorrow.
> 

 I compared original and new sil24 and here are things that are done
differently upto the point where identify command is issued.

 a. Stuff done inside sil_init_pm() in the original driver is not done
    in the new driver.  This includes clearing PM_EN and RESUME bits
    in the ctrl/stat register and DVR_RST'ing the port.

 b. Original driver performs both SATA phy reset and soft reset.  New
    driver performs only SATA phy reset.

 c. New driver uses different order when initializing irq mask and
    doesn't turn on phy status change interrupt.

 d. New driver doesn't turn off SATA link power management.

 We've already tried #d, and I don't think #c has anything to do with
it as inserting 50ms sleep before reading data doesn't make any
difference.  So, it leaves us with #a and #b.  Here's a patch for #a.
If this doesn't work, I'll make a patch for #b.

 This patch is on top of previous test patch which backported
sil24_new.  Please try this one out and let me know the result.

 Thanks.


diff --git a/drivers/scsi/sata_sil24_new.c b/drivers/scsi/sata_sil24_new.c
--- a/drivers/scsi/sata_sil24_new.c
+++ b/drivers/scsi/sata_sil24_new.c
@@ -431,15 +431,11 @@ static void sil24_irq_clear(struct ata_p
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
@@ -451,7 +447,17 @@ static void sil24_reset_controller(struc
 		if (!(tmp & PORT_CS_DEV_RST))
 			break;
 	}
+
 	if (tmp & PORT_CS_DEV_RST)
+		return -1;
+	return 0;
+}
+
+static void sil24_reset_controller(struct ata_port *ap)
+{
+	printk(KERN_NOTICE DRV_NAME
+	       " ata%u: resetting controller...\n", ap->id);
+	if (__sil24_reset_controller((void *)ap->ioaddr.cmd_addr))
 		printk(KERN_ERR DRV_NAME
 		       " ata%u: failed to reset controller\n", ap->id);
 }
@@ -745,6 +751,15 @@ static int sil24_init_one(struct pci_dev
 		/* Clear interrupts */
 		writel(0x0fff0fff, port + PORT_IRQ_STAT);
 		writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);
+
+		/* Clear port enable and resume bits */
+		writel(PORT_CS_PM_EN | PORT_CS_RESUME, port + PORT_CTRL_CLR);
+
+		/* Reset itself */
+		if (__sil24_reset_controller(port))
+			printk(KERN_ERR DRV_NAME
+			       "(%s): failed to reset controller\n",
+			       pci_name(pdev));
 	}
 
 	/* Turn on interrupts */
