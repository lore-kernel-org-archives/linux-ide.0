From: Peter Favrholdt <linux-ide@how.dk>
Subject: Bug is fixed in 2.6.23.1: sata_promise: port is slow to respond,
 reset failed
Date: Sun, 14 Oct 2007 11:21:13 +0200
Message-ID: <4711DF89.5000208@how.dk>
References: <46DA9AAA.3070808@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pqueueb.post.tele.dk ([193.162.153.10]:60171 "EHLO
	pqueueb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904AbXJNJoO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Oct 2007 05:44:14 -0400
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id C434A8522
	for <linux-ide@vger.kernel.org>; Sun, 14 Oct 2007 11:23:16 +0200 (CEST)
Received: from how3.how.dk (0x50a32a37.unknown.tele.dk [80.163.42.55])
	by pfepb.post.tele.dk (Postfix) with ESMTP id 5114CA5003D
	for <linux-ide@vger.kernel.org>; Sun, 14 Oct 2007 11:21:14 +0200 (CEST)
Received: from how7.how.dk ([192.168.0.7] ident=pfavr)
	by how3.how.dk with esmtp (Exim 4.50)
	id 1Igzes-0001GW-33
	for linux-ide@vger.kernel.org; Sun, 14 Oct 2007 11:21:14 +0200
In-Reply-To: <46DA9AAA.3070808@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

The problem is solved in 2.6.23.1 regarding the "port slow to respond" 
issue.

I'm using sata_promise on Promise Technology, Inc. PDC40718 (SATA 300 
TX4) (rev 02) and 4 Seagate 500GB ES drives.

Using 2.6.23.1 it is possible to run

dd if=/dev/sda of=/dev/null bs=1M &
dd if=/dev/sdb of=/dev/null bs=1M &
dd if=/dev/sdc of=/dev/null bs=1M &
dd if=/dev/sdd of=/dev/null bs=1M &

And it just runs perfectly to the end with no hickups :-)

Thank you very much :-)

Best regards,

Peter

