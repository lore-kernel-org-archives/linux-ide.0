From: Mikael Abrahamsson <swmike@swm.pp.se>
Subject: Re: PMPs
Date: Fri, 17 Apr 2009 20:26:59 +0200 (CEST)
Message-ID: <alpine.DEB.1.10.0904171929050.29570@uplift.swm.pp.se>
References: <alpine.DEB.1.10.0904012109180.28814@uplift.swm.pp.se> <49D4073C.4010101@kernel.org> <alpine.DEB.1.10.0904081958100.29570@uplift.swm.pp.se> <49E46997.2060302@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from swm.pp.se ([212.247.200.143]:45779 "EHLO uplift.swm.pp.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394AbZDQS1C (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 14:27:02 -0400
In-Reply-To: <49E46997.2060302@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Tue, 14 Apr 2009, Tejun Heo wrote:

> Can you please try 2.6.29 and post full kernel log?

I have posted a boot time dmesg at <http://swm.pp.se/dmesg090416.txt>

Executive summary of everything that follows below (my opinion of what is 
happening):

If a drive isn't present at boot time in a slot, it's somehow 
"uninitialised". Inserting a drive into a slot not populated before, 
doesn't get detected. If I leave the "undetected" drive, and unplug slot 0 
drive and insert it again, it's now detected and hotplugging of that drive 
works again. I verified this behaviour with slot 2, 3 and 4 below:

So, summary of events (first references the above dmesg file):

At 54s I unplug port1, at 65s I unplug port0, at ~90s I insert same disk 
in port0, at around 120s I insert port1, nothing happens, I then remove 
port0 again, and re-insert it at ~150 or so.

Since I am a bit uncertain about the times above, I'll do it one more time 
and mark each event. State when beginning, both drives are seen.

Unplug port 1:

[  643.891758] ata8.01: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[  643.891763] ata8.01: SError: { PHYRdyChg CommWake DevExch }
[  643.891831] ata8.01: hard resetting link
[  644.616328] ata8.01: SATA link down (SStatus 0 SControl 320)
[  649.616021] ata8.01: hard resetting link
[  649.936351] ata8.01: SATA link down (SStatus 0 SControl 320)
[  649.936416] ata8.01: limiting SATA link speed to 1.5 Gbps
[  654.936038] ata8.01: hard resetting link
[  655.256346] ata8.01: SATA link down (SStatus 0 SControl 310)
[  655.256381] ata8.01: disabled
[  655.256480] ata8: EH complete
[  655.256486] ata8.01: detaching (SCSI 9:1:0:0)
[  655.256808] sd 9:1:0:0: [sdc] Synchronizing SCSI cache
[  655.258065] sd 9:1:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  655.258069] sd 9:1:0:0: [sdc] Stopping disk
[  655.258075] sd 9:1:0:0: [sdc] START_STOP FAILED
[  655.258077] sd 9:1:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

Insert drive 1:

[  700.214554] ata8.01: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[  700.214559] ata8.01: SError: { PHYRdyChg CommWake DevExch }
[  700.214633] ata8.01: hard resetting link
[  700.936351] ata8.01: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  701.048018] ata8.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[  701.048023] ata8.15: hard resetting link
[  701.048025] ata8: controller in dubious state, performing PORT_RST
[  703.280039] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  703.280282] ata8.00: hard resetting link
[  703.600344] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  705.936009] ata8.01: hard resetting link
[  706.256343] ata8.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  706.256348] ata8.02: hard resetting link
[  706.576326] ata8.02: SATA link down (SStatus 0 SControl 320)
[  706.576331] ata8.03: hard resetting link
[  706.896350] ata8.03: SATA link down (SStatus 0 SControl 320)
[  706.896355] ata8.04: hard resetting link
[  707.216351] ata8.04: SATA link down (SStatus 0 SControl 320)
[  707.216356] ata8.05: hard resetting link
[  707.536348] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  707.545142] ata8.00: configured for UDMA/100
[  707.656528] ata8.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[  707.656533] ata8.15: hard resetting link
[  707.656535] ata8: controller in dubious state, performing PORT_RST
[  709.888550] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  709.888791] ata8.00: hard resetting link
[  710.208845] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  711.257020] ata8.01: hard resetting link
[  711.576370] ata8.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  712.537019] ata8.05: hard resetting link
[  712.856333] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  712.878925] ata8.00: configured for UDMA/100
[  712.888057] ata8.01: ATA-8: WDC WD5000AAKS-00YGA0, 12.01C02, max UDMA/133
[  712.888061] ata8.01: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  712.888988] ata8.01: configured for UDMA/100
[  712.889363] ata8: EH complete
[  712.889392] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
[  712.889408] sd 9:0:0:0: [sdb] Write Protect is off
[  712.889414] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  712.889435] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  712.889460] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
[  712.889475] sd 9:0:0:0: [sdb] Write Protect is off
[  712.889480] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  712.889500] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  712.889559] scsi 9:1:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12.0 PQ: 0 ANSI: 5
[  712.890195] sd 9:1:0:0: [sdc] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
[  712.890211] sd 9:1:0:0: [sdc] Write Protect is off
[  712.890216] sd 9:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  712.890236] sd 9:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  712.890291] sd 9:1:0:0: [sdc] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
[  712.890306] sd 9:1:0:0: [sdc] Write Protect is off
[  712.890311] sd 9:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[  712.890332] sd 9:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  712.890340]  sdc: sdc1 sdc2 sdc3 sdc4
[  712.899432] sd 9:1:0:0: [sdc] Attached SCSI disk
[  712.899481] sd 9:1:0:0: Attached scsi generic sg2 type 0

Hm, so now it worked for some reason.

I unplug port1 again:

