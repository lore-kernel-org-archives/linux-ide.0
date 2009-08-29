From: Mark Lord <liml@rtr.ca>
Subject: Re: CF to SATA bridge support
Date: Sat, 29 Aug 2009 11:59:44 -0400
Message-ID: <4A995070.4020108@rtr.ca>
References: <43479bc90908071059o2ce5ac94v1d9d959e3af44326@mail.gmail.com>	 <4A7CEF3B.9090506@gmail.com>	 <43479bc90908081135i229d4061k9d461444d3600645@mail.gmail.com> <43479bc90908090923h40305e14mf726d30fbed0733f@mail.gmail.com> <4A80219D.7070708@rtr.ca> <4A9931B2.2020003@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:51987 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551AbZH2P7o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Aug 2009 11:59:44 -0400
In-Reply-To: <4A9931B2.2020003@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mathieu GELI <mathieu.geli@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Mark Lord wrote:
> ..
>> Those errors are on WRITEs, not READs, so no surprise that "hdparm -t" 
>> works.
>> This could be an IORDY issue, or just due to how the the Marvell chips
>> are buggy when doing PIO of more than a single sector.  That was the only
>> errata we didn't do a complete workaround for, because it's so ugly.  :)
>>
>> I have a CF-to-SATA adapter due to arrive here from DealExtreme.com in 
>> the
>> next week or so.  Remind me, and I'll try it out on some of the 
>> Marvell cards here and see what happens.
..

Okay, here we go again.  This time I'm using the correct cable
to the correct SATA controller.  :)

The 32GB UDMA-capable CF-Card works fine for reading/writing
when hotplugged to the Marvell 7042 SATA adaptor.  But.. it did have
some initial stuttering in the logs:

HOTPLUGGING NOW:
[   40.955329] ata11: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xe frozen
[   40.955396] ata11: edma_err_cause=00000010 pp_flags=00000000, dev connect
[   40.955448] ata11: SError: { PHYRdyChg DevExch }
[   40.955503] ata11: hard resetting link
[   46.888022] ata11: link is slow to respond, please be patient (ready=0)
[   50.976034] ata11: SRST failed (errno=-16)
[   50.976105] ata11: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   50.976111] ata11: link online but device misclassified, retrying
[   50.976114] ata11: hard resetting link
[   51.856044] ata11: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   51.880207] ata11.00: CFA: CF Card, Ver2.19, max UDMA/100
[   51.880210] ata11.00: 63045360 sectors, multi 0: LBA 
[   51.880223] ata11.00: applying bridge limits
[   51.896228] ata11.00: configured for UDMA/100
[   51.896236] ata11: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x1 t4
[   51.896289] ata11: edma_err_cause=00000020 pp_flags=00000000, SError=00180000
[   51.920226] ata11.00: configured for UDMA/100
[   51.920233] ata11: EH complete
[   51.920339] scsi 10:0:0:0: Direct-Access     ATA      CF Card          Ver2 PQ: 0 ANSI: 5
[   51.920481] sd 10:0:0:0: [sdb] 63045360 512-byte hardware sectors: (32.2 GB/30.0 GiB)
[   51.920501] sd 10:0:0:0: [sdb] Write Protect is off
[   51.920504] sd 10:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   51.920535] sd 10:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   51.920639] sd 10:0:0:0: [sdb] 63045360 512-byte hardware sectors: (32.2 GB/30.0 GiB)
[   51.920657] sd 10:0:0:0: [sdb] Write Protect is off
[   51.920660] sd 10:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   51.920690] sd 10:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   51.920694]  sdb: sdb1 sdb2
[   51.924771] sd 10:0:0:0: [sdb] Attached SCSI removable disk
[   51.924851] sd 10:0:0:0: Attached scsi generic sg2 type 0

