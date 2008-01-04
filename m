From: devzero@web.de
Subject: pata_winbond doesn`t unregister from sysfs - bug?
Date: Fri, 04 Jan 2008 14:52:25 +0100
Message-ID: <85735256@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate05.web.de ([217.72.192.243]:43270 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbYADNw2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 08:52:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com

Hi, 

this looks like a bug to me (see below)
happens on 2.6.24rc6 and i came across this by chance...

i`m here on notebook with vmware only, so i cannot test if this happens on real hardware, too.
maybe someone can try "modprobe pata_winbond" twice and see if this is reproduceable....

regards
Roland 


opensuse103:~ # modprobe pata_winbond
FATAL: Error inserting pata_winbond (/lib/modules/2.6.24-rc6-vanilla+suseconfig/kernel/drivers/ata/pata_winbond.ko): No such device

dmesg:
scsi1 : pata_winbond
ata1: PATA max PIO4 cmd 0x1f0 ctl 0x3f6 irq 14

opensuse103:~ # rmmod pata_winbond
ERROR: Module pata_winbond does not exist in /proc/modules

opensuse103:~ # lsmod |grep winbond
opensuse103:~ #

ok, it did not load (as expected)

but on second load:

opensuse103:~ # modprobe pata_winbond
FATAL: Error inserting pata_winbond (/lib/modules/2.6.24-rc6-vanilla+suseconfig/kernel/drivers/ata/pata_winbond.ko): No such device

dmesg:
sysfs: duplicate filename 'pata_winbond.0' can not be created
WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Pid: 2472, comm: modprobe Not tainted 2.6.24-rc6-vanilla+suseconfig #11
 [<c01ad508>] sysfs_add_one+0x54/0xb8
 [<c01ad9a7>] create_dir+0x3c/0x6c
 [<c01ada04>] sysfs_create_dir+0x2d/0x40
 [<c01d2f8f>] kobject_get+0xf/0x13
 [<c01d33a8>] kobject_add+0xe8/0x18f
 [<c01d32ad>] kobject_set_name+0x81/0x94
 [<c0240520>] device_add+0x8b/0x462
 [<c02431cf>] platform_device_add+0xe8/0x116
 [<c024336a>] platform_device_register_simple+0x34/0x4a
 [<e08e6112>] winbond_init+0x112/0x29c [pata_winbond]
 [<c0144044>] sys_init_module+0x1675/0x172d
 [<c0174cbe>] do_sync_read+0x0/0x10a
 [<c0174d85>] do_sync_read+0xc7/0x10a
 [<c012a2f6>] __do_softirq+0x75/0xe1
 [<c012ada4>] __request_region+0x0/0x74
 [<c0104f52>] sysenter_past_esp+0x6b/0xa9
 =======================
kobject_add failed for pata_winbond.0 with -EEXIST, don't try to register things with the same name in the same directory.
Pid: 2472, comm: modprobe Not tainted 2.6.24-rc6-vanilla+suseconfig #11
 [<c01d33fc>] kobject_add+0x13c/0x18f
 [<c01d341d>] kobject_add+0x15d/0x18f
 [<c01d32ad>] kobject_set_name+0x81/0x94
 [<c0240520>] device_add+0x8b/0x462
 [<c02431cf>] platform_device_add+0xe8/0x116
 [<c024336a>] platform_device_register_simple+0x34/0x4a
 [<e08e6112>] winbond_init+0x112/0x29c [pata_winbond]
 [<c0144044>] sys_init_module+0x1675/0x172d
 [<c0174cbe>] do_sync_read+0x0/0x10a
 [<c0174d85>] do_sync_read+0xc7/0x10a
 [<c012a2f6>] __do_softirq+0x75/0xe1
 [<c012ada4>] __request_region+0x0/0x74
 [<c0104f52>] sysenter_past_esp+0x6b/0xa9
 =======================

opensuse103:/ # find /sys |grep winbond
/sys/devices/platform/pata_winbond.0
/sys/devices/platform/pata_winbond.0/uevent
/sys/devices/platform/pata_winbond.0/power
/sys/devices/platform/pata_winbond.0/power/wakeup
/sys/devices/platform/pata_winbond.0/modalias
/sys/devices/platform/pata_winbond.0/subsystem
/sys/devices/platform/pata_winbond.0/host1
/sys/devices/platform/pata_winbond.0/host1/uevent
/sys/devices/platform/pata_winbond.0/host1/power
/sys/devices/platform/pata_winbond.0/host1/power/wakeup
/sys/bus/platform/devices/pata_winbond.0




opensuse103:/ # lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 01)
        Subsystem: VMware Inc virtualHW v3
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 08)
        Subsystem: VMware Inc virtualHW v3
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: VMware Inc virtualHW v3
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
        Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
        Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
        Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
        Region 4: I/O ports at 1050 [size=16]

00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 08)
        Subsystem: VMware Inc virtualHW v3
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0f.0 VGA compatible controller: VMware Inc [VMware SVGA II] PCI Display Adapter (prog-if 00 [VGA])
        Subsystem: VMware Inc [VMware SVGA II] PCI Display Adapter
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Region 0: I/O ports at 1060 [size=16]
        Region 1: Memory at f0000000 (32-bit, non-prefetchable) [size=128M]
        Region 2: Memory at e8000000 (32-bit, non-prefetchable) [size=8M]
        [virtual] Expansion ROM at 30000000 [disabled] [size=32K]

00:10.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1500ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 1080 [size=128]
        Region 1: Memory at e8800000 (32-bit, non-prefetchable) [size=4K]
        [virtual] Expansion ROM at 30008000 [disabled] [size=16K]

00:11.0 PCI bridge: VMware Inc Unknown device 0790 (rev 02) (prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 32 bytes
        Region 0: Memory at e8801000 (64-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=68
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Subsystem: VMware Inc Unknown device 0790

02:00.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet32 LANCE] (rev 10)
        Subsystem: Advanced Micro Devices [AMD] PCnet - Fast 79C971
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1500ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at 2000 [size=128]
        [virtual] Expansion ROM at 30010000 [disabled] [size=64K]

_____________________________________________________________________
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/?mc=100071&distributionid=000000000066