[  778.054235] ata8.01: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[  778.054240] ata8.01: SError: { PHYRdyChg CommWake DevExch }
[  778.054308] ata8.01: hard resetting link
[  778.776330] ata8.01: SATA link down (SStatus 0 SControl 320)
[  783.776010] ata8.01: hard resetting link
[  784.096341] ata8.01: SATA link down (SStatus 0 SControl 320)
[  784.096406] ata8.01: limiting SATA link speed to 1.5 Gbps
[  789.096019] ata8.01: hard resetting link
[  789.416352] ata8.01: SATA link down (SStatus 0 SControl 310)
[  789.416387] ata8.01: disabled
[  789.416482] ata8: EH complete
[  789.416492] ata8.01: detaching (SCSI 9:1:0:0)
[  789.416839] sd 9:1:0:0: [sdc] Synchronizing SCSI cache
[  789.417758] sd 9:1:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  789.417762] sd 9:1:0:0: [sdc] Stopping disk
[  789.417769] sd 9:1:0:0: [sdc] START_STOP FAILED
[  789.417770] sd 9:1:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

I put it in port 2 (hm, I'm a bit unsure this is correct, it seems that I 
might have done something else here, after inserting into slot 2 drive 
isn't visible anyway):

[  842.604261] ata8.01: exception Emask 0x10 SAct 0x0 SErr 0x4010000 
action 0xf
[  842.604267] ata8.01: SError: { PHYRdyChg DevExch }
[  842.604334] ata8.01: hard resetting link
[  843.328351] ata8.01: SATA link down (SStatus 0 SControl 320)
[  848.328014] ata8.01: hard resetting link
[  848.648327] ata8.01: SATA link down (SStatus 0 SControl 320)
[  848.648390] ata8.01: limiting SATA link speed to 1.5 Gbps
[  853.648009] ata8.01: hard resetting link
[  853.968354] ata8.01: SATA link down (SStatus 0 SControl 310)
[  853.968389] ata8.01: disabled
[  853.968487] ata8: EH complete
[  853.968496] ata8.01: detaching (SCSI 9:1:0:0)
[  853.968843] sd 9:1:0:0: [sdc] Synchronizing SCSI cache
[  853.969629] sd 9:1:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  853.969633] sd 9:1:0:0: [sdc] Stopping disk
[  853.969640] sd 9:1:0:0: [sdc] START_STOP FAILED
[  853.969641] sd 9:1:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

(now I got interrupted by a phone call, but the drive is in port 2, fdisk 
doesn't show any sdc drive)

I then unplug port 0:

[ 2321.457367] ata8.00: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
[ 2321.457372] ata8.00: SError: { PHYRdyChg DevExch }
[ 2321.457439] ata8.00: hard resetting link
[ 2322.180327] ata8.00: SATA link down (SStatus 0 SControl 320)
[ 2327.180011] ata8.00: hard resetting link
[ 2327.500352] ata8.00: SATA link down (SStatus 0 SControl 320)
[ 2327.500424] ata8.00: limiting SATA link speed to 1.5 Gbps
[ 2332.500010] ata8.00: hard resetting link
[ 2332.820325] ata8.00: SATA link down (SStatus 0 SControl 310)
[ 2332.820361] ata8.00: disabled
[ 2332.820465] ata8: EH complete
[ 2332.820470] ata8.00: detaching (SCSI 9:0:0:0)
[ 2332.820711] sd 9:0:0:0: [sdb] Synchronizing SCSI cache
[ 2332.821381] sd 9:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[ 2332.821385] sd 9:0:0:0: [sdb] Stopping disk
[ 2332.821392] sd 9:0:0:0: [sdb] START_STOP FAILED
[ 2332.821393] sd 9:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

And insert port 0 again (without touching port 2)

[ 2434.688051] ata8.00: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
[ 2434.688056] ata8.00: SError: { PHYRdyChg CommWake DevExch }
[ 2434.688126] ata8.00: hard resetting link
[ 2435.412327] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2435.524018] ata8.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2435.524024] ata8.15: hard resetting link
[ 2435.524026] ata8: controller in dubious state, performing PORT_RST
[ 2437.756039] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2440.412009] ata8.00: hard resetting link
[ 2440.732339] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2440.732344] ata8.01: hard resetting link
[ 2441.052327] ata8.01: SATA link down (SStatus 0 SControl 320)
[ 2441.052332] ata8.02: hard resetting link
[ 2441.372352] ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2441.372357] ata8.03: hard resetting link
[ 2441.692335] ata8.03: SATA link down (SStatus 0 SControl 320)
[ 2441.692340] ata8.04: hard resetting link
[ 2442.012349] ata8.04: SATA link down (SStatus 0 SControl 320)
[ 2442.012353] ata8.05: hard resetting link
[ 2442.332353] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2442.444018] ata8.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2442.444022] ata8.15: hard resetting link
[ 2442.444025] ata8: controller in dubious state, performing PORT_RST
[ 2444.676039] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2445.732012] ata8.00: hard resetting link
[ 2446.052351] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2446.372010] ata8.02: hard resetting link
[ 2446.692342] ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2447.332011] ata8.05: hard resetting link
[ 2447.652327] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2447.664104] ata8.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
[ 2447.664108] ata8.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 2447.666162] ata8.00: configured for UDMA/100
[ 2447.677536] ata8.02: ATA-8: WDC WD5000AAKS-00YGA0, 12.01C02, max UDMA/133
[ 2447.677539] ata8.02: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 2447.678487] ata8.02: configured for UDMA/100
[ 2447.678853] ata8: EH complete
[ 2447.678936] scsi 9:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
[ 2447.679618] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
[ 2447.679630] sd 9:0:0:0: [sdb] Write Protect is off
[ 2447.679632] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2447.679649] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2447.679699] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
[ 2447.679709] sd 9:0:0:0: [sdb] Write Protect is off
[ 2447.679710] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2447.679727] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2447.679730]  sdb: sdb1
[ 2447.685145] sd 9:0:0:0: [sdb] Attached SCSI disk
[ 2447.685198] sd 9:0:0:0: Attached scsi generic sg1 type 0
[ 2447.685285] scsi 9:2:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12.0 PQ: 0 ANSI: 5
[ 2447.685395] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
[ 2447.685406] sd 9:2:0:0: [sdc] Write Protect is off
[ 2447.685408] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2447.685425] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2447.685486] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors: (500 GB/465 GiB)
[ 2447.685496] sd 9:2:0:0: [sdc] Write Protect is off
[ 2447.685497] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2447.685514] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 2447.685516]  sdc: sdc1 sdc2 sdc3 sdc4
[ 2447.697161] sd 9:2:0:0: [sdc] Attached SCSI disk
[ 2447.697213] sd 9:2:0:0: Attached scsi generic sg2 type 0

