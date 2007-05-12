From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: sata_promise: which version/patch to test?
Date: Sat, 12 May 2007 20:23:08 +0200
Message-ID: <4646060C.7050508@how.dk>
References: <200705121504.l4CF4u83028056@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepc.post.tele.dk ([195.41.46.237]:56677 "EHLO
	pfepc.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbXELSXN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 May 2007 14:23:13 -0400
In-Reply-To: <200705121504.l4CF4u83028056@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Hi,

I've tested with 2.6.21.1 with the following patches (which applied
cleanly):

http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-1-separate-sata-pata-ops-2.6.21
http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-2-error_intr-2.6.21
http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-3-sataii-tx4-port-numbering-fix-2.6.21

dmesg reports version 2.00 (you mentioned version 2.07?):

[   42.091593] sata_promise 0000:01:08.0: version 2.00
[   42.091852] ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
[   42.091901] ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [LNK3] -> GSI
11 (level, low) -> IRQ 11
[   42.092028] sata_promise: applying SATAII-150/300 TX4 port numbering
workaround


The problem is still there. I'm doing:

dd if=/dev/sda of=/dev/null bs=1M &
dd if=/dev/sdb of=/dev/null bs=1M &
dd if=/dev/sdc of=/dev/null bs=1M &
dd if=/dev/sdd of=/dev/null bs=1M &

Then I used smartctl a number of times:

(for each in /dev/sd[abcd]; do smartctl -a -d ata $each ; sleep 5; done)
| grep -i "ATA Error Count"

This _sometimes_ produces the following in dmesg:

[ 1090.412643] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 1090.412801] ata1.00: (port_status 0x00001000)
[ 1090.412942] ata1.00: cmd 25/00:00:00:e5:cc/00:02:01:00:00/e0 tag 0
cdb 0x0 data 262144 in
[ 1090.412944]          res 50/00:00:ff:e6:cc/00:00:01:00:00/e0 Emask
0x20 (host bus error)
[ 1090.462710] ata1.00: configured for UDMA/133
[ 1090.462865] ata1: EH complete
[ 1090.510793] SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
[ 1090.555432] sda: Write Protect is off
[ 1090.555491] sda: Mode Sense: 00 3a 00 00
[ 1090.556570] SCSI device sda: write cache: enabled, read cache:
enabled, doesn't support DPO or FUA

But the dds continues afterwards (which is nice).

Then eventually one port gave up and didn't recover:

[ 1139.067245] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x1180000
action 0x2 frozen
[ 1139.067510] ata4.00: cmd c8/00:00:00:64:cb/00:00:00:00:00/e1 tag 0
cdb 0x0 data 131072 in
[ 1139.067513]          res 40/00:01:09:4f:c2/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 1139.378689] ata4: soft resetting port
[ 1139.534682] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1169.529225] ata4.00: qc timeout (cmd 0xec)
[ 1169.529689] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[ 1169.529829] ata4.00: revalidation failed (errno=-5)
[ 1169.530091] ata4: failed to recover some devices, retrying in 5 secs
[ 1174.530890] ata4: hard resetting port
[ 1175.006682] ata4: COMRESET failed (device not ready)
[ 1175.006829] ata4: hardreset failed, retrying in 5 secs
[ 1180.008469] ata4: hard resetting port
[ 1180.484212] ata4: COMRESET failed (device not ready)
[ 1180.484367] ata4: hardreset failed, retrying in 5 secs
[ 1185.486048] ata4: hard resetting port
[ 1185.961762] ata4: COMRESET failed (device not ready)
[ 1185.961920] ata4: reset failed, giving up
[ 1185.962056] ata4.00: disabled
[ 1185.962198] ata4: EH complete
[ 1185.962808] sd 4:0:0:0: SCSI error: return code = 0x00040000
[ 1185.962940] end_request: I/O error, dev sdd, sector 30106624
[ 1185.963086] Buffer I/O error on device sdd, logical block 3763328
[ 1185.963297] Buffer I/O error on device sdd, logical block 3763329
[ 1185.963447] Buffer I/O error on device sdd, logical block 3763330
[ 1185.963586] Buffer I/O error on device sdd, logical block 3763331
[ 1185.963733] Buffer I/O error on device sdd, logical block 3763332
[ 1185.963872] Buffer I/O error on device sdd, logical block 3763333
[ 1185.963927] Buffer I/O error on device sdd, logical block 3763334
[ 1185.963982] Buffer I/O error on device sdd, logical block 3763335
[ 1185.964036] Buffer I/O error on device sdd, logical block 3763336
[ 1185.964089] Buffer I/O error on device sdd, logical block 3763337
[ 1185.964368] sd 4:0:0:0: SCSI error: return code = 0x00040000
[ 1185.964493] end_request: I/O error, dev sdd, sector 30106880
[ 1185.965233] sd 4:0:0:0: SCSI error: return code = 0x00040000
[ 1185.965376] end_request: I/O error, dev sdd, sector 30106624
[ 1185.967036] sd 4:0:0:0: SCSI error: return code = 0x00040000
[ 1185.967287] end_request: I/O error, dev sdd, sector 30106624
[ 1233.061659] sd 4:0:0:0: SCSI error: return code = 0x00040000
[ 1233.061799] end_request: I/O error, dev sdd, sector 0
[ 1233.061942] printk: 56 messages suppressed.
[ 1233.062074] Buffer I/O error on device sdd, logical block 0
[ 1233.062212] Buffer I/O error on device sdd, logical block 1
[ 1233.062446] Buffer I/O error on device sdd, logical block 2
[ 1233.062523] Buffer I/O error on device sdd, logical block 3
[ 1233.062575] Buffer I/O error on device sdd, logical block 4
[ 1233.062627] Buffer I/O error on device sdd, logical block 5
[ 1233.062680] Buffer I/O error on device sdd, logical block 6
[ 1233.062732] Buffer I/O error on device sdd, logical block 7
[ 1233.062784] Buffer I/O error on device sdd, logical block 8
[ 1233.063882] sd 4:0:0:0: SCSI error: return code = 0x00040000
[ 1233.064025] end_request: I/O error, dev sdd, sector 0

