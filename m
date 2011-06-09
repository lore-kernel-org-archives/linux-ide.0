From: Tim Small <tim@seoss.co.uk>
Subject: Re: SiI 3726 pmp doesn't work with 2.6.38 and Marvell 88SE9123 AHCI
 controller
Date: Thu, 09 Jun 2011 22:11:27 +0100
Message-ID: <4DF136FF.2010404@seoss.co.uk>
References: <4DEE6831.9020501@seoss.co.uk> <20110609143755.GA2615@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([78.47.234.210]:35772 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055Ab1FIVLb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jun 2011 17:11:31 -0400
In-Reply-To: <20110609143755.GA2615@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Tejun,

Thanks very much for your patch - I gave it a spin (against Debian's
2.6.38 kernel) - it's apparently working better than before, but still a
bit wonky...

This is what happens when I hot-plugging the 3726 (with two drives
attached to it) into a SiI3132...

399.038172] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
399.038296] ata2: irq_stat 0x00b40090, PHY RDY changed
399.038402] ata2: hard resetting link
401.235936] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
401.236557] ata2.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
feat 0x1/0x9
401.236904] ata2.00: hard resetting link
401.556327] ata2.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
401.556471] ata2.01: hard resetting link
401.876223] ata2.01: SATA link down (SStatus 0 SControl 320)
401.876440] ata2.02: hard resetting link
402.196093] ata2.02: SATA link down (SStatus 0 SControl 320)
402.196304] ata2.03: hard resetting link
402.516010] ata2.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
402.516204] ata2.04: hard resetting link
402.835901] ata2.04: SATA link down (SStatus 0 SControl 320)
403.147472] ata2.05: no reset method available, skipping reset
403.147925] ata2.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
403.148773] ata2.00: ATA-7: Maxtor 6Y120M0, YAR51BW0, max UDMA/133
403.148945] ata2.00: 240121728 sectors, multi 0: LBA
403.150032] ata2.00: configured for UDMA/100
403.151113] ata2.03: ATA-7: Hitachi HUA721010KLA330, GKAOAB0A, max UDMA/133
403.151302] ata2.03: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
403.152568] ata2.03: configured for UDMA/100
403.152721] ata2: EH complete
403.152867] scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6Y120M0  
YAR5 PQ: 0 ANSI: 5
403.153349] sd 1:0:0:0: [sdb] 240121728 512-byte logical blocks: (122
GB/114 GiB)
403.153439] sd 1:0:0:0: [sdb] Write Protect is off
403.153459] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
403.153505] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
403.154034] scsi 1:3:0:0: Direct-Access     ATA      Hitachi HUA72101
GKAO PQ: 0 ANSI: 5
403.154481] sd 1:3:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00
TB/931 GiB)
403.154546] sd 1:3:0:0: [sdc] Write Protect is off
403.154548] sd 1:3:0:0: [sdc] Mode Sense: 00 3a 00 00
403.154572] sd 1:3:0:0: [sdc] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
403.162661]  sdb: sdb1
403.163293] sd 1:0:0:0: [sdb] Attached SCSI disk
403.168597]  sdc: sdc1 sdc2 < sdc5 >
403.169009] sd 1:3:0:0: [sdc] Attached SCSI disk

... reads from those drives then seem to work fine.

Unplugging from the 3132 (and waiting for things to settle), then
plugging into the 88SE9123 gives the following...