So now both drives are visible again:

I unplug port 2:

[ 2544.467211] ata8.02: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
[ 2544.467217] ata8.02: SError: { PHYRdyChg DevExch }
[ 2544.467291] ata8.02: hard resetting link
[ 2545.188325] ata8.02: SATA link down (SStatus 0 SControl 320)
[ 2550.188026] ata8.02: hard resetting link
[ 2550.508351] ata8.02: SATA link down (SStatus 0 SControl 320)
[ 2550.508424] ata8.02: limiting SATA link speed to 1.5 Gbps
[ 2555.508019] ata8.02: hard resetting link
[ 2555.828350] ata8.02: SATA link down (SStatus 0 SControl 310)
[ 2555.828385] ata8.02: disabled
[ 2555.828482] ata8: EH complete
[ 2555.828487] ata8.02: detaching (SCSI 9:2:0:0)
[ 2555.828837] sd 9:2:0:0: [sdc] Synchronizing SCSI cache
[ 2555.829165] sd 9:2:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[ 2555.829168] sd 9:2:0:0: [sdc] Stopping disk
[ 2555.829175] sd 9:2:0:0: [sdc] START_STOP FAILED
[ 2555.829176] sd 9:2:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

and insert it again:

[ 2583.535671] ata8.02: exception Emask 0x10 SAct 0x0 SErr 0x4050000 
action 0xf
[ 2583.535676] ata8.02: SError: { PHYRdyChg CommWake DevExch }
[ 2583.535745] ata8.02: hard resetting link
[ 2584.256347] ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2584.368019] ata8.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2584.368024] ata8.15: hard resetting link
[ 2584.368026] ata8: controller in dubious state, performing PORT_RST
[ 2586.600039] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2586.600287] ata8.00: hard resetting link
[ 2586.920342] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2586.920347] ata8.01: hard resetting link
[ 2587.240340] ata8.01: SATA link down (SStatus 0 SControl 320)
[ 2589.256008] ata8.02: hard resetting link
[ 2589.576327] ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2589.576332] ata8.03: hard resetting link
[ 2589.896343] ata8.03: SATA link down (SStatus 0 SControl 320)
[ 2589.896347] ata8.04: hard resetting link
[ 2590.216324] ata8.04: SATA link down (SStatus 0 SControl 320)
[ 2590.216329] ata8.05: hard resetting link
[ 2590.536352] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2590.558972] ata8.00: configured for UDMA/100
[ 2590.669019] ata8.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2590.669023] ata8.15: hard resetting link
[ 2590.669026] ata8: controller in dubious state, performing PORT_RST
[ 2592.901040] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2592.901291] ata8.00: hard resetting link
[ 2593.221323] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2593.221327] ata8.01: hard resetting link
[ 2593.540357] ata8.01: SATA link down (SStatus 0 SControl 320)
[ 2594.577017] ata8.02: hard resetting link
[ 2594.897334] ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2595.537018] ata8.05: hard resetting link
[ 2595.856356] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2595.878945] ata8.00: configured for UDMA/100
[ 2595.886571] ata8.02: ATA-8: WDC WD5000AAKS-00YGA0, 12.01C02, max 
UDMA/133
[ 2595.886575] ata8.02: 976773168 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[ 2595.887523] ata8.02: configured for UDMA/100
[ 2595.887890] ata8: EH complete
[ 2595.887937] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 2595.887955] sd 9:0:0:0: [sdb] Write Protect is off
[ 2595.887958] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2595.887983] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 2595.888013] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 2595.888028] sd 9:0:0:0: [sdb] Write Protect is off
[ 2595.888030] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2595.888055] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 2595.888114] scsi 9:2:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 
12.0 PQ: 0 ANSI: 5
[ 2595.888450] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 2595.888461] sd 9:2:0:0: [sdc] Write Protect is off
[ 2595.888463] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2595.888479] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 2595.888529] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 2595.888544] sd 9:2:0:0: [sdc] Write Protect is off
[ 2595.888545] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2595.890701] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 2595.890705]  sdc: sdc1 sdc2 sdc3 sdc4
[ 2595.906229] sd 9:2:0:0: [sdc] Attached SCSI disk
[ 2595.906278] sd 9:2:0:0: Attached scsi generic sg2 type 0

Unplug port 2:

  2622.989543] ata8.02: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
[ 2622.989549] ata8.02: SError: { PHYRdyChg DevExch }
[ 2622.989617] ata8.02: hard resetting link
[ 2623.712341] ata8.02: SATA link down (SStatus 0 SControl 320)
[ 2628.712011] ata8.02: hard resetting link
[ 2629.032325] ata8.02: SATA link down (SStatus 0 SControl 320)
[ 2629.032387] ata8.02: limiting SATA link speed to 1.5 Gbps
[ 2634.032027] ata8.02: hard resetting link
[ 2634.352350] ata8.02: SATA link down (SStatus 0 SControl 310)
[ 2634.352385] ata8.02: disabled
[ 2634.352483] ata8: EH complete
[ 2634.352493] ata8.02: detaching (SCSI 9:2:0:0)
[ 2634.352839] sd 9:2:0:0: [sdc] Synchronizing SCSI cache
[ 2634.353647] sd 9:2:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[ 2634.353651] sd 9:2:0:0: [sdc] Stopping disk
[ 2634.353657] sd 9:2:0:0: [sdc] START_STOP FAILED

and put it in port 3, nothing happens.

I remove it from port 3 and put it back in, still nothing happens.

I remove it from port 3 and put it in port 2:

