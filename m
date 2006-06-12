From: Dario Oliva <anikami1@gmail.com>
Subject: Re: Infinite loop on MODE-SENSE with a removable ATAPI sata device
 on VIA chipset
Date: Mon, 12 Jun 2006 17:12:37 -0400
Message-ID: <448DD8C5.2010000@gmail.com>
References: <E656D53DA4B96C409683999F573A360723E553@sbs.ARCO.local> <4462E5A5.2010703@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070105020004030408060202"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:40574 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751407AbWFLVMn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 17:12:43 -0400
Received: by py-out-1112.google.com with SMTP id x31so1806640pye
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 14:12:42 -0700 (PDT)
In-Reply-To: <4462E5A5.2010703@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070105020004030408060202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

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

Sorry it took so long to get you the information. In case you need me to 
refresh the information here is the body of the original email I had 
sent out.

"We have a removable, ATAPI, SATA device and we are having the following 
problem with Linux (kernel version 2.6.15.6). The device recieves a MODE 
SENSE command. After receiving this command, it is supposed to receive a 
12-byte packet command, which it recieves. Afterwards there is supposed 
to be an IRQ, and then the data is read from the device. However, in one 
computer we have with a VIA chipset, the device keeps getting zeroes 
without stopping. In other words, it gets the 12-bytes and the continues 
to recive bytes all of which are zero. The device never gets the IRQ, 
therefore it does not respond."


I also attached the kernel messages running on intel, nvidia, and via 
chipsets.

Dario Oliva

--------------070105020004030408060202
Content-Type: text/plain;
 name="dmesg_2.6.15.6-ezb_intel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_2.6.15.6-ezb_intel"

ments mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 1c
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
SCSI device sda: drive cache: write through
ata_scsi_dump_cdb: CDB (2:0,0,0) 1e 00 00 00 01 00 00 00 1c
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 6 (dev_stat 0x51)
atapi_request_sense: ATAPI request sense
ata_exec_command_pio: ata2: cmd 0xA0
atapi_request_sense: EXIT
atapi_packet_task: busy wait
atapi_packet_task: send cdb
__atapi_pio_bytes: data read
Device not ready. Make sure there is a disc in the drive.
ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 1c
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x51)
atapi_request_sense: ATAPI request sense
ata_exec_command_pio: ata2: cmd 0xA0
atapi_request_sense: EXIT
atapi_packet_task: busy wait
atapi_packet_task: send cdb
__atapi_pio_bytes: data read
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
sda: Write Protect is off
sda: Mode Sense: 00 38 00 00
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 1c
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
SCSI device sda: drive cache: write through
ata_scsi_dump_cdb: CDB (2:0,0,0) 1b 00 00 00 01 00 00 00 00
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 1b 00 00 00 01 00 00 00 00
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 1e 00 00 00 00 00 00 00 00
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
sda: Write Protect is off
sda: Mode Sense: 00 38 00 00
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 1c
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
SCSI device sda: drive cache: write through
ata_scsi_dump_cdb: CDB (2:0,0,0) 1e 00 00 00 01 00 00 00 1c
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 1c
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
sda: Write Protect is off
sda: Mode Sense: 00 38 00 00
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 1c
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
SCSI device sda: drive cache: write through
 sda:<3>ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
 sda1
ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 ff 00 00 00 00
ata_sg_setup: padding done, sg[0].length=252 pad_len=3
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 00 08 00 00 38
ata_sg_setup: 3 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 00 64 00 00 c8
ata_sg_setup: 25 sg elements mapped
ata_exec_command_pio: ata2: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata2: protocol 7 (dev_stat 0x50)

--------------070105020004030408060202
Content-Type: text/plain;
 name="dmesg_2.6.15.6-ezb_nvidia"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_2.6.15.6-ezb_nvidia"

