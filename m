From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: /dev/hda problem with samsung hd
Date: Thu, 22 May 2003 16:11:58 +0200 (MET DST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.SOL.4.30.0305221608050.9940-100000@mion.elka.pw.edu.pl>
References: <1053605323.1135.16.camel@alice>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:19711 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261874AbTEVOAk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 May 2003 10:00:40 -0400
In-Reply-To: <1053605323.1135.16.camel@alice>
List-Id: linux-ide@vger.kernel.org
To: pacho baratta <pachox@evolinux.it>
Cc: linux-ide@vger.kernel.org


Can you try kernel >= 2.4.21-pre7 (latest is 2.4.21-rc2) ?
It contains fix for some Samsung drives which don't abort unknown
commands.

Regards,
--
Bartlomiej

On 22 May 2003, pacho baratta wrote:

> i'm working with a disk (samsung sv1022d) that my system cannot see. i
> have a live cd with kernel 2.4.20 and glibc-2.2.5.
>
> now when i boot i find in dmesg:
>
> hda samsung sv1022d my100 ata disk drive
> hda: task_no_data_intr 0x51 {DriveRady SeekComplete Error}
> hda: task_no_data_intr 0x04 {DriveStatusError}
> hda: 1 sectors (0 mb) w/480KiB Cache CHS=1240/255/63
>
> ....
>
> hda : hda : bad access : block 0 count 2
> end request I/O error dev 03:030 (hda) sector 0
>
>
> so i tried parted, this is the response:
> /dev/hda disk label not recognized
> the operating system think the geometry on dev/hda is 0/255/63
>
> and doesn't give me acess to the disk.
>
> same for fdisk:
> it simply prints: impossible to read /dev/hda.
>
> hdparm -iv /dev/hda says:
> multcount	0 off
> i/o_support		0
> unmaskirq	0
> dma_supprt		1
> keepsettings		0
> readahead		8
> readonly		0
> geometry		1240/255/63 sectors 1 start 0
>
> disk samsung v1022d my100
> drive conform to ata-atapi-4
>
>
> so i inserted my redhat sysadmin cd.
> by that (it a kernel 2.4.14) i have access to the disk, fix the label by
> parted, rebuild the partitions but when i reboot with lfs i see
> everything as before.
> simply lfs system has not access to the disk
>
> well i tried to change setting in bios and put CHS=1240/255/63 with same
> results.
>
> ideas?
>
> pacho
> --
> pacho baratta			IT Consultant
> tel. +39 347 078.51.31		www.evolinux.it
> mail: pachox@evolinux.it

