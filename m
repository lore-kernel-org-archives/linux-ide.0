From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATA ATAPI work in progress
Date: 15 May 2004 10:04:00 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084637040.3440.5.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com><108455  
	9	000.4017.52.camel@patibmrh9>  <40A51604.8070208@pobox.com><1084578453.5 3
	4	 3.	26.camel@patibmrh9><1084579362.3271.5.camel@patibmrh9> <40A5669B.608
	010	8@pobox.com><1084626376.3079.8.camel@patibmrh9> <1084628978.5082.7.ca m
	el@patibmrh9><40A636D2.3090205@pobox.com>  <1084636180.3083.17.camel@patibm
	rh9><1084636590.3083.25.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:61417 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S262132AbUEOQEY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 12:04:24 -0400
In-Reply-To: <1084636590.3083.25.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> 2) open O_NONBLOCK ioctl SG_IO
> 
> I tried `plscsi /dev/scd0` i.e. an open O_NONBLOCK/ ioctl SG_IO/ close
> of a standard op x12 Inquiry for up to x24 bytes.
> 
> That died in a way that defeated Ctrl+C and `modprobe -r ata-piix`,
> though `reboot` worked.  I'll try ioctl CDROM_SEND_PACKET next, then
> think harder.

ioctl CDROM_SEND_PACKET via sf net iomrrdtools gives me same death as
ioctl SG_IO, so I blame the open of /dev/scd$n til I hear otherwise.

Death occurs as follows.  Next I will grep source for "empty request
buffer".

Pat LaVarre

kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
kernel: ata_scsi_translate: ENTER
kernel: ata2(0): empty request buffer
kernel: ata_scsi_badcmd: ENTER
kernel: ata_scsi_translate: EXIT - badcmd
kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
kernel: ata_scsi_translate: ENTER
kernel: ata2(0): empty request buffer
kernel: ata_scsi_badcmd: ENTER
kernel: ata_scsi_translate: EXIT - badcmd
kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
kernel: ata_scsi_translate: ENTER
kernel: ata2(0): empty request buffer
kernel: ata_scsi_badcmd: ENTER
kernel: ata_scsi_translate: EXIT - badcmd
kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
kernel: ata_scsi_translate: ENTER
kernel: ata2(0): empty request buffer
kernel: ata_scsi_badcmd: ENTER
kernel: ata_scsi_translate: EXIT - badcmd
kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
kernel: ata_scsi_translate: ENTER
kernel: ata2(0): empty request buffer
kernel: ata_scsi_badcmd: ENTER
kernel: ata_scsi_translate: EXIT - badcmd
kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 2a 00 00 00 00 00 80
kernel: ata_scsi_translate: ENTER
kernel: ata_sg_setup_one: mapped buffer of 128 bytes for read
kernel: ata_fill_sg: PRD[0] = (0x46EE00, 0x80)
kernel: ata_dev_select: ENTER, ata2: device 0, wait 1
kernel: ata_tf_load_pio: feat 0x5 nsect 0x0 lba 0x0 0x0 0x0
kernel: ata_tf_load_pio: device 0xA0
kernel: ata_exec_command_pio: ata2: cmd 0xA0
kernel: ata_scsi_translate: EXIT
kernel: atapi_packet_task: busy wait
kernel: atapi_packet_task: send cdb
kernel: ata_host_intr: BUS_DMA (host_stat 0x25)
kernel: ata_dma_complete: ENTER
kernel: ata_dma_complete: host 2, host_stat==0x25, drv_stat==0x51
kernel: ata_sg_clean: unmapping 1 sg elements
kernel: ata_scsi_error: ENTER
kernel: ata_eng_timeout: ENTER
kernel: ata2: BUG: timeout without command
kernel: ata_eng_timeout: EXIT
kernel: ata_scsi_error: EXIT


