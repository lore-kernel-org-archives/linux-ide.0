From: Ajit Prem <Ajit.Prem@motorola.com>
Subject: 31244 & sata_vsc & PPC
Date: Wed, 16 Feb 2005 12:05:16 -0700
Message-ID: <4213996C.4060301@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from motgate4.mot.com ([144.189.100.102]:29390 "EHLO
	motgate4.mot.com") by vger.kernel.org with ESMTP id S261488AbVBPTFW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Feb 2005 14:05:22 -0500
Received: from az33exr04.mot.com (az33exr04.mot.com [10.64.251.234])
	by motgate4.mot.com (8.12.11/Motgate4) with ESMTP id j1GJ9KfC021452
	for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2005 12:09:20 -0700 (MST)
Received: from [127.0.0.1] (mvp-192-172-32-50.corp.mot.com [192.172.32.50])
	by az33exr04.mot.com (8.13.1/8.13.0) with ESMTP id j1GJ5iRS011371
	for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2005 13:05:45 -0600 (CST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The email archives indicate that sata_vsc worked
on a 31244 in a Dell Powervault once the
kernel included the following configuration:

Processor type and features -> Local APIC support on uniprocessors
Processor type and features -> IO-APIC support on uniprocessors
General setup -> Power Management support -> ACPI Support

Trying to use sata_vsc on a 31244 in a PPC board
results in the same problem as other users had on
an X86 board configured without ACPI support - interrupts
come in too early to vsc_sata_interrupt, the interrupt
doesn't get cleared, and the kernel finally disables the irq.
What should one do to get sata_vsc/libata to work on a PPC board?


Using kernel 2.6.10 with only 1 disk connected to port 2.

bash-2.05b# modprobe sata_vsc
ata_device_add: ENTER
ata_host_add: ENTER
ata_port_start: prd alloc, virt ded0c000, dma 1ed0c000
ata_host_add: ENTER
ata_port_start: prd alloc, virt decd3000, dma 1ecd3000
ata_host_add: ENTER
ata_port_start: prd alloc, virt decc7000, dma 1ecc7000
ata_host_add: ENTER
ata_port_start: prd alloc, virt ded00000, dma 1ed00000
ata_device_add: probe begin
ata_device_add: ata1: probe begin
ata_device_add: ata1: probe end
ata_device_add: ata2: probe begin
ata_bus_reset: ENTER, host 2, port 1
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 2, dev 0
ata_dev_select: ENTER, ata2: device 0, wait 1
ata_dev_identify: do ATA identify
ata_dev_select: ENTER, ata2: device 0, wait 1
ata_exec_command_mmio: ata2: cmd 0xEC
irq 98: nobody cared!
Call trace:
 [c003bd8c] __report_bad_irq+0x38/0xb8
 [c003bef8] note_interrupt+0xd0/0x108
 [c003b868] __do_IRQ+0x174/0x184
 [c0003a70] do_IRQ+0x38/0xa0
 [c0002838] ret_from_except+0x0/0x18
 [c0003b28] default_idle+0x50/0x5c
 [c0001c44] rest_init+0x24/0x34
 [c0342630] start_kernel+0x174/0x1b4
 [c000037c] skpinv+0x2ac/0x2e8
handlers:
[<e1078348>] (vsc_sata_interrupt+0x0/0xcc [sata_vsc])
Disabling IRQ #98
ata_pio_sector: data read
ata_qc_complete: EXIT
ata_dump_id: 49==0x2b00  53==0x0007  63==0x0407  64==0x0003  75==0x0000 
ata_dump_id: 80==0x007c  81==0x0019  82==0x346b  83==0x5b68  84==0x4003 
ata_dump_id: 88==0x003f  93==0x600b
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 2, dev 1) -- nodev
ata_host_set_pio: base 0x8 xfer_mode 0xc mask 0x1f x 4
ata_dev_set_xfermode: set features - xfer mode
ata_dev_select: ENTER, ata2: device 0, wait 1
ata_exec_command_mmio: ata2: cmd 0xEF

Message from syslogd@vmeexec at Wed Feb 16 11:47:39 2005 ...
vmeexec kernel: Disabling IRQ #98


The modprobe command hangs. The machine is usable
otherwise.

bash-2.05b# cat /proc/interrupts
           CPU0      
 77:       4891   OpenPIC   Level     enet_tx
 78:       5666   OpenPIC   Level     enet_rx
 82:          0   OpenPIC   Level     enet_error
 90:        257   OpenPIC   Level     serial
 96:          3   OpenPIC   Level     VMEBus (Tsi148)
 98:     100000   OpenPIC   Level     libata
100:          0   OpenPIC   Level     ohci_hcd
101:          0   OpenPIC   Level     ohci_hcd
102:          0   OpenPIC   Level     ehci_hcd
106:          2   OpenPIC   Level     phy_interrupt
BAD:          0


# lscpi -vvvxxx

00:04.0 Class 0106: 8086:3200
        Subsystem: 8086:3200
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 128 (4000ns min, 250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 98
        Region 0: Memory at dfaff000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [e0] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=3
                Status: Bus=255 Dev=4 Func=0 64bit+ 133MHz+ SCD- USC-, 
DC=simple
, DMMRBC=0, DMOST=3, DMCRS=1, RSCEM-    Capabilities: [e8] Power 
Management vers
ion 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ 
Queue=0/2 Enable
-
                Address: 0000000000000000  Data: 0000
00: 86 80 00 32 07 00 30 02 00 00 06 01 08 80 00 00
10: 04 f0 af df 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 32
30: 00 00 00 00 e0 00 00 00 00 00 00 00 62 01 10 01
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 03 80 00 08 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 82
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 07 e8 32 00 20 ff 83 05 01 f0 22 00 00 00 00 00
f0: 05 00 84 00 00 00 00 00 00 00 00 00 00 00 00 00

Thanks,

AP

