From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] libata/ahci: accommodate tag ordered controllers
Date: Mon, 31 Mar 2014 11:35:14 -0700
Message-ID: <20140331183458.32378.97892.stgit@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Ed Ciechanowski <ed.ciechanowski@intel.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The AHCI spec allows implementations to issue commands in tag order
rather than FIFO order:

	5.3.2.12 P:SelectCmd
	HBA sets pSlotLoc = (pSlotLoc + 1) mod (CAP.NCS + 1)
	or HBA selects the command to issue that has had the
	PxCI bit set to '1' longer than any other command
	pending to be issued.

The result is that commands posted sequentially (time-wise) may play out
of sequence when issued by hardware.

This behavior has likely been hidden by drives that arrange for commands
to complete in issue order.  However, it appears recent drives (two from
different vendors that we have found so far) inflict out-of-order
completions as a matter of course.  So, we need to take care to maintain
ordered submission, otherwise we risk triggering a drive to fall out of
sequential-io automation and back to random-io processing, which incurs
large latency and degrades throughput.

This issue was found in simple benchmarks where QD=2 seq-write
performance was 30-50% *greater* than QD=32 seq-write performance.

Tagging for -stable and making the change globally since it has a low
risk-to-reward ratio.  Also, word is that recent versions of an unnamed
OS also does it this way now.  So, drives in the field are already
experienced with this tag ordering scheme.

Cc: <stable@vger.kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ed Ciechanowski <ed.ciechanowski@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/ata/libata-core.c |   21 +++++++++++++--------
 include/linux/libata.h    |    1 +
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 65d3f1b5966c..705376e42513 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4793,21 +4793,26 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
 static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc = NULL;
-	unsigned int i;
+	unsigned int i, tag;
 
 	/* no command while frozen */
 	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
 		return NULL;
 
-	/* the last tag is reserved for internal command. */
-	for (i = 0; i < ATA_MAX_QUEUE - 1; i++)
-		if (!test_and_set_bit(i, &ap->qc_allocated)) {
-			qc = __ata_qc_from_tag(ap, i);
+	for (i = 0; i < ATA_MAX_QUEUE; i++) {
+		tag = (i + ap->tag_order) & (ATA_MAX_QUEUE - 1);
+
+		/* the last tag is reserved for internal command. */
+		if (tag == ATA_TAG_INTERNAL)
+			continue;
+
+		if (!test_and_set_bit(tag, &ap->qc_allocated)) {
+			qc = __ata_qc_from_tag(ap, tag);
+			qc->tag = tag;
+			ap->tag_order = (tag + 1) & (ATA_MAX_QUEUE - 1);
 			break;
 		}
-
-	if (qc)
-		qc->tag = i;
+	}
 
 	return qc;
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bec6dbe939a0..ed303fa685e5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -822,6 +822,7 @@ struct ata_port {
 	unsigned long		qc_allocated;
 	unsigned int		qc_active;
 	int			nr_active_links; /* #links with active qcs */
+	unsigned int		tag_order;	/* next tag hw expects */
 
 	struct ata_link		link;		/* host default link */
 	struct ata_link		*slave_link;	/* see ata_slave_link_init() */