541.610033] ata14: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action
0xe frozen
541.610166] ata14: irq_stat 0x80400040, connection status changed
541.610277] ata14: SError: { PHYRdyChg CommWake DevExch }
541.610391] ata14: hard resetting link
543.288743] ata14: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
543.289086] ata14.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
feat 0x1/0x9
543.289220] ahci 0000:01:00.0: FBS is enabled.
543.289418] ata14.00: hard resetting link
543.608852] ata14.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
543.609031] ata14.01: hard resetting link
543.928756] ata14.01: SATA link down (SStatus 0 SControl 320)
543.928943] ata14.02: hard resetting link
544.248663] ata14.02: SATA link down (SStatus 0 SControl 320)
544.248856] ata14.03: hard resetting link
544.568553] ata14.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
544.880294] ata14.05: no reset method available, skipping reset
544.880594] ata14.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
544.881914] ata14.03: ATA-7: Hitachi HUA721010KLA330, GKAOAB0A, max UDMA/133
544.882099] ata14.03: 1953525168 sectors, multi 0: LBA48 NCQ (depth
31/32), AA
544.883774] ata14.03: configured for UDMA/133
544.883987] ata14: EH complete
544.884213] scsi 13:3:0:0: Direct-Access     ATA      Hitachi HUA72101
GKAO PQ: 0 ANSI: 5
544.884750] sd 13:3:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00
TB/931 GiB)
544.884879] sd 13:3:0:0: [sdb] Write Protect is off
544.884892] sd 13:3:0:0: [sdb] Mode Sense: 00 3a 00 00
544.884957] sd 13:3:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
544.897087]  sdb: sdb1 sdb2 < sdb5 >
544.897519] sd 13:3:0:0: [sdb] Attached SCSI disk

... so definitely some progress, but the Maxtor drive on PMP port zero
hasn't been found...

I then hot-un-plugged the Maxtor from the pmp and got this lot:

 709.515101] ata14.15: PMP product ID mismatch
 709.515256] ata14.15: hard resetting link
 715.043716] ata14.15: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
 715.044020] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
 715.044191] ata14.15: PMP revalidation failed (errno=-19)
 715.044352] ata14.15: limiting SATA link speed to 1.5 Gbps
 720.042049] ata14.15: hard resetting link
 725.572222] ata14.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 725.572595] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
 725.572767] ata14.15: PMP revalidation failed (errno=-19)
 730.570649] ata14.15: hard resetting link
 736.100725] ata14.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 736.101093] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
 736.101259] ata14.15: PMP revalidation failed (errno=-19)
 736.101417] ata14.15: failed to recover PMP after 5 tries, giving up
 736.101578] ata14.15: Port Multiplier detaching
 736.101732] ata14.03: disabled
 736.101874] ata14.00: disabled
 741.099118] ata14: hard resetting link
 746.629228] ata14: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
 746.629636] ata14.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
feat 0x1/0x9
 746.629880] ahci 0000:01:00.0: FBS is enabled.
 746.630139] ata14.00: hard resetting link
 746.949339] ata14.00: SATA link down (SStatus 0 SControl 310)
 746.949534] ata14.01: hard resetting link
 747.269258] ata14.01: SATA link down (SStatus 0 SControl 320)
 747.269448] ata14.02: hard resetting link
 747.589167] ata14.02: SATA link down (SStatus 0 SControl 320)
 747.589359] ata14.03: hard resetting link
 747.909043] ata14.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
 747.909230] ata14.04: hard resetting link
 748.228933] ata14.04: SATA link down (SStatus 0 SControl 320)
 748.540699] ata14.05: no reset method available, skipping reset
 748.541014] ata14.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
 748.542361] ata14.03: ATA-7: Hitachi HUA721010KLA330, GKAOAB0A, max
UDMA/133
 748.542549] ata14.03: 1953525168 sectors, multi 0: LBA48 NCQ (depth
31/32), AA
 748.544247] ata14.03: configured for UDMA/133
 748.544445] ata14: EH complete
 748.544610] ata14.03: detaching (SCSI 13:3:0:0)
 748.556691] sd 13:3:0:0: [sdb] Synchronizing SCSI cache
 748.556960] sd 13:3:0:0: [sdb] Stopping disk
 749.009984] scsi 13:3:0:0: Direct-Access     ATA      Hitachi HUA72101
GKAO PQ: 0 ANSI: 5
 749.010373] sd 13:3:0:0: [sdb] 1953525168 512-byte logical blocks:
