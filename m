From: Tim Small <tim@seoss.co.uk>
Subject: Re: Power-up-in-standby Hitachi 5K3000 fails with either sata_sil24
 or pmp, but not direct to AHCI controllers
Date: Mon, 13 Jun 2011 21:08:43 +0100
Message-ID: <4DF66E4B.9010305@seoss.co.uk>
References: <4DF0C797.201@seoss.co.uk> <20110610102550.GF15235@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay0.allsecurenet.com ([109.169.27.60]:43965 "EHLO
	relay0.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab1FMUIq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jun 2011 16:08:46 -0400
In-Reply-To: <20110610102550.GF15235@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On 10/06/11 11:25, Tejun Heo wrote:
> Hello,
>
> On Thu, Jun 09, 2011 at 02:16:07PM +0100, Tim Small wrote:
>   
>> ... if I then didn't power down the drive, but instead attached it
>> to the Marvell controller, it didn't come back, so I'd guess the
>> interaction with the 3124 has wedged the drive permanently.
>>     
> Heh, that's interesting.  The feature isn't very well tested and it
> wouldn't be too surprising if there are some bugs on all sides
> (driver, controller and drive firmware).  Can you please try with a
> drive from a different vendor and see whether it fares any
> differently?
>   

All tests with a Silicon Image port multiplier, plugged into the Intel
H67 motherboard SATA port...

I tried with a WD drive:

1783.276989] ata11.02: exception Emask 0x10 SAct 0x0 SErr 0x4050000
action 0xf
1783.277165] ata11.02: SError: { PHYRdyChg CommWake DevExch }
1783.277359] ata11.02: hard resetting link
1784.001050] ata11.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
1788.999212] ata11.02: qc timeout (cmd 0xef)
1788.999375] ata11.02: failed to IDENTIFY (SPINUP failed, err_mask=0x4)
1788.999539] ata11.15: hard resetting link
1794.529376] ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
1794.529709] ata11.00: hard resetting link
1794.849450] ata11.00: SATA link down (SStatus 0 SControl 320)
1794.849642] ata11.01: hard resetting link
1795.169358] ata11.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
1795.169538] ata11.02: hard resetting link
1795.489250] ata11.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
1795.489439] ata11.03: hard resetting link
1795.809146] ata11.03: SATA link down (SStatus 0 SControl 320)
1795.809347] ata11.04: hard resetting link
1796.129047] ata11.04: SATA link down (SStatus 0 SControl 320)
1796.129232] ata11.05: hard resetting link
1796.448936] ata11.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
1796.545496] ata11.01: configured for UDMA/133
1796.556856] ata11.02: ATA-8: WDC WD5000AAKS-22YGA0, 12.01C02, max UDMA/133
1796.557038] ata11.02: 976773168 sectors, multi 0: LBA48 NCQ (depth
31/32), AA
1796.558414] ata11.02: configured for UDMA/133
1796.558760] ata11: EH complete
1796.559020] scsi 10:2:0:0: Direct-Access     ATA      WDC WD5000AAKS-2
12.0 PQ: 0 ANSI: 5
1796.559453] sd 10:2:0:0: [sdb] 976773168 512-byte logical blocks: (500
GB/465 GiB)
1796.559726] sd 10:2:0:0: [sdb] Write Protect is off
1796.559886] sd 10:2:0:0: [sdb] Mode Sense: 00 3a 00 00
1796.559910] sd 10:2:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
1796.590194]  sdb: sdb1 sdb2 sdb4 < sdb5 sdb6 >
1796.590690] sd 10:2:0:0: [sdb] Attached SCSI disk

... looks OK - then I added in a different WD (few-year-old Hitachi
Ultrastar "enterprise" 1TB drive):