Here is the related part of my boot log:

[   26.958676]  hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
[   27.019135] hdb: max request size: 128KiB
[   27.019534] hdb: 156301488 sectors (80026 MB) w/2048KiB Cache,
CHS=65535/16/63, UDMA(100)
[   27.019718] hdb: cache flushes not supported
[   27.019775]  hdb: hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 hdb9 >
[   27.092486] ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11
[   27.092535] ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [LNK1] -> GSI
11 (level, low) -> IRQ 11
[   27.093787] ahc_pci:1:10:0: Host Adapter Bios disabled.  Using
default SCSI device parameters
[   42.091115] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[   42.091117]         <Adaptec 2902/04/10/15/20C/30C SCSI adapter>
[   42.091119]         aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs
[   42.091121]
[   42.091593] sata_promise 0000:01:08.0: version 2.00
[   42.091852] ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
[   42.091901] ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [LNK3] -> GSI
11 (level, low) -> IRQ 11
[   42.092028] sata_promise: applying SATAII-150/300 TX4 port numbering
workaround
[   42.092125] ata1: SATA max UDMA/133 cmd 0xe0816380 ctl 0xe08163b8
bmdma 0x00000000 irq 11
[   42.092213] ata2: SATA max UDMA/133 cmd 0xe0816280 ctl 0xe08162b8
bmdma 0x00000000 irq 11
[   42.092302] ata3: SATA max UDMA/133 cmd 0xe0816200 ctl 0xe0816238
bmdma 0x00000000 irq 11
[   42.092389] ata4: SATA max UDMA/133 cmd 0xe0816300 ctl 0xe0816338
bmdma 0x00000000 irq 11
[   42.092454] scsi1 : sata_promise
[   42.558930] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   42.583253] ata1.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[   42.583301] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   42.591245] ata1.00: configured for UDMA/133
[   42.591296] scsi2 : sata_promise
[   43.058704] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   43.083021] ata2.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[   43.083069] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   43.107012] ata2.00: configured for UDMA/133
[   43.107061] scsi3 : sata_promise
[   43.147068] scsi 0:0:4:0: CD-ROM            HP       CD-Writer+ 9200
  1.0e PQ: 0 ANSI: 4
[   43.147139]  target0:0:4: Beginning Domain Validation
[   43.159571]  target0:0:4: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[   43.168135]  target0:0:4: Domain Validation skipping write tests
[   43.168182]  target0:0:4: Ending Domain Validation
[   43.574474] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   43.598789] ata3.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[   43.598837] ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   43.606787] ata3.00: configured for UDMA/133
[   43.606836] scsi4 : sata_promise
[   43.716126] sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
[   43.716176] Uniform CD-ROM driver Revision: 3.20
[   43.716270] sr 0:0:4:0: Attached scsi CD-ROM sr0
[   43.716326] sr 0:0:4:0: Attached scsi generic sg0 type 5
[   44.074248] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   44.098565] ata4.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
[   44.098613] ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   44.122556] ata4.00: configured for UDMA/133
[   44.122649] scsi 1:0:0:0: Direct-Access     ATA      ST3500630NS
  3.AE PQ: 0 ANSI: 5
[   44.122785] SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
[   44.122843] sda: Write Protect is off
[   44.122888] sda: Mode Sense: 00 3a 00 00
[   44.122903] SCSI device sda: write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   44.123002] SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
[   44.123057] sda: Write Protect is off
[   44.123102] sda: Mode Sense: 00 3a 00 00
[   44.123115] SCSI device sda: write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   44.123174]  sda: unknown partition table
[   44.130358] sd 1:0:0:0: Attached scsi disk sda
[   44.130456] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   44.130557] scsi 2:0:0:0: Direct-Access     ATA      ST3500630NS
  3.AE PQ: 0 ANSI: 5
