From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata-acpi: filter out DIPM enable
Date: Sun, 06 Jul 2008 23:15:03 +0900
Message-ID: <4870D367.40106@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38125 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756619AbYGFOPs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Jul 2008 10:15:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, =?UTF-8?B?TWF0aGlldSBCw6lyYXJk?= <Mathieu.Berard@crans.org>

Some BIOSen enable DIPM via _GTF which causes command timeouts under
certain configuration.  This didn't occur on 2.6.25 because 2.6.25
defaulted to SRST, so _GTF wasn't executed during boot probe, so ahci
host reset disabled DIPM and as _GTF wasn't executed after SRST, DIPM
wasn't enabled.  On 2.6.26, hardreset is used during probe and after
probe _GTF is executed enabling DIPM and thus the failures.

This patch could theoretically disable DIPM on machines which used to
have it enabled on 2.6.25 but AFAIK ahci is currently the only driver
which uses SATA ACPI hierarchy (_SDD) and as the host reset would have
always disabled DIPM, this shouldn't happen.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-acpi.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 3ff8b14..abea74b 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -29,14 +29,16 @@
 enum {
 	ATA_ACPI_FILTER_SETXFER	= 1 << 0,
 	ATA_ACPI_FILTER_LOCK	= 1 << 1,
+	ATA_ACPI_FILTER_DIPM	= 1 << 2,
 
 	ATA_ACPI_FILTER_DEFAULT	= ATA_ACPI_FILTER_SETXFER |
-				  ATA_ACPI_FILTER_LOCK,
+				  ATA_ACPI_FILTER_LOCK |
+				  ATA_ACPI_FILTER_DIPM,
 };
 
 static unsigned int ata_acpi_gtf_filter = ATA_ACPI_FILTER_DEFAULT;
 module_param_named(acpi_gtf_filter, ata_acpi_gtf_filter, int, 0644);
-MODULE_PARM_DESC(acpi_gtf_filter, "filter mask for ACPI _GTF commands, set to filter out (0x1=set xfermode, 0x2=lock/freeze lock)");
+MODULE_PARM_DESC(acpi_gtf_filter, "filter mask for ACPI _GTF commands, set to filter out (0x1=set xfermode, 0x2=lock/freeze lock, 0x4=DIPM)");
 
 #define NO_PORT_MULT		0xffff
 #define SATA_ADR(root, pmp)	(((root) << 16) | (pmp))
@@ -690,6 +692,14 @@ static int ata_acpi_filter_tf(const struct ata_taskfile *tf,
 			return 1;
 	}
 
+	if (ata_acpi_gtf_filter & ATA_ACPI_FILTER_DIPM) {
+		/* inhibit enabling DIPM */
+		if (tf->command == ATA_CMD_SET_FEATURES &&
+		    tf->feature == SETFEATURES_SATA_ENABLE &&
+		    tf->nsect == SATA_DIPM)
+			return 1;
+	}
+
 	return 0;
 }
 
