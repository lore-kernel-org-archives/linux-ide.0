From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide/arm/bast-ide.c compile error
Date: Sat, 9 Feb 2008 19:05:24 +0100
Message-ID: <200802091905.24827.bzolnier@gmail.com>
References: <20080209001515.GF6505@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:9522 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbYBIRwR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Feb 2008 12:52:17 -0500
Received: by an-out-0708.google.com with SMTP id d31so997255and.103
        for <linux-ide@vger.kernel.org>; Sat, 09 Feb 2008 09:52:13 -0800 (PST)
In-Reply-To: <20080209001515.GF6505@cs181133002.pp.htv.fi>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: rmk@arm.linux.org.uk, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 09 February 2008, Adrian Bunk wrote:
> Commit 9e016a719209d95338e314b46c3012cc7feaaeec causes the following 
> compile error:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/ide/arm/bast-ide.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/arm/bast-ide.c: In function 'bastide_register':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/arm/bast-ide.c:31: error: 'hwif' redeclared as different kind of symbol
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/arm/bast-ide.c:29: error: previous definition of 'hwif' was here
> make[4]: *** [drivers/ide/arm/bast-ide.o] Error 1
> 
> <--  snip  -->

OK, I suck big time...

I didn't try to compile bast-ide ARM host driver and I overlooked this:

static int __init
bastide_register(unsigned int base, unsigned int aux, int irq,
		 ide_hwif_t **hwif)
{
	ide_hwif_t *hwif;

patch below...


From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] bast-ide: build fix

On Saturday 09 February 2008, Adrian Bunk wrote:
> Commit 9e016a719209d95338e314b46c3012cc7feaaeec causes the following 
> compile error:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/ide/arm/bast-ide.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/arm/bast-ide.c: In function 'bastide_register':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/arm/bast-ide.c:31: error: 'hwif' redeclared as different kind of symbol
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/ide/arm/bast-ide.c:29: error: previous definition of 'hwif' was here
> make[4]: *** [drivers/ide/arm/bast-ide.o] Error 1
> 
> <--  snip  -->

Remove 'ide_hwif_t **hwif' argument from bastide_register()
(together with write-only ifs[]).

Cc: Adrian Bunk <bunk@kernel.org>
Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/bast-ide.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

Index: b/drivers/ide/arm/bast-ide.c
===================================================================
--- a/drivers/ide/arm/bast-ide.c
+++ b/drivers/ide/arm/bast-ide.c
@@ -21,12 +21,7 @@
 #include <asm/arch/bast-map.h>
 #include <asm/arch/bast-irq.h>
 
-/* list of registered interfaces */
-static ide_hwif_t *ifs[2];
-
-static int __init
-bastide_register(unsigned int base, unsigned int aux, int irq,
-		 ide_hwif_t **hwif)
+static int __init bastide_register(unsigned int base, unsigned int aux, int irq)
 {
 	ide_hwif_t *hwif;
 	hw_regs_t hw;
@@ -76,8 +71,9 @@ static int __init bastide_init(void)
 
 	printk("BAST: IDE driver, (c) 2003-2004 Simtec Electronics\n");
 
-	bastide_register(BAST_VA_IDEPRI, BAST_VA_IDEPRIAUX, IRQ_IDE0, &ifs[0]);
-	bastide_register(BAST_VA_IDESEC, BAST_VA_IDESECAUX, IRQ_IDE1, &ifs[1]);
+	bastide_register(BAST_VA_IDEPRI, BAST_VA_IDEPRIAUX, IRQ_IDE0);
+	bastide_register(BAST_VA_IDESEC, BAST_VA_IDESECAUX, IRQ_IDE1);
+
 	return 0;
 }
 

