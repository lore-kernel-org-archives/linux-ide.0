From: Dario Oliva <anikami1@gmail.com>
Subject: Re: Infinite loop on MODE-SENSE with a removable ATAPI sata device
 on VIA chipset
Date: Fri, 12 May 2006 10:43:24 -0400
Message-ID: <44649F0C.5020405@gmail.com>
References: <E656D53DA4B96C409683999F573A360723E553@sbs.ARCO.local> <4462E5A5.2010703@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:42658 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932106AbWELOna (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 May 2006 10:43:30 -0400
Received: by py-out-1112.google.com with SMTP id x31so816794pye
        for <linux-ide@vger.kernel.org>; Fri, 12 May 2006 07:43:30 -0700 (PDT)
In-Reply-To: <4462E5A5.2010703@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: anikami1@gmail.com, Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, =?ISO-8859-1?Q?Reinhard_Brandst=E4dter?= <r.brandstaedter@gmx.at>

Albert Lee wrote:
> Dario Oliva wrote:
>
>> Attached are some kernel messeges. I ran dmesg several times and
>> appended the output to the attached file, so there may be some
>> redudancy. However some of the commands or debug lines do appear to
>> repeat themselves. As you requested, I changed "#undef ATA_DEBUG" to
>> "#define ATA_DEBUG".
>>
>> As far as the device is concerned, is an unreleased product of the
>> company I work for. That's why I did not give a name, because we don't
>> have an official name yet. But like I said, it is SATA, removalbe ATAPI.
>> If you want/need more information let me know.
>>
>
> Is the ATAPI device native SATA or PATA with some bridge chip used?
>
>> From the log, some MODE SENSE did work at first: (So, seems not 
>> DMADIR problem.)
>
> ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
> ata_sg_setup: 1 sg elements mapped
> ata_exec_command_pio: ata1: cmd 0xA0
> atapi_packet_task: busy wait
> atapi_packet_task: send cdb
> ata_host_intr: ata1: protocol 7 (dev_stat 0x50)  <= irq received. 
> ATAPI DMA ok
> sda: Write Protect is off
>
> ===============================================================
>
> Later, irq lost for the following MODE SENSE command:
>
> ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 1c
> ata_sg_setup: 1 sg elements mapped
> ata_exec_command_pio: ata1: cmd 0xA0
> atapi_packet_task: busy wait
> atapi_packet_task: send cdb
> ata_scsi_error: ENTER              <= timeout. ata_eng_timeout: ENTER
> ata_qc_timeout: ENTER
> ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x1   <= device is 
> still busy. The old EH doesn't reset the device.
> ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata_qc_timeout: EXIT
> ata_eng_timeout: EXIT
> ata_scsi_error: EXIT
> ====================================================================
>
> After the timeout, the device is in BUSY state and can't handle any 
> new commands.
> That's why the "infinite loop" seen. (Tejun's new EH can reset the 
> device and bring
> it back to work.)
>
> Don't know what caused the timeout. From the device status 0xd0, it seems
> the device is waiting for something (maybe data transfer?). It is not 
> irq lost
> because the irq is not yet generated when the device status is still 
> BUSY.
>
> Is it possible to attach a protocol analyzer to the SATA cable
> and check whether the ATAPI DMA data is actually transferred?
> Could you also post the dmesg log with ATA_DEBUG for the working 
> Intel/nVidia
> adapter? Maybe we can find some clue by comparing the problematic MODE 
> SENSE transation of both logs.
>
> I've done minimal testing with my VIA VT6421 + ATAPI but unable to 
> reproduce
> the problem.
>
> Thanks,
>
> Albert
>
>
I do have a protocol analyzer here at work and I can get such 
information. It may take me a while to get it for you. But I'll try to 
do it ASAP.

Dario
