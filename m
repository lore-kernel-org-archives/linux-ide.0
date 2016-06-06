From: "Navin P.S" <navinp1912@gmail.com>
Subject: Re: Lenovo A740 gave up waiting for root device with kernels >= 4.3
Date: Mon, 6 Jun 2016 16:56:59 +0530
Message-ID: <CAA=40861-zFKancJ3w5Zia2v9bpaN4TY3bw7Hi8G=97z_30qVA@mail.gmail.com>
References: <87vb1mwz73.fsf@fsfe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33834 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbcFFL1k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Jun 2016 07:27:40 -0400
Received: by mail-vk0-f54.google.com with SMTP id e4so58345034vkb.1
        for <linux-ide@vger.kernel.org>; Mon, 06 Jun 2016 04:27:40 -0700 (PDT)
In-Reply-To: <87vb1mwz73.fsf@fsfe.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Brubeck Unhammer <unhammer@fsfe.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Mon, Jun 6, 2016 at 1:01 PM, Kevin Brubeck Unhammer
<unhammer@fsfe.org> wrote:
> Hi,
>
> I have a Lenovo A740 (running Xubuntu 16.04) which, with kernel
> versions >=3D 4.3.0, tested up until 4.7.0, gives this on trying to b=
oot:
>
>   Begin: Waiting for root file system ... Begin: Running
>   /scripts/local-block ... done.
>   Begin: Running /scripts/local-block ... done.
>   Begin: Running /scripts/local-block ... done.
>   [=E2=80=A6]
>   done.
>   Gave up waiting for root device.
>
> and drops me into an (initramfs) shell, where my keyboard is
> unresponsive. The last kernel I tried which booted fine was 4.2.8.
>
> I reported this at https://bugzilla.kernel.org/show_bug.cgi?id=3D1184=
01
> and, after some investigation, was asked to contact ahci.c - AHCI SAT=
A
> support. The attachments in that report show some output from initram=
fs
> (using a script in /etc/initramfs-tools/scripts/init-premount due to =
the
> keyboard not working).
>
> What should I do to keep debugging this issue?
>

I have been working with Kevin on the bug 118401 .

I'll post the summary.
The kernel 4.2 works and he is able to boot the system.
Kernel 4.4 and 4.6, 4.7  drops into initramfs shell for the same uuid.
Upon further investigation cat /proc/devices showed no block devices
other than zram and loop.The command /sbin/blkid on 4.6 and later
didn't give any output whereas on 4.2 it does.

Kernel 4.2 shows the ahci used count is 3
ahci 36864 3 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000

Where kernel 4.7 doesn't load the ahci module upon boot and upon
modprobe ahci from the initramfs shell it shows the ahci count as 0.
So it is not detecting the drive. Not sure why ?

Some more things to note from 4.2 dmesg it prints not sure if it is rel=
evant.

[    0.716610] ahci 0000:00:1f.2: version 3.0
[    0.716620] ahci 0000:00:1f.2: can't find IRQ for PCI INT B;
probably buggy MP table

[    0.735267] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 6
Gbps 0x1 impl SATA mode

[    0.746033] ata1: SATA max UDMA/133 abar m2048@0xb5618000 port
0xb5618100 irq 44

[    1.068001] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

[    1.134029] ata1.00: ATA-8: ST1000LM014-1EJ164-SSHD-8GB, LIV6, max U=
DMA/133
[    1.134030] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 3=
1/32), AA
[    1.178470] ata1.00: configured for UDMA/133
[    1.178620] scsi 0:0:0:0: Direct-Access     ATA
ST1000LM014-1EJ1 LIV6 PQ: 0 ANSI: 5
[    1.178853] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks:
(1.00 TB/931 GiB)
[    1.178855] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    1.178879] sd 0:0:0:0: [sda] Write Protect is off
[    1.178881] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00


where as 4.6 and later doesn't print these messages.dmesg | grep
ata[0-4] gives no output.

lspci on 4.2 gives this

00:1f.2 SATA controller: Intel Corporation 8 Series SATA Controller 1
[AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
Subsystem: Lenovo 8 Series SATA Controller 1 [AHCI mode]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 44
Region 0: I/O ports at 6088 [size=3D8]
Region 1: I/O ports at 6094 [size=3D4]
Region 2: I/O ports at 6080 [size=3D8]
Region 3: I/O ports at 6090 [size=3D4]
Region 4: I/O ports at 6060 [size=3D32]
Region 5: Memory at b5618000 (32-bit, non-prefetchable) [size=3D2K]
Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
Address: fee0400c  Data: 4181
Capabilities: [70] Power Management version 3
=46lags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D=
3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
Kernel driver in use: ahci
Kernel modules: ahci


Regards,
Navin
