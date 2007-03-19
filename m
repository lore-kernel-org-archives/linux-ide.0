From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: DVD drive fails in 2.6.20.2
Date: Mon, 19 Mar 2007 14:48:43 +0800
Message-ID: <45FE324B.8070001@tw.ibm.com>
References: <45F631F7.6020106@mail.utexas.edu> <45F7760B.10102@gmail.com> <45F81177.9070106@mail.utexas.edu> <45F8E628.2010004@gmail.com> <45F9516D.4090008@mail.utexas.edu> <45F98923.1040601@tw.ibm.com> <45FA07E2.6080008@mail.utexas.edu> <45FAC6FC.4020105@tw.ibm.com> <45FADD53.5030500@mail.utexas.edu> <45FB71EA.7070602@tw.ibm.com> <45FC952C.1040708@mail.utexas.edu> <45FD1B35.2090607@tw.ibm.com> <45FE2680.9050702@mail.utexas.edu>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:60290 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965714AbXCSGs6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Mar 2007 02:48:58 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2J6mv7n022169
	for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 02:48:57 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2J6mvGZ053180
	for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 00:48:57 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2J6muGU003912
	for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 00:48:57 -0600
In-Reply-To: <45FE2680.9050702@mail.utexas.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vlad Codrea <vladcodrea@mail.utexas.edu>
Cc: albertl@mail.com, htejun@gmail.com, linux-ide@vger.kernel.org

Vlad Codrea wrote:
> Albert Lee wrote:
> 
>> This is the first problem.
>> It's weird to see HSM violation here, without any debug task_state trace.
>> In your previous log, it was detected correctly with debug task_state
>> trace.
>>
>> ata2.00: ATAPI, max MWDMA2, CDB intr
>> ata2.00: configured for MWDMA2
>> PM: Adding info for No Bus:target0:0:0
>> scsi 0:0:0:0: Direct-Access     ATA      IBM-DADA-26480   AD6O PQ: 0
>> ANSI: 5
>> PM: Adding info for scsi:0:0:0:0
>> PM: Adding info for No Bus:target1:0:0
>> ata2: protocol 5 task_state 4
>> ata2: protocol 5 task_state 4 (dev_stat 0x58)
>> ata2: protocol 5 task_state 1
>> ata2: protocol 5 task_state 1 (dev_stat 0x58)
>> ata2: protocol 5 task_state 2
>> ata2: protocol 5 task_state 2 (dev_stat 0x50)
>> scsi 1:0:0:0: CD-ROM            TORiSAN  DVD-ROM DRD-N216 1.08 PQ: 0
>> ANSI: 5
>>
>>  
>>
> 
> The first problem shouldn't be there -- I accidentaly copied the top
> portion (before the mount command) from an old dmesg where the DMA was
> still enabled. Sorry about that.
> 

It's ok. With the TORiSAN  DVD-ROM DRD-N216 DMA blacklisted,
the device identify and inquiry look good. The first problem is gone. :)

> libata version 2.00 loaded.
> ata_piix 0000:00:07.1: version 2.00ac7
> ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFCD0 irq 14
> ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xFCD8 irq 15
> scsi0 : ata_piix
> PM: Adding info for No Bus:host0
> ata1.00: ATA-4, max UDMA/33, 12685680 sectors: LBA 
> ata1.00: ata1: dev 0 multi count 16
> ata1.00: configured for UDMA/33
> scsi1 : ata_piix
> PM: Adding info for No Bus:host1
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> USB Universal Host Controller Interface driver v3.0
> ata2: protocol 2 task_state 1 (dev_stat 0x58)
> ata2: protocol 2 task_state 2 (dev_stat 0x50)
> ata2.00: ATAPI, max MWDMA2, CDB intr
> ata2.00: device is on DMA blacklist, disabling DMA
> ata2: protocol 1 task_state 2
> ata2: host_stat 0x4
> ata2: protocol 1 task_state 2 (dev_stat 0x50)
> ata2: protocol 2 task_state 1 (dev_stat 0x58)
> ata2: protocol 2 task_state 2 (dev_stat 0x50)
> ata2.00: configured for PIO4
> PM: Adding info for No Bus:target0:0:0
> scsi 0:0:0:0: Direct-Access     ATA      IBM-DADA-26480   AD6O PQ: 0 ANSI: 5
> PM: Adding info for scsi:0:0:0:0
> PM: Adding info for No Bus:target1:0:0
> CDB (2:0,0,0) 12 00 00 00 24 00 00 00 00
> ata2: protocol 5 task_state 4
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 4 (dev_stat 0x58)
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x50)
> ata2: protocol 5 task_state 2 (dev_stat 0x50)
> scsi 1:0:0:0: CD-ROM            TORiSAN  DVD-ROM DRD-N216 1.08 PQ: 0 ANSI: 5


>>
>>
>> This is the second problem. The device firmware/state machine stopped
>> working suddenly. The INTRQ was not cleared even after the device status
>> register was read. And the device status was struck to 0x58.
>> Let the device transfer the trailing data without limitation didn't help.
>>
>> Vlad, could you please apply the attached debug patch. The patch
>> 1. adds your TORiSAM drive to the DMA blacklist
>>   (so, we don't need to the check_atapi_dma() change this time)
>> 2. adds more debug trace
>>
>>  
>>
> 
> I have attached the dmesg generated after applying this patch.
> 
>> For the 2nd problem, could you please try change the medium and copy
>> the data from another known to be good CD? It might be the medium that
>> caused the device firmware malfunction.
>>  
>>
> 
> I have switched mediums to another pressed CD that I know works on my
> other computer and on this laptop when it is booted in Windows 98.
> 

##### Inserted CD and ran "mount /dev/sr0 /root/cdrom" #####
=> This part looks good as before.

##### Ran "cp -r /root/cdrom /root/cdrom_copy" #####
=> Looks bad, the the trailing data problem still exists even after the
medium is replaced. And the device stopped working.

>From the following trace, it is not clear what happened right before the crash.
Could you please sent me the full dmesg.
(If it is too big for the mailing list, please gzip and send to my e-mail
address as attachment.)

--
Thanks,

Albert

> 
> -- snip --
> 
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2: protocol 5 task_state 1
> ata2: host_stat 0x4
> ata2: protocol 5 task_state 1 (dev_stat 0x58)
> ata2.00: 63488 bytes trailing data
> ata2.00: ata_eh_analyze_tf, AC_ERR_HSM, 0x58
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x28 data 114688 in
>          res 58/00:02:00:00:f8/00:00:00:00:00/a0 Emask 0x6 (timeout)
> ata2: soft resetting port
> ata2: port is slow to respond, please be patient (Status 0xd8)
> ata2: port failed to respond (30 secs, Status 0xd8)
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> ata2.00: qc timeout (cmd 0xa1)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata2.00: revalidation failed (errno=-5)
> ata2: failed to recover some devices, retrying in 5 secs
> ata2: port is slow to respond, please be patient (Status 0xd8)
> ata2: port failed to respond (30 secs, Status 0xd8)
> ata2: soft resetting port
> ata2: port is slow to respond, please be patient (Status 0xd8)


