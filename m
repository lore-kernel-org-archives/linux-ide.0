From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Au1200: kill IDE driver function prototypes
Date: Tue, 15 Apr 2008 22:54:34 +0200
Message-ID: <200804152254.34197.bzolnier@gmail.com>
References: <200804142228.51987.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:31989 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932771AbYDOVTx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 17:19:53 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2140209fgb.17
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2008 14:19:52 -0700 (PDT)
In-Reply-To: <200804142228.51987.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

On Monday 14 April 2008, Sergei Shtylyov wrote:
> Fix these warnings emitted when compiling drivers/ide/mips/au1xxx-ide.c:
> 
> include/asm/mach-au1x00/au1xxx_ide.h:137: warning: 'auide_tune_drive' declared 
> `static' but never defined
> include/asm/mach-au1x00/au1xxx_ide.h:138: warning: 'auide_tune_chipset' declared
>  `static' but never defined
> 
> by wiping out the whole "function prototyping" section from the header file
> <asm-mips/mach-au1x00/au1xxx_ide.h> as it mostly declared functions that are
> already dead in the IDE driver; move the only useful prototype into the driver.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied

> ---
> I'm not sure thru which tree this should go -- probably thru Linux/MIPS one...
> 
> Bart, au1xxx-ide-fix-mwdma-support.patch will probably need to be updated to
> remove that added prototype since it won't be needed anymore...

I would prefer to merge this patch thru IDE tree because of the above and
the fact that it only touches "IDE" files - I hope Ralf is fine with it.

>  drivers/ide/mips/au1xxx-ide.c             |    2 ++
>  include/asm-mips/mach-au1x00/au1xxx_ide.h |   18 ------------------
>  2 files changed, 2 insertions(+), 18 deletions(-)