UBUNTU NOW TRIES TO AUTOMOUNT THE TWO PARTITIONS:
[   52.132086] kjournald starting.  Commit interval 5 seconds
[   52.593861] EXT3 FS on sdb1, internal journal
[   52.593868] EXT3-fs: mounted filesystem with ordered data mode.
[   52.611825] EXT4-fs: barriers enabled
[   52.618484] kjournald2 starting.  Commit interval 5 seconds
[   53.082025] EXT4 FS on sdb2, internal journal on sdb2:8
[   53.082030] EXT4-fs: delayed allocation enabled
[   53.082032] EXT4-fs: file extents enabled
[   53.082155] EXT4-fs: mballoc enabled
[   53.082160] EXT4-fs: mounted filesystem with ordered data mode.
[   53.148535] ata11.00: exception Emask 0x0 SAct 0x0 SErr 0x280000 action 0x6 frozen
[   53.148535] ata11.00: edma_err_cause=00000020 pp_flags=00000001, SError=00080000
[   53.148535] ata11: SError: { 10B8B BadCRC }
[   53.148535] ata11.00: cmd c8/00:f8:80:24:04/00:00:00:00:00/e0 tag 0 dma 126976 in
[   53.148535]          res d0/00:f8:80:24:04/00:00:00:00:00/e0 Emask 0x12 (ATA bus error)
[   53.148535] ata11.00: status: { Busy }
[   53.148535] ata11: hard resetting link
[   53.636026] ata11: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   53.676226] ata11.00: configured for UDMA/100
[   53.700232] ata11.00: configured for UDMA/100
[   53.700241] sd 10:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[   53.700246] sd 10:0:0:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
[   53.700252] Descriptor sense data with sense descriptors (in hex):
[   53.700255]         72 0b 47 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
[   53.700268]         00 04 24 80 
[   53.700273] sd 10:0:0:0: [sdb] Add. Sense: Scsi parity error
[   53.700279] end_request: I/O error, dev sdb, sector 271488
[   53.700351] ata11: EH complete
[   53.700373] EXT4-fs error (device sdb2): __ext4_get_inode_loc: <5>sd 10:0:0:0: [sdb] 63045360 512-byte hardware sectors: (32.2 GB/30.0 GiB)
[   53.700430] sd 10:0:0:0: [sdb] Write Protect is off
[   53.700433] sd 10:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   53.700463] sd 10:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   53.700479] unable to read inode block - inode=32743, block=2562
[   53.700506] sd 10:0:0:0: [sdb] 63045360 512-byte hardware sectors: (32.2 GB/30.0 GiB)
[   53.703345] sd 10:0:0:0: [sdb] Write Protect is off
[   53.703349] sd 10:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   53.703388] sd 10:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   84.276379] ata11.00: exception Emask 0x0 SAct 0x0 SErr 0x100000 action 0x6 frozen
[   84.276444] ata11.00: edma_err_cause=00000020 pp_flags=00000001, SError=00100000
[   84.276509] ata11: SError: { Dispar }
[   84.276560] ata11.00: cmd ca/00:08:f0:e4:03/00:00:00:00:00/e0 tag 0 dma 4096 out
[   84.276562]          res d0/00:08:f0:e4:03/00:00:00:00:00/e0 Emask 0x12 (ATA bus error)
[   84.276687] ata11.00: status: { Busy }
[   84.276738] ata11: hard resetting link
[   84.752043] ata11: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   84.792226] ata11.00: configured for UDMA/100
[   84.816244] ata11.00: configured for UDMA/100
[   84.816251] ata11: EH complete
[   84.820902] sd 10:0:0:0: [sdb] 63045360 512-byte hardware sectors: (32.2 GB/30.0 GiB)
[   84.823276] sd 10:0:0:0: [sdb] Write Protect is off
[   84.823279] sd 10:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   85.751705] sd 10:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   85.754175] sd 10:0:0:0: [sdb] 63045360 512-byte hardware sectors: (32.2 GB/30.0 GiB)
[   85.754194] sd 10:0:0:0: [sdb] Write Protect is off
[   85.754197] sd 10:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   85.754227] sd 10:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   94.226353] EXT4-fs: mballoc: 0 blocks 0 reqs (0 success)
[   94.226357] EXT4-fs: mballoc: 0 extents scanned, 0 goal hits, 0 2^N hits, 0 breaks, 0 lost
[   94.226360] EXT4-fs: mballoc: 0 generated and it took 0
[   94.226362] EXT4-fs: mballoc: 0 preallocated, 0 discarded
[  109.737249] ata11: limiting SATA link speed to 1.5 Gbps
[  109.737249] ata11.00: exception Emask 0x0 SAct 0x0 SErr 0x100000 action 0x6 frozen
[  109.737249] ata11.00: edma_err_cause=00000020 pp_flags=00000001, SError=00100000
[  109.737249] ata11: SError: { Dispar }
[  109.737249] ata11.00: cmd c8/00:00:00:2a:00/00:00:00:00:00/e0 tag 0 dma 131072 in
[  109.737249]          res d0/00:00:00:2a:00/00:00:00:00:00/e0 Emask 0x12 (ATA bus error)
[  109.737249] ata11.00: status: { Busy }
[  109.737249] ata11: hard resetting link
[  110.224035] ata11: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  110.264228] ata11.00: configured for UDMA/100
[  110.288226] ata11.00: configured for UDMA/100
[  110.288233] ata11: EH complete
[  110.296128] sd 10:0:0:0: [sdb] 63045360 512-byte hardware sectors: (32.2 GB/30.0 GiB)
[  110.299660] sd 10:0:0:0: [sdb] Write Protect is off
[  110.299663] sd 10:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  110.306738] sd 10:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  110.313811] sd 10:0:0:0: [sdb] 63045360 512-byte hardware sectors: (32.2 GB/30.0 GiB)
[  110.317344] sd 10:0:0:0: [sdb] Write Protect is off
[  110.317348] sd 10:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  110.324411] sd 10:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA

FROM THIS POINT ONWARD, ALL WAS FINE, READING/WRITING, WHATEVER.

Cheers
