From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Au1200: kill IDE driver function prototypes
Date: Mon, 28 Apr 2008 18:26:29 +0400
Message-ID: <4815DE95.9010107@ru.mvista.com>
References: <200804142228.51987.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5085 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1765164AbYD1O1J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Apr 2008 10:27:09 -0400
In-Reply-To: <200804142228.51987.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org

Hello, I wrote:

> Fix these warnings emitted when compiling drivers/ide/mips/au1xxx-ide.c:

> include/asm/mach-au1x00/au1xxx_ide.h:137: warning: 'auide_tune_drive' declared 
> `static' but never defined
> include/asm/mach-au1x00/au1xxx_ide.h:138: warning: 'auide_tune_chipset' declared
>  `static' but never defined

> by wiping out the whole "function prototyping" section from the header file
> <asm-mips/mach-au1x00/au1xxx_ide.h> as it mostly declared functions that are
> already dead in the IDE driver; move the only useful prototype into the driver.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> I'm not sure thru which tree this should go -- probably thru Linux/MIPS one...

> Bart, au1xxx-ide-fix-mwdma-support.patch will probably need to be updated to
> remove that added prototype since it won't be needed anymore...

    Which you haven't done either in that patch or in 
au1xxx-ide-use-init_dma-method.patch. So, face the consequences:

drivers/ide/mips/au1xxx-ide.c:456: error: conflicting types for 'auide_ddma_init'
drivers/ide/mips/au1xxx-ide.c:51: error: previous declaration of
'auide_ddma_init' was here
drivers/ide/mips/au1xxx-ide.c:456: error: conflicting types for 'auide_ddma_init'
drivers/ide/mips/au1xxx-ide.c:51: error: previous declaration of
'auide_ddma_init' was here
drivers/ide/mips/au1xxx-ide.c:51: warning: 'auide_ddma_init' used but never
defined

MBR, Sergei
