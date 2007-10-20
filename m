From: Mark Lord <liml@rtr.ca>
Subject: Re: AHCI with ATA/IDE Drives
Date: Sat, 20 Oct 2007 09:59:20 -0400
Message-ID: <471A09B8.2040708@rtr.ca>
References: <a14fb1800710200440hbcb0438sf2b0ee627e6e8209@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4714 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151AbXJTN7W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Oct 2007 09:59:22 -0400
In-Reply-To: <a14fb1800710200440hbcb0438sf2b0ee627e6e8209@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Girish Shirasat <girish.shirasat@googlemail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>

Alan / Tejun,

Another case of MDMA2 not working through a SATA->PATA bridge.
Do we have an easy way yet, for Girish to force non-MDMA2 modes?

???


Girish Shirasat wrote:
> Hello All,
>      I have a Core 2 Duo & Intel 3100 chipset SBC. Of the six ports
> supported by the SATA controller ,three have been routed to SST based
> 512MB NAND flashes which provide ATA/IDE compatible interface.One of
> the three NAND flash is on AHCI only port so to access it I need to
> enable the AHCI support in the BIOS. The kernel version I am using is
> 2.6.23 .
>     When I am running in the IDE mode, I am able to access the two
> NAND devices without any issues but when I enable the AHCI mode to
> access the third flash , the access to all the NAND devices fail. I
> have attached the dumps with the debug flags enabled below.
>      Should I be able to do this in the first place as my NAND device=
s
> as stated provide only ATA/IDE emulation ? I disabled the NCQ in the
> AHCI driver but saw the same result. I would appreciate any pointers
> on the same,
>=20
> Regards,
> Girish
>=20
> Linux version 2.6.23 (root@localhost.localdomain) (gcc version 4.1.1
> 20070105 (Red Hat 4.1.1-52)) #13 SMP Sun Oct 21 06:10:01 BST 2007
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009e400 (usable)
>  BIOS-e820: 000000000009e400 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000cc000 - 00000000000d0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000007ff00000 (usable)
>  BIOS-e820: 000000007ff00000 - 000000007ff11000 (ACPI data)
>  BIOS-e820: 000000007ff11000 - 000000007ff80000 (ACPI NVS)
>  BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
>  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
> 1151MB HIGHMEM available.
> 896MB LOWMEM available.
> found SMP MP-table at 000f74c0
> Zone PFN ranges:
>   DMA             0 ->     4096
>   Normal       4096 ->   229376
>   HighMem    229376 ->   524032
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     0:        0 ->   524032
> DMI present.
> Using APIC driver default
> ACPI: RSDP 000F7490, 0014 (r0 PTLTD )
> ACPI: RSDT 7FF0C360, 0040 (r1 PTLTD    RSDT    6040000  LTP        0)
> ACPI: FACP 7FF10EC0, 0074 (r1 INTEL  WHTMLAKE  6040000 PTL         3)
> ACPI: DSDT 7FF0DAAA, 3416 (r1  Intel WHTMLAKE  6040000 MSFT  100000E)
> ACPI: FACS 7FF11FC0, 0040
> ACPI: MCFG 7FF10F34, 003C (r1 PTLTD    MCFG    6040000  LTP        0)
> ACPI: APIC 7FF10F70, 0068 (r1 PTLTD  	 APIC    6040000  LTP        0)
> ACPI: BOOT 7FF10FD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
> ACPI: SSDT 7FF0D84B, 025F (r1  PmRef  Cpu0Tst     3000 INTL 20050228)
> ACPI: SSDT 7FF0D7A5, 00A6 (r1  PmRef  Cpu1Tst     3000 INTL 20050228)
> ACPI: SSDT 7FF0C3A0, 1405 (r1  PmRef    CpuPm     3000 INTL 20050228)
> ACPI: PM-Timer IO Port: 0x1008
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 6:15 APIC version 20
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> Processor #1 6:15 APIC version 20
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at 88000000 (gap: 80000000:60000000=
)
> Built 1 zonelists in Zone order.  Total pages: 519938
> Kernel command line: ro root=3D/dev/VolGroup00/LogVol00 console=3Dtty=
S1,9600
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Initializing CPU#0
> CPU 0 irqstacks, hard=3Dc07c2000 soft=3Dc07a2000
> PID hash table entries: 4096 (order: 12, 16384 bytes)
> Detected 1500.194 MHz processor.
> Console: colour VGA+ 80x25
> console [ttyS1] enabled
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 2070980k/2096128k available (2381k kernel code, 23916k
> reserved, 1047k data, 256k init, 1178624k highmem)
> virtual kernel memory layout:
>     fixmap  : 0xffc54000 - 0xfffff000   (3756 kB)
>     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
>     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
>     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
>       .init : 0xc075f000 - 0xc079f000   ( 256 kB)
>       .data : 0xc0653564 - 0xc0759484   (1047 kB)
>       .text : 0xc0400000 - 0xc0653564   (2381 kB)
> Checking if this processor honours the WP bit even in supervisor mode=
=2E.. Ok.
> Calibrating delay using timer specific routine.. 3001.79 BogoMIPS (lp=
j=3D1500899)
> Security Framework v1.0.0 initialized
> SELinux:  Initializing.
> selinux_register_security:  Registering secondary module capability
> Capability LSM initialized as secondary
> Mount-cache hash table entries: 512
> monitor/mwait feature present.
> using mwait in idle threads.
> CPU: L1 I cache: 32K, L1 D cache: 32K
> CPU: L2 cache: 4096K
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 0
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> Compat vDSO mapped to ffffe000.
> Checking 'hlt' instruction... OK.
> SMP alternatives: switching to UP code
> ACPI: Core revision 20070126
> CPU0: Intel(R) Core(TM)2 CPU         L7400  @ 1.50GHz stepping 06
> SMP alternatives: switching to SMP code
> Booting processor 1/1 eip 3000
> CPU 1 irqstacks, hard=3Dc07c3000 soft=3Dc07a3000
> Initializing CPU#1
> Calibrating delay using timer specific routine.. 2999.79 BogoMIPS (lp=
j=3D1499895)
> monitor/mwait feature present.
> CPU: L1 I cache: 32K, L1 D cache: 32K
> CPU: L2 cache: 4096K
> CPU: Physical Processor ID: 0
> CPU: Processor Core ID: 1
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#1.
> CPU1: Intel(R) Core(TM)2 CPU         L7400  @ 1.50GHz stepping 06
> Total of 2 processors activated (6001.58 BogoMIPS).
> ENABLING IO-APIC IRQs
> ..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
> checking TSC synchronization [CPU#0 -> CPU#1]: passed.
> Brought up 2 CPUs
> khelper used greatest stack depth: 3264 bytes left
> khelper used greatest stack depth: 3232 bytes left
> NET: Registered protocol family 16
> No dock devices found.
> ACPI: bus type pci registered
> PCI: Using MMCONFIG
> Setting up standard PCI resources
> ACPI: Interpreter enabled
> ACPI: (supports S0 S1 S3 S5)
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Transparent bridge - 0000:00:1e.0
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 14 15) *0, disa=
bled.
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 14 15)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 14 15)
> ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 *10 11 14 15)
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 14 15)
> ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 10 *11 14 15)
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> ACPI: bus type pnp registered
> pnp: PnP ACPI: found 8 devices
> ACPI: ACPI bus type pnp unregistered
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> PCI: Using ACPI for IRQ routing
> PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, po=
st a report
> NetLabel: Initializing
> NetLabel:  domain hash size =3D 128
> NetLabel:  protocols =3D UNLABELED CIPSOv4
> NetLabel:  unlabeled traffic allowed by default
> Time: tsc clocksource has been installed.
> pnp: 00:01: iomem range 0xe0000000-0xefffffff could not be reserved
> pnp: 00:01: iomem range 0xfee00000-0xfee0ffff could not be reserved
> pnp: 00:01: iomem range 0xfec81000-0xfec81fff has been reserved
> pnp: 00:01: iomem range 0xfec81400-0xfec823ff could not be reserved
> PCI: Bridge: 0000:00:02.0
>   IO window: 2000-2fff
>   MEM window: dc000000-dc0fffff
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:03.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1c.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:04:00.0
>   IO window: disabled.
>   MEM window: d8000000-dbffffff
>   PREFETCH window: 88000000-880fffff
> PCI: Bridge: 0000:00:1c.1
>   IO window: disabled.
>   MEM window: d8000000-dbffffff
>   PREFETCH window: 88000000-880fffff
> PCI: Bridge: 0000:00:1c.2
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1c.3
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> PCI: Bridge: 0000:00:1e.0
>   IO window: disabled.
>   MEM window: disabled.
>   PREFETCH window: disabled.
> ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
> ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 16
> ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 17
> ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 21 (level, low) -> IRQ 18
> ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 19
> ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 23 (level, low) -> IRQ 20
> NET: Registered protocol family 2
> IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
> TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
> TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
> TCP: Hash tables configured (established 131072 bind 65536)
> TCP reno registered
> checking if image is initramfs... it is
> Freeing initrd memory: 2143k freed
> khelper used greatest stack depth: 3084 bytes left
> Simple Boot Flag at 0x40 set to 0x1
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
> apm: disabled - APM is not SMP safe.
> audit: initializing netlink socket (disabled)
> audit(1192944079.101:1): initialized
> highmem bounce pool size: 64 pages
> Total HugeTLB memory allocated, 0
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> assign_interrupt_mode Found MSI capability
> assign_interrupt_mode Found MSI capability
> assign_interrupt_mode Found MSI capability
> assign_interrupt_mode Found MSI capability
> assign_interrupt_mode Found MSI capability
> assign_interrupt_mode Found MSI capability
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> ACPI: Processor [CPU0] (supports 8 throttling states)
> ACPI: Processor [CPU1] (supports 8 throttling states)
> ACPI Exception (processor_core-0818): AE_NOT_FOUND, Processor Device
> is not present [20070126]
> ACPI Exception (processor_core-0818): AE_NOT_FOUND, Processor Device
> is not present [20070126]
> ACPI Exception (processor_core-0818): AE_NOT_FOUND, Processor Device
> is not present [20070126]
> ACPI Exception (processor_core-0818): AE_NOT_FOUND, Processor Device
> is not present [20070126]
> ACPI Exception (processor_core-0818): AE_NOT_FOUND, Processor Device
> is not present [20070126]
> ACPI Exception (processor_core-0818): AE_NOT_FOUND, Processor Device
> is not present [20070126]
> Real Time Clock Driver v1.12ac
> Non-volatile memory driver v1.2
> Linux agpgart interface v0.102
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enab=
led
> serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
> =FFserial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
> RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksiz=
e
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with ide=
bus=3Dxx
> ide-floppy driver 0.99.newide
> st: Version 20070203, fixed bufsize 32768, s/g segs 256
> osst :I: Tape driver with OnStream support version 0.99.4
> osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
> SCSI Media Changer driver v0.25
> ahci_init_one: ENTER
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 21
> ata_host_alloc: ENTER
> ata_port_alloc: ENTER
> ata_port_alloc: ENTER
> ata_port_alloc: ENTER
> ata_port_alloc: ENTER
> ata_port_alloc: ENTER
> ata_port_alloc: ENTER
> ahci_init_controller: HOST_CTL 0x80000000
> ahci_init_controller: HOST_CTL 0x80000002
> ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports 1.5 Gbps 0x3f impl=
 SATA mode
