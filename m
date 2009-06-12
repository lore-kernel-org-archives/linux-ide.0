From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/9] ide: move IRQ clearing from ack_intr() method to
 clear_irq() method
Date: Fri, 12 Jun 2009 23:17:27 +0400
Message-ID: <4A32A9C7.8020200@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906121818.52719.bzolnier@gmail.com> <4A329D7A.2080305@ru.mvista.com> <200906122048.08585.bzolnier@gmail.com> <4A32A776.1080809@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33917 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751918AbZFLTRa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Jun 2009 15:17:30 -0400
In-Reply-To: <4A32A776.1080809@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hello, I wrote:

>>>>> There are now two methods that clear the port interrupt: 
>>>>> ack_intr() method,
>>>>> implemented only on M680x0 machines, that is called at the start 
>>>>> of ide_intr(),
>>>>> and clear_irq() method, that is called somewhat later in this 
>>>>> function.  In
>>>>> order to stop this duplication, delegate the task of clearing the 
>>>>> interrupt
>>>>> to clear_irq() method, only leaving to ack_intr() the task of 
>>>>> testing for the
>>>>> port interrupt.  This involves moving clear_irq() method call in 
>>>>> ide_intr()
>>>>> closer to the beginning of the function and removing ack_intr() 
>>>>> method call
>>>>> in ide_timer_expiry(), now becoming useless...
>>>>>
>>>>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>>>>
>>>>> ---
>>>>> The patch is atop of ide-2.6.git 'for-next' branch.
>>>>>
>>>>>  drivers/ide/gayle.c  |   23 +++++++++++------------
>>>>>  drivers/ide/ide-io.c |   11 ++++-------
>>>>>  drivers/ide/macide.c |   18 ++++++++++++++----
>>>>>  3 files changed, 29 insertions(+), 23 deletions(-)
>>>>>
>>>>> Index: ide-2.6/drivers/ide/gayle.c
>>>>> ===================================================================
>>>>> --- ide-2.6.orig/drivers/ide/gayle.c
>>>>> +++ ide-2.6/drivers/ide/gayle.c
>>>>> @@ -66,7 +66,7 @@ MODULE_PARM_DESC(doubler, "enable suppor
>>>>>       *  Check and acknowledge the interrupt status
>>>>>       */
>>>>>  
>>>>> -static int gayle_ack_intr_a4000(ide_hwif_t *hwif)
>>>>> +static int gayle_ack_intr(ide_hwif_t *hwif)
>>>>>  {
>>>>>      unsigned char ch;
>>>>>  
>>>>> @@ -76,16 +76,12 @@ static int gayle_ack_intr_a4000(ide_hwif
>>>>>      return 1;
>>>>>  }
>>>>>  
>>>>> -static int gayle_ack_intr_a1200(ide_hwif_t *hwif)
>>>>> +static void gayle_a1200_clear_irq(ide_drive_t *drive)
>>>>>  {
>>>>> -    unsigned char ch;
>>>>> +    ide_hwif_t *hwif = drive->hwif;
>>>>>  
>>>>> -    ch = z_readb(hwif->io_ports.irq_addr);
>>>>> -    if (!(ch & GAYLE_IRQ_IDE))
>>>>> -    return 0;
>>>>>      (void)z_readb(hwif->io_ports.status_addr);
>>>>>      z_writeb(0x7c, hwif->io_ports.irq_addr);
>>>>> -    return 1;
>>>>>  }
>>>>>             
>>>> buddha.c needs a similar treatment
>>>>         
>>>    Do you mean this fragment of xsurf_ack_intr()?
>>>     
>>
>> Yes.
>>   
>
>  OK, I'm taking your word for it.
>
>>>     /* X-Surf needs a 0 written to IRQ register to ensure ISA bit 
>>> A11 stays at 0 */
>>>     z_writeb(0, hwif->io_ports.irq_addr);
>>>     
>
>   Ah, that's "A11", not "All"

   Haven't finished writing... if this is really here only to clear A11, 
I somewhat doubt that I need to modify this...

MBR, Sergei


