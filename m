From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATA ATAPI work in progress
Date: 15 May 2004 10:50:49 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084639849.3286.2.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com><108455  
	9	000.4017.52.camel@patibmrh9>  <40A51604.8070208@pobox.com><1084578453.5 3
		4	 3.	26.camel@patibmrh9><1084579362.3271.5.camel@patibmrh9> <40A5669B.6 0
	8 	010	8@pobox.com><1084626376.3079.8.camel@patibmrh9> <1084628978.5082.7.
	ca m	el@patibmrh9><40A636D2.3090205@pobox.com> <1084636180.3083.17.camel@p
	atibm	rh9><1084636590.3083.25.camel@patibmrh9> <1084637040.3440.5.camel@pat
	 ibmrh9><40A64638.9060202@pobox.com>  <1084639433.3070.5.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:63726 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264704AbUEOQvM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 12:51:12 -0400
In-Reply-To: <1084639433.3070.5.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> Independently I tried omitting that test.  With that test gone, my
> kernel does not crash, but still the open (and thereafter modprobe -r)
> does not complete:
> ...
> kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
> kernel: ata_scsi_translate: ENTER
> kernel: ata_dev_select: ENTER, ata2: device 0, wait 1
> kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
> kernel: ata_tf_load_pio: device 0xA0
> kernel: ata_exec_command_pio: ata2: cmd 0xA0
> kernel: ata_scsi_translate: EXIT
> kernel: atapi_packet_task: busy wait
> kernel: atapi_packet_task: send cdb
> 
> In my ignorance, I'm now trying ...

Sorry to say, as is exactly correct, when dying this way in atapi_xlate
I see:

cmd->sc_data_direction = 3 SCSI_DATA_NONE

cmd->request_bufflen = 0

> Soon I will give up for this day,
> sorry to say, real life intrudes.

See you later,

Pat LaVarre


