From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata atapi work #2.1
Date: 18 May 2004 15:10:07 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084914607.3421.10.camel@patibmrh9>
References: <1084721991.3085.6.camel@patibmrh9> <40A7F757.9020200@pobox.com>
	<1084805767.3083.10.camel@patibmrh9>  <1084844914.3211.182.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:7849 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S263592AbUERVK2
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 May 2004 17:10:28 -0400
In-Reply-To: <1084844914.3211.182.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

> > > on the SCSI end of ATAPI ...
> > > * issue REQUEST SENSE, to simulate an
> > > auto-sensing scsi device
> > ...
> > I will have to discover how to auto sense only after a plain failure,
> > not inappropriately after a timeout.

Is the following patch a miniscule step forward?

I guess it is because, in -bk5, same as before, I see the lack of auto
sense forces me to reboot before again I may modprobe:

kernel: atapi_packet_task: send cdb
kernel: ata_host_intr: BUS_NODATA (drv_stat 0x51)
kernel: atapi_autosense: FIXME: auto sense up to 0x12 of 0x60 @ 0xD2B33140
kernel: ata_scsi_error: ENTER
kernel: ata_eng_timeout: ENTER
/sbin/hotplug: no runnable /etc/hotplug/scsi_generic.agent is installed
kernel: ata2: BUG: timeout without command
kernel: ata_eng_timeout: EXIT
kernel: ata_scsi_error: EXIT
kernel: irq 18: nobody cared!
kernel:  [<c01081d7>] __report_bad_irq+0x2a/0x8b
...
kernel:
kernel: handlers:
kernel: [<df96750f>] (ata_interrupt+0x0/0x1b9 [libata])
kernel: Disabling IRQ #18

The "atapi_autosense: FIXME" message is new, it comes from this patch,
at I hope the right time.

In my newbie ignorance, at first I tried auto sensing in ata_scsi_error,
but the ata_qc_from_tag was null by then.

Next, the "irq 18: nobody cared!" provoked me to confirm that
ata_host_intr sees qc->tf.protocol = 5 = ATA_PROT_ATAPI (not
ATA_PROT_ATAPI_DMA) presumably because (cmd->sc_data_direction ==
SCSI_DATA_NONE).

Now I ask:

"Is the following patch a miniscule step forward?"

Pat LaVarre

diff -Nurp linux-2.6.6-bk5/drivers/scsi/libata-core.c linux-2.6.6-bk5-pel/drivers/scsi/libata-core.c
--- linux-2.6.6-bk5/drivers/scsi/libata-core.c	2004-05-18 14:20:05.000000000 -0600
+++ linux-2.6.6-bk5-pel/drivers/scsi/libata-core.c	2004-05-18 14:40:01.000000000 -0600
@@ -2299,6 +2299,28 @@ struct ata_queued_cmd *ata_qc_new_init(s
 }
 
 /**
+ *	atapi_autosense -
+ *	@qc:
+ *	@drv_stat:
+ *	@cmd:
+ *
+ *	LOCKING:
+ *
+ */
+
+void atapi_autosense(struct ata_queued_cmd *qc, u8 drv_stat,
+		   struct scsi_cmnd *cmd)
+{
+	cmd->result = SAM_STAT_CHECK_CONDITION;
+	if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
+		return;
+	}
+	DPRINTK("FIXME: auto sense up to 0x12 of 0x%X @ 0x%X\n",
+		(int) sizeof cmd->sense_buffer,
+		(int) &cmd->sense_buffer[0]);
+}
+
+/**
  *	ata_qc_complete -
  *	@qc:
  *	@drv_stat:
@@ -2322,7 +2344,7 @@ void ata_qc_complete(struct ata_queued_c
 	if (cmd) {
 		if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ))) {
 			if (is_atapi_taskfile(&qc->tf))
-				cmd->result = SAM_STAT_CHECK_CONDITION;
+				atapi_autosense(qc, drv_stat, cmd);
 			else
 				ata_to_sense_error(qc);
 		} else {


