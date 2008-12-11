From: Tony Battersby <tonyb@cybernetics.com>
Subject: AHCI problem with hotplug
Date: Thu, 11 Dec 2008 15:32:35 -0500
Message-ID: <494178E3.6030305@cybernetics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host64.cybernetics.com ([98.174.209.230]:1976 "EHLO
	mail.cybernetics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450AbYLKVAG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Dec 2008 16:00:06 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

I am having a problem getting Linux to detect hot-plugged SATA disks on my
ICH7 AHCI controller (SuperMicro PDSME motherboard).  On any SATA port that
already had a disk plugged in during BIOS POST, Linux will see the disk and
detect hot-plug and hot-unplug events just fine.  On any SATA port that did
not have a disk plugged in during BIOS POST, Linux will not see a disk no
matter what.  Here are the different sequences of events that I have tried:

1) boot with SATA disk plugged in
   modprobe ahci: disk detected
   unplug disk:   disk deleted
   plug in disk:  disk detected

2) boot with SATA disk plugged in
   unplug disk
   modprobe ahci
   plug in disk: disk detected
   unplug disk:  disk deleted
   plug in disk: disk detected
   unplug disk:  disk deleted
   plug in disk to any other SATA port    -> not detected
   plug in disk to the original SATA port -> disk detected

3) boot with SATA disk unplugged
   plug in disk to any SATA port
   modprobe ahci: not detected
   grep ahci /proc/interrupts: 0 interrupts

4) boot with SATA disk unplugged
   modprobe ahci
   plug in disk to any SATA port: not detected
   grep ahci /proc/interrupts: 0 interrupts

5) keep SATA disk plugged in during BIOS POST but unplug it before the
   kernel boots
   kernel hangs at "BIOS data check"

I have tried both 2.6.24.7 and 2.6.27.8 with the same result.

The BIOS is configured as follows:
Parallel ATA:         [Enabled]
Serial ATA:           [Enabled]
SATA Controller Mode: [Enhanced]
SATA RAID:            [Disabled]
SATA AHCI:            [Enabled]

The root filesystem is on a parallel IDE disk using the legacy (non-libata)
piix driver.



