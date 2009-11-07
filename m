From: Marty <martyb@ix.netcom.com>
Subject: possible ATA hang in 2.6.32-rc6
Date: Sat, 07 Nov 2009 12:25:55 -0500
Message-ID: <4AF5ADA3.3070000@ix.netcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-scoter.atl.sa.earthlink.net ([209.86.89.67]:55930 "EHLO
	elasmtp-scoter.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752302AbZKGRZv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Nov 2009 12:25:51 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, User discussion about IVTV <ivtv-users@ivtvdriver.org>

I got two hard hangs in 2.6.32-rc5 and rc6 in an Asrock A780GXE/128M
with AMD 780G+SB700 chipsets, resulting in no response to magic alt-sysreq.
The first hang left no log clues.  The second was closely but not
immediately preceeded by syslog ATA error messages (see excerpt).

They occurred days apart, possibly associated with keyboard or
mouse operation.  Each hang, both tuner cards were active, with heavy
concurrent graphics, SATA and USB activity. The system has I2C and
framebuffer issues with the Radeon 7000, causing problems in the
tuners, but I don't know if it's relevant. The hangs result in no
response to magic alt-sysreq.

When tuners, USB and graphics are not active, the system passes
heavy prolonged stress testing. I got less-complete ATA-related hangs
on my previous VIA system, under similar conditions.  I hoped this
new board would fix the problem.  The tuner ivtv drivers could be
involved, and were known as unstable until about a year ago.

I am now disabling PMP, to see if that avoids the problem.  Let me
know if you need any more information.  Thanks,

Marty

00:00.0 Host bridge: Advanced Micro Devices [AMD] RS780 Host Bridge
00:02.0 PCI bridge: Advanced Micro Devices [AMD] RS780 PCI to PCI bridge (ext gfx port 0)
00:0a.0 PCI bridge: Advanced Micro Devices [AMD] RS780 PCI to PCI bridge (PCIE port 5)
00:11.0 SATA controller: ATI Technologies Inc SB700/SB800 SATA Controller [IDE mode]
00:12.0 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI0 Controller
00:12.1 USB Controller: ATI Technologies Inc SB700 USB OHCI1 Controller
00:12.2 USB Controller: ATI Technologies Inc SB700/SB800 USB EHCI Controller
00:13.0 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI0 Controller
00:13.1 USB Controller: ATI Technologies Inc SB700 USB OHCI1 Controller
00:13.2 USB Controller: ATI Technologies Inc SB700/SB800 USB EHCI Controller
00:14.0 SMBus: ATI Technologies Inc SBx00 SMBus Controller (rev 3a)
00:14.1 IDE interface: ATI Technologies Inc SB700/SB800 IDE Controller
00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)
00:14.3 ISA bridge: ATI Technologies Inc SB700/SB800 LPC host controller
00:14.4 PCI bridge: ATI Technologies Inc SBx00 PCI to PCI Bridge
00:14.5 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI2 Controller
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: ATI Technologies Inc RV610 video device [Radeon HD 2400 PRO]
01:00.1 Audio device: ATI Technologies Inc RV610 audio device [Radeon HD 2400 PRO]
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
03:05.0 Multimedia video controller: Internext Compression Inc iTVC16 (CX23416) MPEG-2 Encoder (rev 01)
03:06.0 Multimedia video controller: Internext Compression Inc iTVC16 (CX23416) MPEG-2 Encoder (rev 01)
03:08.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]

syslog excerpt:

