From: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Subject: SATA drive keeps hard resetting
Date: Tue, 11 Dec 2007 00:50:20 -0300
Message-ID: <475E08FC.9010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:7702 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbXLKDuQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 22:50:16 -0500
Received: by an-out-0708.google.com with SMTP id d31so446941and
        for <linux-ide@vger.kernel.org>; Mon, 10 Dec 2007 19:50:15 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

I have a SATA drive in a motherboard with an ATI SB600 chipset that=20
until now worked just fine.
The disk seems fine but after a while it start making noises (like=20
spinning up) and the computer freezes during 2 or 3 seconds. I think my=
=20
SATA drive is broken, or maybe the motherboard. This is what dmesg says=
:

[  229.096000] ata4: exception Emask 0x10 SAct 0x0 SErr 0x90200 action=20
0x6 frozen
[  229.096000] ata4: (irq_stat 0x00400000, PHY RDY changed)
[  229.096000] ata4: hard resetting port
[  233.400000] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  233.404000] ata4.00: configured for UDMA/133
[  233.404000] ata4: EH complete
[  233.404000] sd 3:0:0:0: [sda] 160836480 512-byte hardware sectors=20
(82348 MB)
[  233.404000] sd 3:0:0:0: [sda] Write Protect is off
[  233.404000] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  233.404000] sd 3:0:0:0: [sda] Write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA


This happens randomly, maybe after a few seconds, maybe after an hour.=20
Sometimes if the coimputer case receives a little bump or it is moved=20
the problem appears inmediatly.
What's the kernel complaining about? Something is broken isn't it? I=20
hope it's the cable...

I'm using Ubuntu 7.10 with kernel 2.6.22-14-generic in a dual processor=
=20
computer. Below there's some hardware information. The output of dmesg=20
is attached. Thanks!

Mat=EDas.

--------------------------------------------

lspci:

00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 10)
00:02.0 PCI bridge: ATI Technologies Inc RS480 PCI-X Root Port
00:12.0 SATA controller: ATI Technologies Inc SB600 Non-Raid-5 SATA
00:13.0 USB Controller: ATI Technologies Inc SB600 USB (OHCI0)
00:13.1 USB Controller: ATI Technologies Inc SB600 USB (OHCI1)
00:13.2 USB Controller: ATI Technologies Inc SB600 USB (OHCI2)
00:13.3 USB Controller: ATI Technologies Inc SB600 USB (OHCI3)
00:13.4 USB Controller: ATI Technologies Inc SB600 USB (OHCI4)
00:13.5 USB Controller: ATI Technologies Inc SB600 USB Controller (EHCI=
)
00:14.0 SMBus: ATI Technologies Inc SBx00 SMBus Controller (rev 13)
00:14.1 IDE interface: ATI Technologies Inc SB600 IDE
00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia
00:14.3 ISA bridge: ATI Technologies Inc SB600 PCI to LPC Bridge
00:14.4 PCI bridge: ATI Technologies Inc SBx00 PCI to PCI Bridge
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]=
=20
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]=
=20
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]=
=20
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]=
=20
Miscellaneous Control
01:00.0 VGA compatible controller: nVidia Corporation G71 [GeForce 7300=
=20
GS] (rev a1)
02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd.=20
RTL-8110SC/8169SC Gigabit Ethernet (rev 10)

--------------------------------------------

lshw:

     *-pci:0
          description: Host bridge
          product: RS480 Host Bridge
          vendor: ATI Technologies Inc
          physical id: 100
          bus info: pci@0000:00:00.0
          version: 10
          width: 32 bits
          clock: 66MHz
      =20
           *-storage
               description: SATA controller
               product: SB600 Non-Raid-5 SATA
               vendor: ATI Technologies Inc
               physical id: 12
               bus info: pci@0000:00:12.0
               version: 00
               width: 32 bits
               clock: 66MHz
               capabilities: storage ahci_1.0 bus_master cap_list
               configuration: driver=3Dahci latency=3D64 module=3Dahci

--------------------------------------------
