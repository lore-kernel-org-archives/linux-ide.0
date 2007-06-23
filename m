From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 6/6] ide: add ide_pci_device_t.host_flags
Date: Sun, 24 Jun 2007 00:22:55 +0200
Message-ID: <200706240022.56055.bzolnier@gmail.com>
References: <200706232005.50076.bzolnier@gmail.com> <467D7231.7080701@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:31626 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbXFWWHp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 18:07:45 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1044378ugf
        for <linux-ide@vger.kernel.org>; Sat, 23 Jun 2007 15:07:44 -0700 (PDT)
In-Reply-To: <467D7231.7080701@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 23 June 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > * Rename ide_pci_device_t.flags to ide_pci_device_t.host_flags
> >   and IDEPCI_FLAG_ISA_PORTS flag to IDE_HFLAG_ISA_PORTS.
> 
>     Erm, do you intend also adding device_flags field? :-O ;-)

maybe 8)

> > * Add IDE_HFLAG_SINGLE flag for single channel devices.
> 
> > * Convert core code and all IDE PCI drivers to use IDE_HFLAG_SINGLE
> >   and remove no longer needed ide_pci_device_t.channels field.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
>     Sorry, NAK this one. ;-)

Oh, crap... ;-)

> > Index: b/drivers/ide/pci/hpt366.c
> > ===================================================================
> > --- a/drivers/ide/pci/hpt366.c
> > +++ b/drivers/ide/pci/hpt366.c
> > @@ -1490,7 +1490,7 @@ static int __devinit init_setup_hpt366(s
> >  		 * HPT36x chips are single channel and
> >  		 * do not seem to have the channel enable bit...
> >  		 */
> > -		d->channels = 1;
> > +		d->host_flags |= IDE_HFLAG_SINGLE;
> >  		d->enablebits[0].reg = 0;
> 
>     Probablly worth submitting a patch to fix up the enablebit here...
> Well, one we get Linas HPT366/Maxtor issue sorted out...

Sure, I'm patiently waiting for both patches and keeping this one
near the and of the patch queue...

> >  		d->udma_mask = HPT366_ALLOW_ATA66_3 ?
> > Index: b/drivers/ide/pci/scc_pata.c
> > ===================================================================
> > --- a/drivers/ide/pci/scc_pata.c
> > +++ b/drivers/ide/pci/scc_pata.c
> > @@ -731,9 +731,9 @@ static void __devinit init_hwif_scc(ide_
> >        .init_setup	= init_setup_scc,		\
> >        .init_iops	= init_iops_scc,		\
> >        .init_hwif	= init_hwif_scc,		\
> > -      .channels	= 1,					\
> >        .autodma	= AUTODMA,				\
> >        .bootable	= ON_BOARD,				\
> > +      .host_flags = IDE_HFLAG_SINGLE,			\
> 
>     Erm, why misaligned?

Fixed.

> > Index: b/drivers/ide/pci/serverworks.c
> > ===================================================================
> > --- a/drivers/ide/pci/serverworks.c
> > +++ b/drivers/ide/pci/serverworks.c
> > @@ -448,9 +448,12 @@ static int __devinit init_setup_csb6 (st
> >  			d->bootable = ON_BOARD;
> >  	}
> >  
> > -	d->channels = ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE ||
> > -			dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2) &&
> > -		       (!(PCI_FUNC(dev->devfn) & 1))) ? 1 : 2;
> > +	if ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE ||
> > +	    dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2) &&
> 
>     I'd have left that aligning space alone. :-)
> 
> > +	    (!(PCI_FUNC(dev->devfn) & 1)))
> > +		d->host_flags |= IDE_HFLAG_SINGLE;
> > +	else
>  > +		d->host_flags &= IDE_HFLAG_SINGLE;
> 
>     Here's the offending code! Should've been:
> 
> 		d->host_flags &= ~IDE_HFLAG_SINGLE;

Thanks for catching this.

Fixed, new patch below.

[PATCH] ide: add ide_pci_device_t.host_flags (take 2)

* Rename ide_pci_device_t.flags to ide_pci_device_t.host_flags
  and IDEPCI_FLAG_ISA_PORTS flag to IDE_HFLAG_ISA_PORTS.

* Add IDE_HFLAG_SINGLE flag for single channel devices.

