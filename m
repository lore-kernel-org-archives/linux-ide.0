Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CDDC432BE
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 04:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F80C61008
	for <linux-ide@archiver.kernel.org>; Wed,  1 Sep 2021 04:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhIAExi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Sep 2021 00:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229731AbhIAExh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2021 00:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630471960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=P3aBHLWZDnmUXAALkI/MtBHbtK557Aojjg+2/1MJnAU=;
        b=eBlSydANyw3NzcOTj+Qm7IeI/1kyJKJOIKJbuflT4ttx44pI0QqR7BiDyRiyuOT8bdTn5g
        gjowpXwtbyMFF9Aaof1sLd2NcqtUDaXDn4ZSqKNn3Ro0V366ldH2ZDOw6x5ZYN6YcQe9jq
        1TLTjXqm60csCALCmor6RR8UbGCIWQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-6WWXWk_SNlCTV2NEgJHwRQ-1; Wed, 01 Sep 2021 00:52:39 -0400
X-MC-Unique: 6WWXWk_SNlCTV2NEgJHwRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF4938799E0;
        Wed,  1 Sep 2021 04:52:38 +0000 (UTC)
Received: from fedora-t480.rhtw.internal (unknown [10.39.192.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBE5F18A6A;
        Wed,  1 Sep 2021 04:52:34 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung 860 and 870 SSD.
Date:   Wed,  1 Sep 2021 12:52:20 +0800
Message-Id: <20210901045220.27746-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201693
Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
Changes in v4:
* A function ata_dev_check_adapter() is added to check the vendor ID of
  the adapter.
* ATA_HORKAGE_NONCQ_ON_AMD was modified to ATA_HORKAGE_NO_NCQ_ON_AMD to
  align with the naming convention.
* Commit messages were improved according to reviewer comments.

Changes in v3:
* ATA_HORKAGE_NONCQ_ON_ASMEDIA_AMD_MARVELL was modified to
  ATA_HORKAGE_NONCQ_ON_AMD.
* Codes were fixed to completely disable NCQ on AMD controller.

---
 drivers/ata/libata-core.c | 32 ++++++++++++++++++++++++++++++--
 include/linux/libata.h    |  1 +
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c861c93d1e84..49049cd713e4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2186,6 +2186,25 @@ static void ata_dev_config_ncq_prio(struct ata_device *dev)
 	dev->flags &= ~ATA_DFLAG_NCQ_PRIO;
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
@@ -2204,6 +2223,13 @@ static int ata_dev_config_ncq(struct ata_device *dev,
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
@@ -3971,9 +3997,11 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung SSD 860*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NO_NCQ_ON_AMD, },
 	{ "Samsung SSD 870*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NO_NCQ_ON_AMD, },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 860e63f5667b..cdc248a15763 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -426,6 +426,7 @@ enum {
 	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
 	ATA_HORKAGE_MAX_SEC_1024 = (1 << 25),	/* Limit max sects to 1024 */
 	ATA_HORKAGE_MAX_TRIM_128M = (1 << 26),	/* Limit max trim size to 128M */
+	ATA_HORKAGE_NO_NCQ_ON_AMD = (1 << 27),	/* Disable NCQ on AMD chipset */

 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
--
2.31.1

