From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATA ATAPI work in progress
Date: 14 May 2004 17:47:33 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084578453.5343.26.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com><108455 9
	000.4017.52.camel@patibmrh9>  <40A51604.8070208@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:26240 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264571AbUENXr6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 19:47:58 -0400
In-Reply-To: <40A51604.8070208@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Applying patch.[12345] in order to linux-2.6.6-bk1/ here yielded:

kernel: ata_scsi_dump_cdb: CDB (1:1,15,0) 12 00 00 00 24 00 00 00 46
kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 24 00 00 00 46
kernel: ata_scsi_translate: ENTER
kernel: ata_sg_setup_one: mapped buffer of 36 bytes for read
kernel: ata_fill_sg: PRD[0] = (0x469E54, 0x24)
kernel: ata_dev_select: ENTER, ata2: device 0, wait 1
kernel: ata_tf_load_pio: feat 0x1 nsect 0x0 lba 0x0 0x0 0x0
kernel: ata_tf_load_pio: device 0xA0
kernel: ata_exec_command_pio: ata2: cmd 0xA0
kernel: ata_scsi_translate: EXIT
kernel: atapi_packet_task: busy wait
kernel: atapi_packet_task: send cdb
kernel: ata_scsi_error: ENTER
kernel: ata_eng_timeout: ENTER
kernel: ata2: unknown timeout, cmd 0xa0 stat 0xd0
kernel: ata_sg_clean: unmapping 1 sg elements
kernel: ata_eng_timeout: EXIT
kernel: ata_scsi_error: EXIT
kernel: ata_scsi_dump_cdb: CDB (2:0,1,0) 12 00 00 00 24 00 00 00 46

We now get only one ata_exec_command_pio, good.

Next I will try o x1F1 Features = x05 Dma In and x01 Dma Out because:

> Subject: Re: SATA ATAPI UDMA - first in Linux
> ...
> Silicon Image has introduced an addition to ATA called the "DMADIR" bit. 
>   Their bridges require this bit in order to use DMA.
> 
> If your OS driver does not know about DMADIR (read: most OS drivers), 
> then it will fall back _unconditionally_ to PIO.

http://www.google.com/search?q=silicon+image+dmadir
yields the proposal:

Packet DMA Issue ...
http://www.t13.org/docs2003/e03132r3.pdf

Seemingly impractical on various grounds, such as requiring different
device firmware for an old or new host, but including the detail:

---

Features ... [x04] DMADIR

...

Support for this bit is determined by reading bit 15 of word 62 in the
device configuration data.

If bit 15 of word 62 is set to 1, the device requires the use of the
DMADIR bit for Packet DMA commands.

If the device requires the DMADIR bit to be set for Packet DMA
operations and the current operations is DMA (i.e. bit 0, the DMA bit,
is set), this bit indicates the direction of data transfer (0 = transfer
to the device; 1 = transfer to the host). 

---

Pat LaVarre


