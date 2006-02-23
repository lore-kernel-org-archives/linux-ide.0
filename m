From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil.c, 3512 and SIL_QUIRK_MOD15WRITE
Date: Thu, 23 Feb 2006 16:19:21 +0900
Message-ID: <20060223071921.GA24592@htj.dyndns.org>
References: <loom.20060222T182150-518@post.gmane.org> <43FD18F5.20002@gmail.com> <1140677987.11943.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:9179 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751644AbWBWHSQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Feb 2006 02:18:16 -0500
Received: by pproxy.gmail.com with SMTP id i49so1957700pye
        for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2006 23:18:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1140677987.11943.16.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jon K Hellan <hellan@acm.org>
Cc: linux-ide@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

On Thu, Feb 23, 2006 at 07:59:47AM +0100, Jon K Hellan wrote:
> On Thu, 2006-02-23 at 11:07 +0900, Tejun Heo wrote:
> > According to the errata information from Silicon Image, SiI3512 does not 
> > have m15w bug, neither does ST3200822AS. So, this must be something else 
> > and you're not an isolated case.
> 
> Glad to hear it.
> 
> In that case, you'd probably like to hear about the other disk as well.
> Originally, I suspected the disk was about to fail, and bought another
> one - a Samsung SP2504C. I never succeeded in copying the data off the
> Seagate onto the Samsung. The farthest I got was about 2 gigs. The error
> messages would be from sdb (the Samsung):
> 
> Feb 21 20:08:31 parus kernel: ata2: command 0x35 timeout, stat 0xd1 host_stat 0x61
> Feb 21 20:08:31 parus kernel: ata2: translated ATA stat/err 0xd1/00 to
> SCSI SK/ASC/ASCQ 0xb/47/00
> Feb 21 20:08:31 parus kernel: ata2: status=0xd1 { Busy }
> Feb 21 20:08:31 parus kernel: sd 1:0:0:0: SCSI error: return code =
> 0x8000002
> Feb 21 20:08:31 parus kernel: sdb: Current: sense key: Aborted Command
> Feb 21 20:08:31 parus kernel:     Additional sense: Scsi parity error
> Feb 21 20:08:31 parus kernel: end_request: I/O error, dev sdb, sector
> 15657695
> Feb 21 20:08:31 parus kernel: Buffer I/O error on device sdb1, logical
> block 1957204
> Feb 21 20:08:31 parus kernel: lost page write due to I/O error on sdb1
> Feb 21 20:08:31 parus kernel: ATA: abnormal status 0xD1 on port
> 0xF88020C7
> 
> I didn't bring this up originally, since it looked like the Seagate
> problem was a known bug, while Google didn't turn up anything on
> Samsung. After reading linux-ide through gmane, I've seen similar issues
> about Samsung. You guys should get an archive which Google knows
> about :-)

Well, I'm happy with gmane/marc for the time being.  :-)

> 
> > So, it would be very nice if you can test fixes we'll be able to come up with.
> 

Can you try the following patch?  It's a kind of long shot.  I just
want to make sure.  And even if it doesn't work, it wouldn't do any
harm.

diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index e14ed4e..2f71924 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -215,12 +215,13 @@ static const struct {
 	unsigned long scr;	/* SATA control register block */
 	unsigned long sien;	/* SATA Interrupt Enable register */
 	unsigned long xfer_mode;/* data transfer mode register */
+	unsigned long sfis_cfg;	/* SATA FIS reception config register */
 } sil_port[] = {
 	/* port 0 ... */
-	{ 0x80, 0x8A, 0x00, 0x100, 0x148, 0xb4 },
-	{ 0xC0, 0xCA, 0x08, 0x180, 0x1c8, 0xf4 },
-	{ 0x280, 0x28A, 0x200, 0x300, 0x348, 0x2b4 },
-	{ 0x2C0, 0x2CA, 0x208, 0x380, 0x3c8, 0x2f4 },
+	{ 0x80, 0x8A, 0x00, 0x100, 0x148, 0xb4, 0x14c },
+	{ 0xC0, 0xCA, 0x08, 0x180, 0x1c8, 0xf4, 0x1cc },
+	{ 0x280, 0x28A, 0x200, 0x300, 0x348, 0x2b4, 0x34c },
+	{ 0x2C0, 0x2CA, 0x208, 0x380, 0x3c8, 0x2f4, 0x3cc },
 	/* ... port 3 */
 };
 
@@ -372,7 +373,7 @@ static int sil_init_one (struct pci_dev 
 	unsigned long base;
 	void __iomem *mmio_base;
 	int rc;
-	unsigned int i;
+	unsigned int i, cnt;
 	int pci_dev_busy = 0;
 	u32 tmp, irq_mask;
 	u8 cls;
@@ -466,11 +467,23 @@ static int sil_init_one (struct pci_dev 
 		if ((tmp & SIL_INTR_STEERING) == 0)
 			writel(tmp | SIL_INTR_STEERING,
 			       mmio_base + SIL_IDE2_BMDMA);
-
 	} else {
 		irq_mask = SIL_MASK_2PORT;
 	}
 
+	/* R_ERR on DMA activate FIS errata workaround */
+	for (i = 0, cnt = 0; i < probe_ent->n_ports; i++) {
+		tmp = readl(mmio_base + sil_port[i].sfis_cfg);
+		if ((tmp & 0x3) != 0x01)
+			continue;
+		if (!cnt)
+			dev_printk(KERN_INFO, &pdev->dev,
+				   "Applying R_ERR on DMA activate "
+				   "FIS errata fix\n");
+		writel(tmp & ~0x3, mmio_base + sil_port[i].sfis_cfg);
+		cnt++;
+	}
+
 	/* make sure IDE0/1/2/3 interrupts are not masked */
 	tmp = readl(mmio_base + SIL_SYSCFG);
 	if (tmp & irq_mask) {