3221.187324] ata10.03: exception Emask 0x10 SAct 0x0 SErr 0x4050000
action 0xf
3221.187495] ata10.03: SError: { PHYRdyChg CommWake DevExch }
3221.187690] ata10.03: hard resetting link
3221.908208] ata10.03: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
3221.908405] ata10.03: failed to IDENTIFY (I/O error, err_mask=0x100)
3221.908580] ata10.15: hard resetting link
3227.438189] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3227.438596] ata10.00: hard resetting link
3227.758285] ata10.00: SATA link down (SStatus 0 SControl 310)
3227.758481] ata10.01: hard resetting link
3228.078174] ata10.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3228.078363] ata10.02: hard resetting link
3228.398069] ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3228.398249] ata10.03: hard resetting link
3228.717949] ata10.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3228.718129] ata10.04: hard resetting link
3229.037845] ata10.04: SATA link down (SStatus 0 SControl 320)
3229.053513] ata10.05: hard resetting link
3229.373739] ata10.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
3229.471776] ata10.01: configured for UDMA/133
3229.485021] ata10.02: configured for UDMA/133
3234.479859] ata10.03: qc timeout (cmd 0xef)
3234.480019] ata10.03: failed to IDENTIFY (SPINUP failed, err_mask=0x4)
3234.480182] ata10.15: hard resetting link
3240.010031] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3240.010404] ata10.00: hard resetting link
3240.330128] ata10.00: SATA link down (SStatus 0 SControl 310)
3240.330334] ata10.01: hard resetting link
3240.650005] ata10.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3240.650190] ata10.02: hard resetting link
3240.969924] ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3240.970105] ata10.03: hard resetting link
3241.289820] ata10.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3241.289997] ata10.05: hard resetting link
3241.609677] ata10.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
3241.711873] ata10.01: configured for UDMA/133
3241.728940] ata10.02: configured for UDMA/133
3241.729112] ata10.03: failed to IDENTIFY (I/O error, err_mask=0x100)
3241.729270] ata10.03: failed to recover link after 3 tries, disabling
3241.729437] ata10.15: hard resetting link
3247.259626] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3247.579625] ata10.00: hard resetting link
3247.899626] ata10.00: SATA link down (SStatus 0 SControl 310)
3247.899826] ata10.01: hard resetting link
3248.219520] ata10.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3248.219701] ata10.02: hard resetting link
3248.539376] ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3248.539553] ata10.04: hard resetting link
3248.859283] ata10.04: SATA link down (SStatus 0 SControl 320)
3248.859486] ata10.05: hard resetting link
3249.179167] ata10.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
3249.280756] ata10.01: configured for UDMA/133
3249.294319] ata10.02: configured for UDMA/133
3249.611012] ata10: EH complete
3250.388324] ata10.00: failed to read SCR 1 (Emask=0x40)
3250.388490] ata10.01: failed to read SCR 1 (Emask=0x40)
3250.388644] ata10.02: failed to read SCR 1 (Emask=0x40)
3250.388800] ata10.03: failed to read SCR 1 (Emask=0x40)
3250.388955] ata10.04: failed to read SCR 1 (Emask=0x40)
3250.389112] ata10.05: failed to read SCR 1 (Emask=0x40)
3250.389274] ata10.15: exception Emask 0x2 SAct 0x0 SErr 0x0 action 0x6
frozen
3250.389447] ata10.15: irq_stat 0x00800000, incorrect PMP
3250.389608] ata10.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
3250.389842] ata10.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
3250.390072] ata10.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
3250.390300] ata10.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
3250.390525] ata10.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
3250.390763] ata10.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
3250.390993] ata10.15: hard resetting link
3255.920751] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3256.240698] ata10.03: failed to write SCR 1 (Emask=0x100)
3256.240862] ata10.03: COMRESET failed (errno=-5)
3256.241021] ata10.03: failed to write SCR 1 (Emask=0x40)
3256.241182] ata10.03: failed to clear SError.N (errno=-5)
3256.241341] ata10.15: hard resetting link
3261.770807] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3262.090762] ata10.03: failed to write SCR 1 (Emask=0x100)
3262.090922] ata10.03: COMRESET failed (errno=-5)
3262.091076] ata10.03: failed to write SCR 1 (Emask=0x40)
3262.091236] ata10.03: failed to clear SError.N (errno=-5)
3262.091397] ata10.15: hard resetting link
3267.620864] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3267.940817] ata10.03: failed to write SCR 1 (Emask=0x100)
3267.956355] ata10.03: COMRESET failed (errno=-5)
3267.956511] ata10.03: failed to write SCR 1 (Emask=0x40)
3267.956669] ata10.03: failed to clear SError.N (errno=-5)
3267.956672] ata10.15: hard resetting link
3273.482932] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3273.802873] ata10.03: failed to write SCR 1 (Emask=0x100)
3273.803037] ata10.03: COMRESET failed (errno=-5)
3273.803190] ata10.03: failed to write SCR 1 (Emask=0x40)
3273.803348] ata10.03: failed to clear SError.N (errno=-5)
3273.803507] ata10.15: hard resetting link
3279.332984] ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3279.652933] ata10.03: failed to write SCR 1 (Emask=0x100)
3279.653097] ata10.03: COMRESET failed (errno=-5)
3279.653255] ata10.03: failed to write SCR 1 (Emask=0x40)
3279.653411] ata10.03: failed to clear SError.N (errno=-5)
3279.653569] ata10: failed to recover PMP after 5 tries, giving up
3279.653729] ata10.15: Port Multiplier detaching
3279.653884] ata10.01: disabled
3279.654024] ata10.02: disabled
3279.654185] ata10.00: disabled
3279.654335] ata10: exception Emask 0x2 SAct 0x0 SErr 0x0 action 0x6
frozen t4
3279.654507] ata10: irq_stat 0x00800001, incorrect PMP
3279.654666] ata10: hard resetting link
3285.183040] ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3285.183223] ata10: EH complete
3285.183371] ata10.01: detaching (SCSI 9:1:0:0)
3285.207124] sd 9:1:0:0: [sdb] Synchronizing SCSI cache
3285.207304] sd 9:1:0:0: [sdb]  Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
3285.207599] sd 9:1:0:0: [sdb] Stopping disk
3285.207754] sd 9:1:0:0: [sdb] START_STOP FAILED
3285.207908] sd 9:1:0:0: [sdb]  Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
3285.208233] ata10.02: detaching (SCSI 9:2:0:0)
3285.223124] sd 9:2:0:0: [sdc] Synchronizing SCSI cache
3285.223313] sd 9:2:0:0: [sdc]  Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK
3285.223614] sd 9:2:0:0: [sdc] Stopping disk
3285.223771] sd 9:2:0:0: [sdc] START_STOP FAILED
3285.223927] sd 9:2:0:0: [sdc]  Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK


... and then there were no drives visible the other side of the port
multiplier at all - not so good....

Unplugging the port multiplier from the motherboard SATA port (a
different port on this occasion, but I think the same thing happens if I
pick the same one), and replugging it makes the disappeared drives
reappear, along with the (now spun up) Hitachi:

3374.238416] ata10: exception Emask 0x10 SAct 0x0 SErr 0x4090000 action
0xe frozen
3374.238652] ata10: irq_stat 0x00400040, connection status changed
3374.238814] ata10: SError: { PHYRdyChg 10B8B DevExch }
3374.238972] ata10: hard resetting link
3374.961277] ata10: SATA link down (SStatus 0 SControl 300)
3374.961453] ata10: EH complete
3381.497602] ata11: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action
0xe frozen
3381.497838] ata11: irq_stat 0x00400040, connection status changed
3381.498002] ata11: SError: { RecovComm PHYRdyChg CommWake DevExch }
3381.498172] ata11: hard resetting link
3387.429132] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3387.429520] ata11.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
feat 0x1/0x9
3387.429944] ata11.00: hard resetting link
3387.749226] ata11.00: SATA link down (SStatus 0 SControl 310)
3387.749427] ata11.01: hard resetting link
3388.069106] ata11.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3388.069287] ata11.02: hard resetting link
3388.389018] ata11.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3388.389195] ata11.03: hard resetting link
3388.708866] ata11.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
3388.709047] ata11.04: hard resetting link
3389.028796] ata11.04: SATA link down (SStatus 0 SControl 320)
3389.028996] ata11.05: hard resetting link
3389.348681] ata11.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
3389.384254] ata11.01: ATA-7: ST3500641AS, 3.AAD, max UDMA/133
3389.384428] ata11.01: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
3389.450869] ata11.01: configured for UDMA/133
3389.467745] ata11.02: ATA-8: WDC WD5000AAKS-22YGA0, 12.01C02, max UDMA/133
3389.467916] ata11.02: 976773168 sectors, multi 0: LBA48 NCQ (depth
31/32), AA
3389.469215] ata11.02: configured for UDMA/133
3389.478644] ata11.03: ATA-7: Hitachi HUA721010KLA330, GKAOAB0A, max
UDMA/133
3389.478818] ata11.03: 1953525168 sectors, multi 0: LBA48 NCQ (depth
31/32), AA
3389.480158] ata11.03: configured for UDMA/133
3389.480508] ata11: EH complete
3389.480702] scsi 10:1:0:0: Direct-Access     ATA      ST3500641AS     
3.AA PQ: 0 ANSI: 5
3389.480831] sd 10:1:0:0: [sdb] 976773168 512-byte logical blocks: (500
GB/465 GiB)
3389.480878] sd 10:1:0:0: [sdb] Write Protect is off
3389.480881] sd 10:1:0:0: [sdb] Mode Sense: 00 3a 00 00
3389.480903] sd 10:1:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
3389.481290] scsi 10:2:0:0: Direct-Access     ATA      WDC WD5000AAKS-2
12.0 PQ: 0 ANSI: 5
3389.481453] sd 10:2:0:0: [sdc] 976773168 512-byte logical blocks: (500
GB/465 GiB)
3389.481503] sd 10:2:0:0: [sdc] Write Protect is off
3389.481506] sd 10:2:0:0: [sdc] Mode Sense: 00 3a 00 00
3389.481526] sd 10:2:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
3389.481532] scsi 10:3:0:0: Direct-Access     ATA      Hitachi HUA72101
GKAO PQ: 0 ANSI: 5
3389.499135]  sdb: sdb1
3389.499412] sd 10:3:0:0: [sdd] 1953525168 512-byte logical blocks:
(1.00 TB/931 GiB)
3389.499618] sd 10:1:0:0: [sdb] Attached SCSI disk
3389.499834] sd 10:3:0:0: [sdd] Write Protect is off
3389.499987] sd 10:3:0:0: [sdd] Mode Sense: 00 3a 00 00
3389.500007] sd 10:3:0:0: [sdd] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
3389.542656]  sdc: sdc1 sdc2 sdc4 < sdc5 sdc6 >
3389.557103]  sdd: sdd1 sdd2 < sdd5 >
3389.574742] sd 10:2:0:0: [sdc] Attached SCSI disk
3389.574789] sd 10:3:0:0: [sdd] Attached SCSI disk

Is this any use?  Lots of other permutations for me to try out - I'll
try and get some time to do that tomorrow.

Tim.

-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.  
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309

