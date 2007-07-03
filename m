From: Jim Paris <jim@jtan.com>
Subject: Re: [PATCHSET 4/4] implement PMP support, take 4
Date: Tue, 3 Jul 2007 15:40:12 -0400
Message-ID: <20070703194012.GA20608@jim.sh>
References: <1183287253677-git-send-email-htejun@gmail.com> <20070703073953.GA5343@jim.sh> <468A1808.6070303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:48942 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755276AbXGCTkW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 15:40:22 -0400
Content-Disposition: inline
In-Reply-To: <468A1808.6070303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Jim Paris wrote:
> > Tejun Heo wrote:
> > > * Sil4726 is a bit too quirky.  Without the first fan-out port
> > >   occupied, the thing acts really weirdly.  As long as the first port
> > >   is occupied, it works okay.
> > 
> > I'll test the 4726 behavior with pulling disks etc including the first
> > port.  I'll also search to see if I can find a Windows machine to
> > update the firmware and let you know how things change.

Hi Tejun,

I tested some hotplug and didn't any problems at all.  I did:

Unplugged ata1.02
Plugged ata1.02
Unplugged ata1.00
Unplugged ata1.03
Plugged ata1.03
Turned off enclosure entirely
Turned on enclosure
Plugged ata1.00

In all cases, all attached disks were correctly recognized.  The log
is appended below.  I didn't bother trying to update the firmware
since it seems to be working just fine.


> If the Config Disk device can't stand IDENTIFY.  I suppose we're better
> off disabling last two ports on r0.  I'll ask SIMG about it and add
> quirks for r0.

OK, I'll gladly test anything you come up with.

Thanks,
-jim


[   53.323077] ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r0, 6 ports, feat 0x9/0xb

Unplugged ata1.02:

[  685.221846] ata1.02: hard resetting link
[  686.201127] ata1.02: SATA link down (SStatus 0 SControl 300)
[  686.217114] ata1: failed to recover some devices, retrying in 5 secs
[  691.233422] ata1.02: hard resetting link
[  691.797006] ata1.02: SATA link down (SStatus 0 SControl 300)
[  691.828983] ata1.02: limiting SATA link speed to 1.5 Gbps
[  691.829034] ata1.02: limiting speed to UDMA/100:PIO3
[  691.829086] ata1: failed to recover some devices, retrying in 5 secs
[  696.849287] ata1.02: hard resetting link
[  697.480821] ata1.02: SATA link down (SStatus 0 SControl 310)
[  697.496808] ata1.02: disabled
[  698.032416] ata1.02: hard resetting link
[  698.663364] ata1.02: SATA link down (SStatus 0 SControl 300)
[  698.679354] ata1: EH complete
[  698.679979] ata1.02: detaching (SCSI 0:0:2:0)
[  698.680241] sd 0:0:2:0: [sdc] Synchronizing SCSI cache
[  698.680422] sd 0:0:2:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  698.680511] sd 0:0:2:0: [sdc] Stopping disk
[  698.680559] sd 0:0:2:0: [sdc] START_STOP FAILED
[  698.680604] sd 0:0:2:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

Plugged ata1.02:

[  711.466523] ata1.02: hard resetting link
[  720.807647] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  720.852090] ata1.02: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[  720.852142] ata1.02: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  720.924577] ata1.02: configured for UDMA/100
[  720.939552] ata1: EH complete
[  720.939878] scsi 0:0:2:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[  720.940104] sd 0:0:2:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  720.940161] sd 0:0:2:0: [sdc] Write Protect is off
[  720.940220] sd 0:0:2:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  720.940328] sd 0:0:2:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  720.940382] sd 0:0:2:0: [sdc] Write Protect is off
[  720.940439] sd 0:0:2:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  720.940501]  sdc: sdc1
[  720.966807] sd 0:0:2:0: [sdc] Attached SCSI disk

Unplugged ata1.00:

