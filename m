From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 12/15] ide: remove ->dma_master field from ide_hwif_t
Date: Thu, 04 Oct 2007 17:27:45 +0400
Message-ID: <4704EA51.3040707@ru.mvista.com>
References: <200710012339.39304.bzolnier@gmail.com> <200710020006.35156.bzolnier@gmail.com> <4701755C.4030906@garzik.org> <200710022324.01132.bzolnier@gmail.com> <47039024.3090705@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:46716 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753942AbXJDN2G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 09:28:06 -0400
In-Reply-To: <47039024.3090705@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello, I wrote:

>>>>>> * Convert cmd64x, hpt366 and pdc202xx_old host drivers to use
>>>>>>  pci_resource_start(hwif->pci_dev, 4) instead of hwif->dma_master.

>>>>> Before using pci_resource_start(), the code should check 
>>>>> pci_resource_len() to ensure it is the appropriate size.

>>>>> It would be very wise to ensure that 
>>>>> pci_resource_flags()&IORESOURCE_IO is true, too.

>>>> Sure but since the old code hasn't been doing these checks (old code
>>>> just did pci_resource_start() -> hwif->dma_base -> hwif->dma_master)
>>>> this is a separate issue from what the patch tries to achieve.

>>> Nonetheless this is duplicating an existing bug $N times... not ideal :)

>> The existing bug is that the methods converted to use 
>> pci_resource_start()
>> may be set in hwif instance and used even if the BAR4 is invalid.  
>> Therefore
>> the above patch is correct and it isn't duplicating the existing bug. :)

>> However I agree that all these pci_resource_start()s could be a bit 
>> confusing
>> so here is 'take 2'.

>    Yeah, they are.  Actually, I was thinking about such patch ~1.5 years 
> ago *but* using a different approach -- namely, hwif->extra_base.

    Yes, the code introducing this field was written with replacing dma_master 
by it in mind... It's a pity I haven't gotten around to it.

[...]

>> Index: b/drivers/ide/pci/hpt366.c
>> ===================================================================
>> --- a/drivers/ide/pci/hpt366.c
>> +++ b/drivers/ide/pci/hpt366.c
>> @@ -845,32 +845,33 @@ static int hpt374_ide_dma_end(ide_drive_

>    This just asks to be:

    No, it doesn't cause that way one would only break it.

>>  static void hpt3xxn_set_clock(ide_hwif_t *hwif, u8 mode)
>>  {
>     unsigned long base = hwif->extra_base;

    Sorry for a thinko. All offsets below shoud be really 0x6x, not 0x5x...

>     u8 scr2 = inb(base + 0x5b);
> 
>      if ((scr2 & 0x7f) == mode)
>          return;
> 
>      /* Tristate the bus */
>     outb(0x80, base + 0x53);
>     outb(0x80, base + 0x57);
> 
>      /* Switch clock and reset channels */
>     outb(mode, base + 0x5b);
>     outb(0xc0, base + 0x59);
> 
>      /*
>       * Reset the state machines.
>        * NOTE: avoid accidentally enabling the disabled channels.
>       */
>     outb(inb(base + 0x50) | 0x32, base + 0x50);
>     outb(inb(base + 0x54) | 0x32, base + 0x54);
> 
>      /* Complete reset */
>     outb(0x00, base + 0x59);
> 
>     /* Reconnect channels to bus */
>     outb(0x00, base + 0x53);
>     outb(0x00, base + 0x57);
> }

MBR, Sergei