[ 2780.275439] ata8.02: exception Emask 0x10 SAct 0x0 SErr 0x4050000 
action 0xf
[ 2780.275444] ata8.02: SError: { PHYRdyChg CommWake DevExch }
[ 2780.275511] ata8.02: hard resetting link
[ 2780.996352] ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2781.108018] ata8.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2781.108024] ata8.15: hard resetting link
[ 2781.108026] ata8: controller in dubious state, performing PORT_RST
[ 2783.340039] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2783.340285] ata8.00: hard resetting link
[ 2783.660341] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2783.660346] ata8.01: hard resetting link
[ 2783.980325] ata8.01: SATA link down (SStatus 0 SControl 320)
[ 2785.996027] ata8.02: hard resetting link
[ 2786.316349] ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2786.316354] ata8.03: hard resetting link
[ 2786.636326] ata8.03: SATA link down (SStatus 0 SControl 320)
[ 2786.636331] ata8.04: hard resetting link
[ 2786.956343] ata8.04: SATA link down (SStatus 0 SControl 320)
[ 2786.956347] ata8.05: hard resetting link
[ 2787.276333] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2787.281951] ata8.00: configured for UDMA/100
[ 2787.392049] ata8.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2787.392053] ata8.15: hard resetting link
[ 2787.392056] ata8: controller in dubious state, performing PORT_RST
[ 2789.624059] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2789.624317] ata8.00: hard resetting link
[ 2789.944349] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2789.944353] ata8.01: hard resetting link
[ 2790.264323] ata8.01: SATA link down (SStatus 0 SControl 320)
[ 2791.316407] ata8.02: hard resetting link
[ 2791.636349] ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2792.276017] ata8.05: hard resetting link
[ 2792.596344] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2792.618938] ata8.00: configured for UDMA/100
[ 2792.639846] ata8.02: ATA-8: WDC WD5000AAKS-00YGA0, 12.01C02, max 
UDMA/133
[ 2792.639849] ata8.02: 976773168 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[ 2792.640763] ata8.02: configured for UDMA/100
[ 2792.641166] ata8: EH complete
[ 2792.641203] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 2792.641220] sd 9:0:0:0: [sdb] Write Protect is off
[ 2792.641223] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2792.641248] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 2792.641277] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 2792.641292] sd 9:0:0:0: [sdb] Write Protect is off
[ 2792.641295] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2792.641319] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 2792.641392] scsi 9:2:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 
12.0 PQ: 0 ANSI: 5
[ 2792.642033] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 2792.642044] sd 9:2:0:0: [sdc] Write Protect is off
[ 2792.642046] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2792.642062] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 2792.642112] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 2792.642122] sd 9:2:0:0: [sdc] Write Protect is off
[ 2792.642123] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2792.642140] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 2792.642143]  sdc: sdc1 sdc2 sdc3 sdc4
[ 2792.651191] sd 9:2:0:0: [sdc] Attached SCSI disk
[ 2792.651243] sd 9:2:0:0: Attached scsi generic sg2 type 0

Remove it again:

[ 2828.634009] ata8.02: exception Emask 0x10 SAct 0x0 SErr 0x4010000 
action 0xf
[ 2828.634014] ata8.02: SError: { PHYRdyChg DevExch }
[ 2828.634082] ata8.02: hard resetting link
[ 2829.356350] ata8.02: SATA link down (SStatus 0 SControl 320)
[ 2834.356010] ata8.02: hard resetting link
[ 2834.676328] ata8.02: SATA link down (SStatus 0 SControl 320)
[ 2834.676391] ata8.02: limiting SATA link speed to 1.5 Gbps
[ 2839.676011] ata8.02: hard resetting link
[ 2839.996334] ata8.02: SATA link down (SStatus 0 SControl 310)
[ 2839.996368] ata8.02: disabled
[ 2839.996464] ata8: EH complete
[ 2839.996468] ata8.02: detaching (SCSI 9:2:0:0)
[ 2839.996795] sd 9:2:0:0: [sdc] Synchronizing SCSI cache
[ 2839.998377] sd 9:2:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK
[ 2839.998382] sd 9:2:0:0: [sdc] Stopping disk
[ 2839.998388] sd 9:2:0:0: [sdc] START_STOP FAILED
[ 2839.998389] sd 9:2:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK

Put it back in:

[ 2861.359940] ata8.02: exception Emask 0x10 SAct 0x0 SErr 0x4050000 
action 0xf
[ 2861.359946] ata8.02: SError: { PHYRdyChg CommWake DevExch }
[ 2861.360015] ata8.02: hard resetting link
[ 2862.084324] ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2862.196018] ata8.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2862.196023] ata8.15: hard resetting link
[ 2862.196026] ata8: controller in dubious state, performing PORT_RST
[ 2864.428038] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2864.428281] ata8.00: hard resetting link
[ 2864.748324] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2864.748329] ata8.01: hard resetting link
[ 2865.068335] ata8.01: SATA link down (SStatus 0 SControl 320)
[ 2867.084016] ata8.02: hard resetting link
[ 2867.404340] ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2867.404345] ata8.03: hard resetting link
[ 2867.724323] ata8.03: SATA link down (SStatus 0 SControl 320)
[ 2867.724327] ata8.04: hard resetting link
[ 2868.044337] ata8.04: SATA link down (SStatus 0 SControl 320)
[ 2868.044342] ata8.05: hard resetting link
[ 2868.364343] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2868.386951] ata8.00: configured for UDMA/100
[ 2868.497523] ata8.02: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2868.497527] ata8.15: hard resetting link
[ 2868.497530] ata8: controller in dubious state, performing PORT_RST
[ 2870.729542] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2870.729783] ata8.00: hard resetting link
[ 2871.053843] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2871.053847] ata8.01: hard resetting link
[ 2871.385345] ata8.01: SATA link down (SStatus 0 SControl 320)
[ 2872.404009] ata8.02: hard resetting link
[ 2872.724320] ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2873.365529] ata8.05: hard resetting link
[ 2873.684319] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2873.706915] ata8.00: configured for UDMA/100
[ 2873.716621] ata8.02: ATA-8: WDC WD5000AAKS-00YGA0, 12.01C02, max 
UDMA/133
[ 2873.716625] ata8.02: 976773168 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[ 2873.717577] ata8.02: configured for UDMA/100
[ 2873.717950] ata8: EH complete
[ 2873.717981] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 2873.717993] sd 9:0:0:0: [sdb] Write Protect is off
[ 2873.717994] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2873.718011] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 2873.718032] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 2873.718042] sd 9:0:0:0: [sdb] Write Protect is off
[ 2873.718044] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2873.718060] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 2873.718113] scsi 9:2:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 
12.0 PQ: 0 ANSI: 5
[ 2873.718428] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 2873.718439] sd 9:2:0:0: [sdc] Write Protect is off
[ 2873.718441] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2873.718458] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 2873.718510] sd 9:2:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 2873.718520] sd 9:2:0:0: [sdc] Write Protect is off
[ 2873.718522] sd 9:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 2873.718539] sd 9:2:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 2873.718542]  sdc: sdc1 sdc2 sdc3 sdc4
[ 2873.727984] sd 9:2:0:0: [sdc] Attached SCSI disk

