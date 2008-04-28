From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix au1xxx-ide breakage
Date: Mon, 28 Apr 2008 23:42:04 +0200
Message-ID: <200804282342.04205.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:23096 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965772AbYD1V1t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Apr 2008 17:27:49 -0400
Received: by fg-out-1718.google.com with SMTP id l27so5100195fgb.17
        for <linux-ide@vger.kernel.org>; Mon, 28 Apr 2008 14:27:44 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>


On Monday 28 April 2008, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> > Fix these warnings emitted when compiling drivers/ide/mips/au1xxx-ide.c:
> 
> > include/asm/mach-au1x00/au1xxx_ide.h:137: warning: 'auide_tune_drive' declared 
> > `static' but never defined
> > include/asm/mach-au1x00/au1xxx_ide.h:138: warning: 'auide_tune_chipset' declared
> >  `static' but never defined
> 
> > by wiping out the whole "function prototyping" section from the header file
> > <asm-mips/mach-au1x00/au1xxx_ide.h> as it mostly declared functions that are
> > already dead in the IDE driver; move the only useful prototype into the driver.
> > 
> > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > ---
> > I'm not sure thru which tree this should go -- probably thru Linux/MIPS one...
> 
> > Bart, au1xxx-ide-fix-mwdma-support.patch will probably need to be updated to
> > remove that added prototype since it won't be needed anymore...
> 
>     Which you haven't done either in that patch or in 
> au1xxx-ide-use-init_dma-method.patch. So, face the consequences:
> 
> drivers/ide/mips/au1xxx-ide.c:456: error: conflicting types for 'auide_ddma_init'
> drivers/ide/mips/au1xxx-ide.c:51: error: previous declaration of
> 'auide_ddma_init' was here
> drivers/ide/mips/au1xxx-ide.c:456: error: conflicting types for 'auide_ddma_init'
> drivers/ide/mips/au1xxx-ide.c:51: error: previous declaration of
> 'auide_ddma_init' was here
> drivers/ide/mips/au1xxx-ide.c:51: warning: 'auide_ddma_init' used but never
> defined

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/mips/au1xxx-ide.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -48,8 +48,6 @@
 
 static _auide_hwif auide_hwif;
 
-static int auide_ddma_init(_auide_hwif *auide);
-
 #if defined(CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA)
 
 void auide_insw(unsigned long port, void *addr, u32 count)
