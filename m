Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC43C433F5
	for <linux-ide@archiver.kernel.org>; Fri,  3 Sep 2021 09:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7746C6101A
	for <linux-ide@archiver.kernel.org>; Fri,  3 Sep 2021 09:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348870AbhICJpm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Sep 2021 05:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41542 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348802AbhICJpl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Sep 2021 05:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630662281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jSus6DbAtY3HkLoXjsEZTgxcISPGImC9WN1gRcr83FE=;
        b=HFP/M1Y3wVexWhCTut6LSygbBnVU9f337Wez/K+XwyqH0eFvOO6YKj1aR2LMNXeNz/r8OV
        tldDCzK2rBTg+boIXojpB1UG/j2Yw0VHZ3TjWiLk90wJdar83MxE/Pd0++g8BYWksCqnoo
        hKKuagUfVX0I4oJI8hFL1eClYlXsORk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-9w-9I0mrP4ugM674ipu7PA-1; Fri, 03 Sep 2021 05:44:41 -0400
X-MC-Unique: 9w-9I0mrP4ugM674ipu7PA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3D8784A5E9;
        Fri,  3 Sep 2021 09:44:39 +0000 (UTC)
Received: from fedora-t480.rhtw.internal (unknown [10.39.193.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F53A77718;
        Fri,  3 Sep 2021 09:44:33 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v6] libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI for Samsung 860 and 870 SSD.
Date:   Fri,  3 Sep 2021 17:44:11 +0800
Message-Id: <20210903094411.58749-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Many users are reporting that the Samsung 860 and 870 SSD are having
various issues when combined with AMD/ATI (vendor ID 0x1002)  SATA
controllers and only completely disabling NCQ helps to avoid these
issues.

Always disabling NCQ for Samsung 860/870 SSDs regardless of the host
SATA adapter vendor will cause I/O performance degradation with well
behaved adapters. To limit the performance impact to ATI adapters,
introduce the ATA_HORKAGE_NO_NCQ_ON_ATI flag to force disable NCQ
only for these adapters.

Also, two libata.force parameters (noncqati and ncqati) are introduced
to disable and enable the NCQ for the system which equipped with ATI
SATA adapter and Samsung 860 and 870 SSDs. The user can determine NCQ
function to be enabled or disabled according to the demand.

After verifying the chipset from the user reports, the issue appears
on AMD/ATI SB7x0/SB8x0/SB9x0 SATA Controllers and does not appear on
recent AMD SATA adapters. The vendor ID of ATI should be 0x1002.
Therefore, ATA_HORKAGE_NO_NCQ_ON_AMD was modified to
ATA_HORKAGE_NO_NCQ_ON_ATI.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201693
Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
Changes in v6:
* The adapter vendor ID check was revised to PCI_VENDOR_ID_ATI.
* ATA_HORKAGE_NO_NCQ_ON_AMD was revised to ATA_HORKAGE_NO_NCQ_ON_ATI.
* Two libata.force parameters was modified to noncqati and ncqati.

Changes in v5:
* The libata.force parameters ncqamd and noncqamd are used to enable and
  disable the NCQ for the systems equiped with AMD SATA adapter and
  Samsung 860 and 870 SSDs.
* The character encoding of the patch comment was fixed.

Changes in v4:
* A function ata_dev_check_adapter() is added to check the vendor ID of
  the adapter.
* ATA_HORKAGE_NONCQ_ON_AMD was modified to ATA_HORKAGE_NO_NCQ_ON_AMD to
  align with the naming convention.
* Commit messages were improved according to reviewer comments.

Changes in v3:
* ATA_HORKAGE_NONCQ_ON_ASMEDIA_AMD_MARVELL was modified to
  ATA_HORKAGE_NONCQ_ON_AMD.
* Codes were fixed to completely disable NCQ on AMD controller.

---
 drivers/ata/libata-core.c | 34 ++++++++++++++++++++++++++++++++--
 include/linux/libata.h    |  1 +
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3eda3291952b..85e4e56c0681 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2199,6 +2199,25 @@ static void ata_dev_config_ncq_prio(struct ata_device *dev)

 }

+static bool ata_dev_check_adapter(struct ata_device *dev,
+				  unsigned short vendor_id)
+{
+	struct pci_dev *pcidev = NULL;
+	struct device *parent_dev = NULL;
+
+	for (parent_dev = dev->tdev.parent; parent_dev != NULL;
+	     parent_dev = parent_dev->parent) {
+		if (dev_is_pci(parent_dev)) {
+			pcidev = to_pci_dev(parent_dev);
+			if (pcidev->vendor == vendor_id)
+				return true;
+			break;
+		}
+	}
+
+	return false;
+}
+
 static int ata_dev_config_ncq(struct ata_device *dev,
 			       char *desc, size_t desc_sz)
 {
@@ -2217,6 +2236,13 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 		snprintf(desc, desc_sz, "NCQ (not used)");
 		return 0;
 	}
+
+	if (dev->horkage & ATA_HORKAGE_NO_NCQ_ON_ATI &&
+	    ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI)) {
+		snprintf(desc, desc_sz, "NCQ (not used)");
+		return 0;
+	}
+
 	if (ap->flags & ATA_FLAG_NCQ) {
 		hdepth = min(ap->scsi_host->can_queue, ATA_MAX_QUEUE);
 		dev->flags |= ATA_DFLAG_NCQ;
@@ -3951,9 +3977,11 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung SSD 860*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NO_NCQ_ON_ATI, },
 	{ "Samsung SSD 870*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NO_NCQ_ON_ATI, },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },

@@ -6108,6 +6136,8 @@ static int __init ata_parse_force_one(char **cur,
 		{ "ncq",	.horkage_off	= ATA_HORKAGE_NONCQ },
 		{ "noncqtrim",	.horkage_on	= ATA_HORKAGE_NO_NCQ_TRIM },
 		{ "ncqtrim",	.horkage_off	= ATA_HORKAGE_NO_NCQ_TRIM },
+		{ "noncqati",	.horkage_on	= ATA_HORKAGE_NO_NCQ_ON_ATI },
+		{ "ncqati",	.horkage_off	= ATA_HORKAGE_NO_NCQ_ON_ATI },
 		{ "dump_id",	.horkage_on	= ATA_HORKAGE_DUMP_ID },
 		{ "pio0",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 0) },
 		{ "pio1",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 1) },
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3fcd24236793..cb95d3f3337d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -422,6 +422,7 @@ enum {
 	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
 	ATA_HORKAGE_MAX_SEC_1024 = (1 << 25),	/* Limit max sects to 1024 */
 	ATA_HORKAGE_MAX_TRIM_128M = (1 << 26),	/* Limit max trim size to 128M */
+	ATA_HORKAGE_NO_NCQ_ON_ATI = (1 << 27),	/* Disable NCQ on ATI chipset */

 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
--
2.31.1

