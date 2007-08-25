From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [Bugme-new] [Bug 8936] New: sata_promise 2.09 fails to identify ST3400832AS
Date: Sat, 25 Aug 2007 19:12:31 +0200 (MEST)
Message-ID: <200708251712.l7PHCV45008981@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:44310 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028AbXHYRN7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Aug 2007 13:13:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org, linux-ide@vger.kernel.org, michal.k.k.piotrowski@gmail.com, mikpe@it.uu.se, sziemba@ecn.purdue.edu
Cc: bugme-daemon@bugzilla.kernel.org

On Fri, 24 Aug 2007 22:21:47 -0700, Andrew Morton wrote:
> On Fri, 24 Aug 2007 21:14:49 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=8936
> > 
> >            Summary: sata_promise 2.09 fails to identify ST3400832AS
> >            Product: IO/Storage
> >            Version: 2.5
> >      KernelVersion: 2.6.23-rc1
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: high
> >           Priority: P1
> >          Component: Serial ATA
> >         AssignedTo: jgarzik@pobox.com
> >         ReportedBy: sziemba@ecn.purdue.edu
> > 
> > 
> > Most recent kernel where this bug did not occur: 2.6.22 
> > 
> > Using git bisect I have identified the first bad commit.
> > 
> > linux-2.6# git bisect good
> > a77720ad0a4049e4bc6355e4febf899966a48222 is first bad commit
> > commit a77720ad0a4049e4bc6355e4febf899966a48222
> > Author: Mikael Pettersson <mikpe@it.uu.se>
> > Date:   Tue Jul 3 01:09:05 2007 +0200
> > 
> > Distribution: Debian etch (stable)
> > 
> > Hardware Environment: Sun Fire x4100
> > (http://www.crocom.com.pl/ulotki/X4100.pdf)
> > 8 ST3400832AS drives connected to Promise FastTrak TX4200
> > 2 ST973401LSUN72G drives connected to on board Fusion SAS
> > 
> > Software Environment:
> > Problem Description:  
> > 
> > I will attach dmesg output, hdparm and lspci.  I have tried acpi=noirq, noapic,
> >  irqpoll and pci=routeirq.  The drives connected to promise controller fail to
> > identify.  The dmesg for rc-3 with sata_promise 2.09 is truncated as the kernel
> > loops indefinitely.  Replacing sata_promise.c with version 2.08 from previous
> > kernels allows 2.6.23-rc3 to boot (with some warnings during compile/boot).
> > 
> > Steps to reproduce:  Boot the machine with the promise card connected.
> > 
> 
> Thanks for doing the bisection - it really helps.
> 
> Michal, one for the regression file, please.
> 
> Mikael: tsk ;)

According to the lspci the boards are FastTrak TX4200 with DID 0x3519.
Unfortunately these aren't publicly documented, but judging from what
little information there is in Promise's partial-source FT TX4200 driver,
DID 0x3519 is a second-generation chip.

However, sata_promise.c declares it as a first-generation chip, which
changes some details. This didn't matter too much before, but with the
hotplug changes in 2.6.23-rc1, it matters more because the location of
the SATA hotplug register is different in 1st and 2nd generation chips.
(There are also some "failed to resume link for reset" errors with the
2.08 driver that may be caused by the 1st-vs-2nd generation confusion.)

I suspect that correcting the driver to mark DID 0x3515/0x3519 as
2nd-generation should fix the problem. The patch below does just that;
please try it and let us know if it makes any difference.

/Mikael

--- linux-2.6.23-rc3/drivers/ata/sata_promise.c.~1~	2007-08-18 21:51:23.000000000 +0200
+++ linux-2.6.23-rc3/drivers/ata/sata_promise.c	2007-08-25 18:55:37.000000000 +0200
@@ -45,7 +45,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"2.09"
+#define DRV_VERSION	"2.10"
 
 enum {
 	PDC_MAX_PORTS		= 4,
@@ -328,8 +328,8 @@ static const struct pci_device_id pdc_at
 
 	{ PCI_VDEVICE(PROMISE, 0x3318), board_20319 },
 	{ PCI_VDEVICE(PROMISE, 0x3319), board_20319 },
-	{ PCI_VDEVICE(PROMISE, 0x3515), board_20319 },
-	{ PCI_VDEVICE(PROMISE, 0x3519), board_20319 },
+	{ PCI_VDEVICE(PROMISE, 0x3515), board_40518 },
+	{ PCI_VDEVICE(PROMISE, 0x3519), board_40518 },
 	{ PCI_VDEVICE(PROMISE, 0x3d17), board_40518 },
 	{ PCI_VDEVICE(PROMISE, 0x3d18), board_40518 },
 
