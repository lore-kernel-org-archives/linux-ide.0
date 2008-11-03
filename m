From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 8/8] libata: implement ATA_HORKAGE_ATAPI_MOD16_DMA and apply it
Date: Mon,  3 Nov 2008 19:01:09 +0900
Message-ID: <1225706469-27870-9-git-send-email-tj@kernel.org>
References: <1225706469-27870-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34661 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760AbYKCKBk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Nov 2008 05:01:40 -0500
In-Reply-To: <1225706469-27870-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, John Clark <clarkjc@runbox.com>

libata always uses PIO for ATAPI commands when the number of bytes to
transfer isn't multiple of 16 but quantum DAT72 chokes on odd bytes
PIO transfers.  Implement a horkage to skip the mod16 check and apply
it to the quantum device.

This is reported by John Clark in the following thread.

  http://thread.gmane.org/gmane.linux.ide/34748

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: John Clark <clarkjc@runbox.com>
---
 drivers/ata/libata-core.c |    4 +++-
 include/linux/libata.h    |    2 ++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 82af701..91b478f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4024,6 +4024,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 
 	/* Weird ATAPI devices */
 	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_128 },
+	{ "QUANTUM DAT    DAT72-000", NULL,	ATA_HORKAGE_ATAPI_MOD16_DMA },
 
 	/* Devices we expect to fail diagnostics */
 
@@ -4444,7 +4445,8 @@ int atapi_check_dma(struct ata_queued_cmd *qc)
 	/* Don't allow DMA if it isn't multiple of 16 bytes.  Quite a
 	 * few ATAPI devices choke on such DMA requests.
 	 */
-	if (unlikely(qc->nbytes & 15))
+	if (!(qc->dev->horkage & ATA_HORKAGE_ATAPI_MOD16_DMA) &&
+	    unlikely(qc->nbytes & 15))
 		return 1;
 
 	if (ap->ops->check_atapi_dma)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index cc0ceaf..a2eb8f2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -375,6 +375,8 @@ enum {
 	ATA_HORKAGE_IVB		= (1 << 8),	/* cbl det validity bit bugs */
 	ATA_HORKAGE_STUCK_ERR	= (1 << 9),	/* stuck ERR on next PACKET */
 	ATA_HORKAGE_BRIDGE_OK	= (1 << 10),	/* no bridge limits */
+	ATA_HORKAGE_ATAPI_MOD16_DMA = (1 << 11), /* use ATAPI DMA for commands
+						    not multiple of 16 bytes */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
-- 
1.5.4.5

