From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA_SIL on IXP425 workaround
Date: Wed, 20 Jan 2010 23:58:17 -0500
Message-ID: <4B57DEE9.8030604@garzik.org>
References: <m33a4nfvva.fsf@intrepid.localdomain> <201001141659.19687.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020700000907060607050008"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:41115 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab0AUE6U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 23:58:20 -0500
In-Reply-To: <201001141659.19687.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020700000907060607050008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 01/14/2010 10:59 AM, Bartlomiej Zolnierkiewicz wrote:
> On Monday 09 November 2009 06:31:21 pm Krzysztof Halasa wrote:
>> I'm trying to add a workaround for IXP4xx CPUs to SATA SIL driver. The
>> problem is that IXP4xx CPUs (Intel's XScale (ARM) network-oriented
>> processors) are unable to perform 8 and 16-bit read from PCI MMIO, they
>> can only do a full 32-bit readl(); SIL chips respond to that with PCI
>> abort. The workaround is to use 8 and 16-bit regular IO reads (inb/inw)
>> instead (MMIO write is not a problem).
>>
>> For SIL3x12 the workaround is simple (attached) and it works on my 3512.
>> I'm not sure about 3114 (the 4-port chip) - the PIO BARs have TF, CTL
>> and BWDMA registers which are common to channels 0 and 2, and (the other
>> set) to channels 1 and 3. Channel selection is done with bit 4 of
>> device/head TF register, this is similar (same?) as PATA master/slave.
>> Does that mean that I can simply treat channel 0 as PRI master, ch#2 as
>> PRI slave, ch#1 as SEC master and ch#3 as SEC slave, and the SFF code
>> will select the right device correctly? Does it need additional code?
>> I don't have anything based on 3114.
>>
>> Note: the large PRD is not a problem here, the transfer can be started
>> by MMIO write. Only reads are an issue.
>
> FWIW your patch is now in my atang tree (I'm aware that Jeff is working
> on generic solution but in the meantime this non-intrusive patch allows
> sata_sil to work on IXP425).

I was asking an open question, is a generic solution possible?

Something like the attached patch might work, due it is completely 
untested, and I did not verify that the BMDMA Status register is not 
stomped.  Also, the additional ioread32() calls in bmdma start/stop are 
LIKELY to be unnecessary.

	Jeff





--------------020700000907060607050008
Content-Type: text/plain;
 name="patch.sata_sil-mmio32"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch.sata_sil-mmio32"

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 3cb69d5..7fa6164 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -270,9 +270,11 @@ static void sil_bmdma_stop(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	void __iomem *mmio_base = ap->host->iomap[SIL_MMIO_BAR];
 	void __iomem *bmdma2 = mmio_base + sil_port[ap->port_no].bmdma2;
+	u32 tmp;
 
 	/* clear start/stop bit - can safely always write 0 */
-	iowrite8(0, bmdma2);
+	tmp = ioread32(bmdma2) & 0xffffff00;
+	iowrite32(tmp | 0, bmdma2);
 
 	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
 	ata_sff_dma_pause(ap);
@@ -296,14 +298,17 @@ static void sil_bmdma_start(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	void __iomem *mmio_base = ap->host->iomap[SIL_MMIO_BAR];
 	void __iomem *bmdma2 = mmio_base + sil_port[ap->port_no].bmdma2;
-	u8 dmactl = ATA_DMA_START;
+	u32 dmactl = ATA_DMA_START;
+	u32 tmp;
 
 	/* set transfer direction, start host DMA transaction
 	   Note: For Large Block Transfer to work, the DMA must be started
 	   using the bmdma2 register. */
 	if (!rw)
 		dmactl |= ATA_DMA_WR;
-	iowrite8(dmactl, bmdma2);
+
+	tmp = ioread32(bmdma2) & 0xffffff00;
+	iowrite32(tmp | dmactl, bmdma2);
 }
 
 /* The way God intended PCI IDE scatter/gather lists to look and behave... */
@@ -571,13 +576,13 @@ static void sil_freeze(struct ata_port *ap)
 	 * This is because the controller will not give us access to the
 	 * taskfile registers while a DMA is in progress
 	 */
-	iowrite8(ioread8(ap->ioaddr.bmdma_addr) & ~SIL_DMA_ENABLE,
-		 ap->ioaddr.bmdma_addr);
+	tmp = ioread32(ap->ioaddr.bmdma_addr);
+	iowrite32(tmp & ~SIL_DMA_ENABLE, ap->ioaddr.bmdma_addr);
 
 	/* According to ata_bmdma_stop, an HDMA transition requires
 	 * on PIO cycle. But we can't read a taskfile register.
 	 */
-	ioread8(ap->ioaddr.bmdma_addr);
+	ioread32(ap->ioaddr.bmdma_addr);
 }
 
 static void sil_thaw(struct ata_port *ap)
@@ -667,7 +672,7 @@ static void sil_init_controller(struct ata_host *host)
 {
 	struct pci_dev *pdev = to_pci_dev(host->dev);
 	void __iomem *mmio_base = host->iomap[SIL_MMIO_BAR];
-	u8 cls;
+	u32 cls;
 	u32 tmp;
 	int i;
 
@@ -676,9 +681,12 @@ static void sil_init_controller(struct ata_host *host)
 	if (cls) {
 		cls >>= 3;
 		cls++;  /* cls = (line_size/8)+1 */
-		for (i = 0; i < host->n_ports; i++)
-			writew(cls << 8 | cls,
+		for (i = 0; i < host->n_ports; i++) {
+			tmp = readl(mmio_base + sil_port[i].fifo_cfg) &
+			      0xffff0000;
+			writel(tmp | cls << 8 | cls,
 			       mmio_base + sil_port[i].fifo_cfg);
+		}
 	} else
 		dev_printk(KERN_WARNING, &pdev->dev,
 			   "cache line size not set.  Driver may not function\n");

--------------020700000907060607050008--
