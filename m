From: Dario Oliva <anikami1@gmail.com>
Subject: Re: Infinite loop on MODE-SENSE with a removable ATAPI sata device
 on VIA chipset
Date: Wed, 14 Jun 2006 17:30:16 -0400
Message-ID: <44907FE8.5050806@gmail.com>
References: <E656D53DA4B96C409683999F573A360723E553@sbs.ARCO.local> <4462E5A5.2010703@tw.ibm.com> <448DD8C5.2010000@gmail.com> <448F72F5.2060907@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:50256 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932360AbWFNVaW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jun 2006 17:30:22 -0400
Received: by py-out-1112.google.com with SMTP id i49so43613pye
        for <linux-ide@vger.kernel.org>; Wed, 14 Jun 2006 14:30:21 -0700 (PDT)
In-Reply-To: <448F72F5.2060907@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: linux-ide@vger.kernel.org

Albert Lee wrote:
> Dario Oliva wrote:
>   
>> Albert Lee wrote:
>>
>>     
>>> Dario Oliva wrote:
>>>
>>>       
>>>> Attached are some kernel messeges. I ran dmesg several times and
>>>> appended the output to the attached file, so there may be some
>>>> redudancy. However some of the commands or debug lines do appear to
>>>> repeat themselves. As you requested, I changed "#undef ATA_DEBUG" to
>>>> "#define ATA_DEBUG".
>>>>
>>>> As far as the device is concerned, is an unreleased product of the
>>>> company I work for. That's why I did not give a name, because we don't
>>>> have an official name yet. But like I said, it is SATA, removalbe ATAPI.
>>>> If you want/need more information let me know.
>>>>
>>>>         
>>> Is the ATAPI device native SATA or PATA with some bridge chip used?
>>>
>>>       
>>>> From the log, some MODE SENSE did work at first: (So, seems not
>>>> DMADIR problem.)
>>>>         
>>> ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
>>> ata_sg_setup: 1 sg elements mapped
>>> ata_exec_command_pio: ata1: cmd 0xA0
>>> atapi_packet_task: busy wait
>>> atapi_packet_task: send cdb
>>> ata_host_intr: ata1: protocol 7 (dev_stat 0x50)  <= irq received.
>>> ATAPI DMA ok
>>> sda: Write Protect is off
>>>
>>> ===============================================================
>>>
>>> Later, irq lost for the following MODE SENSE command:
>>>
>>> ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 1c
>>> ata_sg_setup: 1 sg elements mapped
>>> ata_exec_command_pio: ata1: cmd 0xA0
>>> atapi_packet_task: busy wait
>>> atapi_packet_task: send cdb
>>> ata_scsi_error: ENTER              <= timeout. ata_eng_timeout: ENTER
>>> ata_qc_timeout: ENTER
>>> ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x1   <= device is
>>> still busy. The old EH doesn't reset the device.
>>> ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
>>> ata_qc_timeout: EXIT
>>> ata_eng_timeout: EXIT
>>> ata_scsi_error: EXIT
>>> ====================================================================
>>>
>>> After the timeout, the device is in BUSY state and can't handle any
>>> new commands.
>>> That's why the "infinite loop" seen. (Tejun's new EH can reset the
>>> device and bring
>>> it back to work.)
>>>
>>> Don't know what caused the timeout. From the device status 0xd0, it seems
>>> the device is waiting for something (maybe data transfer?). It is not
>>> irq lost
>>> because the irq is not yet generated when the device status is still
>>> BUSY.
>>>
>>> Is it possible to attach a protocol analyzer to the SATA cable
>>> and check whether the ATAPI DMA data is actually transferred?
>>> Could you also post the dmesg log with ATA_DEBUG for the working
>>> Intel/nVidia
>>> adapter? Maybe we can find some clue by comparing the problematic MODE
>>> SENSE transation of both logs.
>>>
>>> I've done minimal testing with my VIA VT6421 + ATAPI but unable to
>>> reproduce
>>> the problem.
>>>
>>> Thanks,
>>>
>>> Albert
>>>
>>>
>>>       
>> Sorry it took so long to get you the information. In case you need me to
>> refresh the information here is the body of the original email I had
>> sent out.
>>
>> "We have a removable, ATAPI, SATA device and we are having the following
>> problem with Linux (kernel version 2.6.15.6). The device recieves a MODE
>> SENSE command. After receiving this command, it is supposed to receive a
>> 12-byte packet command, which it recieves. Afterwards there is supposed
>> to be an IRQ, and then the data is read from the device. However, in one
>> computer we have with a VIA chipset, the device keeps getting zeroes
>> without stopping. In other words, it gets the 12-bytes and the continues
>> to recive bytes all of which are zero. The device never gets the IRQ,
>> therefore it does not respond."
>>
>>
>>     
>
> Hi Dario,
>
> Could you please try the new 2.6.17-rc6 kernel? The "flush" after sending
> the ATAPI CDB, etc. has been added to 2.6.17-rcX and it might help to
> your sata_via problem.
>
> Thanks,
>
> Albetr
>
>
>
>   

The 2.6.17-rc6 kernel no longer hangs/loops infinitely on MODE-SENSE. 
But I have another problem. This time is on writes. A hardware engineer 
used a protocol analyzer and this is how he describes it

When we write to the ATAPI advice an ODD number of blocks, for example 
33 blocks, the data transfer goes as follows:

 
                        1. Transfer of 8192 bytes (16 blocks)

                        2. Transfer of 8192 bytes (16 blocks)

                        3. Last transfer of 536 bytes.  (1 block and 24 
bytes)

 

The last transfer should be 512 (1 block) and not 536. (There are 24 
extra bytes).

The device (Quantum GoVault) hung up since they are not expecting the 
extra data.

Testing the same kernel with a computer without the VIA chipset that 
problem do not exist.


