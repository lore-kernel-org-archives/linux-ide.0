From: Mark Lord <liml@rtr.ca>
Subject: Re: ata_std_qc_defer not good enough for FIS-based switching ?
Date: Mon, 28 Apr 2008 22:26:04 -0400
Message-ID: <4816873C.7090302@rtr.ca>
References: <48163C5D.9050605@rtr.ca> <48164AE8.4070106@rtr.ca> <481659B5.7090703@gmail.com> <481660DD.80103@rtr.ca> <48167755.3000208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4265 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbYD2C0J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Apr 2008 22:26:09 -0400
In-Reply-To: <48167755.3000208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Tejun Heo wrote:
> Mark Lord wrote:
>> Mmm.. I just plugged the same PM + drives into my sata_sil24 card here,
>> and that driver went bonkers when I did the same test.
>>
>> Had to reboot eventually to recover.
> 
> Hmm... That can't be.  Above all, although we do manual scheduling 
> around sil24, the controller does its own scheduling and will happily 
> issue command in the right order even if the software scheduler screws 
> up.  Do you have the log?
..

Here's what was in /var/log/messages after I held the power button
for five seconds to force a poweroff and then rebooted.  I didn't make much
effort to learn more, as I'm already busy enough testing/debugging sata_mv.

[ 7815.289014] pciehp: Card present on Slot(0013_0005)
[ 7816.290936] program_fw_provided_values: Could not get hotplug parameters
[ 7816.291117] PCI: Enabling device 0000:0d:00.0 (0000 -> 0003)
[ 7816.291127] ACPI: PCI Interrupt 0000:0d:00.0[A] -> GSI 19 (level, low) -> IRQ 18
[ 7816.291221] PCI: Setting latency timer of device 0000:0d:00.0 to 64
[ 7816.292463] scsi11 : sata_sil24
[ 7816.295726] scsi12 : sata_sil24
[ 7816.295799] ata5: SATA max UDMA/100 host m128@0xefa04000 port 0xefa00000 irq 18
[ 7816.295805] ata6: SATA max UDMA/100 host m128@0xefa04000 port 0xefa02000 irq 18
[ 7818.371127] ata5: SATA link down (SStatus 0 SControl 0)
[ 7820.446489] ata6: SATA link down (SStatus 0 SControl 0)
[ 7902.071861] ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa frozen
[ 7902.071871] ata6: irq_stat 0x00a40080, device exchanged
[ 7902.071888] ata6: hard resetting link
[ 7904.266154] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 7904.266672] ata6.15: Port Multiplier 1.1, 0x11ab:0x4140 r192, 4 ports, feat 0x1/0x1f
[ 7904.267112] ata6.00: hard resetting link
[ 7904.601801] ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 7904.601874] ata6.01: hard resetting link
[ 7904.937053] ata6.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[ 7904.937125] ata6.02: hard resetting link
[ 7905.352127] ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 7905.352199] ata6.03: hard resetting link
[ 7905.703339] ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 7905.745912] ata6.00: ATA-7: ST3750640NS, 3.BAF, max UDMA/133
[ 7905.745920] ata6.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 7905.804131] ata6.00: configured for UDMA/100
[ 7905.806327] ata6.01: ATA-7: Maxtor 7B320S0, BANC1WK0, max UDMA/133
[ 7905.806334] ata6.01: 625142448 sectors, multi 0: LBA48 NCQ (not used)
[ 7905.809473] ata6.01: configured for UDMA/100
[ 7905.810377] ata6.02: ATA-8: Hitachi HDP725050GLA360, GM4OA50E, max UDMA/133
[ 7905.810383] ata6.02: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 7905.811551] ata6.02: configured for UDMA/100
[ 7905.812511] ata6.03: ATA-7: Hitachi HUA721075KLA330, GK8OA70M, max UDMA/133
[ 7905.812517] ata6.03: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 7905.813721] ata6.03: configured for UDMA/100
[ 7905.813848] ata6: EH complete
[ 7905.814017] scsi 12:0:0:0: Direct-Access     ATA      ST3750640NS      3.BA PQ: 0 ANSI: 5
[ 7905.814689] sd 12:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 7905.814743] sd 12:0:0:0: [sdb] Write Protect is off
[ 7905.814749] sd 12:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 7905.814778] sd 12:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 7905.815460] sd 12:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 7905.815480] sd 12:0:0:0: [sdb] Write Protect is off
[ 7905.815485] sd 12:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 7905.815515] sd 12:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 7905.815520]  sdb: sdb1
[ 7905.843863] sd 12:0:0:0: [sdb] Attached SCSI disk
[ 7905.843948] sd 12:0:0:0: Attached scsi generic sg2 type 0
[ 7905.844114] scsi 12:1:0:0: Direct-Access     ATA      Maxtor 7B320S0   BANC PQ: 0 ANSI: 5
[ 7905.844236] sd 12:1:0:0: [sdc] 625142448 512-byte hardware sectors (320073 MB)
[ 7905.844254] sd 12:1:0:0: [sdc] Write Protect is off
[ 7905.844258] sd 12:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 7905.844285] sd 12:1:0:0: [sdc] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 7905.844356] sd 12:1:0:0: [sdc] 625142448 512-byte hardware sectors (320073 MB)
[ 7905.844372] sd 12:1:0:0: [sdc] Write Protect is off
[ 7905.844377] sd 12:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 7905.844403] sd 12:1:0:0: [sdc] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 7905.844408]  sdc: sdc1 sdc2 sdc3
[ 7905.864183] sd 12:1:0:0: [sdc] Attached SCSI disk
[ 7905.864261] sd 12:1:0:0: Attached scsi generic sg3 type 0
[ 7905.864418] scsi 12:2:0:0: Direct-Access     ATA      Hitachi HDP72505 GM4O PQ: 0 ANSI: 5
[ 7905.864542] sd 12:2:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
[ 7905.864560] sd 12:2:0:0: [sdd] Write Protect is off
[ 7905.864566] sd 12:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 7905.864593] sd 12:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 7905.864662] sd 12:2:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
[ 7905.864678] sd 12:2:0:0: [sdd] Write Protect is off
[ 7905.864683] sd 12:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 7905.864709] sd 12:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 7905.864714]  sdd: sdd1
[ 7905.888043] sd 12:2:0:0: [sdd] Attached SCSI disk
[ 7905.888116] sd 12:2:0:0: Attached scsi generic sg4 type 0
[ 7905.888272] scsi 12:3:0:0: Direct-Access     ATA      Hitachi HUA72107 GK8O PQ: 0 ANSI: 5
[ 7905.888394] sd 12:3:0:0: [sde] 1465149168 512-byte hardware sectors (750156 MB)
[ 7905.888411] sd 12:3:0:0: [sde] Write Protect is off
[ 7905.888415] sd 12:3:0:0: [sde] Mode Sense: 00 3a 00 00
[ 7905.888441] sd 12:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 7905.888506] sd 12:3:0:0: [sde] 1465149168 512-byte hardware sectors (750156 MB)
[ 7905.888522] sd 12:3:0:0: [sde] Write Protect is off
[ 7905.888525] sd 12:3:0:0: [sde] Mode Sense: 00 3a 00 00
[ 7905.888551] sd 12:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 7905.888555]  sde: sde1
[ 7905.898762] sd 12:3:0:0: [sde] Attached SCSI disk
[ 7905.898833] sd 12:3:0:0: Attached scsi generic sg5 type 0

