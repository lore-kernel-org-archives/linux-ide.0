Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0B4C3F369
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 14:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEFF24688
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 14:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbgB0OdD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:33:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:51114 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733049AbgB0OdD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 27 Feb 2020 09:33:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 06:33:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="242061509"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 27 Feb 2020 06:33:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3A66614B; Thu, 27 Feb 2020 16:32:59 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH] ahci: Add Intel Comet Lake PCH-H PCI ID
Date:   Thu, 27 Feb 2020 17:32:59 +0300
Message-Id: <20200227143259.67172-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Intel Comet Lake PCH-H PCI ID to the list of supported controllers.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 11ea1aff40db..5f461a92998f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -245,6 +245,7 @@ static const struct ata_port_info ahci_port_info[] = {
 
 static const struct pci_device_id ahci_pci_tbl[] = {
 	/* Intel */
+	{ PCI_VDEVICE(INTEL, 0x06d6), board_ahci }, /* Comet Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x2652), board_ahci }, /* ICH6 */
 	{ PCI_VDEVICE(INTEL, 0x2653), board_ahci }, /* ICH6M */
 	{ PCI_VDEVICE(INTEL, 0x27c1), board_ahci }, /* ICH7 */
-- 
2.25.0

