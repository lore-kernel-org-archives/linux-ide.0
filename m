From: bl0 <bl0-052@playker.info>
Subject: Re: sata_sil data corruption, possible workarounds
Date: Mon, 24 Dec 2012 15:37:53 +0100
Message-ID: <kb9pa2$mi8$1@ger.gmane.org>
References: <kahap3$mur$1@ger.gmane.org> <50CCF1E0.9070804@gmail.com> <kakea2$dh1$1@ger.gmane.org> <50CEB13B.9010100@gmail.com> <kaq1n6$hqa$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1457325.9k650SWqnK"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56814 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132Ab2LXOhF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Dec 2012 09:37:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1Tn99Y-000480-2T
	for linux-ide@vger.kernel.org; Mon, 24 Dec 2012 15:37:16 +0100
Received: from 91.150.147.9.internetia.net.pl ([91.150.147.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 24 Dec 2012 15:37:16 +0100
Received: from bl0-052 by 91.150.147.9.internetia.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 24 Dec 2012 15:37:16 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-pci@vger.kernel.org


--nextPart1457325.9k650SWqnK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit

On Tuesday 18 December 2012 16:23, bl0 wrote:

> On Monday 17 December 2012 06:44, Robert Hancock wrote:
> 
>> But it seems quite likely that
>> whatever magic numbers this code is picking don't work on your system
>> for some reason. It appears the root cause is likely a bug in the SiI
>> chip. There shouldn't be any region why messing around with these values
>> should cause data corruption other than that.
> 
> Do you think something should be done about it in the linux sata_sil
> driver? For a lack of a better solution, here is my suggestion. There is
> already one option 'slow_down' for problematic disks. Another option, for
> example 'cache_line_workaround', could be added for problematic
> motherboards. If enabled, the most straightforward way is to set cache
> line size to 0 and not worry about the fifo_cfg register.

Here is the code I currently have, attached as a diff. (This diff is not
against the latest git tree, it's against an older linux version which I
use.)


--nextPart1457325.9k650SWqnK
Content-Type: text/x-diff; name="sata_sil.diff"
Content-Transfer-Encoding: 8Bit
Content-Disposition: attachment; filename="sata_sil.diff"

--- linux-2.6.27.27/drivers/ata/sata_sil.0.c	2009-07-20 05:45:22.000000000 +0200
+++ linux-2.6.27.27/drivers/ata/sata_sil.c	2012-12-24 10:09:51.000000000 +0100
@@ -246,17 +246,25 @@
 
 static int slow_down;
 module_param(slow_down, int, 0444);
 MODULE_PARM_DESC(slow_down, "Sledgehammer used to work around random problems, by limiting commands to 15 sectors (0=off, 1=on)");
 
+static int cache_line_workaround = -1;
+module_param(cache_line_workaround, int, 0444);
+MODULE_PARM_DESC(cache_line_workaround, "Work around data corruption problem on some motherboards (0 to disable, 1 or 2 to enable different workarounds)");
+
 
 static unsigned char sil_get_device_cache_line(struct pci_dev *pdev)
 {
 	u8 cache_line = 0;
 	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cache_line);
 	return cache_line;
 }
+static void sil_set_device_cache_line(struct pci_dev *pdev, u8 val)
+{
+	pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, val);
+}
 
 /**
  *	sil_set_mode		-	wrap set_mode functions
  *	@link: link to set up
  *	@r_failed: returned device when we fail
@@ -555,30 +563,100 @@
 		dev->udma_mask &= ATA_UDMA5;
 		return;
 	}
 }
 
+static int sil_detect_problematic_chipset(void)
+{
+	/* it could be added later, i wouldn't worry about it now */
+	return 0;
+}
+
+static int sil_get_cache_line_workaround(struct pci_dev *pdev)
+{
+	if (cache_line_workaround != -1) { /* set by user */
+		dev_printk(KERN_INFO, &pdev->dev,
+			"cache_line_workaround=%d given\n", cache_line_workaround);
+		return cache_line_workaround;
+	} else if (slow_down) {
+		/* users have set slow_down because they have experienced problems. lower performance is expected. maybe it makes sense to enable it for them. */
+		dev_printk(KERN_INFO, &pdev->dev,
+			"slow_down given, using cache_line_workaround=1\n");
+		return 1;
+	} else if (sil_detect_problematic_chipset()) {
+		dev_printk(KERN_INFO, &pdev->dev,
+			"problematic motherboard chipset detected, using cache_line_workaround=1\n");
+		return 1;
+	} else {
+		/* default to old behavior */
+		return 0;
+	}
+}
+
 static void sil_init_controller(struct ata_host *host)
 {
 	struct pci_dev *pdev = to_pci_dev(host->dev);
 	void __iomem *mmio_base = host->iomap[SIL_MMIO_BAR];
+	int clw;
 	u8 cls;
+	u8 fifo_cfg_val;
 	u32 tmp;
 	int i;
 
 	/* Initialize FIFO PCI bus arbitration */
-	cls = sil_get_device_cache_line(pdev);
-	if (cls) {
-		cls >>= 3;
-		cls++;  /* cls = (line_size/8)+1 */
-		for (i = 0; i < host->n_ports; i++)
-			writew(cls << 8 | cls,
-			       mmio_base + sil_port[i].fifo_cfg);
-	} else
-		dev_printk(KERN_WARNING, &pdev->dev,
-			   "cache line size not set.  Driver may not function\n");
-
+	clw = sil_get_cache_line_workaround(pdev);
+	switch (clw) {
+	case 0:
+		dev_printk(KERN_WARNING, &pdev->dev,
+			"Data corruption is known to occur in combination with certain motherboards. If you encounter it, try cache_line_workaround=1 parameter.\n");
+		cls = sil_get_device_cache_line(pdev);
+		if (cls) {
+			dev_printk(KERN_DEBUG, &pdev->dev,
+				"cache line size: %d bytes\n", cls*4);
+			fifo_cfg_val = cls/8 + 1;
+			if (fifo_cfg_val > 7) fifo_cfg_val = 7; /* don't go over the maximum value */
+			dev_printk(KERN_DEBUG, &pdev->dev,
+				"setting fifo_cfg to %d\n", fifo_cfg_val);
+			for (i = 0; i < host->n_ports; i++) {
+				writew(fifo_cfg_val << 8 | fifo_cfg_val,
+				       mmio_base + sil_port[i].fifo_cfg);
+			}
+		} else {
+			dev_printk(KERN_INFO, &pdev->dev,
+				"cache line size not set\n");
+		}
+	break;
+	case 1:
+		dev_printk(KERN_INFO, &pdev->dev,
+			"cache_line_workaround=1, setting cache line size to 0\n");
+		sil_set_device_cache_line(pdev, 0);
+	break;
+	case 2:
+		dev_printk(KERN_INFO, &pdev->dev,
+			"cache_line_workaround=2. Increasing cache line size to 64 bytes, if necessary, and setting fifo_cfg to 0.\n");
+		cls = sil_get_device_cache_line(pdev);
+		dev_printk(KERN_DEBUG, &pdev->dev,
+			"current CLS: %d bytes\n", cls*4);
+		if (cls < 0x10) {
+			dev_printk(KERN_DEBUG, &pdev->dev,
+				"increasing CLS to 64 bytes\n");
+			sil_set_device_cache_line(pdev, 0x10);
+		} else {
+			dev_printk(KERN_DEBUG, &pdev->dev,
+				"keeping current CLS\n");
+		}
+		dev_printk(KERN_DEBUG, &pdev->dev,
+			"setting fifo_cfg to 0\n");
+		for (i = 0; i < host->n_ports; i++) {
+			writew(0, mmio_base + sil_port[i].fifo_cfg);
+		}
+	break;
+	default:
+		dev_printk(KERN_ERR, &pdev->dev,
+			"invalid cache_line_workaround: %d\n", clw);
+	}
+	
 	/* Apply R_ERR on DMA activate FIS errata workaround */
 	if (host->ports[0]->flags & SIL_FLAG_RERR_ON_DMA_ACT) {
 		int cnt;
 
 		for (i = 0, cnt = 0; i < host->n_ports; i++) {


--nextPart1457325.9k650SWqnK--

