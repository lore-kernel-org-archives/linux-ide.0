From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: no special completion
 processing for EH commands
Date: Thu, 09 Dec 2010 15:59:32 +0100
Message-ID: <4D00EED4.3020901@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <stable-bounces@linux.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Kyle McMartin <kyle@mcmartin.ca>
Cc: stable@kernel.org
List-Id: linux-ide@vger.kernel.org

ata_qc_complete() contains special handling for certain commands.  For
example, it schedules EH for device revalidation after certain
configurations are changed.  These shouldn't be applied to EH
commands but they were.

In most cases, it doesn't cause an actual problem because EH doesn't
issue any command which would trigger special handling; however, ACPI
can issue such commands via _GTF which can cause weird interactions.

Restructure ata_qc_complete() such that EH commands are always passed
on to __ata_qc_complete().

stable: Please apply to -stable only after 2.6.38 is released.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Kyle McMartin <kyle@mcmartin.ca>
Cc: stable@kernel.org
---
 drivers/ata/libata-core.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 7f77c67..f23d6d4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4807,9 +4807,6 @@ static void ata_verify_xfer(struct ata_queued_cmd *qc)
 {
 	struct ata_device *dev = qc->dev;

-	if (ata_tag_internal(qc->tag))
-		return;
-
 	if (ata_is_nodata(qc->tf.protocol))
 		return;

@@ -4858,14 +4855,23 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 		if (unlikely(qc->err_mask))
 			qc->flags |= ATA_QCFLAG_FAILED;

-		if (unlikely(qc->flags & ATA_QCFLAG_FAILED)) {
-			/* always fill result TF for failed qc */
+		/*
+		 * Finish internal commands without any further processing
+		 * and always with the result TF filled.
+		 */
+		if (unlikely(ata_tag_internal(qc->tag))) {
 			fill_result_tf(qc);
+			__ata_qc_complete(qc);
+			return;
+		}

-			if (!ata_tag_internal(qc->tag))
-				ata_qc_schedule_eh(qc);
-			else
-				__ata_qc_complete(qc);
+		/*
+		 * Non-internal qc has failed.  Fill the result TF and
+		 * summon EH.
+		 */
+		if (unlikely(qc->flags & ATA_QCFLAG_FAILED)) {
+			fill_result_tf(qc);
+			ata_qc_schedule_eh(qc);
 			return;
 		}