00 00 01 00 00 00 1c
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 6 (dev_stat 0x51)
atapi_request_sense: ATAPI request sense
ata_exec_command_pio: ata1: cmd 0xA0
atapi_request_sense: EXIT
atapi_packet_task: busy wait
atapi_packet_task: send cdb
__atapi_pio_bytes: data read
Device not ready. Make sure there is a disc in the drive.
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x51)
atapi_request_sense: ATAPI request sense
ata_exec_command_pio: ata1: cmd 0xA0
atapi_request_sense: EXIT
atapi_packet_task: busy wait
atapi_packet_task: send cdb
__atapi_pio_bytes: data read
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
sda: Write Protect is off
sda: Mode Sense: 00 38 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 1c
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
SCSI device sda: drive cache: write through
ata_scsi_dump_cdb: CDB (1:0,0,0) 1b 00 00 00 01 00 00 00 00
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 1b 00 00 00 01 00 00 00 00
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 1e 00 00 00 00 00 00 00 00
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
sda: Write Protect is off
sda: Mode Sense: 00 38 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 1c
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
SCSI device sda: drive cache: write through
ata_scsi_dump_cdb: CDB (1:0,0,0) 1e 00 00 00 01 00 00 00 1c
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
sda: Write Protect is off
sda: Mode Sense: 00 38 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 1c
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
SCSI device sda: drive cache: write through
 sda:<3>ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
 sda1
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 ff 00 00 00 00
ata_sg_setup: padding done, sg[0].length=252 pad_len=3
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 00 00 00 00 40
ata_sg_setup: 3 sg elements mapped
ata_exec_command_pio: ata2: cmd 0x25
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 08 00 00 38
ata_sg_setup: 2 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
ata_host_intr: ata2: protocol 4 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 ff 00 00 00 00
ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 00 64 00 00 ff
ata_sg_setup: 30 sg elements mapped
ata_exec_command_pio: ata2: cmd 0x25
ata_host_intr: ata2: protocol 4 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 64 00 00 c8
ata_sg_setup: 23 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)

--------------070105020004030408060202
Content-Type: text/plain;
 name="dmesg_2.6.15.6-ezb_via"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_2.6.15.6-ezb_via"

