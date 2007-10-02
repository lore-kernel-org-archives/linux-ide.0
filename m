From: Jeff Garzik <jeff@garzik.org>
Subject: [git patch] libata fix
Date: Tue, 2 Oct 2007 13:17:38 -0400
Message-ID: <20071002171738.GA28493@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:59630 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852AbXJBRRj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Oct 2007 13:17:39 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


Make another laptop's suspend work.


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/ata_piix.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

Tejun Heo (1):
      ata_piix: add another TECRA M3 entry to broken suspend list

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 3b8bf18..6996eb5 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -921,6 +921,13 @@ static int piix_broken_suspend(void)
 {
 	static struct dmi_system_id sysids[] = {
 		{
+			.ident = "TECRA M3",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "TECRA M3"),
+			},
+		},
+		{
 			.ident = "TECRA M5",
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
