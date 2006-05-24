From: Erik Mouw <erik@harddisk-recovery.com>
Subject: 2.6.17-rc4 + libata-pata Oops while reloading pata_amd module
Date: Wed, 24 May 2006 18:50:07 +0200
Message-ID: <20060524165006.GC12022@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dtp.xs4all.nl ([80.126.206.180]:16512 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932409AbWEXQuL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 May 2006 12:50:11 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: linux-ide@vger.kernel.org, rene.herman@keyaccess.nl

Hi Alan,

I got this Oops while reloading the pata_amd module:

pata_amd 0000:00:07.1: version 0.1.7
ata3: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xD800 irq 14
setup_irq: irq handler mismatch
 <c013cb24> setup_irq+0x114/0x130   <e088a930> ata_interrupt+0x0/0x130 [libata]
 <c013cd14> request_irq+0x84/0xb0   <e088b192> ata_device_add+0x182/0x250 [libata]
 <e088a930> ata_interrupt+0x0/0x130 [libata]   <e088ecf1> ata_pci_init_one+0x181/0x3f0 [libata]
 <c02b53b5> _spin_unlock_irqrestore+0x5/0x10   <c01d873a> pci_bus_write_config_byte+0x5a/0x70
 <e0839a8d> amd_init_one+0xdd/0x160 [pata_amd]   <c01dd2e9> pci_call_probe+0x19/0x20
 <c01dd34e> __pci_device_probe+0x5e/0x70   <c01dd38f> pci_device_probe+0x2f/0x50
 <c0220ab7> driver_probe_device+0xb7/0xe0   <c02b340a> klist_dec_and_del+0x1a/0x20
 <c0220b70> __driver_attach+0x0/0x90   <c0220be1> __driver_attach+0x71/0x90
 <c021fe89> bus_for_each_dev+0x69/0x80   <c0220c26> driver_attach+0x26/0x30
 <c0220b70> __driver_attach+0x0/0x90   <c02203e3> bus_add_driver+0x83/0xc0
 <c01dd62d> __pci_register_driver+0x4d/0x70   <e0870017> amd_init+0x17/0x1b [pata_amd]
 <c013a1e0> sys_init_module+0x120/0x1b0   <c0102f27> syscall_call+0x7/0xb
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0221cd1
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: pata_amd nbd ohci_hcd usbcore hw_random i2c_amd756 i2c_core libata scsi_mod amd_k7_agp agpgart 8250 serial_core md_mod
CPU:    0
EIP:    0060:[<c0221cd1>]    Not tainted VLI
EFLAGS: 00010206   (2.6.17-rc4-dirty #2)
EIP is at make_class_name+0x31/0xb0
eax: 00000000   ebx: ffffffff   ecx: ffffffff   edx: 00000009
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c157fd68
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1867, threadinfo=c157f000 task=dfd6dab0)
Stack: <0>0000000e 00287e09 df0ba0e0 df0ba228 df0ba220 df0ba0e0 e08bbb20 c02221cf
       df0ba220 dfd6dbbc 00000000 00000000 df0ba220 df0ba000 df0ba030 dffb9000
       c0222233 df0ba220 df0ba0e0 e089d467 df0ba220 00000004 df0ba2c0 df0ed760
Call Trace:
 <c02221cf> class_device_del+0xff/0x150   <c0222233> class_device_unregister+0x13/0x30
 <e089d467> scsi_remove_host+0xb7/0x110 [scsi_mod]   <e088adee> ata_host_remove+0x2e/0x30 [libata]
 <e088b234> ata_device_add+0x224/0x250 [libata]   <e088ecf1> ata_pci_init_one+0x181/0x3f0 [libata]
 <c02b53b5> _spin_unlock_irqrestore+0x5/0x10   <c01d873a> pci_bus_write_config_byte+0x5a/0x70
 <e0839a8d> amd_init_one+0xdd/0x160 [pata_amd]   <c01dd2e9> pci_call_probe+0x19/0x20
 <c01dd34e> __pci_device_probe+0x5e/0x70   <c01dd38f> pci_device_probe+0x2f/0x50
 <c0220ab7> driver_probe_device+0xb7/0xe0   <c02b340a> klist_dec_and_del+0x1a/0x20
 <c0220b70> __driver_attach+0x0/0x90   <c0220be1> __driver_attach+0x71/0x90
 <c021fe89> bus_for_each_dev+0x69/0x80   <c0220c26> driver_attach+0x26/0x30
 <c0220b70> __driver_attach+0x0/0x90   <c02203e3> bus_add_driver+0x83/0xc0
 <c01dd62d> __pci_register_driver+0x4d/0x70   <e0870017> amd_init+0x17/0x1b [pata_amd]
 <c013a1e0> sys_init_module+0x120/0x1b0   <c0102f27> syscall_call+0x7/0xb
Code: bb ff ff ff ff 83 ec 0c 89 d9 8b 54 24 20 8b 42 48 8b 10 89 e8 89 d7 f2 ae f7 d1 49 8b 44 24 20 89 ca 89 d9 8b 70 08 89 e8 89 f7 <f2> ae f7 d1 49 c7 44 24 04 d0 00 00 00 8d 44 11 02 89 04 24 e8
EIP: [<c0221cd1>] make_class_name+0x31/0xb0 SS:ESP 0068:c157fd68

This is with 2.6.17-rc4 with patch-2.6.17-rc4-ide1.gz applied on top of
it. I could also recreate it with today's -git kernel with your patch
applied on top of it (applies cleanly with some minor fuzz).

Here's the lspci output:

00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 11)
        Flags: bus master, 66Mhz, medium devsel, latency 32
        Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Memory at fb800000 (32-bit, prefetchable) [size=4K]
        I/O ports at e800 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
