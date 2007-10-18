From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 6/8] ide: remove ->init_setup_dma from ide_pci_device_t
Date: Fri, 19 Oct 2007 00:05:35 +0200
Message-ID: <200710190005.36075.bzolnier@gmail.com>
References: <200708271933.24566.bzolnier@gmail.com> <470A8383.3070006@ru.mvista.com> <20071008204752.136b6259@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:5764 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758844AbXJRWuc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 18:50:32 -0400
Received: by nf-out-0910.google.com with SMTP id g13so285712nfb
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 15:50:31 -0700 (PDT)
In-Reply-To: <20071008204752.136b6259@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Monday 08 October 2007, Alan Cox wrote:
> 
> > >   This fixes PCI bus-mastering and DMA simplex mode not being checked for
> > >   CS5510/CS5520 hosts.
> > 
> 
> Just noticed this patch:
> 
> You do realise that the CS5510 and CS5520 aren't IDE class devices so its
> wrong to check the simplex bits on them (Ditto the MPIIX ?)

Thanks for catching this, fixed in take 2.

I've also checked MPIIX and it is OK since we never setup DMA on it.

> You really shouldn't be taking the CS5510, CS5520 or MPIIX via the SFF
> IDE setup paths at all. You'll note that libata takes care not to do so.

It has been done this way AFAIR and there has never been any patches to
improve the situation.  If somebody wants to fix it I'm all for moving these
hardware out of SFF IDE setup code (the only condition is that the changes
should avoid adding the unnecessary code duplication).

> Indeed last time I tested the MPIIX support in old IDE didn't actually
> work precisely due to this.

MPIIX support seems to be a quick piix.c hack so I'm not surprised here
(fortunately we have pata_mpiix nowadays).


New patch version below, the only code change is this one:

diff -u b/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
--- b/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -174,7 +174,7 @@
 			printk(KERN_ERR "%s: DMA base is invalid\n", d->name);
 	}
 
