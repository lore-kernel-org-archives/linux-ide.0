From: MisterE <MisterE2002@zonnet.nl>
Subject: Re[2]: Sata Sil3512 bug?;  Promise SATA300 TX4
Date: Wed, 17 Oct 2007 17:04:44 +0200
Message-ID: <1785297944.20071017170444@zonnet.nl>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <135469746.20071017143929@zonnet.nl> <47160601.80506@lxnt.info>
Reply-To: MisterE <MisterE2002@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.publishnet.nl ([212.241.49.8]:4383 "EHLO smtp.pn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756124AbXJQPBJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 11:01:09 -0400
Received: from localhost ([84.246.52.165])
	by smtp.pn.nl (smtp.pn.nl [212.241.49.8])
	(MDaemon.PRO.v8.1.3.R)
	with ESMTP id 27-md50000105455.msg
	for <linux-ide@vger.kernel.org>; Wed, 17 Oct 2007 17:01:03 +0200
In-Reply-To: <47160601.80506@lxnt.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Sabourenkov <screwdriver@lxnt.info>
Cc: Mikael Pettersson <mikpe@it.uu.se>, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, jeff@garzik.org

Hello Alexander,

Wednesday, October 17, 2007, 2:54:25 PM, you wrote:

> Log file got lost. Please post relevant parts inline.

Sorry, i totally forgot to include them.
I can not reproduce the errors. Last times hda did not give errors. So i'm
not sure if it is related to each other. (in the thread you mentioned
that you can't explain the fixing of problem from Peter Favrholdt, so
maybe it has indeed something to do with the libata)

ct 16 14:10:59 fileserver kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 16 14:10:59 fileserver kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Oct 16 14:10:59 fileserver kernel: ide: failed opcode was: unknown
Oct 16 14:12:49 fileserver kernel: kjournald starting.  Commit interval 5 seconds
Oct 16 14:12:49 fileserver kernel: EXT3 FS on sda1, internal journal
Oct 16 14:12:49 fileserver kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 16 14:13:34 fileserver kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 16 14:13:34 fileserver kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Oct 16 14:13:34 fileserver kernel: ide: failed opcode was: unknown
Oct 16 14:17:21 fileserver kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 16 14:17:21 fileserver kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Oct 16 14:17:21 fileserver kernel: ide: failed opcode was: unknown
Oct 16 14:17:21 fileserver kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 16 14:17:21 fileserver kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Oct 16 14:17:21 fileserver kernel: ide: failed opcode was: unknown
Oct 16 14:17:21 fileserver kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 16 14:17:21 fileserver kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Oct 16 14:17:21 fileserver kernel: ide: failed opcode was: unknown
Oct 16 14:17:21 fileserver kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 16 14:17:21 fileserver kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Oct 16 14:17:21 fileserver kernel: ide: failed opcode was: unknown
Oct 16 14:17:21 fileserver kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 16 14:17:21 fileserver kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Oct 16 14:17:21 fileserver kernel: ide: failed opcode was: unknown
Oct 16 14:17:21 fileserver kernel: hdb: DMA disabled
Oct 16 14:17:21 fileserver kernel: ide0: reset: success
Oct 16 14:32:51 fileserver kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
Oct 16 14:32:51 fileserver kernel: ata1.00: (port_status 0x20080000)
Oct 16 14:32:51 fileserver kernel: ata1.00: cmd c8/00:00:77:f6:6c/00:00:00:00:00/e4 tag 0 cdb 0x0 data 131072 in
Oct 16 14:32:51 fileserver kernel:          res 50/00:00:76:f7:6c/00:00:00:00:00/e4 Emask 0x2 (HSM violation)
Oct 16 14:32:51 fileserver kernel: ata1: soft resetting port
Oct 16 14:32:51 fileserver kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 16 14:32:51 fileserver kernel: ata1.00: configured for UDMA/133
Oct 16 14:32:51 fileserver kernel: ata1: EH complete
Oct 16 14:32:51 fileserver kernel: sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
Oct 16 14:32:51 fileserver kernel: sd 0:0:0:0: [sda] Write Protect is off
Oct 16 14:32:51 fileserver kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 16 14:32:51 fileserver kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct 16 14:44:09 fileserver kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
Oct 16 14:48:48 fileserver kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
Oct 16 14:48:48 fileserver kernel: ata1.00: (port_status 0x20080000)
Oct 16 14:48:48 fileserver kernel: ata1.00: cmd 25/00:00:3f:d0:26/00:01:23:00:00/e0 tag 0 cdb 0x0 data 131072 in
Oct 16 14:48:48 fileserver kernel:          res 50/00:00:3e:d1:26/00:00:23:00:00/e0 Emask 0x2 (HSM violation)
Oct 16 14:48:48 fileserver kernel: ata1: soft resetting port
Oct 16 14:48:49 fileserver kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 16 14:48:49 fileserver kernel: ata1.00: configured for UDMA/133
Oct 16 14:48:49 fileserver kernel: ata1: EH complete
Oct 16 14:48:49 fileserver kernel: sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
Oct 16 14:48:49 fileserver kernel: sd 0:0:0:0: [sda] Write Protect is off
Oct 16 14:48:49 fileserver kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Oct 16 14:48:49 fileserver kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA



> Since you have the hardware, do the tests and decide for yourself.

> I'd try copying one (big, preferably over 160G ) disk onto another (with
> dd) for a start,
> while waiting for answers on mailing lists.


I can order that 1740 online, but returning something is always more
difficult. So need to be quite sure that there are'nt problems with
this highpoint.

Tonight i will try the Asus motherboard with 1 drive and much I/O. And
i will create a new array which takes 7 hours. But how often/hours do
you need to try something to prove it does not fail :P

-- 
Best regards,
 MisterE                            mailto:MisterE2002@zonnet.nl