00: 22 10 0c 70 06 00 30 22 11 00 00 06 00 20 00 00
10: 08 00 00 fc 08 00 80 fb 01 e8 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 18 1b 00 00 00 00 00 00 27 00 00 00
50: 30 77 77 00 4a 8c 01 96 00 00 22 02 00 00 00 00
60: bd 0c a1 85 1b 2e e2 5e bd 8c b1 00 1b 25 d2 5f
70: 00 06 04 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 05 00 91 10 83 00 71 0f f0 02 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 20
a0: 02 00 20 00 03 02 00 0f 00 00 00 00 01 00 01 00
b0: 00 00 00 00 48 00 01 2a 0f ff 0f c5 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 85 0f 00 00 85 0f 00 10
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: f4000000-fb4fffff
        Prefetchable memory behind bridge: fb700000-fb7fffff
00: 22 10 0d 70 07 00 20 02 00 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f1 01 20 22
20: 00 f4 40 fb 70 fb 70 fb 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7440 (rev 05)
        Subsystem: Asustek Computer, Inc.: Unknown device 8044
        Flags: bus master, 66Mhz, medium devsel, latency 0
00: 22 10 40 74 0f 00 20 02 05 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 44 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 20 07 00 01 00 00 00 0b ff 00 81 00 04 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 43 10 44 80 00 de 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7441 (rev 04) (prog-if 8a [Master SecP PriP])
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 7441
        Flags: bus master, medium devsel, latency 32
        I/O ports at d800 [size=16]
00: 22 10 41 74 05 00 00 02 04 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d8 00 00 00 00 00 00 00 00 00 00 22 10 41 74
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 43 f4 00 00 00 00 00 00 a8 a8 a8 a8 ff 00 ff ff
50: 03 03 03 03 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 22 10 41 74 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7443 (rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 8044
        Flags: medium devsel
00: 22 10 43 74 00 00 80 02 03 00 80 06 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 44 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 80 b1 09 07 00 00 00 00 a8 00 50 00 00 00 00 00
50: 01 80 00 00 0f 00 0b a0 01 e4 00 00 00 00 00 00
60: 00 00 80 06 1f 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 44 80
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 73 84 62 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 Ethernet controller: Intel Corp.: Unknown device 100f (rev 01)
        Subsystem: Intel Corp.: Unknown device 1001
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
        Memory at f3800000 (64-bit, non-prefetchable) [size=128K]
        Memory at f3000000 (64-bit, non-prefetchable) [size=256K]
        I/O ports at d400 [size=64]
        Expansion ROM at 30000000 [disabled] [size=256K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] #07 [0002]
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
00: 86 80 0f 10 17 00 30 02 01 00 00 02 08 20 00 00
10: 04 00 80 f3 00 00 00 00 04 00 00 f3 00 00 00 00
20: 01 d4 00 00 00 00 00 00 00 00 00 00 86 80 01 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 ff 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 e4 22 00
e0: 00 00 00 00 07 f0 02 00 00 00 43 04 00 00 00 00
f0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00

00:10.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7448 (rev 05) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        Memory behind bridge: f2800000-f2ffffff
        Prefetchable memory behind bridge: fb500000-fb5fffff
00: 22 10 48 74 17 00 20 22 05 00 04 06 00 20 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 20 f0 00 00 22
20: 80 f2 f0 f2 50 fb 50 fb 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 04 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:05.0 VGA compatible controller: S3 Inc. ViRGE/GX2 (rev 04) (prog-if 00 [VGA])
        Subsystem: Diamond Multimedia Systems Stealth 3D 4000
        Flags: bus master, medium devsel, latency 64, IRQ 16
        Memory at f4000000 (32-bit, non-prefetchable) [size=64M]
        Expansion ROM at fb7f0000 [disabled] [size=64K]
00: 33 53 10 8a 07 00 00 02 04 00 00 03 00 40 00 00
10: 00 00 00 f4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 92 10 10 8a
30: 00 00 7f fb 00 00 00 00 00 00 00 00 0b 01 04 ff
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:00.0 USB Controller: Advanced Micro Devices [AMD]: Unknown device 7449 (rev 07) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8044
        Flags: bus master, medium devsel, latency 32, IRQ 19
        Memory at f2800000 (32-bit, non-prefetchable) [size=4K]
00: 22 10 49 74 17 00 80 02 07 10 03 0c 08 20 00 00
10: 00 00 80 f2 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 44 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 04 00 50
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 43 10 44 80 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Output from lsmod:

Module                  Size  Used by
pata_amd               10151  1
nbd                    19936  0
ohci_hcd               20484  0
usbcore               130432  2 ohci_hcd
hw_random               5592  0
i2c_amd756              6020  0
i2c_core               18688  1 i2c_amd756
libata                 69324  1 pata_amd
scsi_mod              137864  1 libata
amd_k7_agp              7372  1
agpgart                32136  1 amd_k7_agp
8250                   23588  2
serial_core            19712  1 8250
md_mod                 74772  0

The machine is an Asus A7M266-D dual Athlon board with only a single
CPU installed running Debian stable on NFS root.

How to recreate:

- Fully modular scsi and libata, root on NFS
- rmmod pata_amd
- modprobe pata_amd

Works with any drive I've tried.


Erik

PS: note that I'm not at the office till monday, so can't really test
new patches right now.

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
