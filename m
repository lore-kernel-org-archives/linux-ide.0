From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.9-rc8
Date: Fri, 9 Dec 2016 09:22:03 -0500
Message-ID: <20161209142203.GA738@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34538 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751783AbcLIOWG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Dec 2016 09:22:06 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

This is quite late but SCT Write Same support added during this cycle
is broken subtly but seriously and it'd be best to disable it before
v4.9 gets released.

This pull request contains two commits - one low impact sata_mv fix
and the mentioned disabling of SCT Write Same.

Thanks.

The following changes since commit 6929ef385e09c0065b87fda3e7b872a5070ac783:

  ahci: always fall back to single-MSI mode (2016-11-21 11:06:57 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.9-fixes

for you to fetch changes up to e185934ff94466b4a449165e5f1c164a44d005f2:

  libata-scsi: disable SCT Write Same for the moment (2016-12-07 16:29:09 -0500)

----------------------------------------------------------------
Nicolai Stange (1):
      libata-scsi: disable SCT Write Same for the moment

Uwe Kleine-König (1):
      ata: sata_mv: check for errors when parsing nr-ports from dt

 drivers/ata/libata-scsi.c |  1 +
 drivers/ata/sata_mv.c     | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c4eb4ae..8e575fb 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1159,6 +1159,7 @@ static void ata_scsi_sdev_config(struct scsi_device *sdev)
 {
 	sdev->use_10_for_rw = 1;
 	sdev->use_10_for_ms = 1;
+	sdev->no_write_same = 1;
 
 	/* Schedule policy is determined by ->qc_defer() callback and
 	 * it needs to see every deferred qc.  Set dev_blocked to 1 to
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index efc48bf..823e938 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4090,7 +4090,20 @@ static int mv_platform_probe(struct platform_device *pdev)
 
 	/* allocate host */
 	if (pdev->dev.of_node) {
-		of_property_read_u32(pdev->dev.of_node, "nr-ports", &n_ports);
+		rc = of_property_read_u32(pdev->dev.of_node, "nr-ports",
+					   &n_ports);
+		if (rc) {
+			dev_err(&pdev->dev,
+				"error parsing nr-ports property: %d\n", rc);
+			return rc;
+		}
+
+		if (n_ports <= 0) {
+			dev_err(&pdev->dev, "nr-ports must be positive: %d\n",
+				n_ports);
+			return -EINVAL;
+		}
+
 		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
 	} else {
 		mv_platform_data = dev_get_platdata(&pdev->dev);