(1.00 TB/931 GiB)
 749.025616] sd 13:3:0:0: [sdb] Write Protect is off
 749.025619] sd 13:3:0:0: [sdb] Mode Sense: 00 3a 00 00
 749.025641] sd 13:3:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
 751.208927]  sdb: sdb1 sdb2 < sdb5 >
 751.209352] sd 13:3:0:0: [sdb] Attached SCSI disk


Plugging the Maxtor back in then gave:

813.046630] ata14.15: PMP product ID mismatch
813.046787] ata14.15: hard resetting link
814.766608] ata14.15: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
814.766916] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
814.767080] ata14.15: PMP revalidation failed (errno=-19)
814.767241] ata14.15: limiting SATA link speed to 1.5 Gbps
819.764939] ata14.15: hard resetting link
821.488377] ata14.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
821.488766] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
821.488932] ata14.15: PMP revalidation failed (errno=-19)
826.486679] ata14.15: hard resetting link
828.210145] ata14.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
828.210520] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
828.210681] ata14.15: PMP revalidation failed (errno=-19)
828.210832] ata14.15: failed to recover PMP after 5 tries, giving up
828.210990] ata14.15: Port Multiplier detaching
828.211136] ata14.03: disabled
828.211274] ata14.00: disabled
833.208478] ata14: hard resetting link
834.931910] ata14: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
834.932300] ata14.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
feat 0x1/0x9
834.932550] ahci 0000:01:00.0: FBS is enabled.
834.932810] ata14.00: hard resetting link
835.252010] ata14.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
835.252200] ata14.01: hard resetting link
835.571932] ata14.01: SATA link down (SStatus 0 SControl 320)
835.572139] ata14.02: hard resetting link
835.891849] ata14.02: SATA link down (SStatus 0 SControl 320)
835.892045] ata14.03: hard resetting link
836.211721] ata14.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
836.211903] ata14.04: hard resetting link
836.531597] ata14.04: SATA link down (SStatus 0 SControl 320)
836.843382] ata14.05: no reset method available, skipping reset
836.843720] ata14.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
836.844502] ata14.00: ATA-7: Maxtor 6Y120M0, YAR51BW0, max UDMA/133
836.844674] ata14.00: 240121728 sectors, multi 0: LBA
836.845674] ata14.00: configured for UDMA/133
836.847053] ata14.03: ATA-7: Hitachi HUA721010KLA330, GKAOAB0A, max UDMA/133
836.847228] ata14.03: 1953525168 sectors, multi 0: LBA48 NCQ (depth
31/32), AA
836.848736] ata14.03: configured for UDMA/133
836.848913] ata14: EH complete
836.848922] ata14.03: detaching (SCSI 13:3:0:0)
836.871374] sd 13:3:0:0: [sdb] Synchronizing SCSI cache
836.871703] sd 13:3:0:0: [sdb] Stopping disk
837.322901] scsi 13:0:0:0: Direct-Access     ATA      Maxtor 6Y120M0  
YAR5 PQ: 0 ANSI: 5
837.323334] sd 13:0:0:0: [sdb] 240121728 512-byte logical blocks: (122
GB/114 GiB)
837.323392] sd 13:0:0:0: [sdb] Write Protect is off
837.323395] sd 13:0:0:0: [sdb] Mode Sense: 00 3a 00 00
837.323421] sd 13:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
837.323670] scsi 13:3:0:0: Direct-Access     ATA      Hitachi HUA72101
GKAO PQ: 0 ANSI: 5
837.324358] sd 13:3:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00
TB/931 GiB)
837.324628] sd 13:3:0:0: [sdc] Write Protect is off
837.324787] sd 13:3:0:0: [sdc] Mode Sense: 00 3a 00 00
837.324815] sd 13:3:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
837.327022]  sdb: sdb1
837.327376] sd 13:0:0:0: [sdb] Attached SCSI disk
839.487216]  sdc: sdc1 sdc2 < sdc5 >
839.487664] sd 13:3:0:0: [sdc] Attached SCSI disk