Remove it from slot 2, put it in slot 3:

nothing happens (apart from that the disconnection from slot 2 is 
detected)

I unplug port 0:

[ 2948.904873] ata8.00: exception Emask 0x10 SAct 0x0 SErr 0x4010000 
action 0xf
[ 2948.904879] ata8.00: SError: { PHYRdyChg DevExch }
[ 2948.904946] ata8.00: hard resetting link
[ 2949.628361] ata8.00: SATA link down (SStatus 0 SControl 320)
[ 2954.628015] ata8.00: hard resetting link
[ 2954.948351] ata8.00: SATA link down (SStatus 0 SControl 320)
[ 2954.948413] ata8.00: limiting SATA link speed to 1.5 Gbps
[ 2959.948012] ata8.00: hard resetting link
[ 2960.268324] ata8.00: SATA link down (SStatus 0 SControl 310)
[ 2960.268359] ata8.00: disabled
[ 2960.268455] ata8: EH complete
[ 2960.268460] ata8.00: detaching (SCSI 9:0:0:0)
[ 2960.268714] sd 9:0:0:0: [sdb] Synchronizing SCSI cache
[ 2960.268738] sd 9:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK
[ 2960.268741] sd 9:0:0:0: [sdb] Stopping disk
[ 2960.268747] sd 9:0:0:0: [sdb] START_STOP FAILED
[ 2960.268748] sd 9:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK

and put it back in again:

[ 2988.556210] ata8.00: exception Emask 0x10 SAct 0x0 SErr 0x4050000 
action 0xf
[ 2988.556215] ata8.00: SError: { PHYRdyChg CommWake DevExch }
[ 2988.556298] ata8.00: hard resetting link
[ 2989.280352] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2989.392018] ata8.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2989.392023] ata8.15: hard resetting link
[ 2989.392026] ata8: controller in dubious state, performing PORT_RST
[ 2991.624039] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2994.280009] ata8.00: hard resetting link
[ 2994.600351] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 2994.600356] ata8.01: hard resetting link
[ 2994.920335] ata8.01: SATA link down (SStatus 0 SControl 320)
[ 2994.920339] ata8.02: hard resetting link
[ 2995.240342] ata8.02: SATA link down (SStatus 0 SControl 320)
[ 2995.240346] ata8.03: hard resetting link
[ 2995.560350] ata8.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 2995.560355] ata8.04: hard resetting link
[ 2995.880333] ata8.04: SATA link down (SStatus 0 SControl 320)
[ 2995.880337] ata8.05: hard resetting link
[ 2996.200348] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 2996.312018] ata8.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 2996.312022] ata8.15: hard resetting link
[ 2996.312025] ata8: controller in dubious state, performing PORT_RST
[ 2998.544039] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 2999.600011] ata8.00: hard resetting link
[ 2999.920349] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3000.560017] ata8.03: hard resetting link
[ 3000.880348] ata8.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3001.200010] ata8.05: hard resetting link
[ 3001.520325] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 3001.522278] ata8.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
[ 3001.522282] ata8.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[ 3001.524349] ata8.00: configured for UDMA/100
[ 3001.538285] ata8.03: ATA-8: WDC WD5000AAKS-00YGA0, 12.01C02, max 
UDMA/133
[ 3001.538288] ata8.03: 976773168 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[ 3001.539229] ata8.03: configured for UDMA/100
[ 3001.539611] ata8: EH complete
[ 3001.539692] scsi 9:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ 
CR10 PQ: 0 ANSI: 5
[ 3001.540318] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3001.540331] sd 9:0:0:0: [sdb] Write Protect is off
[ 3001.540333] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3001.540350] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3001.540402] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3001.540413] sd 9:0:0:0: [sdb] Write Protect is off
[ 3001.540415] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3001.540432] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3001.540436]  sdb: sdb1
[ 3001.546841] sd 9:0:0:0: [sdb] Attached SCSI disk
[ 3001.546896] sd 9:0:0:0: Attached scsi generic sg1 type 0
[ 3001.546980] scsi 9:3:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 
12.0 PQ: 0 ANSI: 5
[ 3001.547054] sd 9:3:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3001.547065] sd 9:3:0:0: [sdc] Write Protect is off
[ 3001.547066] sd 9:3:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3001.547083] sd 9:3:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3001.547125] sd 9:3:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3001.547135] sd 9:3:0:0: [sdc] Write Protect is off
[ 3001.547136] sd 9:3:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3001.547153] sd 9:3:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3001.547155]  sdc: sdc1 sdc2 sdc3 sdc4
[ 3001.557923] sd 9:3:0:0: [sdc] Attached SCSI disk
[ 3001.557998] sd 9:3:0:0: Attached scsi generic sg2 type 0

I then unplug port 3:

[ 3042.308009] ata8.03: hard resetting link
[ 3042.628343] ata8.03: SATA link down (SStatus 0 SControl 310)
[ 3042.628378] ata8.03: disabled
[ 3042.628474] ata8: EH complete
[ 3042.628483] ata8.03: detaching (SCSI 9:3:0:0)
[ 3042.628816] sd 9:3:0:0: [sdc] Synchronizing SCSI cache
[ 3042.629167] sd 9:3:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK
[ 3042.629170] sd 9:3:0:0: [sdc] Stopping disk
[ 3042.629176] sd 9:3:0:0: [sdc] START_STOP FAILED
[ 3042.629178] sd 9:3:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK

