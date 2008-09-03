From: Dave <tephra@gmail.com>
Subject: Re: exception Emask 0x0 SAct 0x7ff SErr 0x0 action 0x6 frozen
Date: Thu, 4 Sep 2008 00:25:09 +1000
Message-ID: <f0e65c090809030725l78cea2fchb6d03ce9410385e@mail.gmail.com>
References: <f0e65c090809020414n5815377ai11431368eb4c8503@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:2644 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877AbYICOZK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Sep 2008 10:25:10 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2789656rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 03 Sep 2008 07:25:09 -0700 (PDT)
In-Reply-To: <f0e65c090809020414n5815377ai11431368eb4c8503@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Well - I can't be 100% sure but this seems to be related to NCQ.

If I "echo 1 > /sys/block/sda/device/queue_depth" for the 4 drives
in my RAID array and the problem goes away.

Any ideas?

Cheers
Dave

On Tue, Sep 2, 2008 at 9:14 PM, Dave <tephra@gmail.com> wrote:
> Hi Guys,
>
> I keep seeing this, usually during periods of disk usage (vs idle):
>
> ata3.00: exception Emask 0x0 SAct 0x7ff SErr 0x0 action 0x6 frozen
> ata3.00: cmd 60/08:00:3f:5e:37/00:00:03:00:00/40 tag 0 ncq 4096 in
>         res 40/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
> ata3.00: status: { DRDY }
> ata3.00: cmd 60/08:08:5f:ee:e1/00:00:1e:00:00/40 tag 1 ncq 4096 in
>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: status: { DRDY }
> ata3.00: cmd 60/08:10:3f:ce:ee/00:00:1e:00:00/40 tag 2 ncq 4096 in
>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: status: { DRDY }
> ata3.00: cmd 60/08:18:3f:fa:03/00:00:1f:00:00/40 tag 3 ncq 4096 in
>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: status: { DRDY }
> ata3.00: cmd 60/08:20:47:ea:2e/00:00:02:00:00/40 tag 4 ncq 4096 in
>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: status: { DRDY }
> ata3.00: cmd 60/08:28:ef:ab:2f/00:00:02:00:00/40 tag 5 ncq 4096 in
>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: status: { DRDY }
> ata3.00: cmd 60/08:30:0f:60:02/00:00:03:00:00/40 tag 6 ncq 4096 in
>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: status: { DRDY }
> ata3.00: cmd 60/f8:38:df:0e:5c/00:00:19:00:00/40 tag 7 ncq 126976 in
>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: status: { DRDY }
> ata3.00: cmd 60/68:40:d7:0f:5c/00:00:19:00:00/40 tag 8 ncq 53248 in
>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: status: { DRDY }
> ata3.00: cmd 60/f8:48:3f:fa:5a/00:00:19:00:00/40 tag 9 ncq 126976 in
>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: status: { DRDY }
> ata3.00: cmd 60/f8:50:37:fb:5a/00:00:19:00:00/40 tag 10 ncq 126976 in
>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: status: { DRDY }
> ata3: hard resetting link
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: configured for UDMA/133
> ata3: EH complete
> sd 2:0:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
> sd 2:0:0:0: [sdc] Write Protect is off
> sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
>
> It also occurs on ata4 which is a 320G disk. So its not specific to a
> disk, however I havn't seen
> it on ata0 or ata1 so it could be something about the controller??!?
>
> Kernel 2.6.23.3
> AMD 4850E processor, 2GB of DDR2
> Mobo: Asus M3N-H (Nvidia 8300 based)
> Disks: 1x 40G IDE, 3x 300G Seagate SATA, 1x 320G Seagate SATA
>
> lspci -v:
> 00:00.0 RAM memory: nVidia Corporation Device 0754 (rev a2)
>        Subsystem: ASUSTeK Computer Inc. Device 82e2
>        Flags: bus master, 66MHz, fast devsel, latency 0
>        Capabilities: <access denied>
>
> 00:01.0 ISA bridge: nVidia Corporation Device 075c (rev a2)
>        Subsystem: ASUSTeK Computer Inc. Device 82e2
>        Flags: bus master, 66MHz, fast devsel, latency 0
>
> 00:01.1 SMBus: nVidia Corporation Device 0752 (rev a1)
>        Subsystem: ASUSTeK Computer Inc. Device 82e2
>        Flags: 66MHz, fast devsel, IRQ 11
>        I/O ports at fc00 [size=64]
>        I/O ports at 1c00 [size=64]
>        I/O ports at 1c40 [size=64]
>        Capabilities: <access denied>
>
> 00:01.2 RAM memory: nVidia Corporation Device 0751 (rev a1)
>        Subsystem: ASUSTeK Computer Inc. Device 82e2
>        Flags: 66MHz, fast devsel
>
> 00:01.3 Co-processor: nVidia Corporation Device 0753 (rev a2)
>        Subsystem: ASUSTeK Computer Inc. Device 82e2
>        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 7
>        Memory at fdf80000 (32-bit, non-prefetchable) [size=512K]
>
> 00:01.4 RAM memory: nVidia Corporation Device 0568 (rev a1)
>        Subsystem: ASUSTeK Computer Inc. Device 82e2
>        Flags: 66MHz, fast devsel
>
> 00:02.0 USB Controller: nVidia Corporation Device 077b (rev a1) (prog-if 10)
>        Subsystem: ASUSTeK Computer Inc. Device 82e2
>        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 7
>        Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]
>        Capabilities: <access denied>
>        Kernel driver in use: ohci_hcd
>
> 00:02.1 USB Controller: nVidia Corporation Device 077c (rev a1) (prog-if 20)
>        Subsystem: ASUSTeK Computer Inc. Device 82e2
>        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
>        Memory at fe02e000 (32-bit, non-prefetchable) [size=256]
>        Capabilities: <access denied>
>        Kernel driver in use: ehci_hcd
>
> 00:04.0 USB Controller: nVidia Corporation Device 077d (rev a1) (prog-if 10)
>        Subsystem: ASUSTeK Computer Inc. Device 82e2
>        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 10
>        Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
>        Capabilities: <access denied>
>        Kernel driver in use: ohci_hcd
>
> 00:04.1 USB Controller: nVidia Corporation Device 077e (rev a1) (prog-if 20)
>        Subsystem: ASUSTeK Computer Inc. Device 82e2
>        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
>        Memory at fe02c000 (32-bit, non-prefetchable) [size=256]
>        Capabilities: <access denied>
>        Kernel driver in use: ehci_hcd
>
> 00:06.0 IDE interface: nVidia Corporation Device 0759 (rev a1)
> (prog-if 8a [Master SecP PriP])
>        Subsystem: ASUSTeK Computer Inc. Device 82e2
>        Flags: bus master, 66MHz, fast devsel, latency 0
>        [virtual] Memory at 000001f0 (32-bit, non-prefetchable)
> [disabled] [size=8]
>        [virtual] Memory at 000003f0 (type 3, non-prefetchable)
> [disabled] [size=1]
>        [virtual] Memory at 00000170 (32-bit, non-prefetchable)
> [disabled] [size=8]
>        [virtual] Memory at 00000370 (type 3, non-prefetchable)
> [disabled] [size=1]
>        I/O ports at f000 [size=16]
>        Capabilities: <access denied>
>        Kernel driver in use: AMD_IDE
>
> 00:07.0 Audio device: nVidia Corporation Device 0774 (rev a1)
>        Subsystem: ASUSTeK Computer Inc. Device 82fe
>        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 7
>        Memory at fe020000 (32-bit, non-prefetchable) [size=16K]
>        Capabilities: <access denied>
>        Kernel driver in use: HDA Intel
>        Kernel modules: snd-hda-intel
>
> 00:08.0 PCI bridge: nVidia Corporation Device 075a (rev a1) (prog-if 01)
>        Flags: bus master, 66MHz, fast devsel, latency 0
>        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
>        I/O behind bridge: 0000c000-0000cfff
>        Memory behind bridge: f8000000-fcffffff
>        Prefetchable memory behind bridge: fde00000-fdefffff
>        Capabilities: <access denied>
>
> 00:09.0 IDE interface: nVidia Corporation Device 0ad0 (rev a2)
> (prog-if 85 [Master SecO PriO])
>        Subsystem: ASUSTeK Computer Inc. Device 82e2
>        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
>        I/O ports at 09f0 [size=8]
>        I/O ports at 0bf0 [size=4]
>        I/O ports at 0970 [size=8]
>        I/O ports at 0b70 [size=4]
>        I/O ports at dc00 [size=16]
>        Memory at fe026000 (32-bit, non-prefetchable) [size=8K]
>        Capabilities: <access denied>
>        Kernel driver in use: ahci
>
> 00:0a.0 Ethernet controller: nVidia Corporation Device 0760 (rev a2)
>        Subsystem: ASUSTeK Computer Inc. Device 82e2
>        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 15
>        Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
>        I/O ports at d800 [size=8]
>        Memory at fe02a000 (32-bit, non-prefetchable) [size=256]
>        Memory at fe029000 (32-bit, non-prefetchable) [size=16]
>        Capabilities: <access denied>
>        Kernel driver in use: forcedeth
>
> 00:0b.0 PCI bridge: nVidia Corporation Device 0569 (rev a1)
>        Flags: bus master, fast devsel, latency 0
>        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>        I/O behind bridge: 0000b000-0000bfff
>        Memory behind bridge: f6000000-f7ffffff
>        Prefetchable memory behind bridge: 00000000e0000000-00000000efffffff
>        Capabilities: <access denied>
>
> 00:10.0 PCI bridge: nVidia Corporation Device 0778 (rev a1)
>        Flags: bus master, fast devsel, latency 0
>        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>        I/O behind bridge: 0000a000-0000afff
>        Memory behind bridge: fdd00000-fddfffff
>        Prefetchable memory behind bridge: 00000000fdc00000-00000000fdcfffff
>        Capabilities: <access denied>
>
> 00:12.0 PCI bridge: nVidia Corporation Device 075b (rev a1)
>        Flags: bus master, fast devsel, latency 0
>        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
>        I/O behind bridge: 00009000-00009fff
>        Memory behind bridge: fdb00000-fdbfffff
>        Prefetchable memory behind bridge: 00000000fda00000-00000000fdafffff
>        Capabilities: <access denied>
>
> 00:13.0 PCI bridge: nVidia Corporation Device 077a (rev a1)
>        Flags: bus master, fast devsel, latency 0
>        Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
>        I/O behind bridge: 00008000-00008fff
>        Memory behind bridge: fd900000-fd9fffff
>        Prefetchable memory behind bridge: 00000000fd800000-00000000fd8fffff
>        Capabilities: <access denied>
>
> 00:14.0 PCI bridge: nVidia Corporation Device 077a (rev a1)
>        Flags: bus master, fast devsel, latency 0
>        Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
>        I/O behind bridge: 00007000-00007fff
>        Memory behind bridge: fd700000-fd7fffff
>        Prefetchable memory behind bridge: 00000000fd600000-00000000fd6fffff
>        Capabilities: <access denied>
>
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] HyperTransport Technology Configuration
>        Flags: fast devsel
>        Capabilities: <access denied>
>
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] Address Map
>        Flags: fast devsel
>
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] DRAM Controller
>        Flags: fast devsel
>
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
> [Athlon64/Opteron] Miscellaneous Control
>        Flags: fast devsel
>        Capabilities: <access denied>
>        Kernel driver in use: k8temp
>
> 01:08.0 Multimedia video controller: Conexant CX23880/1/2/3 PCI Video
> and Audio Decoder (rev 05)
>        Subsystem: LeadTek Research Inc. Device 665f
>        Flags: bus master, medium devsel, latency 32, IRQ 5
>        Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
>        Capabilities: <access denied>
>        Kernel driver in use: cx8800
>        Kernel modules: cx8800
>
> 01:08.2 Multimedia controller: Conexant CX23880/1/2/3 PCI Video and
> Audio Decoder [MPEG Port] (rev 05)
>        Subsystem: LeadTek Research Inc. Device 665f
>        Flags: bus master, medium devsel, latency 32, IRQ 5
>        Memory at f9000000 (32-bit, non-prefetchable) [size=16M]
>        Capabilities: <access denied>
>        Kernel driver in use: cx88-mpeg driver manager
>        Kernel modules: cx8802
>
> 01:09.0 Multimedia video controller: Conexant CX23880/1/2/3 PCI Video
> and Audio Decoder (rev 05)
>        Subsystem: DViCO Corporation Device db10
>        Flags: bus master, medium devsel, latency 32, IRQ 10
>        Memory at f8000000 (32-bit, non-prefetchable) [size=16M]
>        Capabilities: <access denied>
>        Kernel driver in use: cx8800
>        Kernel modules: cx8800
>
> 01:09.2 Multimedia controller: Conexant CX23880/1/2/3 PCI Video and
> Audio Decoder [MPEG Port] (rev 05)
>        Subsystem: DViCO Corporation Device db10
>        Flags: bus master, medium devsel, latency 32, IRQ 10
>        Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
>        Capabilities: <access denied>
>        Kernel driver in use: cx88-mpeg driver manager
>        Kernel modules: cx8802
>
> 01:0a.0 FireWire (IEEE 1394): Agere Systems FW323 (rev 70) (prog-if 10)
>        Subsystem: ASUSTeK Computer Inc. Device 8294
>        Flags: bus master, medium devsel, latency 32, IRQ 10
>        Memory at fcfff000 (32-bit, non-prefetchable) [size=4K]
>        Capabilities: <access denied>
>
> 01:0b.0 Ethernet controller: Intel Corporation 82546EB Gigabit
> Ethernet Controller (Copper) (rev 01)
>        Subsystem: Intel Corporation Device 1011
>        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 5
>        Memory at fcfc0000 (64-bit, non-prefetchable) [size=128K]
>        I/O ports at cc00 [size=64]
>        Capabilities: <access denied>
>        Kernel driver in use: e1000
>
> 01:0b.1 Ethernet controller: Intel Corporation 82546EB Gigabit
> Ethernet Controller (Copper) (rev 01)
>        Subsystem: Intel Corporation Device 1011
>        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 10
>        Memory at fcfa0000 (64-bit, non-prefetchable) [size=128K]
>        I/O ports at c800 [size=64]
>        Capabilities: <access denied>
>        Kernel driver in use: e1000
>
> 02:00.0 VGA compatible controller: nVidia Corporation Device 0848 (rev a2)
>        Subsystem: ASUSTeK Computer Inc. Device 82e2
>        Flags: bus master, fast devsel, latency 0, IRQ 11
>        Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
>        Memory at e0000000 (64-bit, prefetchable) [size=128M]
>        Memory at ee000000 (64-bit, prefetchable) [size=32M]
>        I/O ports at bc00 [size=128]
>        [virtual] Expansion ROM at e8000000 [disabled] [size=128K]
>        Capabilities: <access denied>
>        Kernel driver in use: nvidia
>        Kernel modules: nvidia
>