Peter Favrholdt wrote:
> Hi,
> 
> I'm still experiencing the same "port is slow to respond" problem using 
> sata_promise in linux-2.6.22.6 with my Promise Technology, Inc. PDC40718 
> (SATA 300 TX4) (rev 02) and 4 Seagate 500GB ES drives:
>         Model Number:       ST3500630NS
>         Firmware Revision:  3.AEE
>         (with 1.5/3.0Gbps jumper removed = 3.0Gbps)
> 
> After doing:
> 
> dd if=/dev/sda of=/dev/null bs=1M &
> dd if=/dev/sdb of=/dev/null bs=1M &
> dd if=/dev/sdc of=/dev/null bs=1M &
> dd if=/dev/sdd of=/dev/null bs=1M &
> 
> it runs fine for a while, then:
> 
> [  810.545909] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
> action 0x2 frozen
> [  810.545923] ata1.00: cmd c8/00:00:00:33:e6/00:00:00:00:00/e1 tag 0 
> cdb 0x0 data 131072 in
> [  810.545926]          res 40/00:28:00:00:00/00:00:00:00:00/40 Emask 
> 0x4 (timeout)
> [  815.913113] ata1: port is slow to respond, please be patient (Status 
> 0xff)
> [  820.590706] ata1: device not ready (errno=-16), forcing hardreset
> [  820.590716] ata1: hard resetting port
> [  826.137780] ata1: port is slow to respond, please be patient (Status 
> 0xff)
> [  830.635488] ata1: COMRESET failed (errno=-16)
> [  830.635497] ata1: hard resetting port
> [  836.182563] ata1: port is slow to respond, please be patient (Status 
> 0xff)
> [  840.680236] ata1: COMRESET failed (errno=-16)
> [  840.680245] ata1: hard resetting port
> [  846.227361] ata1: port is slow to respond, please be patient (Status 
> 0xff)
> [  875.672028] ata1: COMRESET failed (errno=-16)
> [  875.672037] ata1: limiting SATA link speed to 1.5 Gbps
> [  875.672041] ata1: hard resetting port
> [  880.679454] ata1: COMRESET failed (errno=-16)
> [  880.679463] ata1: reset failed, giving up
> [  880.679466] ata1.00: disabled
> [  880.679480] ata1: EH complete
> [  880.679545] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> [  880.679550] end_request: I/O error, dev sda, sector 31863552
> [  880.679555] Buffer I/O error on device sda, logical block 3982944
> [  880.679561] Buffer I/O error on device sda, logical block 3982945
> [  880.679565] Buffer I/O error on device sda, logical block 3982946
> [  880.679569] Buffer I/O error on device sda, logical block 3982947
> [  880.679573] Buffer I/O error on device sda, logical block 3982948
> [  880.679578] Buffer I/O error on device sda, logical block 3982949
> [  880.679582] Buffer I/O error on device sda, logical block 3982950
> [  880.679586] Buffer I/O error on device sda, logical block 3982951
> [  880.679590] Buffer I/O error on device sda, logical block 3982952
> [  880.679594] Buffer I/O error on device sda, logical block 3982953
> [  880.680296] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> [  880.680301] end_request: I/O error, dev sda, sector 31863808
> [  880.680877] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> [  880.680882] end_request: I/O error, dev sda, sector 31863552
> [  880.681383] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> [  880.681388] end_request: I/O error, dev sda, sector 31863552
> 
> The "funny" thing is that it runs fine using linux-2.6.21-rc2 with 
> Mikael Pettersson's "1.5Gbps only" patch.
> 
> I have replaced the cables without any change. I'm quite sure this isn't 
> a hardware problem as I have uptime counting in months without any 
> problems.
> 
> Here is the relevant part of dmesg (detecting drives):
> 
> [   27.612125] scsi3 : sata_promise
> [   27.612214] ata1: SATA max UDMA/133 cmd 0xe0814380 ctl 0xe08143b8 
> bmdma 0x00000000 irq 19
> [   27.612274] ata2: SATA max UDMA/133 cmd 0xe0814280 ctl 0xe08142b8 
> bmdma 0x00000000 irq 19
> [   27.612334] ata3: SATA max UDMA/133 cmd 0xe0814200 ctl 0xe0814238 
> bmdma 0x00000000 irq 19
> [   27.612394] ata4: SATA max UDMA/133 cmd 0xe0814300 ctl 0xe0814338 
> bmdma 0x00000000 irq 19
> [   28.092787] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   28.143577] ata1.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
> [   28.143626] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
> [   28.235153] ata1.00: configured for UDMA/133
> [   28.722457] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   28.770752] ata2.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
> [   28.770800] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
> [   28.854011] ata2.00: configured for UDMA/133
> [   29.342135] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   29.389819] ata3.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
> [   29.389867] ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
> [   29.473081] ata3.00: configured for UDMA/133
> [   29.961812] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   30.012878] ata4.00: ATA-7: ST3500630NS, 3.AEE, max UDMA/133
> [   30.012926] ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
> [   30.104452] ata4.00: configured for UDMA/133
> [   30.104580] scsi 0:0:0:0: Direct-Access     ATA      ST3500630NS 
>  3.AE PQ: 0 ANSI: 5
> [   30.104720] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors 
> (500108 MB)
> [   30.104780] sd 0:0:0:0: [sda] Write Protect is off
> [   30.104827] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [   30.104841] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA
> [   30.104936] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors 
> (500108 MB)
> [   30.104992] sd 0:0:0:0: [sda] Write Protect is off
> [   30.105039] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [   30.105051] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA
> [   30.105110]  sda: unknown partition table
> [   30.123283] sd 0:0:0:0: [sda] Attached SCSI disk
> [   30.123389] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [   30.123494] scsi 1:0:0:0: Direct-Access     ATA      ST3500630NS 
>  3.AE PQ: 0 ANSI: 5
> [   30.123620] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors 
> (500108 MB)
> [   30.123676] sd 1:0:0:0: [sdb] Write Protect is off
> [   30.123723] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [   30.123735] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA
> [   30.123823] sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors 
> (500108 MB)
> [   30.123878] sd 1:0:0:0: [sdb] Write Protect is off
> [   30.123925] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [   30.123938] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA
> [   30.123997]  sdb: unknown partition table
> [   30.142694] sd 1:0:0:0: [sdb] Attached SCSI disk
> [   30.142796] sd 1:0:0:0: Attached scsi generic sg1 type 0
> [   30.142897] scsi 2:0:0:0: Direct-Access     ATA      ST3500630NS 
>  3.AE PQ: 0 ANSI: 5
> [   30.143025] sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors 
> (500108 MB)
> [   30.143080] sd 2:0:0:0: [sdc] Write Protect is off
> [   30.143127] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [   30.143140] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA
> [   30.143225] sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors 
> (500108 MB)
> [   30.143279] sd 2:0:0:0: [sdc] Write Protect is off
> [   30.143326] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [   30.143339] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA
> [   30.143396]  sdc: unknown partition table
> [   30.154054] sd 2:0:0:0: [sdc] Attached SCSI disk
> [   30.154149] sd 2:0:0:0: Attached scsi generic sg2 type 0
> [   30.154257] scsi 3:0:0:0: Direct-Access     ATA      ST3500630NS 
>  3.AE PQ: 0 ANSI: 5
> [   30.154381] sd 3:0:0:0: [sdd] 976773168 512-byte hardware sectors 
> (500108 MB)
> [   30.154437] sd 3:0:0:0: [sdd] Write Protect is off
> [   30.154484] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> [   30.154496] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA
> [   30.154580] sd 3:0:0:0: [sdd] 976773168 512-byte hardware sectors 
> (500108 MB)
> [   30.154635] sd 3:0:0:0: [sdd] Write Protect is off
> [   30.154682] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> [   30.154694] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: 
> enabled, doesn't support DPO or FUA
> [   30.154753]  sdd: unknown partition table
> [   30.169230] sd 3:0:0:0: [sdd] Attached SCSI disk
> [   30.169329] sd 3:0:0:0: Attached scsi generic sg3 type 0
> 
> I'll be happy to try any patches/suggestions.
> 
> Best regards,
> 
> Peter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

