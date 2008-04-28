From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Au1200: kill IDE driver function prototypes
Date: Mon, 28 Apr 2008 20:46:53 +0200
Message-ID: <200804282046.53474.bzolnier@gmail.com>
References: <200804142228.51987.sshtylyov@ru.mvista.com> <4815DE95.9010107@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:32817 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965858AbYD1Sao (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Apr 2008 14:30:44 -0400
Received: by fg-out-1718.google.com with SMTP id l27so5041985fgb.17
        for <linux-ide@vger.kernel.org>; Mon, 28 Apr 2008 11:30:37 -0700 (PDT)
In-Reply-To: <4815DE95.9010107@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org


Hello,

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

Sorry for that, I remember taking a look at au1xxx-ide-fix-mwdma-support.patch
and it was OK (now I see that it was au1xxx-ide-use-init_dma-method.patch that
needed an update).  I'll fix it in today's update.

Thanks,
Bart