0 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x51)
atapi_request_sense: ATAPI request sense
ata_exec_command_pio: ata1: cmd 0xA0
atapi_request_sense: EXIT
atapi_packet_task: busy wait
atapi_packet_task: send cdb
__atapi_pio_bytes: data read
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
sda: Write Protect is off
sda: Mode Sense: 00 38 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 1c
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
SCSI device sda: drive cache: write through
sd 0:0:0:0: Attached scsi removable disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 128M @ 0xe8000000
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x51)
atapi_request_sense: ATAPI request sense
ata_exec_command_pio: ata1: cmd 0xA0
atapi_request_sense: EXIT
atapi_packet_task: busy wait
atapi_packet_task: send cdb
__atapi_pio_bytes: data read
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
sda: Write Protect is off
sda: Mode Sense: 00 38 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 1c
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
SCSI device sda: drive cache: write through
ata_scsi_dump_cdb: CDB (1:0,0,0) 1e 00 00 00 01 00 00 00 1c
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 6 (dev_stat 0x51)
atapi_request_sense: ATAPI request sense
ata_exec_command_pio: ata1: cmd 0xA0
atapi_request_sense: EXIT
atapi_packet_task: busy wait
atapi_packet_task: send cdb
__atapi_pio_bytes: data read
Device not ready. Make sure there is a disc in the drive.
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 6 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x51)
atapi_request_sense: ATAPI request sense
ata_exec_command_pio: ata1: cmd 0xA0
atapi_request_sense: EXIT
atapi_packet_task: busy wait
atapi_packet_task: send cdb
__atapi_pio_bytes: data read
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
sda: Write Protect is off
sda: Mode Sense: 00 38 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: protocol 7 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 1c
ata_sg_setup: 1 sg elements mapped
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x1
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
sda: asking for cache data failed
sda: assuming drive cache: write through
program hwscan is using a deprecated SCSI ioctl, please convert it to SG_IO
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 80 00 ff 00 00 00 1c
ata_sg_setup_one: mapped buffer of 512 bytes for read
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 1e 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
sd 0:0:0:0: ioctl_internal_command return code = 8000002
   : Current [descriptor]: sense key: Aborted Command
    Additional sense: Scsi parity error
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 17
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: Promiscuous mode enabled.
device eth0 entered promiscuous mode
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
p_cdb: CDB (1:0,0,0) 1e 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
sd 0:0:0:0: ioctl_internal_command return code = 8000002
   : Current [descriptor]: sense key: Aborted Command
    Additional sense: Scsi parity error
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 17
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: Promiscuous mode enabled.
device eth0 entered promiscuous mode
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
eth0: Promiscuous mode enabled.
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
sda: Unit Not Ready, sense:
: Current [descriptor]: sense key: Aborted Command
    Additional sense: Scsi parity error
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
si_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 1c
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
sda: Unit Not Ready, sense:
: Current [descriptor]: sense key: Aborted Command
    Additional sense: Scsi parity error
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
sda : READ CAPACITY failed.
sda : status=1, message=00, host=0, driver=08 
sd: Current [descriptor]: sense key: Aborted Command
    Additional sense: Scsi parity error
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 00 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 00 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
b/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
sda : READ CAPACITY failed.
sda : status=1, message=00, host=0, driver=08 
sd: Current [descriptor]: sense key: Aborted Command
    Additional sense: Scsi parity error
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 00 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 00 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
VFS: Can't find ext3 filesystem on dev fd0.
VFS: Can't find an ext2 filesystem on dev fd0.
VFS: Can't find a Minix or Minix V2 filesystem on device fd0.
Unable to load NLS charset cp437
FAT: codepage cp437 not found
Unable to load NLS charset cp437
FAT: codepage cp437 not found
Unable to identify CD-ROM format.
Unable to load NLS charset iso8859-1
NTFS-fs warning (device fd0): is_boot_sector_ntfs(): Invalid boot sector checksum.
NTFS-fs error (device fd0): read_ntfs_boot_sector(): Primary boot sector is invalid.
NTFS-fs error (device fd0): read_ntfs_boot_sector(): Mount option errors=recover not used. Aborting without trying to recover.
NTFS-fs error (device fd0): ntfs_fill_super(): Not an NTFS volume.
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 ff
ata_sg_setup: padding done, sg[0].length=252 pad_len=3
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 ff
ata_sg_setup: padding done, sg[0].length=252 pad_len=3
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
VFS: Can't find ext3 filesystem on dev fd0.
VFS: Can't find an ext2 filesystem on dev fd0.
VFS: Can't find a Minix or Minix V2 filesystem on device fd0.
Unable to load NLS charset cp437
FAT: codepage cp437 not found
Unable to load NLS charset cp437
FAT: codepage cp437 not found
Unable to identify CD-ROM format.
Unable to load NLS charset iso8859-1
NTFS-fs warning (device fd0): is_boot_sector_ntfs(): Invalid boot sector checksum.
NTFS-fs error (device fd0): read_ntfs_boot_sector(): Primary boot sector is invalid.
NTFS-fs error (device fd0): read_ntfs_boot_sector(): Mount option errors=recover not used. Aborting without trying to recover.
NTFS-fs error (device fd0): ntfs_fill_super(): Not an NTFS volume.
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
sda: test WP failed, assume Write Enabled
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_sg_setup: 1 sg elements mapped
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
Unable to load NLS charset cp437
FAT: codepage cp437 not found
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
sda: asking for cache data failed
sda: assuming drive cache: write through
ata_scsi_dump_cdb: CDB (1:0,0,0) 1e 00 00 00 01 00 00 00 08
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
ata1 failed to respond (30 secs)
ATA: abnormal status 0xD0 on port 0xE007
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_scsi_dump_cdb: CDB (1:0,0,0) 1e 00 00 00 01 00 00 00 08
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
ata1 is slow to respond, please be patient
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
ata1: command 0xa0 timeout, stat 0xd0 host_stat 0x0
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
sd 0:0:0:0: ioctl_internal_command return code = 8000002
   : Current [descriptor]: sense key: Aborted Command
    Additional sense: Scsi parity error
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 08
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ATA: abnormal status 0xD0 on port 0xE007
ata_exec_command_pio: ata1: cmd 0xA0

--------------070105020004030408060202--