* Convert core code and all IDE PCI drivers to use IDE_HFLAG_SINGLE
  and remove no longer needed ide_pci_device_t.channels field.

v2:
* Fix issues noticed by Sergei:
  - correct code alignment in scc_pata.c
  - s/IDE_HFLAG_SINGLE/~IDE_HFLAG_SINGLE/ in serverworks.c

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reviewed-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
---
 drivers/ide/pci/aec62xx.c      |    5 -----
 drivers/ide/pci/alim15x3.c     |    1 -
 drivers/ide/pci/amd74xx.c      |    2 --
 drivers/ide/pci/atiixp.c       |    3 +--
 drivers/ide/pci/cmd64x.c       |    4 ----
 drivers/ide/pci/cs5520.c       |    3 +--
 drivers/ide/pci/cs5530.c       |    1 -
 drivers/ide/pci/cs5535.c       |    2 +-
 drivers/ide/pci/cy82c693.c     |    2 +-
 drivers/ide/pci/generic.c      |   15 ---------------
 drivers/ide/pci/hpt34x.c       |    1 -
 drivers/ide/pci/hpt366.c       |    8 +-------
 drivers/ide/pci/it8213.c       |    2 +-
 drivers/ide/pci/it821x.c       |    1 -
 drivers/ide/pci/jmicron.c      |    1 -
 drivers/ide/pci/ns87415.c      |    1 -
 drivers/ide/pci/opti621.c      |    2 --
 drivers/ide/pci/pdc202xx_new.c |    7 -------
 drivers/ide/pci/pdc202xx_old.c |    5 -----
 drivers/ide/pci/piix.c         |    4 +---
 drivers/ide/pci/rz1000.c       |    1 -
 drivers/ide/pci/sc1200.c       |    1 -
 drivers/ide/pci/scc_pata.c     |    2 +-
 drivers/ide/pci/serverworks.c  |   16 ++++++++--------
 drivers/ide/pci/sgiioc4.c      |    2 +-
 drivers/ide/pci/siimage.c      |    1 -
 drivers/ide/pci/sis5513.c      |    1 -
 drivers/ide/pci/sl82c105.c     |    1 -
 drivers/ide/pci/slc90e66.c     |    1 -
 drivers/ide/pci/tc86c001.c     |    4 ++--
 drivers/ide/pci/triflex.c      |    1 -
 drivers/ide/pci/trm290.c       |    1 -
 drivers/ide/pci/via82cxxx.c    |    2 --
 drivers/ide/setup-pci.c        |    9 +++------
 include/linux/ide.h            |    6 +++---
 35 files changed, 25 insertions(+), 94 deletions(-)

Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -265,7 +265,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.init_setup	= init_setup_aec62xx,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= OFF_BOARD,
@@ -275,7 +274,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.init_setup	= init_setup_aec62xx,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
-		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.bootable	= OFF_BOARD,
 		.udma_mask	= 0x1f, /* udma0-4 */
@@ -284,7 +282,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.init_setup	= init_setup_aec62xx,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= NEVER_BOARD,
@@ -294,7 +291,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.init_setup	= init_setup_aec6x80,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.udma_mask	= 0x3f, /* udma0-5 */
@@ -303,7 +299,6 @@ static ide_pci_device_t aec62xx_chipsets
 		.init_setup	= init_setup_aec6x80,
 		.init_chipset	= init_chipset_aec62xx,
 		.init_hwif	= init_hwif_aec62xx,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= OFF_BOARD,
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -817,7 +817,6 @@ static ide_pci_device_t ali15x3_chipset 
 	.init_chipset	= init_chipset_ali15x3,
 	.init_hwif	= init_hwif_ali15x3,
 	.init_dma	= init_dma_ali15x3,
-	.channels	= 2,
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
 };
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -452,7 +452,6 @@ static void __devinit init_hwif_amd74xx(
 		.name		= name_str,				\
 		.init_chipset	= init_chipset_amd74xx,			\
 		.init_hwif	= init_hwif_amd74xx,			\
-		.channels	= 2,					\
 		.autodma	= AUTODMA,				\
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},	\
 		.bootable	= ON_BOARD,				\