[  767.021622] ata1.00: hard resetting link
[  768.000899] ata1.00: SATA link down (SStatus 0 SControl 300)
[  768.016887] ata1: failed to recover some devices, retrying in 5 secs
[  773.017199] ata1.00: hard resetting link
[  773.580790] ata1.00: SATA link down (SStatus 0 SControl 300)
[  773.612765] ata1.00: limiting SATA link speed to 1.5 Gbps
[  773.612814] ata1.00: limiting speed to UDMA/100:PIO3
[  773.612865] ata1: failed to recover some devices, retrying in 5 secs
[  778.613078] ata1.00: hard resetting link
[  779.240623] ata1.00: SATA link down (SStatus 0 SControl 310)
[  779.256610] ata1.00: disabled
[  779.776220] ata1.00: hard resetting link
[  780.403767] ata1.00: SATA link down (SStatus 0 SControl 300)
[  780.419757] ata1: EH complete
[  780.419813] ata1.00: detaching (SCSI 0:0:0:0)
[  780.420006] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  780.423967] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  780.424066] sd 0:0:0:0: [sda] Stopping disk
[  780.424121] sd 0:0:0:0: [sda] START_STOP FAILED
[  780.424169] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

Unplugged ata1.03:

[  785.512005] ata1.03: hard resetting link
[  786.491286] ata1.03: SATA link down (SStatus 0 SControl 300)
[  786.507272] ata1: failed to recover some devices, retrying in 5 secs
[  791.523581] ata1.03: hard resetting link
[  792.087166] ata1.03: SATA link down (SStatus 0 SControl 300)
[  792.119140] ata1.03: limiting SATA link speed to 1.5 Gbps
[  792.119189] ata1.03: limiting speed to UDMA/100:PIO3
[  792.119239] ata1: failed to recover some devices, retrying in 5 secs
[  797.135449] ata1.03: hard resetting link
[  797.762986] ata1.03: SATA link down (SStatus 0 SControl 310)
[  797.778973] ata1.03: disabled
[  798.314580] ata1.03: hard resetting link
[  798.942118] ata1.03: SATA link down (SStatus 0 SControl 300)
[  798.958108] ata1: EH complete
[  798.958163] ata1.03: detaching (SCSI 0:0:3:0)
[  798.958410] sd 0:0:3:0: [sdd] Synchronizing SCSI cache
[  798.958585] sd 0:0:3:0: [sdd] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  798.958674] sd 0:0:3:0: [sdd] Stopping disk
[  798.958722] sd 0:0:3:0: [sdd] START_STOP FAILED
[  798.958767] sd 0:0:3:0: [sdd] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

Plugged ata1.03:

[  801.616148] ata1.03: hard resetting link
[  810.925295] ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  811.327359] ata1.03: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[  811.327409] ata1.03: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  811.385625] ata1.03: configured for UDMA/100
[  811.400946] ata1: EH complete
[  811.401154] scsi 0:0:3:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[  811.401349] sd 0:0:3:0: [sda] 586072368 512-byte hardware sectors (300069 MB)
[  811.401406] sd 0:0:3:0: [sda] Write Protect is off
[  811.401465] sd 0:0:3:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  811.401569] sd 0:0:3:0: [sda] 586072368 512-byte hardware sectors (300069 MB)
[  811.407812] sd 0:0:3:0: [sda] Write Protect is off
[  811.407899] sd 0:0:3:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  811.407961]  sda: sda1
[  811.425436] sd 0:0:3:0: [sda] Attached SCSI disk

Turned off the entire enclosure (ata1, ata2, ata5, ata6):