Kernel messages when the disk was plugged in before booting:
ahci_init_one: ENTER
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ata_host_alloc: ENTER
ata_port_alloc: ENTER
ata_port_alloc: ENTER
ata_port_alloc: ENTER
ata_port_alloc: ENTER
ahci_port_init: PORT_SCR_ERR 0x0
ahci_port_init: PORT_IRQ_STAT 0x0
ahci_init_controller: HOST_CTL 0x80000000
ahci_init_controller: HOST_CTL 0x80000002
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x1 impl SATA
mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part  
ahci 0000:00:1f.2: setting latency timer to 64
__ata_port_freeze: ata4294967295 port frozen
__ata_port_freeze: ata4294967295 port frozen
__ata_port_freeze: ata4294967295 port frozen
__ata_port_freeze: ata4294967295 port frozen
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 abar m1024@0xed000400 port 0xed000500 irq 505
ata2: DUMMY
ata3: DUMMY
ata4: DUMMY
ata_host_register: probe begin
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata1: ata_port_flush_task: EXIT
ata_eh_link_autopsy: ENTER
ata_eh_recover: ENTER
__ata_port_freeze: ata1 port frozen
ahci_hardreset: ENTER
sata_link_hardreset: ENTER
sata_link_hardreset: EXIT, rc=0
ata_dev_classify: found ATA device by sig
ahci_hardreset: EXIT, rc=0, class=1
ata_eh_thaw_port: ata1 port thawed
ata_std_postreset: ENTER
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata1.00: ata_dev_read_id: ENTER
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_port_flush_task: ENTER
ata1: ata_port_flush_task: EXIT
ata1.00: ata_dev_configure: ENTER
ahci_interrupt: ENTER
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_port_flush_task: ENTER
ata1: ata_port_flush_task: EXIT
ata1.00: ata_dev_configure: cfg 49:2f00 82:746b 83:7f61 84:4163 85:7469
86:be41 87:4163 88:207f
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007  64==0x0003  75==0x001f   
ata_dump_id: 80==0x01fe  81==0x0000  82==0x746b  83==0x7f61  84==0x4163   
ata_dump_id: 88==0x207f  93==0x0000
ata1.00: ATA-8: WDC WD2502ABYS-01B7A0, 02.03B02, max UDMA/133
ata1.00: 490350672 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata_dev_set_xfermode: set features - xfer mode
ahci_interrupt: ENTER
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_port_flush_task: ENTER
ata1: ata_port_flush_task: EXIT
ata_dev_set_xfermode: EXIT, err_mask=0
ata1.00: ata_dev_read_id: ENTER
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_port_flush_task: ENTER
ata1: ata_port_flush_task: EXIT
ata1.00: ata_dev_configure: ENTER
ahci_interrupt: ENTER
ahci_interrupt: port 0
ahci_interrupt: EXIT
ata_port_flush_task: ENTER
ata1: ata_port_flush_task: EXIT
ata1.00: ata_dev_configure: cfg 49:2f00 82:746b 83:7f61 84:4163 85:7469
86:be41 87:4163 88:407f
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007  64==0x0003  75==0x001f   
ata_dump_id: 80==0x01fe  81==0x0000  82==0x746b  83==0x7f61  84==0x4163   
ata_dump_id: 88==0x407f  93==0x0000
ata_dev_set_mode: xfer_shift=12, xfer_mode=0x46
ata1.00: configured for UDMA/133
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata2: ata_port_flush_task: EXIT
ata_scsi_error: EXIT
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata3: ata_port_flush_task: EXIT
ata_scsi_error: EXIT
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata4: ata_port_flush_task: EXIT
ata_scsi_error: EXIT
ata_host_register: host probe begin
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsiop_inq_std: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 60 00 00 00 00
ata_scsiop_inq_std: ENTER
scsi 0:0:0:0: Direct-Access     ATA      WDC WD2502ABYS-0 02.0 PQ: 0
ANSI: 5
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
sd 0:0:0:0: [sda] 490350672 512-byte hardware sectors (251060 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
sd 0:0:0:0: [sda] 490350672 512-byte hardware sectors (251060 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
ata_scsiop_mode_sense: ENTER
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda:<3>ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_translate: ENTER
scsi_10_lba_len: ten-byte command
ata_sg_setup: ENTER, ata1
ata_sg_setup: 1 sg elements mapped
ahci_fill_sg: ENTER
ata_scsi_translate: EXIT
ahci_interrupt: ENTER
ata_sg_clean: unmapping 1 sg elements
ahci_interrupt: port 0
ahci_interrupt: EXIT
 sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk



Kernel messages when the disk was unplugged during BIOS POST but plugged in
before modprobe ahci:
ahci_init_one: ENTER
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: forcing PORTS_IMPL to 0xf
ata_host_alloc: ENTER
ata_port_alloc: ENTER
ata_port_alloc: ENTER
ata_port_alloc: ENTER
ata_port_alloc: ENTER
ahci_port_init: PORT_SCR_ERR 0x0
ahci_port_init: PORT_IRQ_STAT 0x0
ahci_port_init: PORT_SCR_ERR 0x0
ahci_port_init: PORT_IRQ_STAT 0x0
ahci_port_init: PORT_SCR_ERR 0x0
ahci_port_init: PORT_IRQ_STAT 0x0
ahci_port_init: PORT_SCR_ERR 0x0
ahci_port_init: PORT_IRQ_STAT 0x0
ahci_init_controller: HOST_CTL 0x80000000
ahci_init_controller: HOST_CTL 0x80000002
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA
mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part  
ahci 0000:00:1f.2: setting latency timer to 64
__ata_port_freeze: ata4294967295 port frozen
__ata_port_freeze: ata4294967295 port frozen
__ata_port_freeze: ata4294967295 port frozen
__ata_port_freeze: ata4294967295 port frozen
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 abar m1024@0xed000400 port 0xed000500 irq 505
ata2: SATA max UDMA/133 abar m1024@0xed000400 port 0xed000580 irq 505
ata3: SATA max UDMA/133 abar m1024@0xed000400 port 0xed000600 irq 505
ata4: SATA max UDMA/133 abar m1024@0xed000400 port 0xed000680 irq 505
ata_host_register: probe begin
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata1: ata_port_flush_task: EXIT
ata_eh_link_autopsy: ENTER
ata_eh_recover: ENTER
__ata_port_freeze: ata1 port frozen
ahci_hardreset: ENTER
sata_link_hardreset: ENTER
sata_link_hardreset: EXIT, rc=0
ahci_hardreset: EXIT, rc=0, class=0
ata_eh_thaw_port: ata1 port thawed
ata_std_postreset: ENTER
ata1: SATA link down (SStatus 0 SControl 0)
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata2: ata_port_flush_task: EXIT
ata_eh_link_autopsy: ENTER
ata_eh_recover: ENTER
__ata_port_freeze: ata2 port frozen
ahci_hardreset: ENTER
sata_link_hardreset: ENTER
sata_link_hardreset: EXIT, rc=0
ahci_hardreset: EXIT, rc=0, class=0
ata_eh_thaw_port: ata2 port thawed
ata_std_postreset: ENTER
ata2: SATA link down (SStatus 0 SControl 0)
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata3: ata_port_flush_task: EXIT
ata_eh_link_autopsy: ENTER
ata_eh_recover: ENTER
__ata_port_freeze: ata3 port frozen
ahci_hardreset: ENTER
sata_link_hardreset: ENTER
sata_link_hardreset: EXIT, rc=0
ahci_hardreset: EXIT, rc=0, class=0
ata_eh_thaw_port: ata3 port thawed
ata_std_postreset: ENTER
ata3: SATA link down (SStatus 0 SControl 0)
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata4: ata_port_flush_task: EXIT
ata_eh_link_autopsy: ENTER
ata_eh_recover: ENTER
__ata_port_freeze: ata4 port frozen
ahci_hardreset: ENTER
sata_link_hardreset: ENTER
sata_link_hardreset: EXIT, rc=0
ahci_hardreset: EXIT, rc=0, class=0
ata_eh_thaw_port: ata4 port thawed
ata_std_postreset: ENTER
ata4: SATA link down (SStatus 0 SControl 0)
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata_eh_recover: EXIT, rc=0
ata_scsi_error: EXIT
ata_host_register: host probe begin



lspci -vv
00:00.0 Host bridge: Intel Corporation E7230/3000/3010 Memory Controller
Hub (rev 81)
    Subsystem: Super Micro Computer Inc Unknown device 7780
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information <?>

00:01.0 PCI bridge: Intel Corporation E7230/3000/3010 PCI Express Root
Port (rev 81) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
    Memory behind bridge: ed100000-ed1fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [88] Subsystem: Super Micro Computer Inc Unknown
device 7780
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [90] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable+
        Address: fee0300c  Data: 4159
    Capabilities: [a0] Express (v1) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag- RBE- FLReset-
        DevCtl:    Report errors: Correctable+ Non-Fatal+ Fatal+
Unsupported+
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #2, Speed 2.5GT/s, Width x8, ASPM L0s, Latency
L0 <1us, L1 <4us
            ClockPM- Suprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surpise-
            Slot #1000, PowerLimit 10.000000; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Off, PwrInd On, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
    Capabilities: [100] Virtual Channel <?>
    Capabilities: [140] Root Complex Link <?>

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 01) (prog-if 00 [Normal decode])
    Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
            ExtTag- RBE- FLReset-
        DevCtl:    Report errors: Correctable+ Non-Fatal+ Fatal+
Unsupported+
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
        LnkCap:    Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1,
Latency L0 <256ns, L1 <4us
            ClockPM- Suprise- LLActRep+ BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
            Slot #  0, PowerLimit 0.000000; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal+ PMEIntEna-
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
    Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable+
        Address: fee0300c  Data: 4161
    Capabilities: [90] Subsystem: Super Micro Computer Inc Unknown
device 7780
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100] Virtual Channel <?>
    Capabilities: [180] Root Complex Link <?>

