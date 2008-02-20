From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] falconide: fix resources reservation
Date: Wed, 20 Feb 2008 21:03:09 +0100
Message-ID: <200802202103.09560.bzolnier@gmail.com>
References: <200802200150.26989.bzolnier@gmail.com> <Pine.LNX.4.64.0802201039520.19893@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932361AbYBTTt3@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0802201039520.19893@vixen.sonytel.be>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Michael Schmitz <schmitz@debian.org>
List-Id: linux-ide@vger.kernel.org

On Wednesday 20 February 2008, Geert Uytterhoeven wrote:
> On Wed, 20 Feb 2008, Bartlomiej Zolnierkiewicz wrote:
> > * Tell IDE layer to not manage resources by setting
> >   hwif->mmio flag and request resources in falconide_init().
> > 
> > * Use request_mem_region() for resources reservation.
> > 
> > * Use driver name for resources reservation.
> > 
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Michael Schmitz <schmitz@debian.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/legacy/falconide.c |    7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > Index: b/drivers/ide/legacy/falconide.c
> > ===================================================================
> > --- a/drivers/ide/legacy/falconide.c
> > +++ b/drivers/ide/legacy/falconide.c
> > @@ -22,6 +22,7 @@
> >  #include <asm/atariints.h>
> >  #include <asm/atari_stdma.h>
> >  
> > +#define DRV_NAME "falconide"
> >  
> >      /*
> >       *  Base of the IDE interface
> > @@ -74,6 +75,11 @@ static int __init falconide_init(void)
> >  
> >  	printk(KERN_INFO "ide: Falcon IDE controller\n");
> >  
> > +	if (!request_mem_region(ATA_HD_BASE, 0x40, DRV_NAME)) {
> > +		printk(KERN_ERR "%s: resources busy\n");
>                                  ^^
> Woops, missing parameter?

thanks, fixed

> pr_error()?

dunno...

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] falconide: fix resources reservation (take 2)

* Tell IDE layer to not manage resources by setting
  hwif->mmio flag and request resources in falconide_init().

* Use request_mem_region() for resources reservation.

* Use driver name for resources reservation.

v2:
* Fix missing printk() parameter. (Noticed by Geert Uytterhoeven)

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@debian.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/falconide.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ide/legacy/falconide.c
===================================================================
--- a/drivers/ide/legacy/falconide.c
+++ b/drivers/ide/legacy/falconide.c
@@ -22,6 +22,7 @@
 #include <asm/atariints.h>
 #include <asm/atari_stdma.h>
 
+#define DRV_NAME "falconide"
 
     /*
      *  Base of the IDE interface
@@ -74,6 +75,11 @@ static int __init falconide_init(void)
 
 	printk(KERN_INFO "ide: Falcon IDE controller\n");
 
+	if (!request_mem_region(ATA_HD_BASE, 0x40, DRV_NAME)) {
+		printk(KERN_ERR "%s: resources busy\n", DRV_NAME);
+		return -EBUSY;
+	}
+
 	falconide_setup_ports(&hw);
 
 	hwif = ide_find_port();
@@ -83,6 +89,7 @@ static int __init falconide_init(void)
 
 		ide_init_port_data(hwif, index);
 		ide_init_port_hw(hwif, &hw);
+		hwif->mmio = 1;
 
 		ide_get_lock(NULL, NULL);
 		ide_device_add(idx, NULL);
