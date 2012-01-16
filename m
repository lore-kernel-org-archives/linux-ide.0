From: Peter Silva <Peter.A.Silva@gmail.com>
Subject: highpoint rr622 ext. SATA controller, regression post 2.6.38
Date: Sun, 15 Jan 2012 21:35:51 -0500
Message-ID: <CADL7Pvhbm2Z8Y8BPDVm9=k92f1O+w3R3eGyyqhuEoxmnXC3SXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64740 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab2APCfw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Jan 2012 21:35:52 -0500
Received: by wgbdq11 with SMTP id dq11so141357wgb.1
        for <linux-ide@vger.kernel.org>; Sun, 15 Jan 2012 18:35:51 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

bug # 37642

was recognize in 2.6.38, not in 3.0 or 3.1 using ubuntu kernels, tried
with upstream, same behaviour.  As per original send, asked for lspci
-nn output:


root@alu:/alu/tr8m_2/virtual_machines# lspci -nn
00:00.0 Host bridge [0600]: Advanced Micro Devices [AMD] RS780 Host
Bridge [1022:9600]
00:02.0 PCI bridge [0604]: Advanced Micro Devices [AMD] RS780 PCI to
PCI bridge (ext gfx port 0) [1022:9603]
00:04.0 PCI bridge [0604]: Advanced Micro Devices [AMD] RS780 PCI to
PCI bridge (PCIE port 0) [1022:9604]
00:06.0 PCI bridge [0604]: Advanced Micro Devices [AMD] RS780 PCI to
PCI bridge (PCIE port 2) [1022:9606]
00:11.0 SATA controller [0106]: ATI Technologies Inc SB7x0/SB8x0/SB9x0
SATA Controller [AHCI mode] [1002:4391]
00:12.0 USB Controller [0c03]: ATI Technologies Inc SB7x0/SB8x0/SB9x0
USB OHCI0 Controller [1002:4397]
00:12.1 USB Controller [0c03]: ATI Technologies Inc SB7x0 USB OHCI1
Controller [1002:4398]
00:12.2 USB Controller [0c03]: ATI Technologies Inc SB7x0/SB8x0/SB9x0
USB EHCI Controller [1002:4396]
00:13.0 USB Controller [0c03]: ATI Technologies Inc SB7x0/SB8x0/SB9x0
USB OHCI0 Controller [1002:4397]
00:13.1 USB Controller [0c03]: ATI Technologies Inc SB7x0 USB OHCI1
Controller [1002:4398]
00:13.2 USB Controller [0c03]: ATI Technologies Inc SB7x0/SB8x0/SB9x0
USB EHCI Controller [1002:4396]
00:14.0 SMBus [0c05]: ATI Technologies Inc SBx00 SMBus Controller
[1002:4385] (rev 3c)
00:14.1 IDE interface [0101]: ATI Technologies Inc SB7x0/SB8x0/SB9x0
IDE Controller [1002:439c]
00:14.2 Audio device [0403]: ATI Technologies Inc SBx00 Azalia (Intel
HDA) [1002:4383]
00:14.3 ISA bridge [0601]: ATI Technologies Inc SB7x0/SB8x0/SB9x0 LPC
host controller [1002:439d]
00:14.4 PCI bridge [0604]: ATI Technologies Inc SBx00 PCI to PCI
Bridge [1002:4384]
00:14.5 USB Controller [0c03]: ATI Technologies Inc SB7x0/SB8x0/SB9x0
USB OHCI2 Controller [1002:4399]
00:18.0 Host bridge [0600]: Advanced Micro Devices [AMD] Family 10h
Processor HyperTransport Configuration [1022:1200]
00:18.1 Host bridge [0600]: Advanced Micro Devices [AMD] Family 10h
Processor Address Map [1022:1201]
00:18.2 Host bridge [0600]: Advanced Micro Devices [AMD] Family 10h
Processor DRAM Controller [1022:1202]
00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] Family 10h
Processor Miscellaneous Control [1022:1203]
00:18.4 Host bridge [0600]: Advanced Micro Devices [AMD] Family 10h
Processor Link Control [1022:1204]
01:00.0 VGA compatible controller [0300]: nVidia Corporation GT215
[GeForce GT 240] [10de:0ca3] (rev a2)
01:00.1 Audio device [0403]: nVidia Corporation High Definition Audio
Controller [10de:0be4] (rev a1)
02:00.0 RAID bus controller [0104]: HighPoint Technologies, Inc.
Device [1103:0622] (rev 01)
02:00.1 IDE interface [0101]: Marvell Technology Group Ltd. 88SE91A4
SATA 6Gb/s Controller [1b4b:91a4] (rev 11)
03:00.0 Ethernet controller [0200]: Atheros Communications AR8131
Gigabit Ethernet [1969:1063] (rev c0)
04:07.0 Multimedia video controller [0400]: Conexant Systems, Inc.
CX23880/1/2/3 PCI Video and Audio Decoder [14f1:8800] (rev 05)
04:07.1 Multimedia controller [0480]: Conexant Systems, Inc.
CX23880/1/2/3 PCI Video and Audio Decoder [Audio Port] [14f1:8801]
(rev 05)
04:07.2 Multimedia controller [0480]: Conexant Systems, Inc.
CX23880/1/2/3 PCI Video and Audio Decoder [MPEG Port] [14f1:8802] (rev
05)
04:07.4 Multimedia controller [0480]: Conexant Systems, Inc.
CX23880/1/2/3 PCI Video and Audio Decoder [IR Port] [14f1:8804] (rev
05)
