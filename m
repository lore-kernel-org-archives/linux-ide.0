From: Matthias Peter Walther <m_walt11@uni-muenster.de>
Subject: Re: Delock 89384 Sata Controller Causes Lockups Under Heavy Load
Date: Wed, 15 Nov 2017 18:29:24 +0100
Message-ID: <1ba6c8f1-44d4-5552-e38d-d11091479d7c@uni-muenster.de>
References: <158d56db94baac238e35093d0223066b@openmailbox.org>
Reply-To: m.wa@wwu.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ZIVM-WWU1-1.UNI-MUENSTER.DE ([128.176.192.4]:12550 "EHLO
        zivm-wwu1.uni-muenster.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbdKORjO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Nov 2017 12:39:14 -0500
In-Reply-To: <158d56db94baac238e35093d0223066b@openmailbox.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sonofagun@openmailbox.org, linux-ide@vger.kernel.org

Hi sonofagun,

did you have some time to look into this? This problem still exists in
Kernel 4.13.

The problem is easily reproducible. In my case a mdadm raid5 of three
320 GB Seagate drives, a resync and a dd from /dev/zero to the raid. And
it takes no longer than 60 seconds till the next lock up occurs.

As you might not have gotten my email from March, once again the request
information:

$ lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation Celeron N3350/Pentium
N4200/Atom E3900 Series Host Bridge [8086:5af0] (rev 0b)
00:02.0 VGA compatible controller [0300]: Intel Corporation Device
[8086:5a85] (rev 0b)
00:0e.0 Audio device [0403]: Intel Corporation Celeron N3350/Pentium
N4200/Atom E3900 Series Audio Cluster [8086:5a98] (rev 0b)
00:0f.0 Communication controller [0780]: Intel Corporation Celeron
N3350/Pentium N4200/Atom E3900 Series Trusted Execution Engine
[8086:5a9a] (rev 0b)
00:12.0 SATA controller [0106]: Intel Corporation Celeron N3350/Pentium
N4200/Atom E3900 Series SATA AHCI Controller [8086:5ae3] (rev 0b)
00:13.0 PCI bridge [0604]: Intel Corporation Celeron N3350/Pentium
N4200/Atom E3900 Series PCI Express Port A #1 [8086:5ad8] (rev fb)
00:13.1 PCI bridge [0604]: Intel Corporation Celeron N3350/Pentium
N4200/Atom E3900 Series PCI Express Port A #2 [8086:5ad9] (rev fb)
00:13.2 PCI bridge [0604]: Intel Corporation Celeron N3350/Pentium
N4200/Atom E3900 Series PCI Express Port A #3 [8086:5ada] (rev fb)
00:13.3 PCI bridge [0604]: Intel Corporation Celeron N3350/Pentium
N4200/Atom E3900 Series PCI Express Port A #4 [8086:5adb] (rev fb)
00:15.0 USB controller [0c03]: Intel Corporation Celeron N3350/Pentium
N4200/Atom E3900 Series USB xHCI [8086:5aa8] (rev 0b)
00:1f.0 ISA bridge [0601]: Intel Corporation Celeron N3350/Pentium
N4200/Atom E3900 Series Low Pin Count Interface [8086:5ae8] (rev 0b)
00:1f.1 SMBus [0c05]: Intel Corporation Celeron N3350/Pentium N4200/Atom
E3900 Series SMBus Controller [8086:5ad4] (rev 0b)
01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168]
(rev 06
03:00.0 SATA controller [0106]: ASMedia Technology Inc. Device
[1b21:0625] (rev 01)

lspci -k for the controller:

03:00.0 SATA controller: ASMedia Technology Inc. Device 0625 (rev 01)
        Subsystem: ASMedia Technology Inc. Device 1060
        Kernel driver in use: ahci
        Kernel modules: ahci

The error in the syslog:
Nov 15 18:24:30 Server3 kernel: [ 2282.488984] ata4.00: exception Emask
0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
Nov 15 18:24:30 Server3 kernel: [ 2282.489077] ata4.00: failed command:
FLUSH CACHE EXT
Nov 15 18:24:30 Server3 kernel: [ 2282.489127] ata4.00: cmd
ea/00:00:00:00:00/00:00:00:00:00/a0 tag 6
Nov 15 18:24:30 Server3 kernel: [ 2282.489127]          res
40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Nov 15 18:24:30 Server3 kernel: [ 2282.489238] ata4.00: status: { DRDY }
Nov 15 18:24:30 Server3 kernel: [ 2282.489278] ata4: hard resetting link
Nov 15 18:24:30 Server3 kernel: [ 2282.804315] ata4: SATA link up 1.5
Gbps (SStatus 113 SControl 300)
Nov 15 18:24:31 Server3 kernel: [ 2282.903885] ata4.00: configured for
UDMA/133
Nov 15 18:24:31 Server3 kernel: [ 2282.903888] ata4.00: retrying FLUSH
0xea Emask 0x4
Nov 15 18:24:31 Server3 kernel: [ 2282.928284] ata4: EH complete

I've set up a test system, which has no data that might be lost. It's
Ubuntu 17.10 server and 4.13 mainline kernel. So I could test anything
you need without the risk of dataloss. I have two Samsung SSDs, one 4 TB
and three 320 GB drives lying around here.

An observation, that might be interesting: While the raid is in lockup,
I can still read and write from the other drives at high speed.

Would be cool if anybody can give some advice. It's definitely not the
cables nor the drives.

Regards,
Matthias

Am 29.03.2017 um 15:43 schrieb sonofagun@openmailbox.org:
>
> Hello there, I am new to this list too! Despite that, I think I can
> help you.
>
> It is more likely that the issue is caused by the ASMedia controller
> or the disks. I have such a controller but it might not be the same
> revision.
>
> If the controller is causing the lockup, I can try something but I
> will need more information to verify my thought. First of all send
> here the output of:
> lspci -nn
> and I will tell you later what else is needed.
>
> If the disks are causing the lockup, I can tell you which one is the
> faulty disk(s). For each attached disk send the output of:
> sudo smartctl -a /dev/sd*
>
> I hope that your disks are fine as you will have a lot of job to do
> prior RMA if anyone is dying. It might be a good idea to find their
> receipts...