[  854.744805] ata6: hard resetting link
[  854.744975] ata5: hard resetting link
[  856.280406] ata1.15: hard resetting link
[  856.280954] ata2.15: hard resetting link
[  856.823499] ata6: SATA link down (SStatus 0 SControl 0)
[  856.823555] ata6: failed to recover some devices, retrying in 5 secs
[  856.823614] ata5: SATA link down (SStatus 0 SControl 0)
[  856.823665] ata5: failed to recover some devices, retrying in 5 secs
[  858.358371] ata1.15: SATA link down (SStatus 0 SControl 0)
[  858.358442] ata2.15: SATA link down (SStatus 0 SControl 0)
[  858.614294] ata1.15: retrying hardreset in 5 secs
[  858.614464] ata2.15: retrying hardreset in 5 secs
[  861.823813] ata6: hard resetting link
[  861.823870] ata5: hard resetting link
[  863.614493] ata1.15: hard resetting link
[  863.614552] ata2.15: hard resetting link
[  863.902286] ata6: SATA link down (SStatus 0 SControl 0)
[  863.902342] ata6: limiting SATA link speed to 1.5 Gbps
[  863.902393] ata6.00: limiting speed to UDMA/100:PIO3
[  863.902440] ata6: failed to recover some devices, retrying in 5 secs
[  863.902500] ata5: SATA link down (SStatus 0 SControl 0)
[  863.902551] ata5: limiting SATA link speed to 1.5 Gbps
[  863.902600] ata5.00: limiting speed to UDMA/100:PIO3
[  863.902647] ata5: failed to recover some devices, retrying in 5 secs
[  865.692970] ata1.15: SATA link down (SStatus 0 SControl 0)
[  865.693041] ata2.15: SATA link down (SStatus 0 SControl 0)
[  865.948898] ata1.15: limiting SATA link speed to 1.5 Gbps
[  865.948946] ata1.15: retrying hardreset in 5 secs
[  865.949120] ata2.15: limiting SATA link speed to 1.5 Gbps
[  865.949167] ata2.15: retrying hardreset in 5 secs
[  868.902601] ata6: hard resetting link
[  868.902658] ata5: hard resetting link
[  870.953090] ata1.15: hard resetting link
[  870.953151] ata2.15: hard resetting link
[  870.985070] ata6: SATA link down (SStatus 0 SControl 10)
[  870.985125] ata6.00: disabled
[  870.985181] ata5: SATA link down (SStatus 0 SControl 10)
[  870.985232] ata5.00: disabled
[  871.492692] ata6: EH complete
[  871.492746] ata5: EH complete
[  871.492798] ata6.00: detaching (SCSI 7:0:0:0)
[  871.492988] sd 7:0:0:0: [sdr] Synchronizing SCSI cache
[  871.495331] sd 7:0:0:0: [sdr] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  871.495430] sd 7:0:0:0: [sdr] Stopping disk
[  871.495698] sd 7:0:0:0: [sdr] START_STOP FAILED
[  871.495745] sd 7:0:0:0: [sdr] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  871.495911] ata5.00: detaching (SCSI 6:0:0:0)
[  871.496092] sd 6:0:0:0: [sdq] Synchronizing SCSI cache
[  871.496400] sd 6:0:0:0: [sdq] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  871.496493] sd 6:0:0:0: [sdq] Stopping disk
[  871.496671] sd 6:0:0:0: [sdq] START_STOP FAILED
[  871.496724] sd 6:0:0:0: [sdq] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  873.035564] ata1.15: SATA link down (SStatus 0 SControl 10)
[  873.035637] ata2.15: SATA link down (SStatus 0 SControl 10)
[  873.291490] ata1.15: retrying hardreset in 5 secs
[  873.291663] ata2.15: retrying hardreset in 5 secs
[  878.291687] ata1.15: hard resetting link
[  878.295681] ata2.15: hard resetting link
[  880.370163] ata1.15: SATA link down (SStatus 0 SControl 10)
[  880.374158] ata2.15: SATA link down (SStatus 0 SControl 10)
[  880.626087] ata1.15: retrying hardreset in 5 secs
[  880.630083] ata2.15: retrying hardreset in 5 secs
[  885.626286] ata1.15: hard resetting link
[  885.630280] ata2.15: hard resetting link
[  887.704762] ata1.15: SATA link down (SStatus 0 SControl 10)
[  887.708757] ata2.15: SATA link down (SStatus 0 SControl 10)
[  887.960737] ata1.15: Port Multiplier detaching
[  887.960809] ata1.01: disabled
[  887.960854] ata1.02: disabled
[  887.960902] ata1.03: disabled
[  887.960946] ata1.04: disabled
[  887.960995] ata1.00: disabled
[  887.961044] ata1: EH complete
[  887.961104] ata1.01: detaching (SCSI 0:0:1:0)
[  887.961302] sd 0:0:1:0: [sdb] Synchronizing SCSI cache
[  887.964553] sd 0:0:1:0: [sdb] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.964087] ata2.15: Port Multiplier detaching
[  887.964111] ata2.00: disabled
[  887.964115] ata2.01: disabled
[  887.964117] ata2.02: disabled
[  887.964119] ata2.03: disabled
[  887.964121] ata2.04: disabled
[  887.964124] ata2.00: disabled
[  887.964130] ata2: EH complete
[  887.965153] sd 0:0:1:0: [sdb] Stopping disk
[  887.965784] sd 0:0:1:0: [sdb] START_STOP FAILED
[  887.965834] sd 0:0:1:0: [sdb] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.965991] ata1.02: detaching (SCSI 0:0:2:0)
[  887.966155] sd 0:0:2:0: [sdc] Synchronizing SCSI cache
[  887.968029] sd 0:0:2:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.968128] sd 0:0:2:0: [sdc] Stopping disk
[  887.968179] sd 0:0:2:0: [sdc] START_STOP FAILED
[  887.968225] sd 0:0:2:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.968385] ata1.03: detaching (SCSI 0:0:3:0)
[  887.968551] sd 0:0:3:0: [sda] Synchronizing SCSI cache
[  887.968620] sd 0:0:3:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.968714] sd 0:0:3:0: [sda] Stopping disk
[  887.968764] sd 0:0:3:0: [sda] START_STOP FAILED
[  887.968812] sd 0:0:3:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.968935] ata1.04: detaching (SCSI 0:0:4:0)
[  887.969098] sd 0:0:4:0: [sde] Synchronizing SCSI cache
[  887.969162] sd 0:0:4:0: [sde] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.969255] sd 0:0:4:0: [sde] Stopping disk
[  887.969303] sd 0:0:4:0: [sde] START_STOP FAILED
[  887.969352] sd 0:0:4:0: [sde] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.975673] ata2.00: detaching (SCSI 1:0:0:0)
[  887.975826] sd 1:0:0:0: [sdf] Synchronizing SCSI cache
[  887.975887] sd 1:0:0:0: [sdf] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.975979] sd 1:0:0:0: [sdf] Stopping disk
[  887.976031] sd 1:0:0:0: [sdf] START_STOP FAILED
[  887.976077] sd 1:0:0:0: [sdf] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.976201] ata2.01: detaching (SCSI 1:0:1:0)
[  887.976351] sd 1:0:1:0: [sdg] Synchronizing SCSI cache
[  887.976412] sd 1:0:1:0: [sdg] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.976505] sd 1:0:1:0: [sdg] Stopping disk
[  887.976557] sd 1:0:1:0: [sdg] START_STOP FAILED
[  887.976605] sd 1:0:1:0: [sdg] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.976727] ata2.02: detaching (SCSI 1:0:2:0)
[  887.976880] sd 1:0:2:0: [sdh] Synchronizing SCSI cache
[  887.976941] sd 1:0:2:0: [sdh] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.977035] sd 1:0:2:0: [sdh] Stopping disk
[  887.977083] sd 1:0:2:0: [sdh] START_STOP FAILED
[  887.977133] sd 1:0:2:0: [sdh] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.977250] ata2.03: detaching (SCSI 1:0:3:0)
[  887.977401] sd 1:0:3:0: [sdi] Synchronizing SCSI cache
[  887.977460] sd 1:0:3:0: [sdi] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.977554] sd 1:0:3:0: [sdi] Stopping disk
[  887.977605] sd 1:0:3:0: [sdi] START_STOP FAILED
[  887.977651] sd 1:0:3:0: [sdi] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.977779] ata2.04: detaching (SCSI 1:0:4:0)
[  887.977932] sd 1:0:4:0: [sdj] Synchronizing SCSI cache
[  887.977993] sd 1:0:4:0: [sdj] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  887.978085] sd 1:0:4:0: [sdj] Stopping disk
[  887.978135] sd 1:0:4:0: [sdj] START_STOP FAILED
[  887.978182] sd 1:0:4:0: [sdj] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK

