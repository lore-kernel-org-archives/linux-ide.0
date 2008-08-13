From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: remove CONFIG_BLK_DEV_IDE config option
Date: Thu, 14 Aug 2008 00:09:26 +0200
Message-ID: <200808140009.26857.bzolnier@gmail.com>
References: <200808132323.02369.bzolnier@gmail.com> <20080813213149.GC7071@cs181140183.pp.htv.fi> <200808140005.03603.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:48652 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbYHMWMF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Aug 2008 18:12:05 -0400
Received: by mu-out-0910.google.com with SMTP id w8so248645mue.1
        for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 15:12:02 -0700 (PDT)
In-Reply-To: <200808140005.03603.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 14 August 2008, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 13 August 2008, Adrian Bunk wrote:
> > On Wed, Aug 13, 2008 at 11:23:02PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > Because hd.c was moved to drivers/block/ this config option
> > > is superfluous now and may be removed.
> > > 
> > > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > ---
> > >  drivers/ide/Kconfig |   38 ++------------------------------------
> > >  1 file changed, 2 insertions(+), 36 deletions(-)
> > >...
> > 
> > /me wonders why your patch doesn't touch drivers/ide/Makefile
> 
> This is a very good question...
> 
> v2 interdiff:

Now for real...  [ I need some sleep badly... ]

...
v2:
Fix drivers/ide/Makefile (noticed by Adrian Bunk).

Cc: Adrian Bunk <bunk@kernel.org>
...

only in patch2:
unchanged:
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -15,14 +15,14 @@ ide-core-$(CONFIG_BLK_DEV_IDEDMA)	+= ide
 ide-core-$(CONFIG_IDE_PROC_FS)		+= ide-proc.o
 ide-core-$(CONFIG_BLK_DEV_IDEACPI)	+= ide-acpi.o
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
+obj-$(CONFIG_IDE)			+= ide-core.o
 
 ifeq ($(CONFIG_IDE_ARM), y)
 	ide-arm-core-y += arm/ide_arm.o
 	obj-y += ide-arm-core.o
 endif
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= legacy/ pci/
+obj-$(CONFIG_IDE)			+= legacy/ pci/
 
 obj-$(CONFIG_IDEPCI_PCIBUS_ORDER)	+= ide-scan-pci.o
 
@@ -31,7 +31,7 @@ ifeq ($(CONFIG_BLK_DEV_CMD640), y)
 	obj-y += cmd640-core.o
 endif
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= ppc/
+obj-$(CONFIG_IDE)			+= ppc/
 obj-$(CONFIG_IDE_H8300)			+= h8300/
 obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
 obj-$(CONFIG_BLK_DEV_IDEPNP)		+= ide-pnp.o
@@ -54,4 +54,4 @@ ifeq ($(CONFIG_BLK_DEV_PLATFORM), y)
 	obj-y += ide-platform-core.o
 endif
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= arm/ mips/
+obj-$(CONFIG_IDE)			+= arm/ mips/