00:1c.4 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI
Express Port 5 (rev 01) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
    I/O behind bridge: 00007000-00007fff
    Memory behind bridge: ed200000-ed2fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
            ExtTag- RBE- FLReset-
        DevCtl:    Report errors: Correctable+ Non-Fatal+ Fatal+
Unsupported+
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
        LnkCap:    Port #5, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <256ns, L1 <4us
            ClockPM- Suprise- LLActRep+ BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
            Slot #  5, PowerLimit 10.000000; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
            Changed: MRL- PresDet+ LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal+ PMEIntEna-
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
    Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable+
        Address: fee0300c  Data: 4169
    Capabilities: [90] Subsystem: Super Micro Computer Inc Unknown
device 7780
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100] Virtual Channel <?>
    Capabilities: [180] Root Complex Link <?>

00:1c.5 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI
Express Port 6 (rev 01) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
    I/O behind bridge: 00008000-00008fff
    Memory behind bridge: ed300000-ed3fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
            ExtTag- RBE- FLReset-
        DevCtl:    Report errors: Correctable+ Non-Fatal+ Fatal+
Unsupported+
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
        LnkCap:    Port #6, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <256ns, L1 <4us
            ClockPM- Suprise- LLActRep+ BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
            Slot #  6, PowerLimit 10.000000; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
            Changed: MRL- PresDet+ LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal+ PMEIntEna-
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
    Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable+
        Address: fee0300c  Data: 4171
    Capabilities: [90] Subsystem: Super Micro Computer Inc Unknown
