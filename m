From: Tejun Heo <htejun@gmail.com>
Subject: Re: PCI SATA controllers on embedded, no-BIOS targets
Date: Wed, 23 Aug 2006 03:00:56 +0900
Message-ID: <44EB4658.3060207@gmail.com>
References: <44EB32E4.8080706@mvista.com> <44EB33BB.4090101@gmail.com> <44EB3650.1080404@mvista.com> <44EB3E2F.4040504@gmail.com> <44EB3F70.6000702@gmail.com> <44EB40DA.3010904@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060209040803010804040401"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:63690 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932293AbWHVSBK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Aug 2006 14:01:10 -0400
Received: by nf-out-0910.google.com with SMTP id o25so124469nfa
        for <linux-ide@vger.kernel.org>; Tue, 22 Aug 2006 11:01:07 -0700 (PDT)
In-Reply-To: <44EB40DA.3010904@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-ide@vger.kernel.org, Deepak Saxena <dsaxena@mvista.com>

This is a multi-part message in MIME format.
--------------060209040803010804040401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kevin Hilman wrote:
>>> I've personally seen it working on XScale and ATI's mips.
> 
> OK, that's good to know.
> 
>> For the record, for ATI's new mips platform, sata_sil needs some 
>> modifications.  Their PCI bridge can't handle byte-aligned mmio and 
>> the driver had to be modified to use IO address space.
> 
> I'm using 2.6.18-rc4 on this XScale IXP425 (big endian) and both the 
> legacy driver (drivers/ide/pci/siimage.c) and the libata driver 
> (drivers/scsi/sata_sil.c) cause crashes during probing due to bad memory 
> accesses.

So, that one can't do byte-aligned mmio either?

> Switching the legacy driver into PIO mode makes the probing work well, 
> but still can't figure out what's happening in the libata driver, AFICT, 
> it can't do PIO.

By PIO, you mean accessing registers via IO address space instead of 
memory address space, right?  Not PIO as opposed to DMA.

> Any chance you can share the changes to use IO address space?  Maybe the 
> PCI on this XScale has similar limitations.

Sure, I've just got okay for releasing the code and am going to post the 
patches on my website anyway.  I'm attaching a patch.  This might not 
apply cleanly to your kernel but it should give enough idea.  Oh the 
code kills 4 ports support for 3114 too.

-- 
tejun

--------------060209040803010804040401
Content-Type: text/plain;
 name="use-pio-instead-of-mmio"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="use-pio-instead-of-mmio"

Index: work1/drivers/scsi/sata_sil.c
===================================================================
--- work1.orig/drivers/scsi/sata_sil.c	2006-06-14 10:44:43.000000000 +0900
+++ work1/drivers/scsi/sata_sil.c	2006-06-15 19:15:08.000000000 +0900
@@ -57,14 +57,10 @@ enum {
 	sil_3512		= 2,
 	sil_3114		= 3,
 
-	SIL_FIFO_R0		= 0x40,
-	SIL_FIFO_W0		= 0x41,
-	SIL_FIFO_R1		= 0x44,
-	SIL_FIFO_W1		= 0x45,
-	SIL_FIFO_R2		= 0x240,
-	SIL_FIFO_W2		= 0x241,
-	SIL_FIFO_R3		= 0x244,
-	SIL_FIFO_W3		= 0x245,
+	SIL_FIFO_0		= 0x40,
+	SIL_FIFO_1		= 0x44,
+	SIL_FIFO_2		= 0x240,
+	SIL_FIFO_3		= 0x244,
 
 	SIL_SYSCFG		= 0x48,
 	SIL_MASK_IDE0_INT	= (1 << 22),
@@ -181,7 +177,7 @@ static const struct ata_port_info sil_po
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+				  ATA_FLAG_SRST,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -191,8 +187,7 @@ static const struct ata_port_info sil_po
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
-				  SIL_FLAG_MOD15WRITE,
+				  ATA_FLAG_SRST | SIL_FLAG_MOD15WRITE,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -202,8 +197,7 @@ static const struct ata_port_info sil_po
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
-				  SIL_FLAG_RERR_ON_DMA_ACT,
+				  ATA_FLAG_SRST | SIL_FLAG_RERR_ON_DMA_ACT,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -459,13 +453,34 @@ static int sil_init_one (struct pci_dev 
 
 	base = (unsigned long) mmio_base;
 
-	for (i = 0; i < probe_ent->n_ports; i++) {
-		probe_ent->port[i].cmd_addr = base + sil_port[i].tf;
-		probe_ent->port[i].altstatus_addr =
-		probe_ent->port[i].ctl_addr = base + sil_port[i].ctl;
-		probe_ent->port[i].bmdma_addr = base + sil_port[i].bmdma;
-		probe_ent->port[i].scr_addr = base + sil_port[i].scr;
-		ata_std_ports(&probe_ent->port[i]);
+	if (ent->driver_data == 3114) {
+		for (i = 0; i < probe_ent->n_ports; i++) {
+			probe_ent->port[i].cmd_addr = base + sil_port[i].tf;
+			probe_ent->port[i].altstatus_addr =
+			probe_ent->port[i].ctl_addr = base + sil_port[i].ctl;
+			probe_ent->port[i].bmdma_addr = base + sil_port[i].bmdma;
+			probe_ent->port[i].scr_addr = base + sil_port[i].scr;
+			ata_std_ports(&probe_ent->port[i]);
+		}
+	} else {
+		/* Use PIO for 3112/3512.  Some platforms barf on
+		 * byte-wide mmio on odd boundary.
+		 */
+		probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
+		probe_ent->port[0].altstatus_addr =
+		probe_ent->port[0].ctl_addr =
+			pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
+		probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
+		probe_ent->port[0].scr_addr = base + sil_port[0].scr;
+		ata_std_ports(&probe_ent->port[0]);
+
+		probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
+		probe_ent->port[1].altstatus_addr =
+		probe_ent->port[1].ctl_addr =
+			pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
+		probe_ent->port[1].bmdma_addr = pci_resource_start(pdev, 4) + 8;
+		probe_ent->port[1].scr_addr = base + sil_port[1].scr;
+		ata_std_ports(&probe_ent->port[1]);
 	}
 
 	/* Initialize FIFO PCI bus arbitration */
@@ -473,15 +488,12 @@ static int sil_init_one (struct pci_dev 
 	if (cls) {
 		cls >>= 3;
 		cls++;  /* cls = (line_size/8)+1 */
-		writeb(cls, mmio_base + SIL_FIFO_R0);
-		writeb(cls, mmio_base + SIL_FIFO_W0);
-		writeb(cls, mmio_base + SIL_FIFO_R1);
-		writeb(cls, mmio_base + SIL_FIFO_W1);
+		tmp = cls << 8 | cls;
+		writew(tmp, mmio_base + SIL_FIFO_0);
+		writew(tmp, mmio_base + SIL_FIFO_1);
 		if (ent->driver_data == sil_3114) {
-			writeb(cls, mmio_base + SIL_FIFO_R2);
-			writeb(cls, mmio_base + SIL_FIFO_W2);
-			writeb(cls, mmio_base + SIL_FIFO_R3);
-			writeb(cls, mmio_base + SIL_FIFO_W3);
+			writew(tmp, mmio_base + SIL_FIFO_2);
+			writew(tmp, mmio_base + SIL_FIFO_3);
 		}
 	} else
 		dev_printk(KERN_WARNING, &pdev->dev,

--------------060209040803010804040401--