and put it back in:

[ 3063.050104] ata8.03: exception Emask 0x10 SAct 0x0 SErr 0x4050000 
action 0xf
[ 3063.050109] ata8.03: SError: { PHYRdyChg CommWake DevExch }
[ 3063.050185] ata8.03: hard resetting link
[ 3063.772345] ata8.03: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3063.884018] ata8.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 3063.884023] ata8.15: hard resetting link
[ 3063.884026] ata8: controller in dubious state, performing PORT_RST
[ 3066.116039] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 3066.116286] ata8.00: hard resetting link
[ 3066.436331] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3066.436336] ata8.01: hard resetting link
[ 3066.756341] ata8.01: SATA link down (SStatus 0 SControl 320)
[ 3066.756346] ata8.02: hard resetting link
[ 3067.076335] ata8.02: SATA link down (SStatus 0 SControl 320)
[ 3068.772008] ata8.03: hard resetting link
[ 3069.092325] ata8.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3069.092330] ata8.04: hard resetting link
[ 3069.412347] ata8.04: SATA link down (SStatus 0 SControl 320)
[ 3069.412350] ata8.05: hard resetting link
[ 3069.732335] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 3069.754950] ata8.00: configured for UDMA/100
[ 3069.865520] ata8.03: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 3069.865524] ata8.15: hard resetting link
[ 3069.865526] ata8: controller in dubious state, performing PORT_RST
[ 3072.097540] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 3072.097788] ata8.00: hard resetting link
[ 3072.416370] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3072.416375] ata8.01: hard resetting link
[ 3072.741837] ata8.01: SATA link down (SStatus 0 SControl 320)
[ 3072.741842] ata8.02: hard resetting link
[ 3073.060344] ata8.02: SATA link down (SStatus 0 SControl 320)
[ 3074.093518] ata8.03: hard resetting link
[ 3074.412849] ata8.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3074.732597] ata8.05: hard resetting link
[ 3075.052353] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 3075.074950] ata8.00: configured for UDMA/100
[ 3075.082664] ata8.03: ATA-8: WDC WD5000AAKS-00YGA0, 12.01C02, max 
UDMA/133
[ 3075.082668] ata8.03: 976773168 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[ 3075.083618] ata8.03: configured for UDMA/100
[ 3075.084001] ata8: EH complete
[ 3075.084048] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3075.084070] sd 9:0:0:0: [sdb] Write Protect is off
[ 3075.084076] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3075.084105] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3075.084140] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3075.084160] sd 9:0:0:0: [sdb] Write Protect is off
[ 3075.084166] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3075.084205] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3075.084264] scsi 9:3:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 
12.0 PQ: 0 ANSI: 5
[ 3075.084877] sd 9:3:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3075.084893] sd 9:3:0:0: [sdc] Write Protect is off
[ 3075.084899] sd 9:3:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3075.084919] sd 9:3:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3075.084975] sd 9:3:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3075.084990] sd 9:3:0:0: [sdc] Write Protect is off
[ 3075.084995] sd 9:3:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3075.085015] sd 9:3:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3075.085024]  sdc: sdc1 sdc2 sdc3 sdc4
[ 3075.094031] sd 9:3:0:0: [sdc] Attached SCSI disk
[ 3075.094083] sd 9:3:0:0: Attached scsi generic sg2 type 0

Unplug port 3:

[ 3096.959797] ata8.03: exception Emask 0x10 SAct 0x0 SErr 0x4010000 
action 0xf
[ 3096.959803] ata8.03: SError: { PHYRdyChg DevExch }
[ 3096.959870] ata8.03: hard resetting link
[ 3097.684321] ata8.03: SATA link down (SStatus 0 SControl 320)
[ 3102.684030] ata8.03: hard resetting link
[ 3103.004350] ata8.03: SATA link down (SStatus 0 SControl 320)
[ 3103.004414] ata8.03: limiting SATA link speed to 1.5 Gbps
[ 3108.004028] ata8.03: hard resetting link
[ 3108.324348] ata8.03: SATA link down (SStatus 0 SControl 310)
[ 3108.324382] ata8.03: disabled
[ 3108.324478] ata8: EH complete
[ 3108.324484] ata8.03: detaching (SCSI 9:3:0:0)
[ 3108.324837] sd 9:3:0:0: [sdc] Synchronizing SCSI cache
[ 3108.325299] sd 9:3:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK
[ 3108.325303] sd 9:3:0:0: [sdc] Stopping disk
[ 3108.325309] sd 9:3:0:0: [sdc] START_STOP FAILED
[ 3108.325311] sd 9:3:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK

Insert into port 4:

nothing happens.

Remove slot 0:

[ 3154.126800] ata8.00: exception Emask 0x10 SAct 0x0 SErr 0x4010000 
action 0xf
[ 3154.126805] ata8.00: SError: { PHYRdyChg DevExch }
[ 3154.126873] ata8.00: hard resetting link
[ 3154.848327] ata8.00: SATA link down (SStatus 0 SControl 320)
[ 3159.848014] ata8.00: hard resetting link
[ 3160.168331] ata8.00: SATA link down (SStatus 0 SControl 320)
[ 3160.168393] ata8.00: limiting SATA link speed to 1.5 Gbps
[ 3165.168030] ata8.00: hard resetting link
[ 3165.488328] ata8.00: SATA link down (SStatus 0 SControl 310)
[ 3165.488364] ata8.00: disabled
[ 3165.488473] ata8: EH complete
[ 3165.488484] ata8.00: detaching (SCSI 9:0:0:0)
[ 3165.488729] sd 9:0:0:0: [sdb] Synchronizing SCSI cache
[ 3165.488756] sd 9:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK
[ 3165.488766] sd 9:0:0:0: [sdb] Stopping disk
[ 3165.488777] sd 9:0:0:0: [sdb] START_STOP FAILED
[ 3165.488782] sd 9:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK

Put slot 0 back in:

