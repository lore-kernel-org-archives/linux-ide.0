From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: Thu, 20 May 2004 19:58:55 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <6AC5FDFB-AACA-11D8-8B8A-003065635034@ieee.org>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
	 <1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482
	 8		840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com><1084831524.3
	2 11	.67.camel@patibmrh9>  <40A93E85.4010904@pobox.com> <1084920024.3191.8.
	ca mel@patibmrh9> <40AAA0BA.9040307@pobox.com> <8A55CC7D-A9E7-11D8-B31E-003
	065635034@ieee.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:11936 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265346AbUEUB7A
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 May 2004 21:59:00 -0400
In-Reply-To: <8A55CC7D-A9E7-11D8-B31E-003065635034@ieee.org>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> This actually almost does work.  Once via ssh I saw ...

Yes we can auto sense at least once per boot.

The extra ata_scsi_translate dmesg comes from a trivial recursion trap 
I added there, this time around.  The 1 is the depth of recursion, the 
x25 is the opcode given as a parameter.

$ plscsi /dev/sg0 -X time 5 0 -i 8 -x "25 00 00:00:00:00 00 00:00 00" 
-vx 00000000 25 00 00:00:00:00 00 00:00 00 .. .. .. .. .. .. 
"%@@@@@@@@@"
x 00000000 00:00:00:00 00:00:00:00 .. .. .. .. .. .. .. .. "@@@@@@@@"
x 00000000 70:00:06:00 00:00:00:18 00:00:00:00 29:00 .. .. 
"p@F@@@@X@@@@)@"
// x 6 29 sense
// -x0002 = -2 = plscsi.main exit int
$

kernel: piix_init: done
kernel: Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  
type 5
kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
kernel: ata_scsi_translate: ENTER 1 0x25
kernel: ata_scsi_translate: ENTER
kernel: ata_sg_setup_one: mapped buffer of 8 bytes for read
kernel: ata_fill_sg: PRD[0] = (0xD440000, 0x8)
kernel: ata_dev_select: ENTER, ata2: device 0, wait 1
kernel: ata_tf_load_pio: feat 0x5 nsect 0x0 lba 0x0 0x0 0x0
kernel: ata_tf_load_pio: device 0xA0
kernel: ata_exec_command_pio: ata2: cmd 0xA0
kernel: ata_scsi_translate: EXIT
kernel: atapi_packet_task: busy wait
kernel: atapi_packet_task: send cdb
/sbin/hotplug: no runnable /etc/hotplug/scsi_generic.agent is installed
kernel: ata_host_intr: BUS_DMA (host_stat 0x25)
kernel: ata_dma_complete: ENTER
kernel: ata_dma_complete: host 2, host_stat==0x25, drv_stat==0x51
kernel: ata_sg_clean: unmapping 1 sg elements
kernel: ata_scsi_error: ENTER
kernel: ata_eng_timeout: ENTER
kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x60 0x0
kernel: ata_tf_load_pio: device 0xA0
kernel: ata_exec: ata2: cmd 0xA0
kernel: ata_exec_command_pio: ata2: cmd 0xA0
kernel: atapi_error: send cdb
kernel: ata_eng_timeout: EXIT
kernel: ata_scsi_error: EXIT

Pat LaVarre

