From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 01/18] ide: add ->read_sff_dma_status method
Date: Mon, 08 Sep 2008 02:26:55 +0400
Message-ID: <48C4552F.9070806@ru.mvista.com>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain> <200809032013.08489.bzolnier@gmail.com> <48C41A2E.8040907@ru.mvista.com> <200809072123.33695.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.mvista.com ([63.81.120.155]:18975 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755532AbYIGW1B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Sep 2008 18:27:01 -0400
In-Reply-To: <200809072123.33695.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>> static void ide_tf_load(ide_drive_t *drive, ide_task_t *task)
>>>>> {
>>>>> 	ide_hwif_t *hwif = drive->hwif;
>>>>> @@ -323,6 +331,8 @@ static void ata_output_data(ide_drive_t 
>>>>>
>>>>> void default_hwif_transport(ide_hwif_t *hwif)
>>>>> {
>>>>> +	hwif->read_sff_dma_status = ide_read_sff_dma_status;
>>>>> +
>>>>> 	hwif->tf_load	  = ide_tf_load;
>>>>> 	hwif->tf_read	  = ide_tf_read;
>>>>>           
>>>>    I also didn't understand the motivation behind putting this method 
>>>> together with the transport operations... IMO, DMA programming interface 
>>>> hardly has anything to do with transporting the data over IDE bus.
>>>>         
>>> The motivation was that hwif->dma_ops is not available yet when
>>> ->read_sff_dma_status is used in ide_pci_check_simplex().
>>>       
>>> However I agree that it should somehow find its way into ->dma_ops
>>> (as usual patches are stongly preffered :).
>>>       
>>     Unless I'm missing something changing the place where hwif->dma_ops is 
>> initialized to sff_dma_ops (along the lines it was changed for hwif->dma_base) 
>> seems pretty trivial, so I wonder why you didn't do it in the same patch...
>>     

   Ah, I forgot for a moment that there were two patches and it would 
have make no sense to do that in the patch that factored out 
ide_pci_check_simplex()... And then tre was a patch introducing 'struct 
ide_tp_ops' which incorporated the read_sff_dma_status() method.

> Indeed, it should be trivial now, one just needs to be careful to:
>
> * move 'if (d->dma_ops) ...' from ide_init_port() into
>   ->init_dma/ide_hwif_setup_dma()
>
> * unset ->dma_ops on ->init_dma/ide_hwif_setup_dma() failures
>   

   Sure.

> I guess I overlooked it ATM of making the patch (or the code evolved
> greatly in the meantime)...
>   

   I think I understand now: it's sticking read_sff_dma_status() method 
into 'struct ide_tp_ops' that was a wrong move that's worth undoing (by 
putting it where it really belongs).

> [ It is really time consuming and difficult to recall the every small
>   detail of every patch after few months (the patch was posted 10 weeks
>   

   Heh, as if it wasn't time consuming to untange that after a few 
months (when I'm suposed to spend time elsewhere :-)...

>   ago and merged 6 weeks ago)...  The most efficient way of handling
>   such issues upon discovery is with sending patches... ]
>   

    Sigh, I'll see what I can do in my currently very limieted time...

> Thanks,
> Bart
>   

MBR, Sergei


