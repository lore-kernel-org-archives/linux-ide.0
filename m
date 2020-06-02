Return-Path: <SRS0=xCVQ=7P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BB3C433E0
	for <linux-ide@archiver.kernel.org>; Tue,  2 Jun 2020 09:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C5C206A4
	for <linux-ide@archiver.kernel.org>; Tue,  2 Jun 2020 09:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgFBJUU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:20:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:55820 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgFBJUT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 2 Jun 2020 05:20:19 -0400
IronPort-SDR: f1Iamx5b4snHMSWUDdFelDeT5V2tu8uzQjB40WTpDRMVq6b0XN9V0RpYZmWZoKf4qFOi+66Tdw
 DAHVqGi7sQQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:20:19 -0700
IronPort-SDR: keO+xNWbDWUuQM3KRUKmrlDfbxETeHku6RAHyOpWNTZWOCRUI+5GRuot9MmBc76xg8876Xc4WD
 814HnFS6DXfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="272298460"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by orsmga006.jf.intel.com with ESMTP; 02 Jun 2020 02:20:17 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Subject: [PATCH 04/15] ahci: use PCI_IRQ_MSI_TYPES where appropriate
Date:   Tue,  2 Jun 2020 11:20:12 +0200
Message-Id: <20200602092012.31831-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 0c0a736eb861..ca1bf4ef0f17 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1556,7 +1556,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	 */
 	if (n_ports > 1) {
 		nvec = pci_alloc_irq_vectors(pdev, n_ports, INT_MAX,
-				PCI_IRQ_MSIX | PCI_IRQ_MSI);
+				PCI_IRQ_MSI_TYPES);
 		if (nvec > 0) {
 			if (!(readl(hpriv->mmio + HOST_CTL) & HOST_MRSM)) {
 				hpriv->get_irq_vector = ahci_get_irq_vector;
-- 
2.17.2

