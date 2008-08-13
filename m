From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: implement no[hs]rst force params
Date: Wed, 13 Aug 2008 20:19:09 +0900
Message-ID: <48A2C32D.1090000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36415 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905AbYHMLVE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Aug 2008 07:21:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux@sun7.cn

Implement force params nohrst, nosrst and norst.  This is to work
around reset related problems and ease debugging.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Dino Wu, specifying libata.force=nohrst will work around the problem
till the problem is properly fixed.

Thanks.

 Documentation/kernel-parameters.txt |    3 ++
 drivers/ata/libata-core.c           |   46 +++++++++++++++++++++++-------------
 drivers/ata/libata-eh.c             |    4 +++
 include/linux/libata.h              |    1 
 4 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index b52f47d..4e45516 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1015,6 +1015,9 @@ and is between 256 and 4096 characters. It is defined in the file
 
 			* [no]ncq: Turn on or off NCQ.
 
+			* nohrst, nosrst, norst: suppress hard, soft
+                          and both resets.
+
 			If there are multiple matching configurations changing
 			the same attribute, the last one is used.
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9bef1a8..8f39788 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -104,6 +104,7 @@ struct ata_force_param {
 	unsigned long	xfer_mask;
 	unsigned int	horkage_on;
 	unsigned int	horkage_off;
+	unsigned int	lflags;
 };
 
 struct ata_force_ent {
@@ -196,22 +197,23 @@ void ata_force_cbl(struct ata_port *ap)
 }
 
 /**
- *	ata_force_spd_limit - force SATA spd limit according to libata.force
+ *	ata_force_link_limits - force link limits according to libata.force
  *	@link: ATA link of interest
  *
- *	Force SATA spd limit according to libata.force and whine about
- *	it.  When only the port part is specified (e.g. 1:), the limit
- *	applies to all links connected to both the host link and all
- *	fan-out ports connected via PMP.  If the device part is
- *	specified as 0 (e.g. 1.00:), it specifies the first fan-out
- *	link not the host link.  Device number 15 always points to the
- *	host link whether PMP is attached or not.
+ *	Force link flags and SATA spd limit according to libata.force
+ *	and whine about it.  When only the port part is specified
+ *	(e.g. 1:), the limit applies to all links connected to both
+ *	the host link and all fan-out ports connected via PMP.  If the
+ *	device part is specified as 0 (e.g. 1.00:), it specifies the
+ *	first fan-out link not the host link.  Device number 15 always
+ *	points to the host link whether PMP is attached or not.
  *
  *	LOCKING:
  *	EH context.
  */
-static void ata_force_spd_limit(struct ata_link *link)
+static void ata_force_link_limits(struct ata_link *link)
 {
+	bool did_spd = false;
 	int linkno, i;
 
 	if (ata_is_host_link(link))
@@ -228,13 +230,22 @@ static void ata_force_spd_limit(struct ata_link *link)
 		if (fe->device != -1 && fe->device != linkno)
 			continue;
 
-		if (!fe->param.spd_limit)
-			continue;
+		/* only honor the first spd limit */
+		if (!did_spd && fe->param.spd_limit) {
+			link->hw_sata_spd_limit = (1 << fe->param.spd_limit) - 1;
+			ata_link_printk(link, KERN_NOTICE,
+					"FORCE: PHY spd limit set to %s\n",
+					fe->param.name);
+			did_spd = true;
+		}
 
-		link->hw_sata_spd_limit = (1 << fe->param.spd_limit) - 1;
-		ata_link_printk(link, KERN_NOTICE,
-			"FORCE: PHY spd limit set to %s\n", fe->param.name);
-		return;
+		/* let lflags stack */
+		if (fe->param.lflags) {
+			link->flags |= fe->param.lflags;
+			ata_link_printk(link, KERN_NOTICE,
+					"FORCE: link flag 0x%x forced -> 0x%x\n",
+					fe->param.lflags, link->flags);
+		}
 	}
 }
 
@@ -5170,7 +5181,7 @@ int sata_link_init_spd(struct ata_link *link)
 	if (spd)
 		link->hw_sata_spd_limit &= (1 << spd) - 1;
 
-	ata_force_spd_limit(link);
+	ata_force_link_limits(link);
 
 	link->sata_spd_limit = link->hw_sata_spd_limit;
 
@@ -5961,6 +5972,9 @@ static int __init ata_parse_force_one(char **cur,
 		{ "udma133",	.xfer_mask	= 1 << (ATA_SHIFT_UDMA + 6) },
 		{ "udma/133",	.xfer_mask	= 1 << (ATA_SHIFT_UDMA + 6) },
 		{ "udma7",	.xfer_mask	= 1 << (ATA_SHIFT_UDMA + 7) },
+		{ "nohrst",	.lflags		= ATA_LFLAG_NO_HRST },
+		{ "nosrst",	.lflags		= ATA_LFLAG_NO_SRST },
+		{ "norst",	.lflags		= ATA_LFLAG_NO_HRST | ATA_LFLAG_NO_SRST },
 	};
 	char *start = *cur, *p = *cur;
 	char *id, *val, *endp;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 58bdc53..a570ca4 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2210,6 +2210,10 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	 */
 	while (ata_eh_reset_timeouts[max_tries] != ULONG_MAX)
 		max_tries++;
+	if (link->flags & ATA_LFLAG_NO_HRST)
+		hardreset = NULL;
+	if (link->flags & ATA_LFLAG_NO_SRST)
+		softreset = NULL;
 
 	now = jiffies;
 	deadline = ata_deadline(ehc->last_reset, ATA_EH_RESET_COOL_DOWN);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5b247b8..12b8013 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -163,6 +163,7 @@ enum {
 	ATA_DEV_NONE		= 9,	/* no device */
 
 	/* struct ata_link flags */
+	ATA_LFLAG_NO_HRST	= (1 << 1), /* avoid hardreset */
 	ATA_LFLAG_NO_SRST	= (1 << 2), /* avoid softreset */
 	ATA_LFLAG_ASSUME_ATA	= (1 << 3), /* assume ATA class */
 	ATA_LFLAG_ASSUME_SEMB	= (1 << 4), /* assume SEMB class */
