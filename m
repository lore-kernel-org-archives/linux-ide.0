From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/6] ide: move SFF I/O code to ide-io-sff.c
Date: Mon, 19 Jan 2009 17:31:28 +0300
Message-ID: <49748EC0.1090503@ru.mvista.com>
References: <20090119130309.24745.40877.sendpatchset@localhost.localdomain> <20090119130322.24745.76137.sendpatchset@localhost.localdomain> <49748B95.9080105@ru.mvista.com> <200901191523.15240.bzolnier@gmail.com> <49748E43.4030009@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:53440 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751977AbZASOay (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 09:30:54 -0500
In-Reply-To: <49748E43.4030009@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, I wrote:

>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

>>>    Gah, what in the world is that SFF I/O code?

>>>> Index: b/drivers/ide/ide-io-sff.c
>>>> ===================================================================
>>>> --- /dev/null
>>>> +++ b/drivers/ide/ide-io-sff.c
>>>> @@ -0,0 +1,314 @@
>>>> +
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/ide.h>
>>>> +
>>>> +/*
>>>> + *    Conventional PIO operations for ATA devices
>>>> + */
>>>> +
>>>> +static u8 ide_inb(unsigned long port)
>>>> +{
>>>> +    return (u8) inb(port);
>>>> +}
>>>> +
>>>> +static void ide_outb(u8 val, unsigned long port)
>>>> +{
>>>> +    outb(val, port);
>>>> +}
>>>> +
>>>> +/*
>>>> + *    MMIO operations, typically used for SATA controllers
>>>> + */
>>>> +
>>>> +static u8 ide_mm_inb(unsigned long port)
>>>> +{
>>>> +    return (u8) readb((void __iomem *) port);
>>>> +}
>>>> +
>>>> +static void ide_mm_outb(u8 value, unsigned long port)
>>>> +{
>>>> +    writeb(value, (void __iomem *) port);
>>>> +}

>>>    Ah, I see. Can we finally stop abusing the SFF name? Or are we 
>>> bound to copy every mistake that libata has made? :-/

>> Please suggest a better name. :)

>> [ I'm also not happy with the naming but couldn't think of a better 
>> one. ]

>    Legacy perhaps?

    As in ide-io-legacy.c. I can also suggest ide-io-std.c, 
ide-io-trad[itional].c...

MBR, Sergei