for d in /dev/sd? ; do bash -c "hdparm -t $d &" ; done

[ 7936.193491] ata6.00: failed to read SCR 1 (Emask=0x40)
[ 7936.193502] ata6.01: failed to read SCR 1 (Emask=0x40)
[ 7936.193506] ata6.02: failed to read SCR 1 (Emask=0x40)
[ 7936.193512] ata6.03: failed to read SCR 1 (Emask=0x40)
[ 7936.193522] ata6.15: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 7936.193528] ata6.15: irq_stat 0x00060002, PMP DMA CS errata
[ 7936.193539] ata6.00: exception Emask 0x100 SAct 0x6 SErr 0x0 action 0x6 frozen
[ 7936.193551] ata6.00: cmd 60/08:08:00:1f:00/00:00:00:00:00/40 tag 1 ncq 4096 in
[ 7936.193553]          res 50/00:00:00:00:00/00:00:00:00:00/00 Emask 0x100 (unknown error)
[ 7936.193559] ata6.00: status: { DRDY }
[ 7936.193568] ata6.00: cmd 60/f8:10:08:1f:00/00:00:00:00:00/40 tag 2 ncq 126976 in
[ 7936.193570]          res 50/00:00:00:00:00/00:00:00:00:00/00 Emask 0x100 (unknown error)
[ 7936.193576] ata6.00: status: { DRDY }
[ 7936.193586] ata6.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[ 7936.193596] ata6.01: cmd c8/00:00:00:18:00/00:00:00:00:00/e0 tag 0 dma 131072 in
[ 7936.193598]          res 50/00:00:00:00:00/00:00:00:00:00/00 Emask 0x100 (unknown error)
[ 7936.193604] ata6.01: status: { DRDY }
[ 7936.193614] ata6.02: exception Emask 0x2 SAct 0x800 SErr 0x0 action 0x6 frozen
[ 7936.193619] ata6.02: irq_stat 0x00060002, data directon mismatch
[ 7936.193631] ata6.02: cmd 60/f8:58:08:16:00/00:00:00:00:00/40 tag 11 ncq 126976 in
[ 7936.193633]          res 50/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violation)
[ 7936.193638] ata6.02: status: { DRDY }
[ 7936.193647] ata6.03: exception Emask 0x100 SAct 0x1008 SErr 0x0 action 0x6 frozen
[ 7936.193657] ata6.03: cmd 60/08:18:00:19:00/00:00:00:00:00/40 tag 3 ncq 4096 in
[ 7936.193659]          res 50/00:00:00:00:00/00:00:00:00:00/00 Emask 0x100 (unknown error)
[ 7936.193664] ata6.03: status: { DRDY }
[ 7936.193675] ata6.03: cmd 60/f8:60:08:19:00/00:00:00:00:00/40 tag 12 ncq 126976 in
[ 7936.193677]          res 50/00:00:00:00:00/00:00:00:00:00/00 Emask 0x100 (unknown error)
[ 7936.193683] ata6.03: status: { DRDY }
[ 7936.193693] ata6.15: hard resetting link
[ 7936.193697] ata6: controller in dubious state, performing PORT_RST
[ 7938.417807] ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 7938.418267] ata6.00: hard resetting link
[ 7938.769221] ata6.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[ 7938.769268] ata6.01: hard resetting link
[ 7948.746735] ata6.01: softreset failed (timeout)
[ 7948.746746] ata6.01: hard resetting link
[ 7958.733406] ata6.01: softreset failed (timeout)
[ 7958.733417] ata6.01: hard resetting link
[ 7989.698590] ata6.01: failed to read SCR 0 (Emask=0x40)
[ 7989.698599] ata6.01: failed to read SCR 0 (Emask=0x40)

