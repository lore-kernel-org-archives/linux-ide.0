From: Tony Battersby <tonyb@cybernetics.com>
Subject: [PATCH] libata: revert "libata: use blk taging" et al.
Date: Wed, 11 Mar 2015 14:15:25 -0400
Message-ID: <5500863D.4070807@cybernetics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>, Shaohua Li <shli@fb.com>, linux-ide@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This reverts commits 12cb5ce101abfaf74421f8cc9f196e708209eb79 and
98bd4be1ba95f2fe7f543910792b7163a5de06eb.

Commit 12cb5ce101ab ("libata: use blk taging") causes the following oops
with scsi-mq enabled:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
IP: [<ffffffff804fd46e>] ata_qc_new_init+0x3e/0x120
PGD 32adf0067 PUD 32adf1067 PMD 0 
Oops: 0002 [#1] SMP DEBUG_PAGEALLOC 
Modules linked in: iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi igb
i2c_algo_bit ptp pps_core pm80xx libsas scsi_transport_sas sg coretemp
eeprom w83795 i2c_i801
CPU: 4 PID: 1450 Comm: cydiskbench Not tainted 4.0.0-rc3 #1
Hardware name: Supermicro X8DTH-i/6/iF/6F/X8DTH, BIOS 2.1b       05/04/12  
task: ffff8800ba86d500 ti: ffff88032a064000 task.ti: ffff88032a064000
RIP: 0010:[<ffffffff804fd46e>]  [<ffffffff804fd46e>] ata_qc_new_init+0x3e/0x120
RSP: 0018:ffff88032a067858  EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8800ba0d2230 RCX: 000000000000002a
RDX: ffffffff80505ae0 RSI: 0000000000000020 RDI: ffff8800ba0d2230
RBP: ffff88032a067868 R08: 0000000000000201 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8800ba0d0000
R13: ffff8800ba0d2230 R14: ffffffff80505ae0 R15: ffff8800ba0d0000
FS:  0000000041223950(0063) GS:ffff88033e480000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000058 CR3: 000000032a0a3000 CR4: 00000000000006e0
Stack:
 ffff880329eee758 ffff880329eee758 ffff88032a0678a8 ffffffff80502dad
 ffff8800ba167978 ffff880329eee758 ffff88032bf9c520 ffff8800ba167978
 ffff88032bf9c520 ffff88032bf9a290 ffff88032a0678b8 ffffffff80506909
Call Trace:
 [<ffffffff80502dad>] ata_scsi_translate+0x3d/0x1b0
 [<ffffffff80506909>] ata_sas_queuecmd+0x149/0x2a0
 [<ffffffffa0046650>] sas_queuecommand+0xa0/0x1f0 [libsas]
 [<ffffffff804ea544>] scsi_dispatch_cmd+0xd4/0x1a0
 [<ffffffff804eb50f>] scsi_queue_rq+0x66f/0x7f0
 [<ffffffff803e5098>] __blk_mq_run_hw_queue+0x208/0x3f0
 [<ffffffff803e54b8>] blk_mq_run_hw_queue+0x88/0xc0
 [<ffffffff803e5c74>] blk_mq_insert_request+0xc4/0x130
 [<ffffffff803e0b63>] blk_execute_rq_nowait+0x73/0x160
 [<ffffffffa0023fca>] sg_common_write+0x3da/0x720 [sg]
 [<ffffffff80308b8e>] ? might_fault+0x5e/0xb0
 [<ffffffffa0025100>] sg_new_write+0x250/0x360 [sg]
 [<ffffffff802a236c>] ? __lock_acquire+0x50c/0xc10
 [<ffffffff802a2b87>] ? lock_release_non_nested+0xa7/0x360
 [<ffffffff8068954b>] ? _raw_spin_unlock_irqrestore+0x3b/0x60
 [<ffffffff80308b8e>] ? might_fault+0x5e/0xb0
 [<ffffffff80308b8e>] ? might_fault+0x5e/0xb0
 [<ffffffffa0025feb>] sg_write+0x13b/0x450 [sg]
 [<ffffffff802a236c>] ? __lock_acquire+0x50c/0xc10
 [<ffffffff802cb1e9>] ? do_futex+0x109/0xbf0
 [<ffffffff80308b8e>] ? might_fault+0x5e/0xb0
 [<ffffffff8032ec91>] vfs_write+0xd1/0x1b0
 [<ffffffff8032ee54>] SyS_write+0x54/0xc0
 [<ffffffff80689932>] system_call_fastpath+0x12/0x17
Code: 24 20 04 0f 85 ec 00 00 00 49 83 3c 24 00 0f 84 cf 00 00 00 83 fe 1f
0f 87 dc 00 00 00 89 f0 48 69 c0 f0 00 00 00 49 8d 44 04 40 <89> 70 58 48
c7 40 10 00 00 00 00 4c 89 20 48 89 58 08 c7 40 64 
RIP  [<ffffffff804fd46e>] ata_qc_new_init+0x3e/0x120
 RSP <ffff88032a067858>
CR2: 0000000000000058
---[ end trace 43f5eefb64627eff ]---


scsi-mq uses a host-wide tag map shared among all devices with some
integer tag values >= ATA_MAX_QUEUE.  These unexpectedly high tag values
cause __ata_qc_from_tag() to return NULL, which is then dereferenced in
ata_qc_new_init(), causing the oops above.

Due to conflicts, it is also necessary to revert commit 98bd4be1ba95
("libata: move sas ata tag allocation to libata-scsi.c"), which appears
to have been a follow-on cleanup to the commit that caused the problem.

Fixes: 12cb5ce101ab ("libata: use blk taging")
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---

Note: when reverting the two commits above, I had to fixup conflicts
with the following commit:
72dd299d5039a336493993dcc63413cf31d0e662 ("libata: allow sata_sil24 to
opt-out of tag ordered submission")

If anyone else can suggest a fix that does not involve reverting the
commits, then I would be happy to test.

The oops output was generated using the SCSI generic driver (sg) to send
commands to SATA disks connected to a pm80xx HBA.

Here is the code relevant to the oops:

enum {
	ATA_MAX_QUEUE = 32,
};

static inline unsigned int ata_tag_valid(unsigned int tag)
{
	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
}

static inline struct ata_queued_cmd *__ata_qc_from_tag(struct ata_port *ap,
						       unsigned int tag)
{
	if (likely(ata_tag_valid(tag)))
		return &ap->qcmd[tag];
	return NULL;
}

struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
{
	...
	qc = __ata_qc_from_tag(ap, tag); /* tag >= ATA_MAX_QUEUE */
	qc->tag = tag; /* qc is NULL, OOPS HERE */
	...
}

diff -urpN linux-4.0.0-rc3-a/drivers/ata/libata-core.c linux-4.0.0-rc3-b/drivers/ata/libata-core.c
--- linux-4.0.0-rc3-a/drivers/ata/libata-core.c	2015-03-08 19:09:09.000000000 -0400
+++ linux-4.0.0-rc3-b/drivers/ata/libata-core.c	2015-03-10 14:13:44.000000000 -0400
@@ -1585,6 +1585,8 @@ unsigned ata_exec_internal_sg(struct ata
 	else
 		tag = 0;
 
+	if (test_and_set_bit(tag, &ap->qc_allocated))
+		BUG();
 	qc = __ata_qc_from_tag(ap, tag);
 
 	qc->tag = tag;
@@ -4720,36 +4722,69 @@ void swap_buf_le16(u16 *buf, unsigned in
 }
 
 /**
- *	ata_qc_new_init - Request an available ATA command, and initialize it
- *	@dev: Device from whom we request an available command structure
+ *	ata_qc_new - Request an available ATA command, for queueing
+ *	@ap: target port
+ *
+ *	Some ATA host controllers may implement a queue depth which is less
+ *	than ATA_MAX_QUEUE. So we shouldn't allocate a tag which is beyond
+ *	the hardware limitation.
  *
  *	LOCKING:
  *	None.
  */
 
-struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
+static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 {
-	struct ata_port *ap = dev->link->ap;
-	struct ata_queued_cmd *qc;
+	struct ata_queued_cmd *qc = NULL;
+	unsigned int max_queue = ap->host->n_tags;
+	unsigned int i, tag;
 
 	/* no command while frozen */
 	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
 		return NULL;
 
-	/* libsas case */
-	if (!ap->scsi_host) {
-		tag = ata_sas_allocate_tag(ap);
-		if (tag < 0)
-			return NULL;
+	for (i = 0, tag = ap->last_tag + 1; i < max_queue; i++, tag++) {
+		if (ap->flags & ATA_FLAG_LOWTAG)
+			tag = i;
+		else
+			tag = tag < max_queue ? tag : 0;
+
+		/* the last tag is reserved for internal command. */
+		if (tag == ATA_TAG_INTERNAL)
+			continue;
+
+		if (!test_and_set_bit(tag, &ap->qc_allocated)) {
+			qc = __ata_qc_from_tag(ap, tag);
+			qc->tag = tag;
+			ap->last_tag = tag;
+			break;
+		}
 	}
 
-	qc = __ata_qc_from_tag(ap, tag);
-	qc->tag = tag;
-	qc->scsicmd = NULL;
-	qc->ap = ap;
-	qc->dev = dev;
+	return qc;
+}
 
-	ata_qc_reinit(qc);
+/**
+ *	ata_qc_new_init - Request an available ATA command, and initialize it
+ *	@dev: Device from whom we request an available command structure
+ *
+ *	LOCKING:
+ *	None.
+ */
+
+struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->link->ap;
+	struct ata_queued_cmd *qc;
+
+	qc = ata_qc_new(ap);
+	if (qc) {
+		qc->scsicmd = NULL;
+		qc->ap = ap;
+		qc->dev = dev;
+
+		ata_qc_reinit(qc);
+	}
 
 	return qc;
 }
@@ -4776,8 +4811,7 @@ void ata_qc_free(struct ata_queued_cmd *
 	tag = qc->tag;
 	if (likely(ata_tag_valid(tag))) {
 		qc->tag = ATA_TAG_POISON;
-		if (!ap->scsi_host)
-			ata_sas_free_tag(tag, ap);
+		clear_bit(tag, &ap->qc_allocated);
 	}
 }
 
diff -urpN linux-4.0.0-rc3-a/drivers/ata/libata.h linux-4.0.0-rc3-b/drivers/ata/libata.h
--- linux-4.0.0-rc3-a/drivers/ata/libata.h	2015-03-08 19:09:09.000000000 -0400
+++ linux-4.0.0-rc3-b/drivers/ata/libata.h	2015-03-10 14:12:38.000000000 -0400
@@ -63,7 +63,7 @@ extern struct ata_link *ata_dev_phys_lin
 extern void ata_force_cbl(struct ata_port *ap);
 extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
 extern u64 ata_tf_to_lba48(const struct ata_taskfile *tf);
-extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag);
+extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   u64 block, u32 n_block, unsigned int tf_flags,
 			   unsigned int tag);
@@ -144,8 +144,6 @@ extern void ata_scsi_dev_rescan(struct w
 extern int ata_bus_probe(struct ata_port *ap);
 extern int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 			      unsigned int id, u64 lun);
-int ata_sas_allocate_tag(struct ata_port *ap);
-void ata_sas_free_tag(unsigned int tag, struct ata_port *ap);
 
 
 /* libata-eh.c */
diff -urpN linux-4.0.0-rc3-a/drivers/ata/libata-scsi.c linux-4.0.0-rc3-b/drivers/ata/libata-scsi.c
--- linux-4.0.0-rc3-a/drivers/ata/libata-scsi.c	2015-03-08 19:09:09.000000000 -0400
+++ linux-4.0.0-rc3-b/drivers/ata/libata-scsi.c	2015-03-10 14:12:38.000000000 -0400
@@ -756,7 +756,7 @@ static struct ata_queued_cmd *ata_scsi_q
 {
 	struct ata_queued_cmd *qc;
 
-	qc = ata_qc_new_init(dev, cmd->request->tag);
+	qc = ata_qc_new_init(dev);
 	if (qc) {
 		qc->scsicmd = cmd;
 		qc->scsidone = cmd->scsi_done;
@@ -3668,9 +3668,6 @@ int ata_scsi_add_hosts(struct ata_host *
 		 */
 		shost->max_host_blocked = 1;
 
-		if (scsi_init_shared_tag_map(shost, host->n_tags))
-			goto err_add;
-
 		rc = scsi_add_host_with_dma(ap->scsi_host,
 						&ap->tdev, ap->host->dev);
 		if (rc)
@@ -4233,31 +4230,3 @@ int ata_sas_queuecmd(struct scsi_cmnd *c
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ata_sas_queuecmd);
-
-int ata_sas_allocate_tag(struct ata_port *ap)
-{
-	unsigned int max_queue = ap->host->n_tags;
-	unsigned int i, tag;
-
-	for (i = 0, tag = ap->sas_last_tag + 1; i < max_queue; i++, tag++) {
-		if (ap->flags & ATA_FLAG_LOWTAG)
-			tag = 1;
-		else
-			tag = tag < max_queue ? tag : 0;
-
-		/* the last tag is reserved for internal command. */
-		if (tag == ATA_TAG_INTERNAL)
-			continue;
-
-		if (!test_and_set_bit(tag, &ap->sas_tag_allocated)) {
-			ap->sas_last_tag = tag;
-			return tag;
-		}
-	}
-	return -1;
-}
-
-void ata_sas_free_tag(unsigned int tag, struct ata_port *ap)
-{
-	clear_bit(tag, &ap->sas_tag_allocated);
-}
diff -urpN linux-4.0.0-rc3-a/include/linux/libata.h linux-4.0.0-rc3-b/include/linux/libata.h
--- linux-4.0.0-rc3-a/include/linux/libata.h	2015-03-08 19:09:09.000000000 -0400
+++ linux-4.0.0-rc3-b/include/linux/libata.h	2015-03-10 14:12:38.000000000 -0400
@@ -823,10 +823,10 @@ struct ata_port {
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
 
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
-	unsigned long		sas_tag_allocated; /* for sas tag allocation only */
+	unsigned long		qc_allocated;
 	unsigned int		qc_active;
 	int			nr_active_links; /* #links with active qcs */
-	unsigned int		sas_last_tag;	/* track next tag hw expects */
+	unsigned int		last_tag;	/* track next tag hw expects */
 
 	struct ata_link		link;		/* host default link */
 	struct ata_link		*slave_link;	/* see ata_slave_link_init() */
@@ -1352,7 +1352,6 @@ extern struct device_attribute *ata_comm
 	.ioctl			= ata_scsi_ioctl,		\
 	.queuecommand		= ata_scsi_queuecmd,		\
 	.can_queue		= ATA_DEF_QUEUE,		\
-	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
 	.this_id		= ATA_SHT_THIS_ID,		\
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,		\
 	.emulated		= ATA_SHT_EMULATED,		\