[ 3181.810530] ata8.00: exception Emask 0x10 SAct 0x0 SErr 0x4050000 
action 0xf
[ 3181.810536] ata8.00: SError: { PHYRdyChg CommWake DevExch }
[ 3181.810604] ata8.00: hard resetting link
[ 3182.532338] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3182.644018] ata8.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 3182.644022] ata8.15: hard resetting link
[ 3182.644025] ata8: controller in dubious state, performing PORT_RST
[ 3184.876039] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 3187.532016] ata8.00: hard resetting link
[ 3187.852349] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3187.852355] ata8.01: hard resetting link
[ 3188.172349] ata8.01: SATA link down (SStatus 0 SControl 320)
[ 3188.172353] ata8.02: hard resetting link
[ 3188.492349] ata8.02: SATA link down (SStatus 0 SControl 320)
[ 3188.492353] ata8.03: hard resetting link
[ 3188.812350] ata8.03: SATA link down (SStatus 0 SControl 320)
[ 3188.812355] ata8.04: hard resetting link
[ 3189.132357] ata8.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3189.132360] ata8.05: hard resetting link
[ 3189.452348] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 3189.564018] ata8.00: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 3189.564022] ata8.15: hard resetting link
[ 3189.564025] ata8: controller in dubious state, performing PORT_RST
[ 3191.796038] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 3192.852008] ata8.00: hard resetting link
[ 3193.172334] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3194.132009] ata8.04: hard resetting link
[ 3194.452350] ata8.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3194.452355] ata8.05: hard resetting link
[ 3194.772342] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 3194.786265] ata8.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
[ 3194.786269] ata8.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[ 3194.788316] ata8.00: configured for UDMA/100
[ 3194.799671] ata8.04: ATA-8: WDC WD5000AAKS-00YGA0, 12.01C02, max 
UDMA/133
[ 3194.799675] ata8.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[ 3194.800760] ata8.04: configured for UDMA/100
[ 3194.801146] ata8: EH complete
[ 3194.801228] scsi 9:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ 
CR10 PQ: 0 ANSI: 5
[ 3194.801318] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3194.801329] sd 9:0:0:0: [sdb] Write Protect is off
[ 3194.801331] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3194.801348] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3194.801396] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3194.801406] sd 9:0:0:0: [sdb] Write Protect is off
[ 3194.801407] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3194.801424] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3194.801428]  sdb: sdb1
[ 3194.807183] sd 9:0:0:0: [sdb] Attached SCSI disk
[ 3194.807249] sd 9:0:0:0: Attached scsi generic sg1 type 0
[ 3194.807330] scsi 9:4:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 
12.0 PQ: 0 ANSI: 5
[ 3194.807397] sd 9:4:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3194.807408] sd 9:4:0:0: [sdc] Write Protect is off
[ 3194.807410] sd 9:4:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3194.807427] sd 9:4:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3194.807467] sd 9:4:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3194.807477] sd 9:4:0:0: [sdc] Write Protect is off
[ 3194.807478] sd 9:4:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3194.807495] sd 9:4:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3194.807497]  sdc: sdc1 sdc2 sdc3 sdc4
[ 3194.819337] sd 9:4:0:0: [sdc] Attached SCSI disk
[ 3194.819390] sd 9:4:0:0: Attached scsi generic sg2 type 0

Remove slot 4:

[ 3212.728880] ata8.04: exception Emask 0x10 SAct 0x0 SErr 0x4010000 
action 0xf
[ 3212.728886] ata8.04: SError: { PHYRdyChg DevExch }
[ 3212.728953] ata8.04: hard resetting link
[ 3213.452339] ata8.04: SATA link down (SStatus 0 SControl 320)
[ 3218.452009] ata8.04: hard resetting link
[ 3218.772347] ata8.04: SATA link down (SStatus 0 SControl 320)
[ 3218.772412] ata8.04: limiting SATA link speed to 1.5 Gbps
[ 3223.772012] ata8.04: hard resetting link
[ 3224.092346] ata8.04: SATA link down (SStatus 0 SControl 310)
[ 3224.092383] ata8.04: disabled
[ 3224.092480] ata8: EH complete
[ 3224.092489] ata8.04: detaching (SCSI 9:4:0:0)
[ 3224.092837] sd 9:4:0:0: [sdc] Synchronizing SCSI cache
[ 3224.092859] sd 9:4:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK
[ 3224.092862] sd 9:4:0:0: [sdc] Stopping disk
[ 3224.092868] sd 9:4:0:0: [sdc] START_STOP FAILED
[ 3224.092869] sd 9:4:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK

insert back into slot 4:

[ 3245.277437] ata8.04: exception Emask 0x10 SAct 0x0 SErr 0x4050000 
action 0xf
[ 3245.277443] ata8.04: SError: { PHYRdyChg CommWake DevExch }
[ 3245.277509] ata8.04: hard resetting link
[ 3246.000353] ata8.04: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3246.112018] ata8.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 3246.112022] ata8.15: hard resetting link
[ 3246.112025] ata8: controller in dubious state, performing PORT_RST
[ 3248.344039] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 3248.344293] ata8.00: hard resetting link
[ 3248.664328] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3248.664333] ata8.01: hard resetting link
[ 3248.984336] ata8.01: SATA link down (SStatus 0 SControl 320)
[ 3248.984341] ata8.02: hard resetting link
[ 3249.304336] ata8.02: SATA link down (SStatus 0 SControl 320)
[ 3249.304340] ata8.03: hard resetting link
[ 3249.624348] ata8.03: SATA link down (SStatus 0 SControl 320)
[ 3251.000014] ata8.04: hard resetting link
[ 3251.320346] ata8.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3251.320350] ata8.05: hard resetting link
[ 3251.640335] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 3251.661160] ata8.00: configured for UDMA/100
[ 3251.772023] ata8.04: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 3251.772027] ata8.15: hard resetting link
[ 3251.772030] ata8: controller in dubious state, performing PORT_RST
[ 3254.004044] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 3254.004302] ata8.00: hard resetting link
[ 3254.324342] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3254.324346] ata8.01: hard resetting link
[ 3254.644359] ata8.01: SATA link down (SStatus 0 SControl 320)
[ 3254.644363] ata8.02: hard resetting link
[ 3254.964376] ata8.02: SATA link down (SStatus 0 SControl 320)
[ 3254.964380] ata8.03: hard resetting link
[ 3255.285837] ata8.03: SATA link down (SStatus 0 SControl 320)
[ 3256.320819] ata8.04: hard resetting link
[ 3256.640357] ata8.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3256.640362] ata8.05: hard resetting link
[ 3256.960377] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 3256.974186] ata8.00: configured for UDMA/100
[ 3256.984713] ata8.04: ATA-8: WDC WD5000AAKS-00YGA0, 12.01C02, max 
UDMA/133
[ 3256.984716] ata8.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[ 3256.985670] ata8.04: configured for UDMA/100
[ 3256.986051] ata8: EH complete
[ 3256.986087] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3256.986104] sd 9:0:0:0: [sdb] Write Protect is off
[ 3256.986107] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3256.986132] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3256.986161] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3256.986176] sd 9:0:0:0: [sdb] Write Protect is off
[ 3256.986178] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3256.986203] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3256.986278] scsi 9:4:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 
12.0 PQ: 0 ANSI: 5
[ 3256.986363] sd 9:4:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3256.986373] sd 9:4:0:0: [sdc] Write Protect is off
[ 3256.986375] sd 9:4:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3256.986392] sd 9:4:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3256.986438] sd 9:4:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3256.986448] sd 9:4:0:0: [sdc] Write Protect is off
[ 3256.986449] sd 9:4:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3256.986466] sd 9:4:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3256.986469]  sdc: sdc1 sdc2 sdc3 sdc4
[ 3256.996065] sd 9:4:0:0: [sdc] Attached SCSI disk
[ 3256.996119] sd 9:4:0:0: Attached scsi generic sg2 type 0