Turned on the enclosure.  ata1.00 is still unplugged:

[  914.543194] ata6: hard resetting link
[  914.543595] ata5: hard resetting link
[  914.769024] ata1: hard resetting link
[  914.768702] ata2: hard resetting link
[  916.966675] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  916.967234] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  917.110543] ata2.15: Port Multiplier 1.1, 0x1095:0x4726 r0, 6 ports, feat 0x9/0xb
[  917.111101] ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r0, 6 ports, feat 0x9/0xb
[  917.222475] ata2.00: hard resetting link
[  917.223035] ata1.00: hard resetting link
[  917.786057] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  917.786616] ata1.00: SATA link down (SStatus 0 SControl 300)
[  917.802043] ata2.01: hard resetting link
[  917.802603] ata1.01: hard resetting link
[  924.541684] ata6: hard resetting link
[  924.541787] ata5: hard resetting link
[  926.756014] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  926.771997] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[  926.785908] ata5.00: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[  926.785957] ata5.00: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  926.840036] ata6.00: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[  926.840085] ata6.00: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  926.844175] ata5.00: configured for UDMA/100
[  926.844224] ata5: EH complete
[  926.844482] scsi 6:0:0:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[  926.845662] sd 6:0:0:0: [sda] 586072368 512-byte hardware sectors (300069 MB)
[  926.845725] sd 6:0:0:0: [sda] Write Protect is off
[  926.846006] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  926.846178] sd 6:0:0:0: [sda] 586072368 512-byte hardware sectors (300069 MB)
[  926.846234] sd 6:0:0:0: [sda] Write Protect is off
[  926.846467] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  926.846532]  sda: sda1
[  926.883969] sd 6:0:0:0: [sda] Attached SCSI disk
[  926.935888] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  926.951868] ata1.02: hard resetting link
[  927.089749] ata6.00: configured for UDMA/100
[  927.089804] ata6: EH complete
[  927.090044] scsi 7:0:0:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[  927.091176] sd 7:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  927.091246] sd 7:0:0:0: [sdb] Write Protect is off
[  927.091532] sd 7:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  927.091709] sd 7:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
[  927.091779] sd 7:0:0:0: [sdb] Write Protect is off
[  927.091840] sd 7:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  927.091904]  sdb:<6>ata2.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  927.239097] ata2.02: hard resetting link
[  927.265083]  sdb1
[  927.265218] sd 7:0:0:0: [sdb] Attached SCSI disk
[  936.408903] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  936.424890] ata1.03: hard resetting link
[  936.692139] ata2.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  936.708125] ata2.03: hard resetting link
[  945.909908] ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  945.925895] ata1.04: hard resetting link
[  946.017273] ata2.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  946.033259] ata2.04: hard resetting link
[  955.278454] ata2.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  955.278507] ata2.05: hard resetting link
[  955.538818] ata1.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  955.538872] ata1.05: hard resetting link
[  955.842038] ata2.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  955.884453] ata2.00: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[  955.884505] ata2.00: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  955.942715] ata2.00: configured for UDMA/100
[  955.981937] ata2.01: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[  955.981986] ata2.01: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  956.040204] ata2.01: configured for UDMA/100
[  956.086187] ata2.02: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[  956.086236] ata2.02: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  956.102401] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  956.144454] ata2.02: configured for UDMA/100
[  956.145604] ata1.01: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[  956.145653] ata1.01: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  956.188834] ata2.03: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[  956.188882] ata2.03: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  956.203868] ata1.01: configured for UDMA/100
[  956.243730] ata1.02: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[  956.243778] ata1.02: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  956.247100] ata2.03: configured for UDMA/100
[  956.288708] ata2.04: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[  956.288757] ata2.04: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  956.316179] ata1.02: configured for UDMA/100
[  956.346974] ata2.04: configured for UDMA/100
[  956.347150] ata2.05: failed to IDENTIFY (I/O error, err_mask=0x1)
[  956.347199] ata2: failed to recover some devices, retrying in 5 secs
[  956.353522] ata1.03: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[  956.353571] ata1.03: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  956.411786] ata1.03: configured for UDMA/100
[  956.457105] ata1.04: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[  956.457154] ata1.04: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  956.515370] ata1.04: configured for UDMA/100
[  956.515540] ata1.05: failed to IDENTIFY (I/O error, err_mask=0x1)
[  956.515588] ata1: failed to recover some devices, retrying in 5 secs
[  961.346535] ata2.05: hard resetting link
[  961.514408] ata1.05: hard resetting link
[  961.910126] ata2.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  962.019086] ata2.00: configured for UDMA/100
[  962.078001] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  962.124914] ata2.01: configured for UDMA/100
[  962.180368] ata1.01: configured for UDMA/100
[  962.229307] ata2.02: configured for UDMA/100
[  962.286784] ata1.02: configured for UDMA/100
[  962.331715] ata2.03: configured for UDMA/100
[  962.388299] ata1.03: configured for UDMA/100
[  962.431532] ata2.04: configured for UDMA/100
[  962.431706] ata2.05: failed to IDENTIFY (I/O error, err_mask=0x1)
[  962.445730] ata2.05: limiting SATA link speed to 1.5 Gbps
[  962.445778] ata2.05: limiting speed to UDMA7:PIO5
[  962.445829] ata2: failed to recover some devices, retrying in 5 secs
[  962.491902] ata1.04: configured for UDMA/100
[  962.492073] ata1.05: failed to IDENTIFY (I/O error, err_mask=0x1)
[  962.509683] ata1.05: limiting SATA link speed to 1.5 Gbps
[  962.509733] ata1.05: limiting speed to UDMA7:PIO5
[  962.509783] ata1: failed to recover some devices, retrying in 5 secs
[  967.446044] ata2.05: hard resetting link
[  967.509994] ata1.05: hard resetting link
[  968.073589] ata2.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  968.073782] ata2.05: failed to IDENTIFY (I/O error, err_mask=0x1)
[  968.073831] ata2: failed to recover some devices, retrying in 5 secs
[  968.137539] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  968.137715] ata1.05: failed to IDENTIFY (I/O error, err_mask=0x1)
[  968.137764] ata1: failed to recover some devices, retrying in 5 secs
[  973.073899] ata2.05: hard resetting link
[  973.141846] ata1.05: hard resetting link
[  973.637490] ata2.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  973.653479] ata2: EH pending after completion, repeating EH (cnt=4)
[  973.705439] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  973.721431] ata1: EH pending after completion, repeating EH (cnt=4)
[  973.781385] ata2: EH complete
[  973.781599] scsi 1:0:0:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[  973.782745] sd 1:0:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  973.782808] sd 1:0:0:0: [sdc] Write Protect is off
[  973.783091] sd 1:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.783266] sd 1:0:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
[  973.783322] sd 1:0:0:0: [sdc] Write Protect is off
[  973.783596] sd 1:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.783661]  sdc: sdc1
[  973.803836] sd 1:0:0:0: [sdc] Attached SCSI disk
[  973.804799] scsi 1:0:1:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[  973.806206] sd 1:0:1:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  973.806279] sd 1:0:1:0: [sdd] Write Protect is off
[  973.806567] sd 1:0:1:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.806741] sd 1:0:1:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
[  973.806798] sd 1:0:1:0: [sdd] Write Protect is off
[  973.807036] sd 1:0:1:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.807099]  sdd: sdd1
[  973.826406] sd 1:0:1:0: [sdd] Attached SCSI disk
[  973.828828] scsi 1:0:2:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[  973.829925] sd 1:0:2:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  973.832408] sd 1:0:2:0: [sde] Write Protect is off
[  973.836405] sd 1:0:2:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.837640] sd 1:0:2:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
[  973.837781] sd 1:0:2:0: [sde] Write Protect is off
[  973.837955] sd 1:0:2:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.838019]  sde:<6>ata1: EH complete
[  973.856112]  sde1
[  973.856258] sd 1:0:2:0: [sde] Attached SCSI disk
[  973.857341] scsi 1:0:3:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[  973.859574] sd 1:0:3:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
[  973.859723] sd 1:0:3:0: [sdf] Write Protect is off
[  973.860516] sd 1:0:3:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.860639] sd 1:0:3:0: [sdf] 586072368 512-byte hardware sectors (300069 MB)
[  973.860695] sd 1:0:3:0: [sdf] Write Protect is off
[  973.860757] sd 1:0:3:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.860820]  sdf: sdf1
[  973.874922] sd 1:0:3:0: [sdf] Attached SCSI disk
[  973.877377] scsi 1:0:4:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[  973.879591] sd 1:0:4:0: [sdg] 586072368 512-byte hardware sectors (300069 MB)
[  973.880372] sd 1:0:4:0: [sdg] Write Protect is off
[  973.884370] sd 1:0:4:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.888370] sd 1:0:4:0: [sdg] 586072368 512-byte hardware sectors (300069 MB)
[  973.888433] sd 1:0:4:0: [sdg] Write Protect is off
[  973.889531] sd 1:0:4:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.889597]  sdg: sdg1
[  973.908066] sd 1:0:4:0: [sdg] Attached SCSI disk
[  973.908364] scsi 0:0:1:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[  973.912369] sd 0:0:1:0: [sdh] 586072368 512-byte hardware sectors (300069 MB)
[  973.913300] sd 0:0:1:0: [sdh] Write Protect is off
[  973.915499] sd 0:0:1:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.915780] sd 0:0:1:0: [sdh] 586072368 512-byte hardware sectors (300069 MB)
[  973.915927] sd 0:0:1:0: [sdh] Write Protect is off
[  973.917297] sd 0:0:1:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.917365]  sdh: sdh1
[  973.931851] sd 0:0:1:0: [sdh] Attached SCSI disk
[  973.933116] scsi 0:0:2:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[  973.933392] sd 0:0:2:0: [sdi] 586072368 512-byte hardware sectors (300069 MB)
[  973.933937] sd 0:0:2:0: [sdi] Write Protect is off
[  973.934204] sd 0:0:2:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.937270] sd 0:0:2:0: [sdi] 586072368 512-byte hardware sectors (300069 MB)
[  973.938128] sd 0:0:2:0: [sdi] Write Protect is off
[  973.939540] sd 0:0:2:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.939607]  sdi: sdi1
[  973.954948] sd 0:0:2:0: [sdi] Attached SCSI disk
[  973.957276] scsi 0:0:3:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[  973.959079] sd 0:0:3:0: [sdj] 586072368 512-byte hardware sectors (300069 MB)
[  973.960321] sd 0:0:3:0: [sdj] Write Protect is off
[  973.961247] sd 0:0:3:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.964181] sd 0:0:3:0: [sdj] 586072368 512-byte hardware sectors (300069 MB)
[  973.964321] sd 0:0:3:0: [sdj] Write Protect is off
[  973.964648] sd 0:0:3:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.964710]  sdj: sdj1
[  973.981606] sd 0:0:3:0: [sdj] Attached SCSI disk
[  973.985261] scsi 0:0:4:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[  973.986644] sd 0:0:4:0: [sdq] 586072368 512-byte hardware sectors (300069 MB)
[  973.986873] sd 0:0:4:0: [sdq] Write Protect is off
[  973.987098] sd 0:0:4:0: [sdq] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.988307] sd 0:0:4:0: [sdq] 586072368 512-byte hardware sectors (300069 MB)
[  973.988885] sd 0:0:4:0: [sdq] Write Protect is off
[  973.992324] sd 0:0:4:0: [sdq] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  973.992392]  sdq: sdq1
[  974.010309] sd 0:0:4:0: [sdq] Attached SCSI disk

