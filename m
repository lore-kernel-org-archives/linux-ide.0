From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: Current qc_defer implementation may lead to infinite recursion
Date: Tue, 12 Feb 2008 09:57:58 +0100
Message-ID: <877iha3621.fsf@denkblock.local>
References: <87ir0w4rzo.fsf@denkblock.local> <47AFD7C1.7070204@gmail.com>
	<871w7k9b8y.fsf@denkblock.local> <47B00AA1.3010104@gmail.com>
	<87r6fj2lsx.fsf@denkblock.local> <47B0F2E0.9020204@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:37608 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758668AbYBLI6S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Feb 2008 03:58:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

--=-=-=

Tejun Heo <htejun@gmail.com> wrote:
> Elias Oltmanns wrote:
>> +static int piix_qc_defer(struct ata_queued_cmd *qc)
>> +{
>> +	static struct ata_port *ap = NULL;
>> +	struct ata_queued_cmd qcmd[ATA_MAX_QUEUE];
>
> missing static?

Oh well, I must have been too tired already yesterday. There are a few
more things I got wrong last time. Please see the new patch at the end
of this email.

This time I applied the patch to 2.6.24.1 and performed a

# cat large-file > /dev/null &
# tail -f /var/log/kern.log

and aborted once the output of dump_stack() had occurred. This proves
that piix_qc_defer() has declined the same command 100 times in
succession. However, this will only happen if the status of all the
commands enqueued for one port hasn't changed in the meantime. This
suggests to me that the threads scheduled for command execution and
completion aren't served for some reason. Any ideas?

The foot print of piix_qc_defer() in my log files looks like this, by
the way:

Feb 12 08:53:42 denkblock kernel: piix_qc_defer(): saved current state
Feb 12 08:53:42 denkblock kernel: Pid: 31, comm: kblockd/0 Not tainted 2.6.24.1-dbg-1 #1
Feb 12 08:53:42 denkblock kernel:  [<e0042116>] piix_qc_defer+0xac/0xeb [ata_piix]
Feb 12 08:53:42 denkblock kernel:  [<e008c4e4>] ata_scsi_translate+0xd6/0x10a [libata]
Feb 12 08:53:42 denkblock kernel:  [<e008af20>] ata_build_rw_tf+0x175/0x242 [libata]
Feb 12 08:53:42 denkblock kernel:  [<e006734e>] scsi_done+0x0/0x16 [scsi_mod]
Feb 12 08:53:42 denkblock kernel:  [<e008eb8f>] ata_scsi_queuecmd+0x17f/0x184 [libata]
Feb 12 08:53:42 denkblock kernel:  [<e008c20a>] ata_scsi_rw_xlat+0x0/0x1de [libata]
Feb 12 08:53:42 denkblock kernel:  [<e0067aa8>] scsi_dispatch_cmd+0x197/0x20b [scsi_mod]
Feb 12 08:53:42 denkblock kernel:  [<e006cb33>] scsi_request_fn+0x256/0x2d7 [scsi_mod]
Feb 12 08:53:42 denkblock kernel:  [<e0042136>] piix_qc_defer+0xcc/0xeb [ata_piix]
Feb 12 08:53:42 denkblock kernel:  [<c01961d3>] blk_run_queue+0x2a/0x4b
Feb 12 08:53:42 denkblock kernel:  [<e006bea2>] scsi_queue_insert+0x84/0x8e [scsi_mod]
Feb 12 08:53:42 denkblock kernel:  [<e006a70d>] scsi_delete_timer+0xf/0x50 [scsi_mod]
Feb 12 08:53:42 denkblock kernel:  [<e0067adc>] scsi_dispatch_cmd+0x1cb/0x20b [scsi_mod]
Feb 12 08:53:42 denkblock kernel:  [<e006cb33>] scsi_request_fn+0x256/0x2d7 [scsi_mod]
Feb 12 08:53:42 denkblock kernel:  [<c0195289>] blk_remove_plug+0x4e/0x5a
Feb 12 08:53:42 denkblock kernel:  [<c01934c2>] blk_unplug_work+0x0/0xc
Feb 12 08:53:42 denkblock kernel:  [<c01952b2>] __generic_unplug_device+0x1d/0x1f
Feb 12 08:53:42 denkblock kernel:  [<c0195c07>] generic_unplug_device+0x6/0x8
Feb 12 08:53:42 denkblock kernel:  [<c01934cd>] blk_unplug_work+0xb/0xc
Feb 12 08:53:42 denkblock kernel:  [<c0122943>] run_workqueue+0x6b/0xdf
Feb 12 08:53:42 denkblock kernel:  [<c024dcd2>] schedule+0x1f3/0x20d
Feb 12 08:53:42 denkblock kernel:  [<c0122f37>] worker_thread+0x0/0xbd
Feb 12 08:53:42 denkblock kernel:  [<c0122fe9>] worker_thread+0xb2/0xbd
Feb 12 08:53:42 denkblock kernel:  [<c0125429>] autoremove_wake_function+0x0/0x35
Feb 12 08:53:42 denkblock kernel:  [<c01252d2>] kthread+0x36/0x5c
Feb 12 08:53:42 denkblock kernel:  [<c012529c>] kthread+0x0/0x5c
Feb 12 08:53:42 denkblock kernel:  [<c0104733>] kernel_thread_helper+0x7/0x10
Feb 12 08:53:42 denkblock kernel:  =======================

Regards,

Elias


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=test-qc_defer.patch

---

 drivers/ata/ata_piix.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index b406b39..c987462 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -167,6 +167,7 @@ static void piix_set_dmamode(struct ata_
 static void ich_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static int ich_pata_cable_detect(struct ata_port *ap);
 static u8 piix_vmw_bmdma_status(struct ata_port *ap);
+static int piix_qc_defer(struct ata_queued_cmd *qc);
 #ifdef CONFIG_PM
 static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 static int piix_pci_device_resume(struct pci_dev *pdev);
@@ -311,6 +312,7 @@ static const struct ata_port_operations 
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
+	.qc_defer		= piix_qc_defer,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
@@ -343,6 +345,7 @@ static const struct ata_port_operations 
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
+	.qc_defer		= piix_qc_defer,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
@@ -371,6 +374,7 @@ static const struct ata_port_operations 
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
+	.qc_defer		= piix_qc_defer,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
@@ -402,6 +406,7 @@ static const struct ata_port_operations 
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= piix_vmw_bmdma_status,
+	.qc_defer		= piix_qc_defer,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
@@ -419,6 +424,43 @@ static const struct ata_port_operations 
 	.port_start		= ata_port_start,
 };
 
+static int piix_qc_defer(struct ata_queued_cmd *qc)
+{
+	static struct ata_port *ap = NULL;
+	static struct ata_queued_cmd qcmd[ATA_MAX_QUEUE];
+	static int count = 0;
+#define PIIX_QC_DEFER_THRESHOLD 5000
+
+	if (!ap)
+		ap = qc->ap;
+	else if (ap != qc->ap)
+		return 0;
+
+	if (count > PIIX_QC_DEFER_THRESHOLD + 100)
+		return 0;
+
+	count++;
+	if (count < PIIX_QC_DEFER_THRESHOLD)
+		return 0;
+	else if (count == PIIX_QC_DEFER_THRESHOLD) {
+		int i;
+		if (ap->qc_allocated) {
+			for (i = 0; i < ATA_MAX_QUEUE; i++)
+				qcmd[i] = ap->qcmd[i];
+			printk(KERN_DEBUG "piix_qc_defer(): saved current state\n");
+			return ATA_DEFER_LINK;
+		} else
+			count--;
+	} else if (count == PIIX_QC_DEFER_THRESHOLD + 100) {
+		dump_stack();
+		count++;
+	} else if (!memcmp(qcmd, ap->qcmd, sizeof(qcmd[0]) * ATA_MAX_QUEUE))
+		return ATA_DEFER_LINK;
+	else
+		count = 0;
+	return 0;
+}
+
 static const struct piix_map_db ich5_map_db = {
 	.mask = 0x7,
 	.port_enable = 0x3,

--=-=-=--
