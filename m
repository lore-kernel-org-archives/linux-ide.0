From: "Mat Loikkanen" <Mat.Loikkanen@synopsys.com>
Subject: scsi error -> hang
Date: Thu, 27 Jan 2005 10:07:26 -0800
Message-ID: <007901c5049b$0eedbab0$5015040a@internal.synopsys.com>
Reply-To: <Mat.Loikkanen@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from us01smtp2.synopsys.com ([198.182.44.80]:38299 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S262684AbVA0SH2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Jan 2005 13:07:28 -0500
Received: from maiden.synopsys.com (maiden.synopsys.com [146.225.100.170])
	by kiruna.synopsys.com (Postfix) with ESMTP id 3E02CF96B
	for <linux-ide@vger.kernel.org>; Thu, 27 Jan 2005 10:07:26 -0800 (PST)
Received: from us03-mail-2.synopsys.com (localhost [127.0.0.1])
	by maiden.synopsys.com (8.9.1/8.9.1) with ESMTP id KAA11965
	for <linux-ide@vger.kernel.org>; Thu, 27 Jan 2005 10:07:27 -0800 (PST)
Received: from us03-mail-2.synopsys.com (localhost [127.0.0.1])
	by us03-mail-2.synopsys.com (Postfix) with ESMTP id CF82E611
	for <linux-ide@vger.kernel.org>; Thu, 27 Jan 2005 10:07:26 -0800 (PST)
Received: from loikd600 (unknown [10.4.21.80])
	by us03-mail-2.synopsys.com (Postfix) with ESMTP id A97F253A
	for <linux-ide@vger.kernel.org>; Thu, 27 Jan 2005 10:07:26 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm trying to track down why Libata/SCSI is hanging after an error -- in
this case a result from a ATAPI device to a "test unit ready" packet cmd.
The sequence of events are as follows (HSATA is my driver).  My ISR gets
called when the error (status=0x51/error=0x64) is received by my host
controller;  my ISR ends up calling qc_complete.  An error is reported by
the scsi error handler kernel thread.  I'm using 2.6.9

ata_scsi_queuecmd
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsi_translate
atapi_xlat
HSATA : <6>hsata_qc_prep: not doing DMA - exiting
ata_qc_issue_prot: ATA_PROT_ATAPI_NODATA
ata_tf_load_mmio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
ata_tf_load_mmio: device 0xA0
ata_exec_command_mmio: ata1: cmd 0xA0        <<ATAPI PACKET cmd>>
ata_scsi_translate: EXIT
atapi_packet_task: ENTER
atapi_packet_task: send cdb                  <<"test unit ready" (0x00)
cmd>>
HSATA : hsata_isr: <3>STATUS ERROR (0x51)
HSATA : hsata_isr: <3>ERROR REG = 0x64
HSATA : <6>hsata_isr: INTERRUPT ISR NODATA irq=21
ata_qc_complete   <<called as result of interrupt>>
HSATA : <4>hsata_scsi_error WARNING: uid=1 tid=-1
ata_scsi_error: ENTER                       <<.eh_strategy_handler>>
HSATA : <4>hsata_eng_timeout WARNING: id=1 magic=13
HSATA : <3>hsata_eng_timeout ERROR: ata1: BUG: timeout without command,
exiting
ata_scsi_error: EXIT

Any ideas to point me in the right direction?  I saw another thread on scsi
errors and hanging and decrementing ->host_failed in ata_scsi_error(), which
my version of libata-scsi does.

Thanks!

-mat
 
Mat Loikkanen
Synopsys, Inc.

