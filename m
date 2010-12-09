From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: issue DIPM enable commands
 with LPM state updated
Date: Thu, 09 Dec 2010 16:13:15 +0100
Message-ID: <4D00F20B.2080908@kernel.org>
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
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Kyle McMartin <kyle@mcmartin.ca>
Cc: stable <stable@kernel.org>
List-Id: linux-ide@vger.kernel.org

Low level drivers may behave differently depending on the current
link->lpm_policy.  During ata_eh_set_lpm(), DIPM enable commands are
issued after the successful completion of ap->ops->set_lpm(), which
means that the controller is already in the target state.  This causes
DIPM enable commands to be processed with mismatching controller power
state and link->lpm_policy value.

In ahci, link->lpm_policy is used to ignore certain PHY events if LPM
is enabled; however, as DIPM commands are issued with stale
link->lpm_policy, they sometimes end up triggering these conditions
and get aborted leading to LPM configuration failure.

Fix it by updating link->lpm_policy before issuing DIPM enable
commands.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Kyle McMartin <kyle@mcmartin.ca>
Cc: stable@kernel.org
---
 drivers/ata/libata-eh.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 5e59050..17a6378 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3275,6 +3275,7 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	struct ata_port *ap = ata_is_host_link(link) ? link->ap : NULL;
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_device *dev, *link_dev = NULL, *lpm_dev = NULL;
+	enum ata_lpm_policy old_policy = link->lpm_policy;
 	unsigned int hints = ATA_LPM_EMPTY | ATA_LPM_HIPM;
 	unsigned int err_mask;
 	int rc;
@@ -3338,6 +3339,14 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		goto fail;
 	}

+	/*
+	 * Low level driver acked the transition.  Issue DIPM command
+	 * with the new policy set.
+	 */
+	link->lpm_policy = policy;
+	if (ap && ap->slave_link)
+		ap->slave_link->lpm_policy = policy;
+
 	/* host config updated, enable DIPM if transitioning to MIN_POWER */
 	ata_for_each_dev(dev, link, ENABLED) {
 		if (policy == ATA_LPM_MIN_POWER && ata_id_has_dipm(dev->id)) {
@@ -3353,12 +3362,14 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		}
 	}

-	link->lpm_policy = policy;
-	if (ap && ap->slave_link)
-		ap->slave_link->lpm_policy = policy;
 	return 0;

 fail:
+	/* restore the old policy */
+	link->lpm_policy = old_policy;
+	if (ap && ap->slave_link)
+		ap->slave_link->lpm_policy = old_policy;
+
 	/* if no device or only one more chance is left, disable LPM */
 	if (!dev || ehc->tries[dev->devno] <= 2) {
 		ata_link_printk(link, KERN_WARNING,
