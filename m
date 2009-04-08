From: Dustin Harrison <d.harrison@sutus.com>
Subject: Re: [PATCH 2/2] sata_sil: disable DMA engine in ->freeze
Date: Wed, 08 Apr 2009 12:37:18 -0700
Message-ID: <49DCFCEE.7040000@sutus.com>
References: <20090407232247.GA16086@havoc.gtf.org>	 <20090407232331.GA16190@havoc.gtf.org> <3fb94e50904072213n637525b1w4b032544dcef3618@mail.gmail.com> <49DC3357.3030703@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from office.office.sutus.com ([216.18.10.60]:56666 "EHLO
	office.sutuscentral.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933196AbZDHThW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Apr 2009 15:37:22 -0400
In-Reply-To: <49DC3357.3030703@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Sagar Borikar <sagar.borikar@gmail.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Jeff Garzik wrote:
> Sagar Borikar wrote:
>> This patch works for our platform.
>
> Did you try both patches together?  Both are required for the solution.
>
Thanks for updating the patch Jeff.  I see you spotted the reason why I 
didn't put the code into sil_freeze.  I tested your patch and it 
prevented the kernel panic.  I now get the following output, which seems 
to be correct to me.

WARNING: at drivers/ata/libata-core.c:5209 ata_qc_complete()
Call Trace:
[<80107ed0>] dump_stack+0x8/0x34
[<802f92e0>] ata_qc_complete+0x58/0x114
[<80303aec>] ata_port_abort+0xc4/0x104
[<80306870>] sil_interrupt+0x340/0x384
[<80146cc0>] handle_IRQ_event+0x54/0xb8
[<80146dc0>] __do_IRQ+0x9c/0x11c
[<80102670>] ll_sutuspci_irq+0xe8/0x158
[<8010161c>] do_extended_irq+0xa0/0x104
[<80102b94>] ret_from_irq+0x0/0x4
[<8029c4fc>] both_aligned+0x1c/0x64
[<8014a9a4>] file_read_actor+0xac/0x154
[<8014a564>] do_generic_mapping_read+0x210/0x5a4
[<8014ce98>] generic_file_aio_read+0x180/0x1d4
[<8016cba4>] do_sync_read+0xc4/0x128
[<8016ccbc>] vfs_read+0xb4/0x154
[<8016d02c>] sys_read+0x54/0x98
[<8010a620>] stack_done+0x20/0x3c

ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0x2 frozen
ata1.00: cmd c8/00:f8:08:e3:06/00:00:00:00:00/e0 tag 0 cdb 0x0 data 
126976 in
         res d0/d0:d0:d0:d0:d0/00:00:00:00:00/d0 Emask 0x12 (ATA bus error)
ata1: hard resetting port
ata1: SATA link down (SStatus 0 SControl 310)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link down (SStatus 0 SControl 310)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link down (SStatus 0 SControl 310)
ata1.00: disabled
sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x08
sd 0:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 47 00 00 00 00 0c 00 0a 80 00 00 00 00 00
        00 d0 d0 d0
sd 0:0:0:0: [sda] ASC=0x47 ASCQ=0x0
end_request: I/O error, dev sda, sector 451336
Buffer I/O error on device sda, logical block 56417
Buffer I/O error on device sda, logical block 56418
Buffer I/O error on device sda, logical block 56419
Buffer I/O error on device sda, logical block 56420
Buffer I/O error on device sda, logical block 56421
Buffer I/O error on device sda, logical block 56422
Buffer I/O error on device sda, logical block 56423
Buffer I/O error on device sda, logical block 56424
Buffer I/O error on device sda, logical block 56425
Buffer I/O error on device sda, logical block 56426
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: [sda] Result: hostbyte=0x01 driverbyte=0x00
end_request: I/O error, dev sda, sector 451584
ata1: EH complete
ata1.00: detaching (SCSI 0:0:0:0)
dd: /dev/sda: Input/output error
# sd 0:0:0:0: [sda] Synchronizing SCSI cache
sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
sd 0:0:0:0: [sda] Stopping disk
sd 0:0:0:0: [sda] START_STOP FAILED
sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00

