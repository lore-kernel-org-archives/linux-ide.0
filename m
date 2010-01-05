From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] ide: add __init/__exit macros to drivers/ide/scc_pata.c
Date: Tue, 5 Jan 2010 19:39:07 +0100
Message-ID: <201001051939.07756.bzolnier@gmail.com>
References: <1261470564-23754-1-git-send-email-peterhuewe@gmx.de> <1261470564-23754-2-git-send-email-peterhuewe@gmx.de> <alpine.LNX.2.00.1001051124150.2277@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755328Ab0AETCJ@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1001051124150.2277@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Peter Huewe <peterhuewe@gmx.de>, kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tuesday 05 January 2010 11:25:13 am Jiri Kosina wrote:
> On Tue, 22 Dec 2009, peterhuewe@gmx.de wrote:
> 
> > From: Peter Huewe <peterhuewe@gmx.de>
> > 
> > Trivial patch which adds the __init/__exit macros to the module_init/
> > module_exit functions of
> > 
> > drivers/ide/scc_pata.c
> > 
> > Please have a look at the small patch and either pull it through
> > your tree, or please ack' it so Jiri can pull it through the trivial
> > tree.
> > 
> > Patch against linux-next-tree, 22. Dez 08:38:18 CET 2009
> > but also present in linus tree.
> > 
> > Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> > ---
> >  drivers/ide/scc_pata.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ide/scc_pata.c b/drivers/ide/scc_pata.c
> > index 1104bb3..58c9c91 100644
> > --- a/drivers/ide/scc_pata.c
> > +++ b/drivers/ide/scc_pata.c
> > @@ -872,14 +872,14 @@ static struct pci_driver scc_pci_driver = {
> >  	.remove = __devexit_p(scc_remove),
> >  };
> >  
> > -static int scc_ide_init(void)
> > +static int __init scc_ide_init(void)
> >  {
> >  	return ide_pci_register_driver(&scc_pci_driver);
> >  }
> >  
> >  module_init(scc_ide_init);
> >  /* -- No exit code?
> > -static void scc_ide_exit(void)
> > +static void __exit scc_ide_exit(void)
> >  {
> >  	ide_pci_unregister_driver(&scc_pci_driver);
> >  }
> 
> This code is commented out anyway. So we should either nuke it out 
> completely if it is not needed, or uncomment and fix.
> 
> Bartlomiej, David?

We can fix it nowadays, though I worry that by fixing it we may be 'creating
competition' for 'officially blessed yet unmaintained' PATA stack... 8-)

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] scc_pata: fix module unloading

scc_pata host driver predated module unloading support for IDE host
drivers so even though it supports PCI hot-unplug and implements
PCI device ->remove method it doesn't allow module removal.  Fix it.

Add missing __init/__exit tags to module_init/module_exit functions
while at it (from Peter Huewe).

Noticed-by: Jiri Kosina <jkosina@suse.cz>
Cc: Peter Huewe <peterhuewe@gmx.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/scc_pata.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

Index: b/drivers/ide/scc_pata.c
===================================================================
--- a/drivers/ide/scc_pata.c
+++ b/drivers/ide/scc_pata.c
@@ -872,20 +872,18 @@ static struct pci_driver scc_pci_driver
 	.remove = __devexit_p(scc_remove),
 };
 
-static int scc_ide_init(void)
+static int __init scc_ide_init(void)
 {
 	return ide_pci_register_driver(&scc_pci_driver);
 }
 
-module_init(scc_ide_init);
-/* -- No exit code?
-static void scc_ide_exit(void)
+static void __exit scc_ide_exit(void)
 {
-	ide_pci_unregister_driver(&scc_pci_driver);
+	pci_unregister_driver(&scc_pci_driver);
 }
-module_exit(scc_ide_exit);
- */
 
+module_init(scc_ide_init);
+module_exit(scc_ide_exit);
 
 MODULE_DESCRIPTION("PCI driver module for Toshiba SCC IDE");
 MODULE_LICENSE("GPL");
