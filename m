From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Au1200: kill IDE driver function prototypes
Date: Mon, 28 Apr 2008 22:36:35 +0400
Message-ID: <48161933.5020200@ru.mvista.com>
References: <200804142228.51987.sshtylyov@ru.mvista.com> <4815DE95.9010107@ru.mvista.com> <200804282046.53474.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <200804282046.53474.bzolnier@gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>Fix these warnings emitted when compiling drivers/ide/mips/au1xxx-ide.c:

>>>include/asm/mach-au1x00/au1xxx_ide.h:137: warning: 'auide_tune_drive' declared 
>>>`static' but never defined
>>>include/asm/mach-au1x00/au1xxx_ide.h:138: warning: 'auide_tune_chipset' declared
>>> `static' but never defined

>>>by wiping out the whole "function prototyping" section from the header file
>>><asm-mips/mach-au1x00/au1xxx_ide.h> as it mostly declared functions that are
>>>already dead in the IDE driver; move the only useful prototype into the driver.

>>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>>---
>>>I'm not sure thru which tree this should go -- probably thru Linux/MIPS one...

>>>Bart, au1xxx-ide-fix-mwdma-support.patch will probably need to be updated to
>>>remove that added prototype since it won't be needed anymore...

>>    Which you haven't done either in that patch or in 
>>au1xxx-ide-use-init_dma-method.patch. So, face the consequences:

>>drivers/ide/mips/au1xxx-ide.c:456: error: conflicting types for 'auide_ddma_init'
>>drivers/ide/mips/au1xxx-ide.c:51: error: previous declaration of
>>'auide_ddma_init' was here
>>drivers/ide/mips/au1xxx-ide.c:456: error: conflicting types for 'auide_ddma_init'
>>drivers/ide/mips/au1xxx-ide.c:51: error: previous declaration of
>>'auide_ddma_init' was here
>>drivers/ide/mips/au1xxx-ide.c:51: warning: 'auide_ddma_init' used but never
>>defined

> Sorry for that, I remember taking a look at au1xxx-ide-fix-mwdma-support.patch
> and it was OK

    This patch was a fitting place to get rid of that proto since it removed 
the sole call because of which that proto was needed.

> (now I see that it was au1xxx-ide-use-init_dma-method.patch that
> needed an update).  I'll fix it in today's update.

    TIA.

> Thanks,
> Bart

MBR, Sergei
