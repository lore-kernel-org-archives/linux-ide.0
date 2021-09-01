Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6E2C432BE
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 15:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F6F6109E
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 15:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbhIAPR7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Sep 2021 11:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245699AbhIAPR6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2021 11:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630509421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Mh3cylghfHfvCDQ5ybQ0BmduttKnKOaYDqF4MlKkW9M=;
        b=DtBM2Vk2CcJqk8a37vqbIKVM6FKCie/oZk3HG9bXfWd9I+fJ48iINl+VQy7rdvp1kT4k56
        6QsjbEestRqj4X/rd5C2gADxQN6s+ArpYhX7oslHRec20uiENce65XO6bSU8cD/95X9chY
        dnvqHGm0c0IOwe8OJffzCK4cft4rdSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-Yuquzq97P3mmrLZTRAVsaQ-1; Wed, 01 Sep 2021 11:17:00 -0400
X-MC-Unique: Yuquzq97P3mmrLZTRAVsaQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6BA41B2C980;
        Wed,  1 Sep 2021 15:16:58 +0000 (UTC)
Received: from fedora-t480.redhat.com (unknown [10.39.192.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F22FB60C9F;
        Wed,  1 Sep 2021 15:16:54 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v5] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860 and 870 SSD.
Date:   Wed,  1 Sep 2021 23:16:43 +0800
Message-Id: <20210901151643.13562-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Many users are reporting that the Samsung 860 and 870 SSD are having
various issues when combined with AMD SATA controllers and only
completely disabling NCQ helps to avoid these issues.

Always disabling NCQ for Samsung 860/870 SSDs regardless of the host
SATA adapter vendor will cause I/O performance degradation with well
behaved adapters. To limit the performance impact to AMD adapters,
introduce the ATA_HORKAGE_NO_NCQ_ON_AMD flag to force disable NCQ
only for these adapters.

Also, two libata.force parameters (noncqamd and ncqamd) are introduced
to disable and enable the NCQ for the system which equiped with AMD
SATA adapter and Samsung 860 and 870 SSDs. The user can determine NCQ
function to be enabled or disabled according to the demand.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201693
Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
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
index 3eda3291952b..e2e900085f99 100644
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
+	if (dev->horkage & ATA_HORKAGE_NO_NCQ_ON_AMD &&
+	    ata_dev_check_adapter(dev, PCI_VENDOR_ID_AMD)) {
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
+						ATA_HORKAGE_NO_NCQ_ON_AMD, },
 	{ "Samsung SSD 870*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NO_NCQ_ON_AMD, },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },

@@ -6108,6 +6136,8 @@ static int __init ata_parse_force_one(char **cur,
 		{ "ncq",	.horkage_off	= ATA_HORKAGE_NONCQ },
 		{ "noncqtrim",	.horkage_on	= ATA_HORKAGE_NO_NCQ_TRIM },
 		{ "ncqtrim",	.horkage_off	= ATA_HORKAGE_NO_NCQ_TRIM },
+		{ "noncqamd",	.horkage_on	= ATA_HORKAGE_NO_NCQ_ON_AMD },
+		{ "ncqamd",	.horkage_off	= ATA_HORKAGE_NO_NCQ_ON_AMD },
 		{ "dump_id",	.horkage_on	= ATA_HORKAGE_DUMP_ID },
 		{ "pio0",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 0) },
 		{ "pio1",	.xfer_mask	= 1 << (ATA_SHIFT_PIO + 1) },
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3fcd24236793..ef1417152ecd 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -422,6 +422,7 @@ enum {
 	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
 	ATA_HORKAGE_MAX_SEC_1024 = (1 << 25),	/* Limit max sects to 1024 */
 	ATA_HORKAGE_MAX_TRIM_128M = (1 << 26),	/* Limit max trim size to 128M */
+	ATA_HORKAGE_NO_NCQ_ON_AMD = (1 << 27),	/* Disable NCQ on AMD chipset */

 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
--
2.31.1

