From: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Subject: sata_via bus errors fixed?
Date: Mon, 24 Jan 2011 16:06:31 +0000
Message-ID: <4D3DA387.8080301@mrc-lmb.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:36222 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab1AXQb3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 11:31:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm not a kernel expert, so apologies if I misstep. I've recently
experienced many errors with a new disk and SATA controller, which have
apparently disappeared when a recent kernel is used. I'd welcome any
informed opinions about whether the system should be stable in this
configuration.

Short story first.

I have a fairly old system and one of the SATA 1 drives is failing so I
bought a replacement, which is SATA 2. The system didn't see it at all
so I rushed out and bought another drive (Xmas panic!) but it wasn't
seen either. Google told me it was a problem with the SATA chip on the
motherboard, so I borrowed a SATA adapter. It kind of worked but gave
lots of bus errors. I tried a couple of other adapters with similar
results. I tested the drives and they're perfect. I read about power
issues with SATA so I disconnected everything I could but that made no
difference. I tried with several cables, both data and power. So I
started looking for a new system.

Then I seem to have got lucky. I've been running openSUSE 11.2 and have
also tested Ubuntu 10.04 with similar results. Recently I tried Knoppix
6.4.3 and apparently everything worked perfectly. I still need to do
more testing but maybe my old system can live a while longer.

I'd be interested in any views people have about the prognosis.

OK, now here's the details:

The mobo is an MSI K8M Neo-V, which has two SATA 1.5 Gbps ports
controlled by a VIA VT6420 chip, whcih can't see 3 Gbps drives.

The failing drive is a Seagate 1.5 Gbps. The new drives are both Samsung
3 Gbps SATA drives; a 1 TB HD103SJ and a 320 GB. The smaller drive has a
jumper to force 1.5 Gbps speed, while the larger one uses a software
utility.

I borrowed a PCI adapter based on the Sil 3512 and I've bought one based
on the VIA VT6421A. Like all PCI SATA adapters, they're limited to 1.5 Gbps.

The output from lspci (with the Sil controller) looked like this:

00:00.0 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge
[K8T800/K8T890 South]
00:0b.0 Mass storage controller: Silicon Image, Inc. SiI 3512
[SATALink/SATARaid] Serial ATA Controller (rev 01)
00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394
Controller (Link)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
(rev 78)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
01:00.0 VGA compatible controller: nVidia Corporation NV44A [GeForce
6200] (rev a1)

Typical error messages were like this:

Jan  5 22:53:27 piglet kernel: [  157.040095] ata5: hard resetting link
Jan  5 22:53:27 piglet kernel: [  157.390039] ata5: SATA link up 1.5
Gbps (SStatus 113 SControl 310)
Jan  5 22:53:32 piglet kernel: [  162.390035] ata5: hard resetting link
Jan  5 22:53:33 piglet kernel: [  162.740037] ata5: SATA link up 1.5
Gbps (SStatus 113 SControl 310)
Jan  5 22:53:33 piglet kernel: [  162.780287] ata5.00: configured for
UDMA/100
Jan  5 22:53:33 piglet kernel: [  162.780294] ata5.00: device reported
invalid CHS sector 0
Jan  5 22:53:33 piglet kernel: [  162.780302] ata5: EH complete
Jan  5 22:54:03 piglet kernel: [  193.040089] ata5: hard resetting link
Jan  5 22:54:03 piglet kernel: [  193.390060] ata5: SATA link up 1.5
Gbps (SStatus 113 SControl 310)
Jan  5 22:54:03 piglet kernel: [  193.430287] ata5.00: configured for
UDMA/100
Jan  5 22:54:03 piglet kernel: [  193.430295] ata5.00: device reported
invalid CHS sector 0
Jan  5 22:54:03 piglet kernel: [  193.430308] ata5: EH complete
Jan  5 22:54:07 piglet kernel: [  197.042033] ata5.00: limiting speed to
UDMA/66:PIO4
Jan  5 22:54:07 piglet kernel: [  197.042070] ata5: hard resetting link
Jan  5 22:54:07 piglet kernel: [  197.390059] ata5: SATA link up 1.5
Gbps (SStatus 113 SControl 310)
Jan  5 22:54:07 piglet kernel: [  197.430288] ata5.00: configured for
UDMA/66
Jan  5 22:54:07 piglet kernel: [  197.430305] ata5: EH complete
Jan  5 22:54:08 piglet kernel: [  197.821413] ata5.00: configured for
UDMA/66
Jan  5 22:54:08 piglet kernel: [  197.821437] ata5: EH complete
Jan  5 22:54:38 piglet kernel: [  228.040099] ata5: hard resetting link
Jan  5 22:54:38 piglet kernel: [  228.390046] ata5: SATA link up 1.5
Gbps (SStatus 113 SControl 310)
Jan  5 22:54:38 piglet kernel: [  228.430286] ata5.00: configured for
UDMA/66
Jan  5 22:54:38 piglet kernel: [  228.430309] ata5: EH complete

You can see that it steadily reduces the bus speed.


With the new VIA adapter, lspci shows:

00:00.0 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge
[K8T800/K8T890 South]
00:0b.0 RAID bus controller: VIA Technologies, Inc. VT6421 IDE RAID
Controller (rev 50)
00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394
Controller (Link)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
(rev 78)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
01:00.0 VGA compatible controller: nVidia Corporation NV44A [GeForce
6200] (rev a1)


and error messages looked like this:

Jan 12 20:51:18 piglet kernel: [  109.441492] ata2.00: exception Emask
0x12 SAct 0x0 SErr 0x1000500 action 0x6
Jan 12 20:51:18 piglet kernel: [  109.441517] ata2.00: BMDMA stat 0x5
Jan 12 20:51:18 piglet kernel: [  109.441525] ata2: SError: {
UnrecovData Proto TrStaTrns }
Jan 12 20:51:18 piglet kernel: [  109.441539] ata2.00: cmd
c8/00:f0:58:05:57/00:00:00:00:00/e1 tag 0 dma 122880 in
Jan 12 20:51:18 piglet kernel: [  109.441541]          res
51/84:48:00:00:00/84:58:00:00:00/e0 Emask 0x12 (ATA bus error)
Jan 12 20:51:18 piglet kernel: [  109.441555] ata2.00: status: { DRDY ERR }
Jan 12 20:51:18 piglet kernel: [  109.441561] ata2.00: error: { ICRC ABRT }
Jan 12 20:51:18 piglet kernel: [  109.441575] ata2: hard resetting link
Jan 12 20:51:18 piglet kernel: [  109.746050] ata2: SATA link up 1.5
Gbps (SStatus 113 SControl 310)
Jan 12 20:51:18 piglet kernel: [  109.784313] ata2.00: configured for
UDMA/33
Jan 12 20:51:18 piglet kernel: [  109.784337] ata2: EH complete

The errors didn't seem to cause any data corruption.

Oh and the kernel versions are:
openSUSE 11.2  2.6.31
ubuntu 10.04   2.6.32
knoppix 6.4.3  2.6.36


Looking at the kernel changelogs I see a 'magic patch' from Joseph Chan
that was applied between .32 and .36. It is described as improving
behaviour with WD drives while mine are Samsung. But looking at the
kernel bugzilla, it seemed to my tyro eyes that the symptoms are similar.

So I'm curious whether:
(1) My case is support for wider usefulness of the 'magic patch', or
(2) there was some other kernel change that explains the improved
behaviour on my system, or
(3) I've misunderstood the evidence and there's something else going on.

Regards, Dave