Plugged ata1.00:

[  998.067505] ata1.00: hard resetting link
[  999.046782] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1007.515467] ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[ 1007.515531] ata1: failed to recover some devices, retrying in 5 secs
[ 1012.516856] ata1.00: hard resetting link
[ 1013.080448] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1013.109654] ata1.00: ATA-7: ST3300822AS, 3.AAD, max UDMA/133
[ 1013.109703] ata1.00: 586072368 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 1013.167921] ata1.00: configured for UDMA/100
[ 1013.184371] ata1: EH pending after completion, repeating EH (cnt=4)
[ 1013.296289] ata1.00: hard resetting link
[ 1013.859874] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1013.967009] ata1.00: configured for UDMA/100
[ 1013.983784] ata1: EH complete
[ 1013.983944] sd 0:0:1:0: [sdh] 586072368 512-byte hardware sectors (300069 MB)
[ 1013.984087] sd 0:0:1:0: [sdh] Write Protect is off
[ 1013.984305] sd 0:0:1:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1013.984469] sd 0:0:2:0: [sdi] 586072368 512-byte hardware sectors (300069 MB)
[ 1013.984610] sd 0:0:2:0: [sdi] Write Protect is off
[ 1013.984820] sd 0:0:2:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1013.984982] sd 0:0:3:0: [sdj] 586072368 512-byte hardware sectors (300069 MB)
[ 1013.985124] sd 0:0:3:0: [sdj] Write Protect is off
[ 1013.985334] sd 0:0:3:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1013.985534] sd 0:0:4:0: [sdq] 586072368 512-byte hardware sectors (300069 MB)
[ 1013.985678] sd 0:0:4:0: [sdq] Write Protect is off
[ 1013.985912] sd 0:0:4:0: [sdq] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1013.986133] scsi 0:0:0:0: Direct-Access     ATA      ST3300822AS      3.AA PQ: 0 ANSI: 5
[ 1013.986349] sd 0:0:0:0: [sdr] 586072368 512-byte hardware sectors (300069 MB)
[ 1013.986488] sd 0:0:0:0: [sdr] Write Protect is off
[ 1013.986698] sd 0:0:0:0: [sdr] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1013.986898] sd 0:0:0:0: [sdr] 586072368 512-byte hardware sectors (300069 MB)
[ 1013.987038] sd 0:0:0:0: [sdr] Write Protect is off
[ 1013.987251] sd 0:0:0:0: [sdr] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1013.987314]  sdr: sdr1
[ 1014.006839] sd 0:0:0:0: [sdr] Attached SCSI disk