> ahci 0000:00:1f.2: flags: 64bit ncq pm led pmp slum part
> __ata_port_freeze: ata4294967295 port frozen
> __ata_port_freeze: ata4294967295 port frozen
> __ata_port_freeze: ata4294967295 port frozen
> __ata_port_freeze: ata4294967295 port frozen
> __ata_port_freeze: ata4294967295 port frozen
> __ata_port_freeze: ata4294967295 port frozen
> scsi0 : ahci
> scsi1 : ahci
> scsi2 : ahci
> scsi3 : ahci
> scsi4 : ahci
> scsi5 : ahci
> ata1: SATA max UDMA/133 cmd 0xf8826500 ctl 0x00000000 bmdma 0x0000000=
0 irq 21
> ata2: SATA max UDMA/133 cmd 0xf8826580 ctl 0x00000000 bmdma 0x0000000=
0 irq 21
> ata3: SATA max UDMA/133 cmd 0xf8826600 ctl 0x00000000 bmdma 0x0000000=
0 irq 21
> ata4: SATA max UDMA/133 cmd 0xf8826680 ctl 0x00000000 bmdma 0x0000000=
0 irq 21
> ata5: SATA max UDMA/133 cmd 0xf8826700 ctl 0x00000000 bmdma 0x0000000=
0 irq 21
> ata6: SATA max UDMA/133 cmd 0xf8826780 ctl 0x00000000 bmdma 0x0000000=
0 irq 21
> ata_host_register: probe begin
> ata_port_schedule_eh: port EH scheduled
> ata_scsi_error: ENTER
> ata_port_flush_task: ENTER
> ata_eh_autopsy: ENTER
> ata_eh_recover: ENTER
> __ata_port_freeze: ata1 port frozen
> ahci_do_softreset: ENTER
> ahci_do_softreset: PHY reports no device
> ata_std_postreset: ENTER
> ata1: SATA link down (SStatus 0 SControl 300)
> ata_std_postreset: EXIT, no device
> ata_eh_thaw_port: ata1 port thawed
> ata_eh_revalidate_and_attach: ENTER
> ata_eh_recover: EXIT, rc=3D0
> ata_scsi_error: EXIT
> ata_port_schedule_eh: port EH scheduled
> ata_scsi_error: ENTER
> ata_port_flush_task: ENTER
> ata_eh_autopsy: ENTER
> ata_eh_recover: ENTER
> __ata_port_freeze: ata2 port frozen
> ahci_do_softreset: ENTER
> ata_dev_classify: found ATA device by sig
> ahci_do_softreset: EXIT, class=3D1
> ata_std_postreset: ENTER
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata_std_postreset: EXIT
> ata_eh_thaw_port: ata2 port thawed
> ata_eh_revalidate_and_attach: ENTER
> ata2: ata_dev_select: ENTER, device 0, wait 1
> ata_sg_setup: ENTER, ata2
> ata_sg_setup: 1 sg elements mapped
> ahci_fill_sg: ENTER
> ahci_interrupt: ENTER
> ata_sg_clean: unmapping 1 sg elements
> ahci_interrupt: port 1
> ahci_interrupt: EXIT
> ata_port_flush_task: ENTER
> ata_dump_id: 49=3D=3D0x2f00  53=3D=3D0x0007  63=3D=3D0x0407  64=3D=3D=
0x0003  75=3D=3D0x0000
> ata_dump_id: 80=3D=3D0x00fe  81=3D=3D0x0000  82=3D=3D0x706b  83=3D=3D=
0x7e01  84=3D=3D0x4023
> ata_dump_id: 88=3D=3D0x007f  93=3D=3D0x0000
> ata2.00: ATA-7: WDC WD800JD-00LSA0, 06.01D06, max UDMA/133
> ata2.00: 156301488 sectors, multi 0: LBA48
> ata_dev_set_xfermode: set features - xfer mode
> ahci_interrupt: ENTER
> ahci_interrupt: port 1
> ahci_interrupt: EXIT
> ata_port_flush_task: ENTER
> ata_dev_set_xfermode: EXIT, err_mask=3D0
> ata2: ata_dev_select: ENTER, device 0, wait 1
> ata_sg_setup: ENTER, ata2
> ata_sg_setup: 1 sg elements mapped
> ahci_fill_sg: ENTER
> ahci_interrupt: ENTER
> ata_sg_clean: unmapping 1 sg elements
> ahci_interrupt: port 1
> ahci_interrupt: EXIT
> ata_port_flush_task: ENTER
> ata_dump_id: 49=3D=3D0x2f00  53=3D=3D0x0007  63=3D=3D0x0007  64=3D=3D=
0x0003  75=3D=3D0x0000
> ata_dump_id: 80=3D=3D0x00fe  81=3D=3D0x0000  82=3D=3D0x706b  83=3D=3D=
0x7e01  84=3D=3D0x4023
> ata_dump_id: 88=3D=3D0x407f  93=3D=3D0x0000
> ata_dev_set_mode: xfer_shift=3D12, xfer_mode=3D0x46
> ata2.00: configured for UDMA/133
> ata_eh_recover: EXIT, rc=3D0
> ata_scsi_error: EXIT
> ata_port_schedule_eh: port EH scheduled
> ata_scsi_error: ENTER
> ata_port_flush_task: ENTER
> ata_eh_autopsy: ENTER
> ata_eh_recover: ENTER
> __ata_port_freeze: ata3 port frozen
> ahci_do_softreset: ENTER
> ahci_do_softreset: PHY reports no device
> ata_std_postreset: ENTER
> ata3: SATA link down (SStatus 0 SControl 300)
> ata_std_postreset: EXIT, no device
> ata_eh_thaw_port: ata3 port thawed
> ata_eh_revalidate_and_attach: ENTER
> ata_eh_recover: EXIT, rc=3D0
> ata_scsi_error: EXIT
> ata_port_schedule_eh: port EH scheduled
> ata_scsi_error: ENTER
> ata_port_flush_task: ENTER
> ata_eh_autopsy: ENTER
> ata_eh_recover: ENTER
> __ata_port_freeze: ata4 port frozen
> ahci_do_softreset: ENTER
> ahci_do_softreset: PHY reports no device
> ata_std_postreset: ENTER
> ata4: SATA link down (SStatus 0 SControl 300)
> ata_std_postreset: EXIT, no device
> ata_eh_thaw_port: ata4 port thawed
> ata_eh_revalidate_and_attach: ENTER
> ata_eh_recover: EXIT, rc=3D0
> ata_scsi_error: EXIT
> ata_port_schedule_eh: port EH scheduled
> ata_scsi_error: ENTER
> ata_port_flush_task: ENTER
> ata_eh_autopsy: ENTER
> ata_eh_recover: ENTER
> __ata_port_freeze: ata5 port frozen
> ahci_do_softreset: ENTER
> ata_dev_classify: found ATA device by sig
> ahci_do_softreset: EXIT, class=3D1
> ata_std_postreset: ENTER
> ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata_std_postreset: EXIT
> ata_eh_thaw_port: ata5 port thawed
> ata_eh_revalidate_and_attach: ENTER
> ata5: ata_dev_select: ENTER, device 0, wait 1
> ata_sg_setup: ENTER, ata5
> ata_sg_setup: 1 sg elements mapped
> ahci_fill_sg: ENTER
> ahci_interrupt: ENTER
> ata_sg_clean: unmapping 1 sg elements
> ahci_interrupt: port 4
> ahci_interrupt: EXIT
> ata_port_flush_task: ENTER
> ata_dump_id: 49=3D=3D0x0b00  53=3D=3D0x0003  63=3D=3D0x0407  64=3D=3D=
0x0003  75=3D=3D0x0000
> ata_dump_id: 80=3D=3D0x007e  81=3D=3D0x0019  82=3D=3D0x706a  83=3D=3D=
0x410c  84=3D=3D0x4000
> ata_dump_id: 88=3D=3D0x0000  93=3D=3D0x0000
> ata5.00: ATA-6:   512MB NANDrive, NDBA418J, max MWDMA2
> ata5.00: 1000944 sectors, multi 0: LBA
> ata_dev_set_xfermode: set features - xfer mode
> ahci_interrupt: ENTER
> ahci_interrupt: port 4
> ahci_interrupt: EXIT
> ata_port_flush_task: ENTER
> ata_dev_set_xfermode: EXIT, err_mask=3D0
> ata5: ata_dev_select: ENTER, device 0, wait 1
> ata_sg_setup: ENTER, ata5
> ata_sg_setup: 1 sg elements mapped
> ahci_fill_sg: ENTER
> ahci_interrupt: ENTER
> ata_sg_clean: unmapping 1 sg elements
> ahci_interrupt: port 4
> ahci_interrupt: EXIT
> ata_port_flush_task: ENTER
> ata_dump_id: 49=3D=3D0x0b00  53=3D=3D0x0003  63=3D=3D0x0407  64=3D=3D=
0x0003  75=3D=3D0x0000
> ata_dump_id: 80=3D=3D0x007e  81=3D=3D0x0019  82=3D=3D0x706a  83=3D=3D=
0x410c  84=3D=3D0x4000
> ata_dump_id: 88=3D=3D0x0000  93=3D=3D0x0000
> ata_dev_set_mode: xfer_shift=3D0, xfer_mode=3D0xc
> ata5.00: configured for PIO4
> ata_eh_recover: EXIT, rc=3D0
> ata_scsi_error: EXIT
> ata_port_schedule_eh: port EH scheduled
> ata_scsi_error: ENTER
> ata_port_flush_task: ENTER
> ata_eh_autopsy: ENTER
> ata_eh_recover: ENTER
> __ata_port_freeze: ata6 port frozen
> ahci_do_softreset: ENTER
> ahci_do_softreset: PHY reports no device
> ata_std_postreset: ENTER
> ata6: SATA link down (SStatus 0 SControl 300)
> ata_std_postreset: EXIT, no device
> ata_eh_thaw_port: ata6 port thawed
> ata_eh_revalidate_and_attach: ENTER
> ata_eh_recover: EXIT, rc=3D0
> ata_scsi_error: EXIT
> ata_host_register: host probe begin
> ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 24 00 00 00 00
> ata_scsiop_inq_std: ENTER
> ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 60 00 00 00 00
> ata_scsiop_inq_std: ENTER
> scsi 1:0:0:0: Direct-Access     ATA      WDC WD800JD-00LS 06.0 PQ: 0 =
ANSI: 5
> ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
> ata_scsiop_noop: ENTER
> ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
> ata_scsiop_read_cap: ENTER
> sd 1:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
> ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 3f 00 00 00 00 00 08
> ata_scsiop_mode_sense: ENTER
> sd 1:0:0:0: [sda] Write Protect is off
> ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08
> ata_scsiop_mode_sense: ENTER
> ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 24
> ata_scsiop_mode_sense: ENTER
> sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 24
> ata_scsiop_noop: ENTER
> ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
> ata_scsiop_read_cap: ENTER
> sd 1:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
> ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 3f 00 00 00 00 00 08
> ata_scsiop_mode_sense: ENTER
> sd 1:0:0:0: [sda] Write Protect is off
> ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08
> ata_scsiop_mode_sense: ENTER
> ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 24
> ata_scsiop_mode_sense: ENTER
> sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
>  sda:<3>ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 00 00 00 00 08
> ata_scsi_translate: ENTER
> scsi_10_lba_len: ten-byte command
> ata_sg_setup: ENTER, ata2
> ata_sg_setup: 1 sg elements mapped
> ahci_fill_sg: ENTER
> ata_scsi_translate: EXIT
> ahci_interrupt: ENTER
> ata_sg_clean: unmapping 1 sg elements
> ahci_interrupt: port 1
> ahci_interrupt: EXIT
>  sda1 sda2
> sd 1:0:0:0: [sda] Attached SCSI disk
> sd 1:0:0:0: Attached scsi generic sg0 type 0
> ata_scsi_dump_cdb: CDB (5:0,0,0) 12 00 00 00 24 00 00 00 00
> ata_scsiop_inq_std: ENTER
> ata_scsi_dump_cdb: CDB (5:0,0,0) 12 00 00 00 60 00 00 00 00
> ata_scsiop_inq_std: ENTER
> scsi 4:0:0:0: Direct-Access     ATA        512MB NANDrive NDBA PQ: 0 =
ANSI: 5
> ata_scsi_dump_cdb: CDB (5:0,0,0) 00 00 00 00 00 00 00 00 24
> ata_scsiop_noop: ENTER
> ata_scsi_dump_cdb: CDB (5:0,0,0) 25 00 00 00 00 00 00 00 00
> ata_scsiop_read_cap: ENTER
> sd 4:0:0:0: [sdb] 1000944 512-byte hardware sectors (512 MB)
> ata_scsi_dump_cdb: CDB (5:0,0,0) 5a 00 3f 00 00 00 00 00 08
> ata_scsiop_mode_sense: ENTER
> sd 4:0:0:0: [sdb] Write Protect is off
> ata_scsi_dump_cdb: CDB (5:0,0,0) 5a 00 08 00 00 00 00 00 08
> ata_scsiop_mode_sense: ENTER
> ata_scsi_dump_cdb: CDB (5:0,0,0) 5a 00 08 00 00 00 00 00 24
> ata_scsiop_mode_sense: ENTER
> sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> ata_scsi_dump_cdb: CDB (5:0,0,0) 00 00 00 00 00 00 00 00 24
> ata_scsiop_noop: ENTER
> ata_scsi_dump_cdb: CDB (5:0,0,0) 25 00 00 00 00 00 00 00 00
> ata_scsiop_read_cap: ENTER
> sd 4:0:0:0: [sdb] 1000944 512-byte hardware sectors (512 MB)
> ata_scsi_dump_cdb: CDB (5:0,0,0) 5a 00 3f 00 00 00 00 00 08
> ata_scsiop_mode_sense: ENTER
> sd 4:0:0:0: [sdb] Write Protect is off
> ata_scsi_dump_cdb: CDB (5:0,0,0) 5a 00 08 00 00 00 00 00 08
> ata_scsiop_mode_sense: ENTER
> ata_scsi_dump_cdb: CDB (5:0,0,0) 5a 00 08 00 00 00 00 00 24
> ata_scsiop_mode_sense: ENTER
> sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
>  sdb:<3>ata_scsi_dump_cdb: CDB (5:0,0,0) 28 00 00 00 00 00 00 00 08
> ata_scsi_translate: ENTER
> scsi_10_lba_len: ten-byte command
> ata_sg_setup: ENTER, ata5
> ata_sg_setup: 1 sg elements mapped
> ahci_fill_sg: ENTER
> ata_scsi_translate: EXIT
> ata_scsi_timed_out: ENTER
> ata_scsi_timed_out: EXIT, ret=3D0
> ata_scsi_error: ENTER
> ata_port_flush_task: ENTER
> __ata_port_freeze: ata5 port frozen
> ata_eh_autopsy: ENTER
> ata_eh_autopsy: PxSERR:0
> ata_eh_analyze_tf: TfData:40
> ata_eh_autopsy: EXIT
> ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata5.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4=
096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata_eh_recover: ENTER
> __ata_port_freeze: ata5 port frozen
> ata5: soft resetting port
> ahci_do_softreset: ENTER
> ata5: failed to reset engine (errno=3D-95)<3>ata_dev_classify: found =
ATA
> device by sig
> ahci_do_softreset: EXIT, class=3D1
> ata_std_postreset: ENTER
> ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata_std_postreset: EXIT
> ata_eh_thaw_port: ata5 port thawed
> ata_eh_revalidate_and_attach: ENTER
> ata5: ata_dev_select: ENTER, device 0, wait 1
> ata_wait_idle: ATA: abnormal status 0x58 on port 0x00000000
> ata_wait_idle: ATA: abnormal status 0x58 on port 0x00000000
> ata_sg_setup: ENTER, ata5
> ata_sg_setup: 1 sg elements mapped
> ahci_fill_sg: ENTER
> ata_port_flush_task: ENTER
> ata_sg_clean: unmapping 1 sg elements
> __ata_port_freeze: ata5 port frozen
> ata5.00: qc timeout (cmd 0xec)
> ata5.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
> ata5.00: revalidation failed (errno=3D-5)
> ata_eh_revalidate_and_attach: EXIT rc=3D-5
> ata5: failed to recover some devices, retrying in 5 secs
> __ata_port_freeze: ata5 port frozen
> ata5: hard resetting port
> ahci_hardreset: ENTER
> sata_std_hardreset: ENTER
> sata_port_hardreset: ENTER
> sata_port_hardreset: EXIT, rc=3D0
> ata5: port is slow to respond, please be patient (Status 0x80)
> ata5: COMRESET failed (errno=3D-16)
> ahci_hardreset: EXIT, rc=3D-16, class=3D5
> ata5: hard resetting port
> ahci_hardreset: ENTER
> sata_std_hardreset: ENTER
> sata_port_hardreset: ENTER
> sata_port_hardreset: EXIT, rc=3D0
> ata_dev_classify: found ATA device by sig
> sata_std_hardreset: EXIT, class=3D1
> ata_dev_classify: found ATA device by sig
> ahci_hardreset: EXIT, rc=3D0, class=3D1
> ata_std_postreset: ENTER
> ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata_std_postreset: EXIT
> ata_eh_thaw_port: ata5 port thawed
> ata_eh_revalidate_and_attach: ENTER
> ata5: ata_dev_select: ENTER, device 0, wait 1
> ata_sg_setup: ENTER, ata5
> ata_sg_setup: 1 sg elements mapped
> ahci_fill_sg: ENTER
> ahci_interrupt: ENTER
> ata_sg_clean: unmapping 1 sg elements
> ahci_interrupt: port 4
> ahci_interrupt: EXIT
> ata_port_flush_task: ENTER
> ata_dump_id: 49=3D=3D0x0b00  53=3D=3D0x0003  63=3D=3D0x0407  64=3D=3D=
0x0003  75=3D=3D0x0000
> ata_dump_id: 80=3D=3D0x007e  81=3D=3D0x0019  82=3D=3D0x706a  83=3D=3D=
0x410c  84=3D=3D0x4000
> ata_dump_id: 88=3D=3D0x0000  93=3D=3D0x0000
> ata_dev_set_xfermode: set features - xfer mode
> ahci_interrupt: ENTER
> ahci_interrupt: port 4
> ahci_interrupt: EXIT
> ata_port_flush_task: ENTER
> ata_dev_set_xfermode: EXIT, err_mask=3D0
> ata5: ata_dev_select: ENTER, device 0, wait 1
> ata_sg_setup: ENTER, ata5
> ata_sg_setup: 1 sg elements mapped
> ahci_fill_sg: ENTER
> ahci_interrupt: ENTER
> ata_sg_clean: unmapping 1 sg elements
> ahci_interrupt: port 4
> ahci_interrupt: EXIT
> ata_port_flush_task: ENTER
> ata_dump_id: 49=3D=3D0x0b00  53=3D=3D0x0003  63=3D=3D0x0407  64=3D=3D=
0x0003  75=3D=3D0x0000
> ata_dump_id: 80=3D=3D0x007e  81=3D=3D0x0019  82=3D=3D0x706a  83=3D=3D=
0x410c  84=3D=3D0x4000
> ata_dump_id: 88=3D=3D0x0000  93=3D=3D0x0000
> ata_dev_set_mode: xfer_shift=3D0, xfer_mode=3D0xc
> ata5.00: configured for PIO4
> ata_eh_recover: EXIT, rc=3D0
> ata_sg_clean: unmapping 1 sg elements
> ata5: EH pending after completion, repeating EH (cnt=3D4)
> ata_eh_autopsy: ENTER
> ata_eh_autopsy: PxSERR:0
> ata_eh_autopsy: EXIT
> ata_eh_recover: ENTER
> ata_eh_revalidate_and_attach: ENTER
> ata_eh_recover: EXIT, rc=3D0
> ata5: EH complete
> ata_scsi_error: EXIT
> ata_scsi_dump_cdb: CDB (5:0,0,0) 28 00 00 00 00 00 00 00 08
> ata_scsi_translate: ENTER
> scsi_10_lba_len: ten-byte command
> ata_sg_setup: ENTER, ata5
> ata_sg_setup: 1 sg elements mapped
> ahci_fill_sg: ENTER
> ata_scsi_translate: EXIT
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

