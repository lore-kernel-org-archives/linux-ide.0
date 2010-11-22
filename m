From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: Why so much PIO for r/w accesses ?
Date: Mon, 22 Nov 2010 14:35:40 +0300
Message-ID: <4CEA558C.6050705@ru.mvista.com>
References: <4CE9ACAA.9060203@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38647 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429Ab0KVLhc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Nov 2010 06:37:32 -0500
Received: by eye27 with SMTP id 27so3747152eye.19
        for <linux-ide@vger.kernel.org>; Mon, 22 Nov 2010 03:37:31 -0800 (PST)
In-Reply-To: <4CE9ACAA.9060203@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Hello.

On 22-11-2010 2:35, Mark Lord wrote:

> While working on something unrelated today,
> I instrumented ata_sff_data_xfer32() to generate a printk() on each invocation.

> Imagine then my complete surprise to see that print() being invoked very
> frequently
> after rebooting with the modified kernel.

> ata_sff_data_xfer32() is for PIO read/writes.. something that I don't expect
> to see.

> This is an ata_piix system, with a pure SATA SSD.

    Most PIO I/O you saw points to an ATAPI device...

> Why are we using PIO so much?
> Or am I simply misunderstanding something basic here.. ?

> Confused.

> ata_sff_data_xfer32: buf=f68015fc:512 (write)
> ata1.00: ATA-8: OCZ-VERTEX, 1.6, max UDMA/133
> ata1.00: 250069680 sectors, multi 1: LBA48 NCQ (depth 0/32)
> ata_sff_data_xfer32: buf=f6801f80:512 (write)
> ata1.00: configured for UDMA/133
> scsi 0:0:0:0: Direct-Access ATA OCZ-VERTEX 1.6 PQ: 0 ANSI: 5
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
> sda:
> sda1 sda2
> sd 0:0:0:0: [sda] Attached SCSI disk
> ata_sff_data_xfer32: buf=f68055fc:512 (write)
> ata2.00: ATAPI: SlimtypeDVD A DS8A1P, CX16, max UDMA/33
> ata_sff_data_xfer32: buf=f6805f80:512 (write)
> ata2.00: configured for UDMA/33
> ata_sff_data_xfer32: buf=f68053a8:12 (read)
> ata_sff_data_xfer32: buf=f68040c4:12 (read)
> ata_sff_data_xfer32: buf=f7088e00:36 (write)

    I think you have your (read)/(write) backwars. 12 bytes is the typical CDB 
length -- and CDB is written, not read. 36 bytes seems to be INQUIRY data 
length -- which is read, not written. 512 bytes then stand for IDENTIFY 
[PACKET] DEVICE data.

> ata_sff_data_xfer32: buf=f68040c4:12 (read)
> scsi 1:0:0:0: CD-ROM Slimtype DVD A DS8A1P CX16 PQ: 0 ANSI: 5
> ata_sff_data_xfer32: buf=f68040c4:12 (read)
> ata_sff_data_xfer32: buf=f68053a8:12 (read)
> ata_sff_data_xfer32: buf=f73b1580:18 (write)

    This seems to be REQUEST SENSE command and (perhaps) TEST UNIT READY 
preceding it...

> ...

    You're seeing so many PIO transfers because libata doesn't use DMA with 
ATAPI transfers which aren't divisible by sector size (this is a hardware 
limitation on many chips).

WBR, Sergei
