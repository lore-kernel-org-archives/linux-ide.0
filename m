From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Subject: Re: sata_promise: which version/patch to test?
Date: Mon, 28 May 2007 21:45:24 +0300 (EEST)
Message-ID: <51376.192.168.9.10.1180377924.squirrel@ncircle.nullnet.fi>
References: <200705121504.l4CF4u83028056@harpo.it.uu.se>
    <465A0D8F.8090309@how.dk>
    <42957.194.237.142.21.1180331956.squirrel@ncircle.nullnet.fi>
    <465B0A28.9050305@how.dk>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:43126 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbXE1Spe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 May 2007 14:45:34 -0400
In-Reply-To: <465B0A28.9050305@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Favrholdt <linux-ide@how.dk>
Cc: linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>


Hi,

> I don't know if this would be possible for you, but I think it would be
> interesting to see what would happen if you swapped the SATA cable on
> one of your problem drives with one which is ok. In my system (four
> identical drives) I have the feeling the problem is only on two of the
> ports (the exact ports changed when the port enumeration patch went into
> the kernel - it used to be sd[cd] and now it is sda and maybe sdb -
> haven't tested that much yet).
>
> If you try this - and the problem moves with the drive, then it must be
> drive related and not the ports/driver.

I have tried changing the cables and host ports and
the errors do follow the newer seagate 7200.10 drives, so my understanding
is that the problem must be related to sata300tx4/driver & my newer disks.
The ports and cables work flawlessly with older 7200.7 drives time after
time.


> Maybe we could collect some more information here:
> http://sata300tx4.gratiswiki.dk

Hmm, good idea, as this problem seems to be a hard one to figure out.

Regards,
Tomi Orava

> Tomi Orava wrote:
>> Hello,
>>
>>> I have tried exchanging SATA cables, but still have the problem with
>>> sata_promise using 2.6.21-git16.
>>
>> Unfortunately, I don't have any solution for you but I wanted to let you
>> know that you are not alone with this problem. I'm still running
>> with 2.6.21-rc3-git10 based kernel with promise_sata_1.5Gps.patch
>> and promise_enumeration.patch patches due to the fact that anything
>> newer
>> just doesn't work at all (the system drops interface speeds to almost
>> zero
>> due to  errors as reported previosly on this list). My current (old)
>> kernel with patches still reports the following errors whenever there is
>> more load on the system, but at least the promise sata300tx4 card &
>> seagate 7200.10 disks do work (not well, but anyway):
>>
>> ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
>> ata4.00: cmd 25/00:28:d7:be:99/00:00:17:00:00/e0 tag 0 cdb 0x0 data
>> 20480 in
>>          res 50/00:00:fe:be:99/00:00:46:9f:4a/e0 Emask 0x1 (device
>> error)
>> ata4.00: configured for UDMA/133
>> ata4: EH complete
>> SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
>> sdd: Write Protect is off
>> sdd: Mode Sense: 00 3a 00 00
>> SCSI device sdd: write cache: enabled, read cache: enabled, doesn't
>> support DPO or FUA
>>
>> I still don't understand why on earth the above errors get logged only
>> for
>> the newer Seagate 7200.10 disks and never for the older 7200.7 disks.
>>
>> 00:0e.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA
>> 300 TX4) (rev 02)
>>         Subsystem: Promise Technology, Inc. PDC40718 (SATA 300 TX4)
>>         Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 16
>>         I/O ports at ec00 [size=128]
>>         I/O ports at e000 [size=256]
>>         Memory at fe900000 (32-bit, non-prefetchable) [size=4K]
>>         Memory at fe800000 (32-bit, non-prefetchable) [size=128K]
>>         Expansion ROM at fe600000 [disabled] [size=32K]
>>         Capabilities: [60] Power Management version 2
>>
>> Disks:
>>
>> pdc_port_start(port 0): adjusted SControl from 0x00000000 to 0x00000011
>> ata1: SATA max UDMA/133 cmd 0xf880a380 ctl 0xf880a3b8 bmdma 0x00000000
>> irq 16
>> pdc_port_start(port 1): adjusted SControl from 0x00000000 to 0x00000011
>> ata2: SATA max UDMA/133 cmd 0xf880a280 ctl 0xf880a2b8 bmdma 0x00000000
>> irq 16
>> pdc_port_start(port 2): adjusted SControl from 0x00000000 to 0x00000011
>> ata3: SATA max UDMA/133 cmd 0xf880a200 ctl 0xf880a238 bmdma 0x00000000
>> irq 16
>> pdc_port_start(port 3): adjusted SControl from 0x00000000 to 0x00000011
>> ata4: SATA max UDMA/133 cmd 0xf880a300 ctl 0xf880a338 bmdma 0x00000000
>> irq 16
>> scsi0 : sata_promise
>> Switched to high resolution mode on CPU 0
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> ata1.00: ATA-6: ST3200822AS, 3.01, max UDMA/133
>> ata1.00: 390721968 sectors, multi 0: LBA48
>> ata1.00: configured for UDMA/133
>> scsi1 : sata_promise
>> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> ata2.00: ATA-6: ST3200822AS, 3.01, max UDMA/133
>> ata2.00: 390721968 sectors, multi 0: LBA48
>> ata2.00: configured for UDMA/133
>> scsi2 : sata_promise
>> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> ata3.00: ATA-7: ST3500630AS, 3.AAK, max UDMA/133
>> ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
>> ata3.00: configured for UDMA/133
>> scsi3 : sata_promise
>> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> ata4.00: ATA-7: ST3500630AS, 3.AAK, max UDMA/133
>> ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (not used)
>> ata4.00: configured for UDMA/133
>> scsi 0:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0
>> ANSI: 5
>> SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
>> sda: Write Protect is off
>> sda: Mode Sense: 00 3a 00 00
>> SCSI device sda: write cache: enabled, read cache: enabled, doesn't
>> support DPO or FUA
>> SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
>> sda: Write Protect is off
>> sda: Mode Sense: 00 3a 00 00
>> SCSI device sda: write cache: enabled, read cache: enabled, doesn't
>> support DPO or FUA
>>  sda: sda1 sda2
>> sd 0:0:0:0: Attached scsi disk sda
>> sd 0:0:0:0: Attached scsi generic sg0 type 0
>> scsi 1:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0
>> ANSI: 5
>> SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
>> sdb: Write Protect is off
>> sdb: Mode Sense: 00 3a 00 00
>> SCSI device sdb: write cache: enabled, read cache: enabled, doesn't
>> support DPO or FUA
>>  sdb: sdb1 sdb2
>> sd 1:0:0:0: Attached scsi disk sdb
>> sd 1:0:0:0: Attached scsi generic sg1 type 0
>> scsi 2:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0
>> ANSI: 5
>> SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
>> sdc: Write Protect is off
>> sdc: Mode Sense: 00 3a 00 00
>> SCSI device sdc: write cache: enabled, read cache: enabled, doesn't
>> support DPO or FUA
>> SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
>> sdc: Write Protect is off
>> sdc: Mode Sense: 00 3a 00 00
>> SCSI device sdc: write cache: enabled, read cache: enabled, doesn't
>> support DPO or FUA
>>  sdc: sdc1 sdc2
>> sd 2:0:0:0: Attached scsi disk sdc
>> sd 2:0:0:0: Attached scsi generic sg2 type 0
>> scsi 3:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0
>> ANSI: 5
>> SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
>> sdd: Write Protect is off
>> sdd: Mode Sense: 00 3a 00 00
>> SCSI device sdd: write cache: enabled, read cache: enabled, doesn't
>> support DPO or FUA
>> SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
>> sdd: Write Protect is off
>> sdd: Mode Sense: 00 3a 00 00
>> SCSI device sdd: write cache: enabled, read cache: enabled, doesn't
>> support DPO or FUA
>>  sdd: sdd1 sdd2
>> sd 3:0:0:0: Attached scsi disk sdd
>> sd 3:0:0:0: Attached scsi generic sg3 type 0
>>
>>
>> Regards,
>> Tomi Orava
>>
>>> HW info:
>>>
>>> Promise Technology, Inc. PDC40718 (SATA 300 TX4) (rev 02)
>>> with 4 Seagate 500GB ES drives:
>>>          Model Number:       ST3500630NS
>>>          Firmware Revision:  3.AEE
>>>          (with 1.5/3.0Gbps jumper removed = 3.0Gbps)
>>>
>>> After doing:
>>>
>>> dd if=/dev/sda of=/dev/null bs=1M &
>>> dd if=/dev/sdb of=/dev/null bs=1M &
>>> dd if=/dev/sdc of=/dev/null bs=1M &
>>> dd if=/dev/sdd of=/dev/null bs=1M &
>>>
>>> it runs fine for a while, then:
>>>
>>> [ 3171.247821] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000
>>> action 0x2 frozen
>>> [ 3171.247835] ata1.00: cmd c8/00:00:00:3c:35/00:00:00:00:00/ea tag 0
>>> cdb 0x0 data 131072 in
>>> [ 3171.247837]          res 40/00:28:00:00:00/00:00:00:00:00/00 Emask
>>> 0x4 (timeout)
>>> [ 3171.559676] ata1: device not ready (errno=-19), forcing hardreset
>>> [ 3171.559685] ata1: hard resetting port
>>> [ 3172.035566] ata1: COMRESET failed (errno=-19)
>>> [ 3172.035575] ata1: reset failed (errno=-19), retrying in 10 secs
>>> [ 3181.555162] ata1: hard resetting port
>>> [ 3182.031060] ata1: COMRESET failed (errno=-19)
>>> [ 3182.031068] ata1: reset failed (errno=-19), retrying in 10 secs
>>> [ 3191.550679] ata1: hard resetting port
>>> [ 3192.026471] ata1: COMRESET failed (errno=-19)
>>> [ 3192.026480] ata1: reset failed (errno=-19), retrying in 35 secs
>>> [ 3226.534976] ata1: hard resetting port
>>> [ 3227.010769] ata1: COMRESET failed (errno=-19)
>>> [ 3227.010777] ata1: reset failed, giving up
>>> [ 3227.010780] ata1.00: disabled
>>> [ 3227.010792] ata1: EH complete
>>> [ 3227.011088] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
>>> [ 3227.011094] end_request: I/O error, dev sda, sector 171260928
>>> [ 3227.011099] Buffer I/O error on device sda, logical block 21407616
>>> [ 3227.011104] Buffer I/O error on device sda, logical block 21407617
>>> [ 3227.011108] Buffer I/O error on device sda, logical block 21407618
>>> [ 3227.011112] Buffer I/O error on device sda, logical block 21407619
>>> [ 3227.011115] Buffer I/O error on device sda, logical block 21407620
>>> [ 3227.011119] Buffer I/O error on device sda, logical block 21407621
>>> [ 3227.011122] Buffer I/O error on device sda, logical block 21407622
>>> [ 3227.011126] Buffer I/O error on device sda, logical block 21407623
>>> [ 3227.011130] Buffer I/O error on device sda, logical block 21407624
>>> [ 3227.011133] Buffer I/O error on device sda, logical block 21407625
>>> [ 3227.011161] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
>>> [ 3227.011165] end_request: I/O error, dev sda, sector 171261184
>>> [ 3227.011297] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
>>> [ 3227.011301] end_request: I/O error, dev sda, sector 171260928
>>> [ 3227.011327] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
>>> [ 3227.011332] end_request: I/O error, dev sda, sector 171260928
>>> [4]   Exit 1                  dd if=/dev/sda of=/dev/null bs=1M  (wd:
>>> ~)
>>
>>
>


-- 
Tomi.Orava@ncircle.nullnet.fi