-	if (dma_base) {
+	if ((d->host_flags & IDE_HFLAG_CS5520) == 0 && dma_base) {
 		u8 simplex_stat = 0;
 		dma_base += hwif->channel ? 8 : 0;
 


[PATCH] ide: remove ->init_setup_dma from ide_pci_device_t (take 2)

* Make ide_pci_device_t.host_flags u32 and add IDE_HFLAG_CS5520 host flag.

* Pass ide_pci_device_t *d to setup-pci.c::ide_get_or_set_dma_base()
  and use d->name instead of hwif->cds->name.

* Set IDE_HFLAG_CS5520 host flag in cs5520 host driver and use it in
  ide_get_or_set_dma_base() to find out which PCI BAR to use, remove no longer
  needed cs5520.c::cs5520_init_setup_dma() and ide_pci_device_t.init_setup_dma.

  This fixes PCI bus-mastering not being checked for CS5510/CS5520 hosts.

v2:
* It is wrong to check simplex bits on CS5510/CS5520 as v1 did.
  (Noticed by Alan).

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cs5520.c |   14 +-------------
 drivers/ide/setup-pci.c  |   35 ++++++++++++++++-------------------
 include/linux/ide.h      |    5 +++--
 3 files changed, 20 insertions(+), 34 deletions(-)

Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -106,18 +106,6 @@ static void cs5520_set_dma_mode(ide_driv
 }
 
 /*
- *	We provide a callback for our nonstandard DMA location
- */
-
-static void __devinit cs5520_init_setup_dma(struct pci_dev *dev, ide_pci_device_t *d, ide_hwif_t *hwif)
-{
-	unsigned long bmide = pci_resource_start(dev, 2);	/* Not the usual 4 */
-	if(hwif->mate && hwif->mate->dma_base)	/* Second channel at primary + 8 */
-		bmide += 8;
-	ide_setup_dma(hwif, bmide, 8);
-}
-
-/*
  *	We wrap the DMA activate to set the vdma flag. This is needed
  *	so that the IDE DMA layer issues PIO not DMA commands over the
  *	DMA channel
@@ -150,9 +138,9 @@ static void __devinit init_hwif_cs5520(i
 #define DECLARE_CS_DEV(name_str)				\
 	{							\
 		.name		= name_str,			\
-		.init_setup_dma = cs5520_init_setup_dma,	\
 		.init_hwif	= init_hwif_cs5520,		\
 		.host_flags	= IDE_HFLAG_ISA_PORTS |		\
+				  IDE_HFLAG_CS5520 |		\
 				  IDE_HFLAG_VDMA |		\
 				  IDE_HFLAG_NO_ATAPI_DMA |	\
 				  IDE_HFLAG_BOOTABLE,		\
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -147,6 +147,7 @@ static int ide_setup_pci_baseregs (struc
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	ide_get_or_set_dma_base		-	setup BMIBA
+ *	@d: IDE pci device data
  *	@hwif: Interface
  *
  *	Fetch the DMA Bus-Master-I/O-Base-Address (BMIBA) from PCI space.
@@ -154,7 +155,7 @@ static int ide_setup_pci_baseregs (struc
  *	and enforce IDE simplex rules.
  */
 
-static unsigned long ide_get_or_set_dma_base (ide_hwif_t *hwif)
+static unsigned long ide_get_or_set_dma_base(ide_pci_device_t *d, ide_hwif_t *hwif)
 {
 	unsigned long	dma_base = 0;
 	struct pci_dev	*dev = hwif->pci_dev;
@@ -165,14 +166,15 @@ static unsigned long ide_get_or_set_dma_
 	if (hwif->mate && hwif->mate->dma_base) {
 		dma_base = hwif->mate->dma_base - (hwif->channel ? 0 : 8);
 	} else {
-		dma_base = pci_resource_start(dev, 4);
-		if (!dma_base) {
-			printk(KERN_ERR "%s: dma_base is invalid\n",
-					hwif->cds->name);
-		}
+		u8 baridx = (d->host_flags & IDE_HFLAG_CS5520) ? 2 : 4;
+
+		dma_base = pci_resource_start(dev, baridx);
+
+		if (dma_base == 0)
+			printk(KERN_ERR "%s: DMA base is invalid\n", d->name);
 	}
 
-	if (dma_base) {
+	if ((d->host_flags & IDE_HFLAG_CS5520) == 0 && dma_base) {
 		u8 simplex_stat = 0;
 		dma_base += hwif->channel ? 8 : 0;
 
@@ -188,8 +190,8 @@ static unsigned long ide_get_or_set_dma_
 				simplex_stat = hwif->INB(dma_base + 2);
 				if (simplex_stat & 0x80) {
 					printk(KERN_INFO "%s: simplex device: "
-						"DMA forced\n",
-						hwif->cds->name);
+							 "DMA forced\n",
+							 d->name);
 				}
 				break;
 			default:
@@ -212,8 +214,8 @@ static unsigned long ide_get_or_set_dma_
  */
 					if (hwif->mate && hwif->mate->dma_base) {
 						printk(KERN_INFO "%s: simplex device: "
-							"DMA disabled\n",
-							hwif->cds->name);
+								 "DMA disabled\n",
+								 d->name);
 						dma_base = 0;
 					}
 				}
@@ -434,7 +436,7 @@ static void ide_hwif_setup_dma(struct pc
 	if ((d->host_flags & IDE_HFLAG_NO_AUTODMA) == 0 ||
 	    ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE &&
 	     (dev->class & 0x80))) {
-		unsigned long dma_base = ide_get_or_set_dma_base(hwif);
+		unsigned long dma_base = ide_get_or_set_dma_base(d, hwif);
 		if (dma_base && !(pcicmd & PCI_COMMAND_MASTER)) {
 			/*
  			 * Set up BM-DMA capability
@@ -559,14 +561,9 @@ void ide_pci_setup_ports(struct pci_dev 
 		if (d->init_iops)
 			d->init_iops(hwif);
 
-		if (d->host_flags & IDE_HFLAG_NO_DMA)
-			goto bypass_legacy_dma;
-
-		if(d->init_setup_dma)
-			d->init_setup_dma(dev, d, hwif);
-		else
+		if ((d->host_flags & IDE_HFLAG_NO_DMA) == 0)
 			ide_hwif_setup_dma(dev, d, hwif);
-bypass_legacy_dma:
+
 		hwif->host_flags = d->host_flags;
 		hwif->pio_mask = d->pio_mask;
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1252,6 +1252,8 @@ enum {
 	IDE_HFLAG_NO_DMA		= (1 << 14),
 	/* check if host is PCI IDE device before allowing DMA */
 	IDE_HFLAG_NO_AUTODMA		= (1 << 15),
+	/* host is CS5510/CS5520 */
+	IDE_HFLAG_CS5520		= (1 << 16),
 };
 
 #ifdef CONFIG_BLK_DEV_OFFBOARD
@@ -1263,7 +1265,6 @@ enum {
 typedef struct ide_pci_device_s {
 	char			*name;
 	int			(*init_setup)(struct pci_dev *, struct ide_pci_device_s *);
-	void			(*init_setup_dma)(struct pci_dev *, struct ide_pci_device_s *, ide_hwif_t *);
 	unsigned int		(*init_chipset)(struct pci_dev *, const char *);
 	void			(*init_iops)(ide_hwif_t *);
 	void                    (*init_hwif)(ide_hwif_t *);
@@ -1272,7 +1273,7 @@ typedef struct ide_pci_device_s {
 	ide_pci_enablebit_t	enablebits[2];
 	unsigned int		extra;
 	struct ide_pci_device_s	*next;
-	u16			host_flags;
+	u32			host_flags;
 	u8			pio_mask;
 	u8			udma_mask;
 } ide_pci_device_t;
