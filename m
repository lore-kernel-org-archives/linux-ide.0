From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA ATAPI work in progress
Date: Sat, 15 May 2004 12:32:56 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A64638.9060202@pobox.com>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com><108455  	9	000.4017.52.camel@patibmrh9>  <40A51604.8070208@pobox.com><1084578453.5 3	4	 3.	26.camel@patibmrh9><1084579362.3271.5.camel@patibmrh9> <40A5669B.608 	010	8@pobox.com><1084626376.3079.8.camel@patibmrh9> <1084628978.5082.7.ca m	el@patibmrh9><40A636D2.3090205@pobox.com>  <1084636180.3083.17.camel@patibm	rh9><1084636590.3083.25.camel@patibmrh9> <1084637040.3440.5.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59549 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264682AbUEOQdI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 12:33:08 -0400
In-Reply-To: <1084637040.3440.5.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
> kernel: ata_scsi_translate: ENTER
> kernel: ata2(0): empty request buffer
> kernel: ata_scsi_badcmd: ENTER
> kernel: ata_scsi_translate: EXIT - badcmd

TEST UNIT READY.  We probably just delete the following check, which 
appears to be bogus now.  I can't remember why I put this in here...

         if (unlikely(cmd->request_bufflen < 1)) {
                 printk(KERN_WARNING "ata%u(%u): empty request buffer\n",
                        ap->id, dev->devno);
                 goto err_out;
         }


> kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 2a 00 00 00 00 00 80
> kernel: ata_scsi_translate: ENTER
> kernel: ata_sg_setup_one: mapped buffer of 128 bytes for read
> kernel: ata_fill_sg: PRD[0] = (0x46EE00, 0x80)
> kernel: ata_dev_select: ENTER, ata2: device 0, wait 1
> kernel: ata_tf_load_pio: feat 0x5 nsect 0x0 lba 0x0 0x0 0x0
> kernel: ata_tf_load_pio: device 0xA0
> kernel: ata_exec_command_pio: ata2: cmd 0xA0
> kernel: ata_scsi_translate: EXIT
> kernel: atapi_packet_task: busy wait
> kernel: atapi_packet_task: send cdb
> kernel: ata_host_intr: BUS_DMA (host_stat 0x25)
> kernel: ata_dma_complete: ENTER
> kernel: ata_dma_complete: host 2, host_stat==0x25, drv_stat==0x51

MODE SENSE 10.

We see from drv_stat==0x51 that the device is signalling 'CHECK 
CONDITION', so we need to issue a REQUEST SENSE at this point.

Seems like we are pretty close.  Once I add the code to issue a REQUEST 
SENSE, I bet things start working.

	Jeff