Taking too long to recover (I needed the machine for other work),
so here I unplugged the PCIe controller card.

[ 7989.698603] pciehp: Card not present on Slot(0013_0005)
[ 7989.698610] ata6.01: failed to read SCR 1 (Emask=0x40)
[ 7989.698614] ata6.01: failed to read SCR 0 (Emask=0x40)
[ 7989.698619] ata6.02: failed to read SCR 2 (Emask=0x40)
[ 7989.698623] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
[ 7989.698630] ata6.02: hard resetting link
[ 7989.807925] ata6.02: hardreset failed (port not ready)
[ 7989.807935] ata6.02: reset failed (errno=-5), retrying in 10 secs
[ 7999.673872] ata6.02: hard resetting link
[ 7999.785623] ata6.02: hardreset failed (port not ready)
[ 7999.785633] ata6.02: reset failed (errno=-5), retrying in 10 secs
[ 8009.651570] ata6.02: hard resetting link
[ 8009.763321] ata6.02: hardreset failed (port not ready)
[ 8009.763331] ata6.02: reset failed (errno=-5), retrying in 35 secs

Mmmm.. libata refusing to give up on a non-present card,
so just for fun I plugged it back in again:

[ 8037.211419] pciehp: Card present on Slot(0013_0005)
[ 8037.211447] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
[ 8041.397700] pciehp: Card not present on Slot(0013_0005)
[ 8041.397723] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
[ 8044.573516] ata6.02: failed to read SCR 0 (Emask=0x40)
[ 8044.573526] ata6.02: limiting SATA link speed to 1.5 Gbps
[ 8044.573530] ata6.02: hard resetting link
[ 8044.685264] ata6.02: hardreset failed (port not ready)
[ 8044.685275] ata6.02: reset failed, giving up
[ 8044.685286] ata6.15: hard resetting link
[ 8044.685290] ata6: controller in dubious state, performing PORT_RST
[ 8046.888352] ata6.15: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[ 8047.139783] ata6.15: qc timeout (cmd 0xe4)
[ 8047.251534] ata6.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 8047.251543] ata6.15: PMP revalidation failed (errno=-5)
[ 8047.251546] ata6.15: retrying hardreset in 5 secs
[ 8047.920143] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
[ 8052.244373] ata6.15: hard resetting link
[ 8052.244382] ata6: controller in dubious state, performing PORT_RST
[ 8054.447456] ata6.15: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[ 8054.698886] ata6.15: qc timeout (cmd 0xe4)
[ 8054.810638] ata6.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 8054.810647] ata6.15: PMP revalidation failed (errno=-5)
[ 8054.810655] ata6.15: limiting SATA link speed to <unknown>
[ 8054.810659] ata6.15: retrying hardreset in 5 secs
[ 8059.803478] ata6.15: hard resetting link
[ 8059.803487] ata6: controller in dubious state, performing PORT_RST
[ 8062.006561] ata6.15: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[ 8062.257992] ata6.15: qc timeout (cmd 0xe4)
[ 8062.369727] ata6.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 8062.369736] ata6.15: PMP revalidation failed (errno=-5)
[ 8062.369743] ata6.15: limiting SATA link speed to <unknown>
[ 8062.369747] ata6.15: retrying hardreset in 5 secs
[ 8067.362548] ata6.15: hard resetting link
[ 8067.362557] ata6: controller in dubious state, performing PORT_RST
[ 8069.573606] ata6.15: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[ 8069.825030] ata6.15: qc timeout (cmd 0xe4)
[ 8069.936939] ata6.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 8069.936949] ata6.15: PMP revalidation failed (errno=-5)
[ 8069.936955] ata6.15: limiting SATA link speed to <unknown>
[ 8069.936959] ata6.15: retrying hardreset in 5 secs
[ 8074.929619] ata6.15: hard resetting link
[ 8074.929627] ata6: controller in dubious state, performing PORT_RST
[ 8077.132724] ata6.15: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[ 8077.384147] ata6.15: qc timeout (cmd 0xe4)
[ 8077.495881] ata6.15: failed to read PMP GSCR[0] (Emask=0x4)
[ 8077.495889] ata6.15: PMP revalidation failed (errno=-5)
[ 8077.495894] ata6.15: failed to recover PMP after 5 tries, giving up
[ 8077.495897] ata6.15: Port Multiplier detaching
[ 8077.607655] ata6.00: disabled
[ 8077.607663] ata6.01: disabled
[ 8077.607667] ata6.02: disabled
[ 8077.607670] ata6.03: disabled
[ 8077.607677] ata6.00: disabled
[ 8077.607706] sd 12:1:0:0: [sdc] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[ 8077.607713] sd 12:1:0:0: [sdc] Sense Key : Aborted Command [current] [descriptor]
[ 8077.607720] Descriptor sense data with sense descriptors (in hex):
[ 8077.607724]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
[ 8077.607737]         00 00 00 00 
[ 8077.607742] sd 12:1:0:0: [sdc] Add. Sense: No additional sense information
[ 8077.607750] end_request: I/O error, dev sdc, sector 6144
[ 8077.607755] Buffer I/O error on device sdc, logical block 768
[ 8077.607764] Buffer I/O error on device sdc, logical block 769
[ 8077.607769] Buffer I/O error on device sdc, logical block 770
[ 8077.607773] Buffer I/O error on device sdc, logical block 771
[ 8077.607778] Buffer I/O error on device sdc, logical block 772
[ 8077.607783] Buffer I/O error on device sdc, logical block 773
[ 8077.607787] Buffer I/O error on device sdc, logical block 774
[ 8077.607792] Buffer I/O error on device sdc, logical block 775
[ 8077.607796] Buffer I/O error on device sdc, logical block 776
[ 8077.607801] Buffer I/O error on device sdc, logical block 777
[ 8077.607845] sd 12:1:0:0: rejecting I/O to offline device
[ 8077.607855] sd 12:1:0:0: rejecting I/O to offline device
[ 8077.607906] sd 12:1:0:0: rejecting I/O to offline device
[ 8077.607919] sd 12:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[ 8077.607927] sd 12:0:0:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
[ 8077.607936] Descriptor sense data with sense descriptors (in hex):
[ 8077.607940]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
[ 8077.607960]         00 00 00 00 
[ 8077.607968] sd 12:0:0:0: [sdb] Add. Sense: No additional sense information
[ 8077.607977] end_request: I/O error, dev sdb, sector 7936
[ 8077.607986] sd 12:0:0:0: rejecting I/O to offline device
[ 8077.607992] sd 12:0:0:0: rejecting I/O to offline device
[ 8077.608045] sd 12:0:0:0: [sdb] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[ 8077.608053] sd 12:0:0:0: [sdb] Sense Key : Aborted Command [current] [descriptor]
[ 8077.608062] Descriptor sense data with sense descriptors (in hex):
[ 8077.608066]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
[ 8077.608085]         00 00 00 00 
[ 8077.608092] sd 12:0:0:0: [sdb] Add. Sense: No additional sense information
[ 8077.608101] end_request: I/O error, dev sdb, sector 7944
[ 8077.608146] sd 12:3:0:0: [sde] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[ 8077.608153] sd 12:3:0:0: [sde] Sense Key : Aborted Command [current] [descriptor]
[ 8077.608162] Descriptor sense data with sense descriptors (in hex):
[ 8077.608166]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
[ 8077.608187]         00 00 00 00 
[ 8077.608194] sd 12:3:0:0: [sde] Add. Sense: No additional sense information
[ 8077.608203] end_request: I/O error, dev sde, sector 6400
[ 8077.608213] sd 12:3:0:0: rejecting I/O to offline device
[ 8077.608224] sd 12:2:0:0: [sdd] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[ 8077.608231] sd 12:2:0:0: [sdd] Sense Key : Aborted Command [current] [descriptor]
[ 8077.608240] Descriptor sense data with sense descriptors (in hex):
[ 8077.608244]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
[ 8077.608263]         00 00 00 00 
[ 8077.608270] sd 12:2:0:0: [sdd] Add. Sense: No additional sense information
[ 8077.608279] end_request: I/O error, dev sdd, sector 5640
[ 8077.608324] sd 12:2:0:0: rejecting I/O to offline device
[ 8077.608334] sd 12:3:0:0: [sde] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[ 8077.608340] sd 12:3:0:0: [sde] Sense Key : Aborted Command [current] [descriptor]
[ 8077.608349] Descriptor sense data with sense descriptors (in hex):
[ 8077.608354]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
[ 8077.608374]         00 00 00 00 
[ 8077.608381] sd 12:3:0:0: [sde] Add. Sense: No additional sense information
[ 8077.608390] end_request: I/O error, dev sde, sector 6408
[ 8077.608434] ata6: EH complete
[ 8077.608448] sd 12:1:0:0: [sdc] Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK,SUGGEST_OK
[ 8077.608455] end_request: I/O error, dev sdc, sector 6400
[ 8077.608462] sd 12:0:0:0: [sdb] Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK,SUGGEST_OK
[ 8077.608469] end_request: I/O error, dev sdb, sector 8192
[ 8077.608479] sd 12:3:0:0: [sde] Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK,SUGGEST_OK
[ 8077.608486] end_request: I/O error, dev sde, sector 6656
[ 8077.608530] sd 12:2:0:0: [sdd] Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK,SUGGEST_OK
[ 8077.608538] end_request: I/O error, dev sdd, sector 5888
[ 8077.610463] sd 12:0:0:0: [sdb] Synchronizing SCSI cache
[ 8077.610504] sd 12:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[ 8077.610511] sd 12:0:0:0: [sdb] Stopping disk
[ 8077.610523] sd 12:0:0:0: [sdb] START_STOP FAILED
[ 8077.610527] sd 12:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[ 8077.612167] sd 12:1:0:0: [sdc] Stopping disk
[ 8077.612187] sd 12:1:0:0: [sdc] START_STOP FAILED
[ 8077.612191] sd 12:1:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[ 8077.613666] sd 12:2:0:0: [sdd] Synchronizing SCSI cache
[ 8077.613701] sd 12:2:0:0: [sdd] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[ 8077.613708] sd 12:2:0:0: [sdd] Stopping disk
[ 8077.613721] sd 12:2:0:0: [sdd] START_STOP FAILED
[ 8077.613725] sd 12:2:0:0: [sdd] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[ 8077.615310] sd 12:3:0:0: [sde] Synchronizing SCSI cache
[ 8077.615344] sd 12:3:0:0: [sde] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[ 8077.615352] sd 12:3:0:0: [sde] Stopping disk
[ 8077.615365] sd 12:3:0:0: [sde] START_STOP FAILED
[ 8077.615368] sd 12:3:0:0: [sde] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[ 8077.615525] ACPI: PCI interrupt for device 0000:0d:00.0 disabled

System now dead.  No alt-sysrq, no nothing.
At one point there was a kernel Ooops on the screen, with libata-eh clearly
in the traceback.  But this didn't make it into /var/log/messages, so.. oh well.

Like I said, I need this machine for other work (it's my main machine).