device 7780
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100] Virtual Channel <?>
    Capabilities: [180] Root Complex Link <?>

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
Controller #1 (rev 01) (prog-if 00 [UHCI])
    Subsystem: Super Micro Computer Inc Unknown device 7780
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 23
    Region 4: I/O ports at 64e0 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
Controller #2 (rev 01) (prog-if 00 [UHCI])
    Subsystem: Super Micro Computer Inc Unknown device 7780
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 19
    Region 4: I/O ports at 6800 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
Controller #3 (rev 01) (prog-if 00 [UHCI])
    Subsystem: Super Micro Computer Inc Unknown device 7780
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin C routed to IRQ 18
    Region 4: I/O ports at 6820 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
Controller #4 (rev 01) (prog-if 00 [UHCI])
    Subsystem: Super Micro Computer Inc Unknown device 7780
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin D routed to IRQ 16
    Region 4: I/O ports at 6840 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 01) (prog-if 20 [EHCI])
    Subsystem: Super Micro Computer Inc Unknown device 7780
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 23
    Region 0: Memory at ed000000 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] Debug port: BAR=1 offset=00a0

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1) (prog-if
01 [Subtractive decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Bus: primary=00, secondary=0a, subordinate=0a, sec-latency=32
    I/O behind bridge: 00009000-00009fff
    Memory behind bridge: ed400000-eeffffff
    Prefetchable memory behind bridge: 0000000030000000-00000000300fffff
    Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [50] Subsystem: Super Micro Computer Inc Unknown
device 7780

00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC
Interface Bridge (rev 01)
    Subsystem: Super Micro Computer Inc Unknown device 7780
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information <?>

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 01) (prog-if 8a [Master SecP PriP])
    Subsystem: Super Micro Computer Inc Unknown device 7780
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 18
    Region 0: I/O ports at 01f0 [size=8]
    Region 1: I/O ports at 03f4 [size=1]
    Region 2: I/O ports at 0170 [size=8]
    Region 3: I/O ports at 0374 [size=1]
    Region 4: I/O ports at 64d0 [size=16]

00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family) SATA
AHCI Controller (rev 01) (prog-if 01 [AHCI 1.0])
    Subsystem: Super Micro Computer Inc Unknown device 7780
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 507
    Region 0: I/O ports at 6898 [size=8]
    Region 1: I/O ports at 687c [size=4]
    Region 2: I/O ports at 6890 [size=8]
    Region 3: I/O ports at 6878 [size=4]
    Region 4: I/O ports at 6880 [size=16]
    Region 5: Memory at ed000400 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable+
        Address: fee0300c  Data: 4189
    Capabilities: [70] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
(rev 01)
    Subsystem: Super Micro Computer Inc Unknown device 7780
    Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin B routed to IRQ 19
    Region 4: I/O ports at 1100 [size=32]

01:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge
A (rev 09) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
    Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [44] Express (v1) PCI/PCI-X Bridge, MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal+ Fatal+
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x8, ASPM L0s, Latency
L0 unlimited, L1 unlimited
            ClockPM- Suprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [6c] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [d8] PCI-X bridge device
        Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=100MHz
        Status: Dev=01:00.0 64bit- 133MHz- SCD- USC- SCO- SRD-
        Upstream: Capacity=65535 CommitmentLimit=65535
        Downstream: Capacity=65535 CommitmentLimit=65535
    Capabilities: [100] Advanced Error Reporting <?>
    Capabilities: [300] Power Budgeting <?>

01:00.1 PIC: Intel Corporation 6700/6702PXH I/OxAPIC Interrupt
Controller A (rev 09) (prog-if 20 [IO(X)-APIC])
    Subsystem: Super Micro Computer Inc Unknown device 7780
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Region 0: Memory at ed100000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 256 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x8, ASPM L0s, Latency
L0 unlimited, L1 unlimited
            ClockPM- Suprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [6c] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge
B (rev 09) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=01, secondary=03, subordinate=03, sec-latency=64
    Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [44] Express (v1) PCI/PCI-X Bridge, MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal+ Fatal+
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x8, ASPM L0s, Latency
L0 unlimited, L1 unlimited
            ClockPM- Suprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [6c] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [d8] PCI-X bridge device
        Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=133MHz
        Status: Dev=01:00.2 64bit- 133MHz- SCD- USC- SCO- SRD-
        Upstream: Capacity=65535 CommitmentLimit=65535
        Downstream: Capacity=65535 CommitmentLimit=65535
    Capabilities: [100] Advanced Error Reporting <?>
    Capabilities: [300] Power Budgeting <?>

01:00.3 PIC: Intel Corporation 6700PXH I/OxAPIC Interrupt Controller B
(rev 09) (prog-if 20 [IO(X)-APIC])
    Subsystem: Super Micro Computer Inc Unknown device 7780
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Region 0: Memory at ed101000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 256 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x8, ASPM L0s, Latency
L0 unlimited, L1 unlimited
            ClockPM- Suprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [6c] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:00.0 Ethernet controller: Intel Corporation 82573E Gigabit Ethernet
Controller (Copper) (rev 03)
    Subsystem: Super Micro Computer Inc Unknown device 108c
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 506
    Region 0: Memory at ed200000 (32-bit, non-prefetchable) [size=128K]
    Region 2: I/O ports at 7000 [size=32]
    Capabilities: [c8] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=1 PME-
    Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable+
        Address: 00000000fee0300c  Data: 41a9
    Capabilities: [e0] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr+
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM unknown,
Latency L0 <128ns, L1 <64us
            ClockPM- Suprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [100] Advanced Error Reporting <?>
    Capabilities: [140] Device Serial Number a4-8d-86-ff-ff-48-30-00

06:00.0 Ethernet controller: Intel Corporation 82573E Gigabit Ethernet
Controller (Copper) (rev 03)
    Subsystem: Super Micro Computer Inc Unknown device 108c
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 505
    Region 0: Memory at ed300000 (32-bit, non-prefetchable) [size=128K]
    Region 2: I/O ports at 8000 [size=32]
    Capabilities: [c8] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=1 PME-
    Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable+
        Address: 00000000fee0300c  Data: 41c1
    Capabilities: [e0] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr+
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM unknown,
Latency L0 <128ns, L1 <64us
            ClockPM- Suprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [100] Advanced Error Reporting <?>
    Capabilities: [140] Device Serial Number a5-8d-86-ff-ff-48-30-00

0a:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
(prog-if 00 [VGA controller])
    Subsystem: ATI Technologies Inc Rage XL
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 66 (2000ns min), Cache Line Size: 32 bytes
    Interrupt: pin A routed to IRQ 10
    Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
    Region 1: I/O ports at 9000 [size=256]
    Region 2: Memory at ed400000 (32-bit, non-prefetchable) [size=4K]
    [virtual] Expansion ROM at 30000000 [disabled] [size=128K]
    Capabilities: [5c] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

