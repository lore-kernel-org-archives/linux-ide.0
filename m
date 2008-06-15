From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [m68k] drivers/ide/ide-taskfile.c:235: error: implicit declaration of function 'sg_page'
Date: Sun, 15 Jun 2008 16:50:32 +0200
Message-ID: <200806151650.33323.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0806151538160.5736@anakin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:21728 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758025AbYFOOt2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Jun 2008 10:49:28 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2909279ywe.1
        for <linux-ide@vger.kernel.org>; Sun, 15 Jun 2008 07:49:23 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0806151538160.5736@anakin>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org, linux-next@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>


Hi,

On Sunday 15 June 2008, Geert Uytterhoeven wrote:
> 	Hi Bart,
> 
> As of June 12, drivers/ide/ide-taskfile.c fails to compile on m68k in
> linux-next:
> 
> | drivers/ide/ide-taskfile.c:235: error: implicit declaration of function 'sg_page'
> | drivers/ide/ide-taskfile.c:251: error: implicit declaration of function 'sg_next'
> | distcc[17810] ERROR: compile drivers/ide/ide-taskfile.c on localhost failed
> | make[3]: *** [drivers/ide/ide-taskfile.o] Error 1
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/31729/
> 
> I suspect http://git.kernel.org/?p=linux/kernel/git/sfr/linux-next.git;a=commitdiff;h=52cc802c0f45d8c15b20025e0fecf84174797307 is too blame:
> 
> | ide: remove needless includes from ide-taskfile.c
> 
> | -#include <linux/scatterlist.h>
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> As ide-taskfile.c uses scatterlists, it should include <linux/scatterlist.h>.

Yep, obvious bug (sorry for it), fixed in IDE tree now.

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove needless includes from ide-taskfile.c (take 2)

v2:

On Sunday 15 June 2008, Geert Uytterhoeven wrote:
> As ide-taskfile.c uses scatterlists, it should include <linux/scatterlist.h>.

(v1 broke IDE build on m68k, thanks to Geert for finding the bug)

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |   10 ----------
 1 file changed, 10 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -8,28 +8,18 @@
  *  The big the bad and the ugly.
  */
 
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
-#include <linux/major.h>
 #include <linux/errno.h>
-#include <linux/genhd.h>
-#include <linux/blkpg.h>
 #include <linux/slab.h>
-#include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/hdreg.h>
 #include <linux/ide.h>
-#include <linux/bitops.h>
 #include <linux/scatterlist.h>
 
-#include <asm/byteorder.h>
-#include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