.... and reading from each disk individually works, but reading from
both at the same time doesn't (I/Os time-out, and then the whole lot
gets reset).


839.487664] sd 13:3:0:0: [sdc] Attached SCSI disk
928.712783] ata14.00: failed to read SCR 1 (Emask=0x40)
928.713010] ata14.01: failed to read SCR 1 (Emask=0x40)
928.713167] ata14.02: failed to read SCR 1 (Emask=0x40)
928.713320] ata14.03: failed to read SCR 1 (Emask=0x40)
928.713474] ata14.04: failed to read SCR 1 (Emask=0x40)
928.713630] ata14.05: failed to read SCR 1 (Emask=0x40)
928.713787] ata14.15: exception Emask 0x4 SAct 0x0 SErr 0x0 action 0x6
frozen
928.713957] ata14.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
928.714178] ata14.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
928.714399] ata14.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
928.714620] ata14.03: exception Emask 0x100 SAct 0x3 SErr 0x0 action 0x6
frozen
928.714841] ata14.03: failed command: READ FPDMA QUEUED
928.714999] ata14.03: cmd 60/00:00:00:02:00/01:00:00:00:00/40 tag 0 ncq
131072 in
928.715000]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4
(timeout)
928.715440] ata14.03: status: { DRDY }
928.715583] ata14.03: failed command: READ FPDMA QUEUED
928.715738] ata14.03: cmd 60/00:08:00:03:00/01:00:00:00:00/40 tag 1 ncq
131072 in
928.715739]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
(timeout)
928.716179] ata14.03: status: { DRDY }
928.716329] ata14.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
928.716552] ata14.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6
frozen
928.716785] ata14.15: hard resetting link
930.440201] ata14.15: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
930.440531] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
930.440702] ata14.15: PMP revalidation failed (errno=-19)
935.438490] ata14.15: hard resetting link
937.161975] ata14.15: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
937.162311] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
937.162474] ata14.15: PMP revalidation failed (errno=-19)
937.162629] ata14.15: limiting SATA link speed to 1.5 Gbps
942.160272] ata14.15: hard resetting link
943.883736] ata14.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
943.884114] ata14.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
943.884297] ata14.15: PMP revalidation failed (errno=-19)
943.884457] ata14.15: failed to recover PMP after 5 tries, giving up
943.884623] ata14.15: Port Multiplier detaching
943.884778] ata14.00: disabled
943.884920] ata14.03: disabled
943.885063] ata14.00: disabled
948.882087] ata14: hard resetting link
950.605510] ata14: SATA link up 3.0 Gbps (SStatus 123 SControl 370)
950.605902] ata14.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
feat 0x1/0x9
950.606143] ahci 0000:01:00.0: FBS is enabled.
950.606387] ata14.00: hard resetting link
950.925629] ata14.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
950.925807] ata14.01: hard resetting link
951.245532] ata14.01: SATA link down (SStatus 0 SControl 320)
951.245728] ata14.02: hard resetting link
951.565428] ata14.02: SATA link down (SStatus 0 SControl 320)
951.565625] ata14.03: hard resetting link
951.885272] ata14.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
951.885449] ata14.04: hard resetting link
952.205216] ata14.04: SATA link down (SStatus 0 SControl 320)
952.516939] ata14.05: no reset method available, skipping reset
952.517234] ata14.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
952.517977] ata14.00: ATA-7: Maxtor 6Y120M0, YAR51BW0, max UDMA/133
952.518145] ata14.00: 240121728 sectors, multi 0: LBA
952.518955] ata14.00: configured for UDMA/133
952.519905] ata14.03: ATA-7: Hitachi HUA721010KLA330, GKAOAB0A, max UDMA/133
952.520082] ata14.03: 1953525168 sectors, multi 0: LBA48 NCQ (depth
31/32), AA
952.521264] ata14.03: configured for UDMA/133
952.521443] ata14.03: device reported invalid CHS sector 0
952.521605] ata14.03: device reported invalid CHS sector 0
952.521761] sd 13:3:0:0: [sdc]  Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE
952.522053] sd 13:3:0:0: [sdc]  Sense Key : Aborted Command [current]
[descriptor]
952.522548] Descriptor sense data with sense descriptors (in hex):
952.522788]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
952.524111]         00 00 00 00
952.524591] sd 13:3:0:0: [sdc]  Add. Sense: No additional sense information
952.524903] sd 13:3:0:0: [sdc] CDB: Read(10): 28 00 00 00 02 00 00 01 00 00
952.525980] end_request: I/O error, dev sdc, sector 512
952.526140] Buffer I/O error on device sdc, logical block 64
952.526306] Buffer I/O error on device sdc, logical block 65
952.526323] sd 13:3:0:0: rejecting I/O to offline device
952.526628] Buffer I/O error on device sdc, logical block 66
952.526630] Buffer I/O error on device sdc, logical block 67
952.526633] Buffer I/O error on device sdc, logical block 68
952.526635] Buffer I/O error on device sdc, logical block 69
952.526638] Buffer I/O error on device sdc, logical block 70
952.526640] Buffer I/O error on device sdc, logical block 71
952.526642] Buffer I/O error on device sdc, logical block 72
952.526644] Buffer I/O error on device sdc, logical block 73
952.526663] sd 13:3:0:0: [sdc]  Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE
952.526665] sd 13:3:0:0: [sdc]  Sense Key : Aborted Command [current]
[descriptor]
952.526668] Descriptor sense data with sense descriptors (in hex):
952.526686]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
952.526692]         00 00 00 00
952.526696] sd 13:3:0:0: [sdc]  Add. Sense: No additional sense information
952.526716] sd 13:3:0:0: [sdc] CDB: Read(10): 28 00 00 00 03 00 00 01 00 00
952.526741] end_request: I/O error, dev sdc, sector 768
952.526811] ata14: EH complete
952.526848] ata14.00: detaching (SCSI 13:0:0:0)
952.531753] sd 13:3:0:0: rejecting I/O to offline device
952.531916] end_request: I/O error, dev sdc, sector 0
952.532078] sd 13:3:0:0: rejecting I/O to offline device
952.532239] end_request: I/O error, dev sdc, sector 0
952.544961] sd 13:0:0:0: [sdb] Synchronizing SCSI cache
952.545209] sd 13:0:0:0: [sdb] Stopping disk
952.653571] ata14.03: detaching (SCSI 13:3:0:0)
952.672917] sd 13:3:0:0: [sdc] Synchronizing SCSI cache
952.673212] sd 13:3:0:0: [sdc] Stopping disk
953.145975] scsi 13:0:0:0: Direct-Access     ATA      Maxtor 6Y120M0  
YAR5 PQ: 0 ANSI: 5
953.146403] sd 13:0:0:0: [sdb] 240121728 512-byte logical blocks: (122
GB/114 GiB)
953.146428] scsi 13:3:0:0: Direct-Access     ATA      Hitachi HUA72101
GKAO PQ: 0 ANSI: 5
953.146614] sd 13:3:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00
TB/931 GiB)
953.146666] sd 13:3:0:0: [sdc] Write Protect is off
953.146669] sd 13:3:0:0: [sdc] Mode Sense: 00 3a 00 00
953.146692] sd 13:3:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
953.147550] sd 13:0:0:0: [sdb] Write Protect is off
953.147710] sd 13:0:0:0: [sdb] Mode Sense: 00 3a 00 00
953.147739] sd 13:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
955.301412]  sdc: sdc1 sdc2 < sdc5 >
955.301853] sd 13:3:0:0: [sdc] Attached SCSI disk
956.199755]  sdb: sdb1
956.200134] sd 13:0:0:0: [sdb] Attached SCSI disk


I hope this is of some help - if you can give any hints, I'm happy to
try and dig a bit further (and/or if you'd like me to sent you any of
the hardware involved, please let me know).

Cheers!

Tim.

-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.  
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309