[   44.130687] SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
[   44.130742] sdb: Write Protect is off
[   44.130787] sdb: Mode Sense: 00 3a 00 00
[   44.130800] SCSI device sdb: write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   44.130891] SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
[   44.130946] sdb: Write Protect is off
[   44.130990] sdb: Mode Sense: 00 3a 00 00
[   44.131004] SCSI device sdb: write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   44.131062]  sdb: unknown partition table
[   44.140212] sd 2:0:0:0: Attached scsi disk sdb
[   44.140310] sd 2:0:0:0: Attached scsi generic sg2 type 0
[   44.140413] scsi 3:0:0:0: Direct-Access     ATA      ST3500630NS
  3.AE PQ: 0 ANSI: 5
[   44.140552] SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
[   44.140608] sdc: Write Protect is off
[   44.140652] sdc: Mode Sense: 00 3a 00 00
[   44.140666] SCSI device sdc: write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   44.140755] SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
[   44.140810] sdc: Write Protect is off
[   44.140855] sdc: Mode Sense: 00 3a 00 00
[   44.140868] SCSI device sdc: write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   44.140926]  sdc: unknown partition table
[   44.159100] sd 3:0:0:0: Attached scsi disk sdc
[   44.159192] sd 3:0:0:0: Attached scsi generic sg3 type 0
[   44.159293] scsi 4:0:0:0: Direct-Access     ATA      ST3500630NS
  3.AE PQ: 0 ANSI: 5
[   44.159417] SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
[   44.159472] sdd: Write Protect is off
[   44.159516] sdd: Mode Sense: 00 3a 00 00
[   44.159530] SCSI device sdd: write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   44.159613] SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
[   44.159667] sdd: Write Protect is off
[   44.159712] sdd: Mode Sense: 00 3a 00 00
[   44.159725] SCSI device sdd: write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   44.159783]  sdd: unknown partition table
[   44.181673] sd 4:0:0:0: Attached scsi disk sdd
[   44.181767] sd 4:0:0:0: Attached scsi generic sg4 type 0
[   44.181871] sata_sil 0000:01:0b.0: version 2.1
[   44.181892] ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNK3] -> GSI
11 (level, low) -> IRQ 11
[   44.182056] ata5: SATA max UDMA/100 cmd 0xe081e080 ctl 0xe081e08a
bmdma 0xe081e000 irq 11
[   44.182141] ata6: SATA max UDMA/100 cmd 0xe081e0c0 ctl 0xe081e0ca
bmdma 0xe081e008 irq 11
[   44.182208] scsi5 : sata_sil
[   44.494036] ata5: SATA link down (SStatus 0 SControl 310)
[   44.494092] scsi6 : sata_sil
[   44.805896] ata6: SATA link down (SStatus 0 SControl 310)


I'll continue testing with the other kernels you suggested.

Please let me know if I can do anything else to help.

Best regards,

Peter

Mikael Pettersson wrote:
> On Thu, 10 May 2007 21:41:32 +0200, Peter Favrholdt wrote:
>> I would like to help by testing the most recent version of the 
>> sata_promise driver on my
>>
>> Promise Technology, Inc. PDC40718 (SATA 300 TX4) (rev 02)
>>
>> with 4 Seagate 500GB ES drives:
>>         Model Number:       ST3500630NS
>>         Firmware Revision:  3.AEE
>>         (with 1.5/3.0Gbps jumper removed = 3.0Gbps)
>>
>> This setup experienced a problem a while ago which was fixed using 
>> 2.6.21-rc2 + Mikael Petterssons "force 1.5Gbps patch".
>>
>> Could someone provide a hint on what sources/patches I should get?
>>
>> E.g. vanilla 2.6.21.1 + ?
> 
> For a SATA 300 TX4 you should test version 2.07 of sata_promise.c.
> You can get it in 2.6.21-git16, or 2.6.21-mm2 plus the following
> two patches:
> 
> http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-1-error_intr-abort_port-2.6.21-mm2
> http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-2-sataii-tx4-port-numbering-fix-2.6.21-mm2
> 
> or 2.6.21 plus the following three patches:
> 
> http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-1-separate-sata-pata-ops-2.6.21
> http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-2-error_intr-2.6.21
> http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-3-sataii-tx4-port-numbering-fix-2.6.21
> 
> Note that this corrects the longstanding mis-enumeration
> of ports on SATAII TX4 cards, so you may need to adjust
> your /etc/fstab and boot-time root= parameter if you're
> using hard-coded partition names.
> 
> /Mikael