@@ -463,7 +462,6 @@ static void __devinit init_hwif_amd74xx(
 		.name		= name_str,				\
 		.init_chipset	= init_chipset_amd74xx,			\
 		.init_hwif	= init_hwif_amd74xx,			\
-		.channels	= 2,					\
 		.autodma	= AUTODMA,				\
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},	\
 		.bootable	= ON_BOARD,				\
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -291,17 +291,16 @@ static ide_pci_device_t atiixp_pci_info[
 	{	/* 0 */
 		.name		= "ATIIXP",
 		.init_hwif	= init_hwif_atiixp,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x48,0x01,0x00}, {0x48,0x08,0x00}},
 		.bootable	= ON_BOARD,
 	},{	/* 1 */
 		.name		= "SB600_PATA",
 		.init_hwif	= init_hwif_atiixp,
-		.channels	= 1,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x48,0x01,0x00}, {0x00,0x00,0x00}},
  		.bootable	= ON_BOARD,
+ 		.host_flags	= IDE_HFLAG_SINGLE,
  	},
 };
 
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -622,7 +622,6 @@ static ide_pci_device_t cmd64x_chipsets[
 		.init_setup	= init_setup_cmd64x,
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
@@ -632,7 +631,6 @@ static ide_pci_device_t cmd64x_chipsets[
 		.init_setup	= init_setup_cmd646,
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
@@ -642,7 +640,6 @@ static ide_pci_device_t cmd64x_chipsets[
 		.init_setup	= init_setup_cmd64x,
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
@@ -652,7 +649,6 @@ static ide_pci_device_t cmd64x_chipsets[
 		.init_setup	= init_setup_cmd64x,
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -194,10 +194,9 @@ static void __devinit init_hwif_cs5520(i
 		.name		= name_str,			\
 		.init_setup_dma = cs5520_init_setup_dma,	\
 		.init_hwif	= init_hwif_cs5520,		\
-		.channels	= 2,				\
 		.autodma	= AUTODMA,			\
 		.bootable	= ON_BOARD,			\
-		.flags		= IDEPCI_FLAG_ISA_PORTS,	\
+		.host_flags	= IDE_HFLAG_ISA_PORTS,		\
 	}
 
 static ide_pci_device_t cyrix_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -341,7 +341,6 @@ static ide_pci_device_t cs5530_chipset _
 	.name		= "CS5530",
 	.init_chipset	= init_chipset_cs5530,
 	.init_hwif	= init_hwif_cs5530,
-	.channels	= 2,
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
 };
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -228,9 +228,9 @@ static void __devinit init_hwif_cs5535(i
 static ide_pci_device_t cs5535_chipset __devinitdata = {
 	.name		= "CS5535",
 	.init_hwif	= init_hwif_cs5535,
-	.channels	= 1,
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
+	.host_flags	= IDE_HFLAG_SINGLE,
 };
 
 static int __devinit cs5535_init_one(struct pci_dev *dev,
Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -483,9 +483,9 @@ static ide_pci_device_t cy82c693_chipset
 	.init_chipset	= init_chipset_cy82c693,
 	.init_iops	= init_iops_cy82c693,
 	.init_hwif	= init_hwif_cy82c693,
-	.channels	= 1,
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
+	.host_flags	= IDE_HFLAG_SINGLE,
 };
 
 static int __devinit cy82c693_init_one(struct pci_dev *dev, const struct pci_device_id *id)
Index: b/drivers/ide/pci/generic.c
===================================================================
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -95,92 +95,77 @@ static ide_pci_device_t generic_chipsets
 	{	/* 0 */
 		.name		= "Unknown",
 		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 1 */
 		.name		= "NS87410",
 		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x43,0x08,0x08}, {0x47,0x08,0x08}},
 		.bootable	= ON_BOARD,
         },{	/* 2 */
 		.name		= "SAMURAI",
 		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 3 */
 		.name		= "HT6565",
 		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 4 */
 		.name		= "UM8673F",
 		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
 		.autodma	= NODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 5 */
 		.name		= "UM8886A",
 		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
 		.autodma	= NODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 6 */
 		.name		= "UM8886BF",
 		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
 		.autodma	= NODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 7 */
 		.name		= "HINT_IDE",
 		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 8 */
 		.name		= "VIA_IDE",
 		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 9 */
 		.name		= "OPTI621V",
 		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 10 */
 		.name		= "VIA8237SATA",
 		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 	},{	/* 11 */
 		.name 		= "Piccolo0102",
 		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 12 */
 		.name 		= "Piccolo0103",
 		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 13 */
 		.name 		= "Piccolo0105",
 		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 14 */
 		.name		= "Revolution",
 		.init_hwif	= init_hwif_generic,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 	}
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -175,7 +175,6 @@ static ide_pci_device_t hpt34x_chipset _
 	.name		= "HPT34X",
 	.init_chipset	= init_chipset_hpt34x,
 	.init_hwif	= init_hwif_hpt34x,
-	.channels	= 2,
 	.autodma	= NOAUTODMA,
 	.bootable	= NEVER_BOARD,
 	.extra		= 16
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1490,7 +1490,7 @@ static int __devinit init_setup_hpt366(s
 		 * HPT36x chips are single channel and
 		 * do not seem to have the channel enable bit...
 		 */
-		d->channels = 1;
+		d->host_flags |= IDE_HFLAG_SINGLE;
 		d->enablebits[0].reg = 0;
 
 		d->udma_mask = HPT366_ALLOW_ATA66_3 ?
@@ -1545,7 +1545,6 @@ static ide_pci_device_t hpt366_chipsets[
 		.init_chipset	= init_chipset_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.bootable	= OFF_BOARD,
@@ -1556,7 +1555,6 @@ static ide_pci_device_t hpt366_chipsets[
 		.init_chipset	= init_chipset_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.udma_mask	= HPT372_ALLOW_ATA133_6 ? 0x7f : 0x3f,
@@ -1568,7 +1566,6 @@ static ide_pci_device_t hpt366_chipsets[
 		.init_chipset	= init_chipset_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.udma_mask	= HPT302_ALLOW_ATA133_6 ? 0x7f : 0x3f,
@@ -1580,7 +1577,6 @@ static ide_pci_device_t hpt366_chipsets[
 		.init_chipset	= init_chipset_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.udma_mask	= HPT371_ALLOW_ATA133_6 ? 0x7f : 0x3f,
@@ -1592,7 +1588,6 @@ static ide_pci_device_t hpt366_chipsets[
 		.init_chipset	= init_chipset_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
-		.channels	= 2,	/* 4 */
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.udma_mask	= 0x3f,
@@ -1604,7 +1599,6 @@ static ide_pci_device_t hpt366_chipsets[
 		.init_chipset	= init_chipset_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
-		.channels	= 2,	/* 4 */
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.udma_mask	= HPT372_ALLOW_ATA133_6 ? 0x7f : 0x3f,
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -272,10 +272,10 @@ static void __devinit init_hwif_it8213(i
 	{						\
 		.name		= name_str,		\
 		.init_hwif	= init_hwif_it8213,	\
-		.channels	= 1,			\
 		.autodma	= AUTODMA,		\
 		.enablebits	= {{0x41,0x80,0x80}}, \
 		.bootable	= ON_BOARD,		\
+		.host_flags	= IDE_HFLAG_SINGLE,	\
 	}
 
 static ide_pci_device_t it8213_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -719,7 +719,6 @@ static unsigned int __devinit init_chips
 		.name		= name_str,		\
 		.init_chipset	= init_chipset_it821x,	\
 		.init_hwif	= init_hwif_it821x,	\
-		.channels	= 2,			\
 		.autodma	= AUTODMA,		\
 		.bootable	= ON_BOARD,		\
 		.fixup	 	= it821x_fixups		\
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -177,7 +177,6 @@ fallback:
 	{						\
 		.name		= name_str,		\
 		.init_hwif	= init_hwif_jmicron,	\
-		.channels	= 2,			\
 		.autodma	= AUTODMA,		\
 		.bootable	= ON_BOARD,		\
 		.enablebits	= { {0x40, 1, 1}, {0x40, 0x10, 0x10} }, \
Index: b/drivers/ide/pci/ns87415.c
===================================================================
--- a/drivers/ide/pci/ns87415.c
+++ b/drivers/ide/pci/ns87415.c
@@ -281,7 +281,6 @@ static ide_pci_device_t ns87415_chipset 
 	.init_iops	= init_iops_ns87415,
 #endif
 	.init_hwif	= init_hwif_ns87415,
-	.channels	= 2,
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
 };
Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -350,14 +350,12 @@ static ide_pci_device_t opti621_chipsets
 	{	/* 0 */
 		.name		= "OPTI621",
 		.init_hwif	= init_hwif_opti621,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
 		.bootable	= ON_BOARD,
 	},{	/* 1 */
 		.name		= "OPTI621X",
 		.init_hwif	= init_hwif_opti621,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
 		.bootable	= ON_BOARD,
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -560,7 +560,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
 		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.udma_mask	= 0x3f, /* udma0-5 */
@@ -569,7 +568,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
 		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.udma_mask	= 0x7f, /* udma0-6*/
@@ -578,7 +576,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_setup	= init_setup_pdc20270,
 		.init_chipset	= init_chipset_pdcnew,
 		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.udma_mask	= 0x3f, /* udma0-5 */
@@ -587,7 +584,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
 		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.udma_mask	= 0x7f, /* udma0-6*/
@@ -596,7 +592,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
 		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.udma_mask	= 0x7f, /* udma0-6*/
@@ -605,7 +600,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_setup	= init_setup_pdc20276,
 		.init_chipset	= init_chipset_pdcnew,
 		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.udma_mask	= 0x7f, /* udma0-6*/
@@ -614,7 +608,6 @@ static ide_pci_device_t pdcnew_chipsets[
 		.init_setup	= init_setup_pdcnew,
 		.init_chipset	= init_chipset_pdcnew,
 		.init_hwif	= init_hwif_pdc202new,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.udma_mask	= 0x7f, /* udma0-6*/
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -441,7 +441,6 @@ static ide_pci_device_t pdc202xx_chipset
 		.init_chipset	= init_chipset_pdc202xx,
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 16,
@@ -452,7 +451,6 @@ static ide_pci_device_t pdc202xx_chipset
 		.init_chipset	= init_chipset_pdc202xx,
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
@@ -463,7 +461,6 @@ static ide_pci_device_t pdc202xx_chipset
 		.init_chipset	= init_chipset_pdc202xx,
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
@@ -474,7 +471,6 @@ static ide_pci_device_t pdc202xx_chipset
 		.init_chipset	= init_chipset_pdc202xx,
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
@@ -485,7 +481,6 @@ static ide_pci_device_t pdc202xx_chipset
 		.init_chipset	= init_chipset_pdc202xx,
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -495,7 +495,6 @@ static void __devinit init_hwif_piix(ide
 		.name		= name_str,		\
 		.init_chipset	= init_chipset_piix,	\
 		.init_hwif	= init_hwif_piix,	\
-		.channels	= 2,			\
 		.autodma	= AUTODMA,		\
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}}, \
 		.bootable	= ON_BOARD,		\
@@ -514,11 +513,10 @@ static ide_pci_device_t piix_pci_info[] 
 		 */
 		.name		= "MPIIX",
 		.init_hwif	= init_hwif_piix,
-		.channels	= 2,
 		.autodma	= NODMA,
 		.enablebits	= {{0x6d,0xc0,0x80}, {0x6d,0xc0,0xc0}},
 		.bootable	= ON_BOARD,
-		.flags		= IDEPCI_FLAG_ISA_PORTS
+		.host_flags	= IDE_HFLAG_ISA_PORTS,
 	},
 
 	/*  3 */ DECLARE_PIIX_DEV("PIIX3", 0x00),	/* no udma */
Index: b/drivers/ide/pci/rz1000.c
===================================================================
--- a/drivers/ide/pci/rz1000.c
+++ b/drivers/ide/pci/rz1000.c
@@ -52,7 +52,6 @@ static void __devinit init_hwif_rz1000 (
 static ide_pci_device_t rz1000_chipset __devinitdata = {
 	.name		= "RZ100x",
 	.init_hwif	= init_hwif_rz1000,
-	.channels	= 2,
 	.autodma	= NODMA,
 	.bootable	= ON_BOARD,
 };
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -471,7 +471,6 @@ static void __devinit init_hwif_sc1200 (
 static ide_pci_device_t sc1200_chipset __devinitdata = {
 	.name		= "SC1200",
 	.init_hwif	= init_hwif_sc1200,
-	.channels	= 2,
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
 };
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -731,9 +731,9 @@ static void __devinit init_hwif_scc(ide_
       .init_setup	= init_setup_scc,		\
       .init_iops	= init_iops_scc,		\
       .init_hwif	= init_hwif_scc,		\
-      .channels	= 1,					\
       .autodma	= AUTODMA,				\
       .bootable	= ON_BOARD,				\
+      .host_flags	= IDE_HFLAG_SINGLE,		\
   }
 
 static ide_pci_device_t scc_chipsets[] __devinitdata = {
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -448,9 +448,12 @@ static int __devinit init_setup_csb6 (st
 			d->bootable = ON_BOARD;
 	}
 
-	d->channels = ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE ||
-			dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2) &&
-		       (!(PCI_FUNC(dev->devfn) & 1))) ? 1 : 2;
+	if ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE ||
+	    dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2) &&
+	    (!(PCI_FUNC(dev->devfn) & 1)))
+		d->host_flags |= IDE_HFLAG_SINGLE;
+	else
+		d->host_flags &= ~IDE_HFLAG_SINGLE;
 
 	return ide_setup_pci_device(dev, d);
 }
@@ -461,7 +464,6 @@ static ide_pci_device_t serverworks_chip
 		.init_setup	= init_setup_svwks,
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 1 */
@@ -469,7 +471,6 @@ static ide_pci_device_t serverworks_chip
 		.init_setup	= init_setup_svwks,
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 2 */
@@ -477,7 +478,6 @@ static ide_pci_device_t serverworks_chip
 		.init_setup	= init_setup_csb6,
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
 	},{	/* 3 */
@@ -485,17 +485,17 @@ static ide_pci_device_t serverworks_chip
 		.init_setup	= init_setup_csb6,
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.channels	= 1,	/* 2 */
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_SINGLE,
 	},{	/* 4 */
 		.name		= "SvrWks HT1000",
 		.init_setup	= init_setup_svwks,
 		.init_chipset	= init_chipset_svwks,
 		.init_hwif	= init_hwif_svwks,
-		.channels	= 1,	/* 2 */
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
+		.host_flags	= IDE_HFLAG_SINGLE,
 	}
 };
 
Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -724,10 +724,10 @@ static ide_pci_device_t sgiioc4_chipset 
 	 .name = "SGIIOC4",
 	 .init_hwif = ide_init_sgiioc4,
 	 .init_dma = ide_dma_sgiioc4,
-	 .channels = 1,
 	 .autodma = AUTODMA,
 	 /* SGI IOC4 doesn't have enablebits. */
 	 .bootable = ON_BOARD,
+	 .host_flags = IDE_HFLAG_SINGLE,
 };
 
 int
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -980,7 +980,6 @@ static void __devinit init_hwif_siimage(
 		.init_iops	= init_iops_siimage,	\
 		.init_hwif	= init_hwif_siimage,	\
 		.fixup		= siimage_fixup,	\
-		.channels	= 2,			\
 		.autodma	= AUTODMA,		\
 		.bootable	= ON_BOARD,		\
 	}
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -882,7 +882,6 @@ static ide_pci_device_t sis5513_chipset 
 	.name		= "SIS5513",
 	.init_chipset	= init_chipset_sis5513,
 	.init_hwif	= init_hwif_sis5513,
-	.channels	= 2,
 	.autodma	= NOAUTODMA,
 	.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 	.bootable	= ON_BOARD,
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -455,7 +455,6 @@ static ide_pci_device_t sl82c105_chipset
 	.name		= "W82C105",
 	.init_chipset	= init_chipset_sl82c105,
 	.init_hwif	= init_hwif_sl82c105,
-	.channels	= 2,
 	.autodma	= NOAUTODMA,
 	.enablebits	= {{0x40,0x01,0x01}, {0x40,0x10,0x10}},
 	.bootable	= ON_BOARD,
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -214,7 +214,6 @@ static void __devinit init_hwif_slc90e66
 static ide_pci_device_t slc90e66_chipset __devinitdata = {
 	.name		= "SLC90E66",
 	.init_hwif	= init_hwif_slc90e66,
-	.channels	= 2,
 	.autodma	= AUTODMA,
 	.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 	.bootable	= ON_BOARD,
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -248,9 +248,9 @@ static ide_pci_device_t tc86c001_chipset
 	.name		= "TC86C001",
 	.init_chipset	= init_chipset_tc86c001,
 	.init_hwif	= init_hwif_tc86c001,
-	.channels	= 1,
 	.autodma	= AUTODMA,
-	.bootable	= OFF_BOARD
+	.bootable	= OFF_BOARD,
+	.host_flags	= IDE_HFLAG_SINGLE,
 };
 
 static int __devinit tc86c001_init_one(struct pci_dev *dev,
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -129,7 +129,6 @@ static void __devinit init_hwif_triflex(
 static ide_pci_device_t triflex_device __devinitdata = {
 	.name		= "TRIFLEX",
 	.init_hwif	= init_hwif_triflex,
-	.channels	= 2,
 	.autodma	= AUTODMA,
 	.enablebits	= {{0x80, 0x01, 0x01}, {0x80, 0x02, 0x02}},
 	.bootable	= ON_BOARD,
Index: b/drivers/ide/pci/trm290.c
===================================================================
--- a/drivers/ide/pci/trm290.c
+++ b/drivers/ide/pci/trm290.c
@@ -327,7 +327,6 @@ static void __devinit init_hwif_trm290(i
 static ide_pci_device_t trm290_chipset __devinitdata = {
 	.name		= "TRM290",
 	.init_hwif	= init_hwif_trm290,
-	.channels	= 2,
 	.autodma	= NOAUTODMA,
 	.bootable	= ON_BOARD,
 };
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -501,7 +501,6 @@ static ide_pci_device_t via82cxxx_chipse
 		.name		= "VP_IDE",
 		.init_chipset	= init_chipset_via82cxxx,
 		.init_hwif	= init_hwif_via82cxxx,
-		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD
@@ -509,7 +508,6 @@ static ide_pci_device_t via82cxxx_chipse
 		.name		= "VP_IDE",
 		.init_chipset	= init_chipset_via82cxxx,
 		.init_hwif	= init_hwif_via82cxxx,
-		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
 		.bootable	= ON_BOARD,
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -407,7 +407,7 @@ static ide_hwif_t *ide_hwif_configure(st
 	unsigned long ctl = 0, base = 0;
 	ide_hwif_t *hwif;
 
-	if ((d->flags & IDEPCI_FLAG_ISA_PORTS) == 0) {
+	if ((d->host_flags & IDE_HFLAG_ISA_PORTS) == 0) {
 		/*  Possibly we should fail if these checks report true */
 		ide_pci_check_iomem(dev, d, 2*port);
 		ide_pci_check_iomem(dev, d, 2*port+1);
@@ -571,7 +571,7 @@ out:
  
 void ide_pci_setup_ports(struct pci_dev *dev, ide_pci_device_t *d, int pciirq, ata_index_t *index)
 {
-	int port;
+	int channels = (d->host_flags & IDE_HFLAG_SINGLE) ? 1 : 2, port;
 	int at_least_one_hwif_enabled = 0;
 	ide_hwif_t *hwif, *mate = NULL;
 	u8 tmp;
@@ -582,16 +582,13 @@ void ide_pci_setup_ports(struct pci_dev 
 	 * Set up the IDE ports
 	 */
 	 
-	for (port = 0; port <= 1; ++port) {
+	for (port = 0; port < channels; ++port) {
 		ide_pci_enablebit_t *e = &(d->enablebits[port]);
 	
 		if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) ||
 		    (tmp & e->mask) != e->val))
 			continue;	/* port not enabled */
 
-		if (d->channels	<= port)
-			break;
-	
 		if ((hwif = ide_hwif_configure(dev, d, mate, port, pciirq)) == NULL)
 			continue;
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1244,7 +1244,8 @@ typedef struct ide_pci_enablebit_s {
 
 enum {
 	/* Uses ISA control ports not PCI ones. */
-	IDEPCI_FLAG_ISA_PORTS		= (1 << 0),
+	IDE_HFLAG_ISA_PORTS		= (1 << 0),
+	IDE_HFLAG_SINGLE		= (1 << 1),
 };
 
 typedef struct ide_pci_device_s {
@@ -1256,13 +1257,12 @@ typedef struct ide_pci_device_s {
 	void                    (*init_hwif)(ide_hwif_t *);
 	void			(*init_dma)(ide_hwif_t *, unsigned long);
 	void			(*fixup)(ide_hwif_t *);
-	u8			channels;
 	u8			autodma;
 	ide_pci_enablebit_t	enablebits[2];
 	u8			bootable;
 	unsigned int		extra;
 	struct ide_pci_device_s	*next;
-	u8			flags;
+	u8			host_flags;
 	u8			udma_mask;
 } ide_pci_device_t;
 
