From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH, review] IDE driver for MIPS Toshiba RBTX4939
Date: Wed, 31 May 2006 22:23:29 +0400
Message-ID: <447DDF21.4060509@ru.mvista.com>
References: <20050929162228.GS18074@smtp.west.cox.net> <58cb370e0510030917q2bcb1790g6b9cd0456525bfae@mail.gmail.com> <447DD363.1070206@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:15773 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751775AbWEaSYZ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 14:24:25 -0400
In-Reply-To: <447DD363.1070206@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hello, I wrote:

>>> Hello.  I'm submitting, mainly for review (questions, comments, etc) the
>>> IDE driver for the MIPS-based Toshiba RBTX4939.  In some private emails
>>> with Bartlomiej about the ide-dma changes, I understand there's at least
>>> one problem with the driver (happy to fix with a pointer to a good
>>> example).  And I see real quickly there's a few style things a
>>> Lindent'ing would fix.  Thanks.

>>> Signed-off-by: Hiroshi DOYU <hdoyu@mvista.com>
>>> Signed-off-by: Tom Rini <trini@kernel.crashing.org>

>>> Index: linux-2.6.10/drivers/ide/ide-cd.c
>>> ===================================================================
>>> --- linux-2.6.10.orig/drivers/ide/ide-cd.c
>>> +++ linux-2.6.10/drivers/ide/ide-cd.c
>>> @@ -678,6 +678,13 @@ static int cdrom_decode_status(ide_drive
>>>        err = HWIF(drive)->INB(IDE_ERROR_REG);
>>>        sense_key = err >> 4;
>>>
>>> +#if defined(CONFIG_BLK_DEV_IDE_TX4939)
>>> +        if (IS_IDE_TX4939) {
>>> +               extern void tx4939_ide_softreset(ide_drive_t*);
>>> +               tx4939_ide_softreset(drive);
>>> +        }
>>> +#endif
>>> +

>> Why is this needed?

    The datasheet says only about the DMA transfer being stopped by a bus 
error case. So, who knows? I'm afraid, even Toshiba engineers don't... :-)

>>> Index: linux-2.6.10/drivers/ide/mips/ide-tx4939.c
>>> ===================================================================
>>> --- /dev/null
>>> +++ linux-2.6.10/drivers/ide/mips/ide-tx4939.c

>>> +       sc_port = (!is_slave) ?
>>> +               data_port + TX4939_ATA_SYSTEM_CONTROL1_OFFSET :
>>> +               data_port + TX4939_ATA_SYSTEM_CONTROL2_OFFSET;
>>> +
>>> +       if (!hwif->channel) {   /* primary */

>> Why only primary channel is tuned?

>    You won't believe: it's single channel, and that's how Toshiba deals 
> with this. :-)

    Worse, it's dual channel. Then I have no idea other than that this was 
copied from another driver for the single-channel chip (I've seen such code 
already). Oh, horror... :-/

>    Worse still: this controller has only _one_ timing register for both 
> master and slave, and doesn't define selectproc!

    BTW, the datasheet is contradictory here. The register map has 2 system 
control regs per channel, while ATAP setcion says about the single one, and 
warns that it must be changed with every change of DEV bit...

> Though wait, they 
> prefer to handle this in tx4939_ide_outb(). The driver seems even more 
> broken-minded than I initially thought... And that tuneproc() stupidity 
> where they're clearing the  DMA mode...

    Well, this is not as stupid, DMA mode should be off anyway...

MBR, Sergei
