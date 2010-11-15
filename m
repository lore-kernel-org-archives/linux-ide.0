From: James Cloos <cloos@jhcloos.com>
Subject: Re: AMD 890GX vs 6Gbps SATA?
Date: Mon, 15 Nov 2010 11:31:36 -0500
Message-ID: <m339r2lf9b.fsf@jhcloos.com>
References: <2DEEA3AB13739D45A22ADDB5086AEA0B915107@sshaexmb1.amd.com>
	<1E8B869C0C6913418421A406C094DF7C82D812@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eagle.jhcloos.com ([207.210.242.212]:48924 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758006Ab0KOQqA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Nov 2010 11:46:00 -0500
In-Reply-To: <1E8B869C0C6913418421A406C094DF7C82D812@sshaexmb1.amd.com> (Shane
	Huang's message of "Mon, 15 Nov 2010 15:45:19 +0800")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: linux-ide@vger.kernel.org, "Xu, Andiry" <Andiry.Xu@amd.com>, "Petkov, Borislav" <Borislav.Petkov@amd.com>

--=-=-=
Content-Type: text/plain

>>>>> "HS" == Huang, Shane <Shane.Huang@amd.com> writes:

HS> Can you send us your full dmesg and lspci?

lspci is:

00:00.0 Host bridge: Advanced Micro Devices [AMD] RS880 Host Bridge
00:01.0 PCI bridge: Advanced Micro Devices [AMD] RS780 PCI to PCI bridge (int gfx)
00:05.0 PCI bridge: Advanced Micro Devices [AMD] RS780 PCI to PCI bridge (PCIE port 1)
00:06.0 PCI bridge: Advanced Micro Devices [AMD] RS780 PCI to PCI bridge (PCIE port 2)
00:11.0 SATA controller: ATI Technologies Inc SB700/SB800 SATA Controller [AHCI mode] (rev 40)
00:12.0 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI0 Controller
00:12.2 USB Controller: ATI Technologies Inc SB700/SB800 USB EHCI Controller
00:13.0 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI0 Controller
00:13.2 USB Controller: ATI Technologies Inc SB700/SB800 USB EHCI Controller
00:14.0 SMBus: ATI Technologies Inc SBx00 SMBus Controller (rev 41)
00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA) (rev 40)
00:14.3 ISA bridge: ATI Technologies Inc SB700/SB800 LPC host controller (rev 40)
00:14.4 PCI bridge: ATI Technologies Inc SBx00 PCI to PCI Bridge (rev 40)
00:14.5 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI2 Controller
00:15.0 PCI bridge: ATI Technologies Inc Device 43a0
00:16.0 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI0 Controller
00:16.2 USB Controller: ATI Technologies Inc SB700/SB800 USB EHCI Controller
00:18.0 Host bridge: Advanced Micro Devices [AMD] Family 10h Processor HyperTransport Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] Family 10h Processor Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] Family 10h Processor DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] Family 10h Processor Miscellaneous Control
00:18.4 Host bridge: Advanced Micro Devices [AMD] Family 10h Processor Link Control
01:05.0 VGA compatible controller: ATI Technologies Inc RS880 [Radeon HD 4290]
01:05.1 Audio device: ATI Technologies Inc RS880 Audio Device [Radeon HD 4200]
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 03)
03:00.0 USB Controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev 03)
04:05.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
05:04.0 Ethernet controller: Intel Corporation 82557/8/9/0/1 Ethernet Pro 100 (rev 05)
05:05.0 Ethernet controller: Intel Corporation 82557/8/9/0/1 Ethernet Pro 100 (rev 05)
06:00.0 IDE interface: JMicron Technology Corp. JMB368 IDE controller

The verbose output for 00:11.0 is:

00:11.0 SATA controller: ATI Technologies Inc SB700/SB800 SATA Controller [AHCI mode] (rev 40) (prog-if 01 [AHCI 1.0])
        Subsystem: Micro-Star International Co., Ltd. Device 7642
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 40
        Region 0: I/O ports at 9000 [size=8]
        Region 1: I/O ports at 8000 [size=4]
        Region 2: I/O ports at 7000 [size=8]
        Region 3: I/O ports at 6000 [size=4]
        Region 4: I/O ports at 5000 [size=16]
        Region 5: Memory at fe2ffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] MSI: Enable+ Count=1/8 Maskable- 64bit+
                Address: 00000000fee0f00c  Data: 4159
        Capabilities: [70] SATA HBA v1.0 InCfgSpace
        Capabilities: [a4] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: ahci

And the dmesg, compressed to fit, is attached:


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=dmesg.gz
Content-Transfer-Encoding: base64
Content-Description: Gzip(1)ed dmesg

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
bQdy0NnPZ1kzd+PDsAAA
--=-=-=
Content-Type: text/plain


(Heh.  The gzip is smaller than the bzip2.)

(The carbon1 in the kernel version is a .config tracking localversion.)

HS> I submitted one patch to support SATA AHCI 6Gbps message
HS> in 2008, does your kernel contain it?

HS> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
HS> t;h=8522ee25f3a645577d41e71328cd4fcf8610dfeb

I currently run the v2.6.36 tag on that box; newer kernels have a pty
deadlock (in bz).  That commit is in the tree, but the function it
changed has since moved from ahci.c to libahci.c.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6

--=-=-=--