remove it from slot 4:

[ 3279.547817] ata8.04: exception Emask 0x10 SAct 0x0 SErr 0x4010000 
action 0xf
[ 3279.547822] ata8.04: SError: { PHYRdyChg DevExch }
[ 3279.547889] ata8.04: hard resetting link
[ 3280.272329] ata8.04: SATA link down (SStatus 0 SControl 320)
[ 3285.272011] ata8.04: hard resetting link
[ 3285.592343] ata8.04: SATA link down (SStatus 0 SControl 320)
[ 3285.592407] ata8.04: limiting SATA link speed to 1.5 Gbps
[ 3290.592014] ata8.04: hard resetting link
[ 3290.912353] ata8.04: SATA link down (SStatus 0 SControl 310)
[ 3290.912388] ata8.04: disabled
[ 3290.912486] ata8: EH complete
[ 3290.912493] ata8.04: detaching (SCSI 9:4:0:0)
[ 3290.912842] sd 9:4:0:0: [sdc] Synchronizing SCSI cache
[ 3290.913199] sd 9:4:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK
[ 3290.913204] sd 9:4:0:0: [sdc] Stopping disk
[ 3290.913211] sd 9:4:0:0: [sdc] START_STOP FAILED
[ 3290.913212] sd 9:4:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK

insert it into slot 1:

[ 3303.617230] ata8.01: exception Emask 0x10 SAct 0x0 SErr 0x4000000 
action 0xf
[ 3303.617235] ata8.01: SError: { DevExch }
[ 3303.617307] ata8.01: hard resetting link
[ 3304.340351] ata8.01: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3304.452018] ata8.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 3304.452023] ata8.15: hard resetting link
[ 3304.452025] ata8: controller in dubious state, performing PORT_RST
[ 3306.684039] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 3306.684292] ata8.00: hard resetting link
[ 3307.005330] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3309.340020] ata8.01: hard resetting link
[ 3309.660352] ata8.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3309.660356] ata8.02: hard resetting link
[ 3309.981335] ata8.02: SATA link down (SStatus 0 SControl 320)
[ 3309.981339] ata8.03: hard resetting link
[ 3310.300350] ata8.03: SATA link down (SStatus 0 SControl 320)
[ 3310.300354] ata8.04: hard resetting link
[ 3310.620341] ata8.04: SATA link down (SStatus 0 SControl 320)
[ 3310.620346] ata8.05: hard resetting link
[ 3310.940335] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 3310.962930] ata8.00: configured for UDMA/100
[ 3311.073023] ata8.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 3311.073027] ata8.15: hard resetting link
[ 3311.073030] ata8: controller in dubious state, performing PORT_RST
[ 3313.305043] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 3313.305280] ata8.00: hard resetting link
[ 3313.624358] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 3314.661021] ata8.01: hard resetting link
[ 3314.984857] ata8.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3315.941095] ata8.05: hard resetting link
[ 3316.261331] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 3316.265343] ata8.00: configured for UDMA/100
[ 3316.272185] ata8.01: ATA-8: WDC WD5000AAKS-00YGA0, 12.01C02, max 
UDMA/133
[ 3316.272189] ata8.01: 976773168 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[ 3316.273118] ata8.01: configured for UDMA/100
[ 3316.273496] ata8: EH complete
[ 3316.273533] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3316.273550] sd 9:0:0:0: [sdb] Write Protect is off
[ 3316.273553] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3316.273578] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3316.273607] sd 9:0:0:0: [sdb] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3316.273622] sd 9:0:0:0: [sdb] Write Protect is off
[ 3316.273625] sd 9:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3316.273649] sd 9:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3316.273723] scsi 9:1:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 
12.0 PQ: 0 ANSI: 5
[ 3316.273823] sd 9:1:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3316.273833] sd 9:1:0:0: [sdc] Write Protect is off
[ 3316.273835] sd 9:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3316.273852] sd 9:1:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3316.273901] sd 9:1:0:0: [sdc] 976773168 512-byte hardware sectors: (500 
GB/465 GiB)
[ 3316.273910] sd 9:1:0:0: [sdc] Write Protect is off
[ 3316.273912] sd 9:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3316.273929] sd 9:1:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 3316.273932]  sdc: sdc1 sdc2 sdc3 sdc4
[ 3316.283551] sd 9:1:0:0: [sdc] Attached SCSI disk
[ 3316.283601] sd 9:1:0:0: Attached scsi generic sg2 type 0


-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
