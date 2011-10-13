From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] cy82c693: fix PCI device selection
Date: Thu, 13 Oct 2011 12:28:54 +0200
Message-ID: <201110131229.09178.bzolnier@gmail.com>
References: <201110111937.32501.bzolnier@gmail.com> <201110121652.10495.bzolnier@gmail.com> <20111012.150207.1100668688848833225.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111012.150207.1100668688848833225.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

David Miller wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Wed, 12 Oct 2011 16:52:10 +0200
> 
> > David Miller wrote:
> > 
> >> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >> Date: Tue, 11 Oct 2011 19:37:32 +0200
> >> 
> >> > While at it remove redundant pci_get_slot() call as cy82c693_init_one()
> >> > already takes care of keeping the reference on the second port's PCI
> >> > device.
> >> 
> >> Please do not submit unrelated changes with a bug fix, and as IDE is
> >> in long-term maintainence I would not accept a risky refinement like
> >> this anyways.
> > 
> > Removed code is just bogus, we cannot fail in ->set_pio_mode method.
> > 
> > Please take a look at the code:
> >  
> > -	/* select primary or secondary channel */
> > -	if (hwif->index > 0) {  /* drive is on the secondary channel */
> > -		dev = pci_get_slot(dev->bus, dev->devfn+1);
> > -		if (!dev) {
> > -			printk(KERN_ERR "%s: tune_drive: "
> > -				"Cannot find secondary interface!\n",
> > -				drive->name);
> > -			return;
> > -		}
> > -	}
> > 
> > Please apply the patch,
> 
> Sorry, I will not do that, please respin the patch with the unrelated
> pieces removed.  I don't care how obvious it is to you.
> 
> The IDE layer is not a place for refinements or simplifications any
> longer, I'm sorry if that isn't clear to you.

Calling pci_get_slot() inside ->set_pio_mode is a bug since this method
cannot fail but if you want to leave it as it is here is an updated patch:

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH v2] cy82c693: fix PCI device selection

Wrong PCI device may be selected by cy82c693_set_pio_mode() if modular
IDE host drivers are used and there are additional IDE PCI devices
installed in the system.  Fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cy82c693.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ide/cy82c693.c
===================================================================
--- a/drivers/ide/cy82c693.c
+++ b/drivers/ide/cy82c693.c
@@ -1,7 +1,7 @@
 /*
  *  Copyright (C) 1998-2000 Andreas S. Krebs (akrebs@altavista.net), Maintainer
  *  Copyright (C) 1998-2002 Andre Hedrick <andre@linux-ide.org>, Integrator
- *  Copyright (C) 2007-2010 Bartlomiej Zolnierkiewicz
+ *  Copyright (C) 2007-2011 Bartlomiej Zolnierkiewicz
  *
  * CYPRESS CY82C693 chipset IDE controller
  *
@@ -90,7 +90,7 @@ static void cy82c693_set_pio_mode(ide_hw
 	u8 time_16, time_8;
 
 	/* select primary or secondary channel */
-	if (hwif->index > 0) {  /* drive is on the secondary channel */
+	if (drive->dn > 1) {  /* drive is on the secondary channel */
 		dev = pci_get_slot(dev->bus, dev->devfn+1);
 		if (!dev) {
 			printk(KERN_ERR "%s: tune_drive: "
@@ -141,7 +141,7 @@ static void cy82c693_set_pio_mode(ide_hw
 		pci_write_config_byte(dev, CY82_IDE_SLAVE_IOW, time_16);
 		pci_write_config_byte(dev, CY82_IDE_SLAVE_8BIT, time_8);
 	}
-	if (hwif->index > 0)
+	if (drive->dn > 1)
 		pci_dev_put(dev);
 }
 