Nov  5 18:25:01 algernon kernel: ata1.00: exception Emask 0x50 SAct 0x3 SErr 0x800 action 0x6 frozen
Nov  5 18:25:01 algernon kernel: ata1.00: irq_stat 0x08000000, interface fatal error
Nov  5 18:25:01 algernon kernel: ata1: SError: { HostInt }
Nov  5 18:25:01 algernon kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov  5 18:25:01 algernon kernel: ata1.00: cmd 61/00:00:d8:f7:32/04:00:57:00:00/40 tag 0 ncq 524288 out
Nov  5 18:25:01 algernon kernel:          res 40/00:0c:d8:fb:32/00:00:57:00:00/40 Emask 0x50 (ATA bus error)
Nov  5 18:25:01 algernon kernel: ata1.00: status: { DRDY }
Nov  5 18:25:01 algernon kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov  5 18:25:01 algernon kernel: ata1.00: cmd 61/e8:08:d8:fb:32/00:00:57:00:00/40 tag 1 ncq 118784 out
Nov  5 18:25:01 algernon kernel:          res 40/00:0c:d8:fb:32/00:00:57:00:00/40 Emask 0x50 (ATA bus error)
Nov  5 18:25:01 algernon kernel: ata1.00: status: { DRDY }
Nov  5 18:25:01 algernon kernel: ata1: hard resetting link
Nov  5 18:25:02 algernon kernel: ata1: softreset failed (device not ready)
Nov  5 18:25:02 algernon kernel: ata1: applying SB600 PMP SRST workaround and retrying
Nov  5 18:25:02 algernon kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov  5 18:25:02 algernon kernel: ata1.00: configured for UDMA/133
Nov  5 18:25:02 algernon kernel: ata1: EH complete
Nov  5 18:25:34 algernon kernel: ata1.00: exception Emask 0x50 SAct 0x3 SErr 0x400800 action 0x6 frozen
Nov  5 18:25:34 algernon kernel: ata1.00: irq_stat 0x08000000, interface fatal error
Nov  5 18:25:34 algernon kernel: ata1: SError: { HostInt Handshk }
Nov  5 18:25:34 algernon kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov  5 18:25:34 algernon kernel: ata1.00: cmd 61/00:00:80:f3:fa/04:00:6c:00:00/40 tag 0 ncq 524288 out
Nov  5 18:25:34 algernon kernel:          res 40/00:0c:80:f7:fa/00:00:6c:00:00/40 Emask 0x50 (ATA bus error)
Nov  5 18:25:34 algernon kernel: ata1.00: status: { DRDY }
Nov  5 18:25:34 algernon kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov  5 18:25:34 algernon kernel: ata1.00: cmd 61/d8:08:80:f7:fa/00:00:6c:00:00/40 tag 1 ncq 110592 out
Nov  5 18:25:34 algernon kernel:          res 40/00:0c:80:f7:fa/00:00:6c:00:00/40 Emask 0x50 (ATA bus error)
Nov  5 18:25:34 algernon kernel: ata1.00: status: { DRDY }
Nov  5 18:25:34 algernon kernel: ata1: hard resetting link
Nov  5 18:25:35 algernon kernel: ata1: softreset failed (device not ready)
Nov  5 18:25:35 algernon kernel: ata1: applying SB600 PMP SRST workaround and retrying
Nov  5 18:25:35 algernon kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov  5 18:25:35 algernon kernel: ata1.00: configured for UDMA/133
Nov  5 18:25:35 algernon kernel: ata1: EH complete
Nov  5 18:25:41 algernon kernel: ata1.00: exception Emask 0x50 SAct 0x3 SErr 0x400800 action 0x6 frozen
Nov  5 18:25:41 algernon kernel: ata1.00: irq_stat 0x08000000, interface fatal error
Nov  5 18:25:41 algernon kernel: ata1: SError: { HostInt Handshk }
Nov  5 18:25:41 algernon kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov  5 18:25:41 algernon kernel: ata1.00: cmd 61/00:00:68:b1:fb/04:00:6c:00:00/40 tag 0 ncq 524288 out
Nov  5 18:25:41 algernon kernel:          res 40/00:04:68:b1:fb/00:00:6c:00:00/40 Emask 0x50 (ATA bus error)
Nov  5 18:25:41 algernon kernel: ata1.00: status: { DRDY }
Nov  5 18:25:41 algernon kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov  5 18:25:41 algernon kernel: ata1.00: cmd 61/30:08:68:b5:fb/01:00:6c:00:00/40 tag 1 ncq 155648 out
Nov  5 18:25:41 algernon kernel:          res 40/00:04:68:b1:fb/00:00:6c:00:00/40 Emask 0x50 (ATA bus error)
Nov  5 18:25:41 algernon kernel: ata1.00: status: { DRDY }
Nov  5 18:25:41 algernon kernel: ata1: hard resetting link
Nov  5 18:25:41 algernon kernel: ata1: softreset failed (device not ready)
Nov  5 18:25:41 algernon kernel: ata1: applying SB600 PMP SRST workaround and retrying
Nov  5 18:25:42 algernon kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Nov  5 18:25:42 algernon kernel: ata1.00: configured for UDMA/133
Nov  5 18:25:42 algernon kernel: ata1: EH complete
Nov  5 18:25:48 algernon kernel: ata1: limiting SATA link speed to 1.5 Gbps
Nov  5 18:25:48 algernon kernel: ata1.00: exception Emask 0x50 SAct 0x3 SErr 0x800 action 0x6 frozen
Nov  5 18:25:48 algernon kernel: ata1.00: irq_stat 0x08000000, interface fatal error
Nov  5 18:25:48 algernon kernel: ata1: SError: { HostInt }
Nov  5 18:25:48 algernon kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov  5 18:25:48 algernon kernel: ata1.00: cmd 61/00:00:50:32:fc/04:00:6c:00:00/40 tag 0 ncq 524288 out
Nov  5 18:25:48 algernon kernel:          res 40/00:0c:50:36:fc/00:00:6c:00:00/40 Emask 0x50 (ATA bus error)
Nov  5 18:25:48 algernon kernel: ata1.00: status: { DRDY }
Nov  5 18:25:48 algernon kernel: ata1.00: failed command: WRITE FPDMA QUEUED
Nov  5 18:25:48 algernon kernel: ata1.00: cmd 61/a8:08:50:36:fc/00:00:6c:00:00/40 tag 1 ncq 86016 out
Nov  5 18:25:48 algernon kernel:          res 40/00:0c:50:36:fc/00:00:6c:00:00/40 Emask 0x50 (ATA bus error)
Nov  5 18:25:48 algernon kernel: ata1.00: status: { DRDY }
Nov  5 18:25:48 algernon kernel: ata1: hard resetting link
Nov  5 18:25:48 algernon kernel: ata1: softreset failed (device not ready)
Nov  5 18:25:48 algernon kernel: ata1: applying SB600 PMP SRST workaround and retrying
Nov  5 18:25:48 algernon kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Nov  5 18:25:48 algernon kernel: ata1.00: configured for UDMA/133
Nov  5 18:25:48 algernon kernel: ata1: EH complete
Nov  5 18:38:28 algernon syslogd 1.5.0#5: restart.
