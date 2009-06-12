From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/9] cmd64x: implement clear_irq() method
Date: Fri, 12 Jun 2009 22:39:51 +0400
Message-ID: <4A32A0F7.3020101@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906102244.46334.sshtylyov@ru.mvista.com> <200906121816.58809.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33107 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754085AbZFLSjy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Jun 2009 14:39:54 -0400
In-Reply-To: <200906121816.58809.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Hi Sergei,
>
> This is a very nice series 

   Oh, I'm flattened. :-)

> and I would like to apply it immediately
> but unfortunately there is quite a few issues to be addressed first..
>   

   Sigh, it's a pity -- I'm now on vacation and won't be available since 
this Sunday... I should have posted it earlier of course. Will have to 
try to address your comments tomorrow then.

>> Convert the driver's two dma_end() methods into clear_irq() methods -- the
>> driver will now use the standard dma_end() method implementation, ide_dma_end().
>>
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>
>> ---
>> The patch is atop of ide-2.6.git 'for-next' branch.
>>
>>  drivers/ide/cmd64x.c |   31 +++++++++++++++++--------------
>>  1 files changed, 17 insertions(+), 14 deletions(-)
>>     
>
> [...]
>   
>> @@ -226,11 +226,10 @@ static void cmd64x_set_dma_mode(ide_driv
>>  		(void) pci_write_config_byte(dev, pciU, regU);
>>  }
>>  
>> -static int cmd648_dma_end(ide_drive_t *drive)
>> +static void cmd648_clear_irq(ide_drive_t *drive)
>>  {
>>  	ide_hwif_t *hwif	= drive->hwif;
>>  	unsigned long base	= hwif->dma_base - (hwif->channel * 8);
>>     
>
> Don't we need to check whether hwif->dma_base is valid now?
>   

   You're right, I have managed to overlook this. I'll change this to 
pci_resource_start() call instead...

> Also shouldn't this patch be done after fixing core code first?
>   

   Fixing what exactly, ide_timer_expiry()?

> [IOW this should be patch #5.5]
>   

   I don't see how this is connected to the fix but I can reorder if 
you'd prefer it this way.

MBR, Sergei


