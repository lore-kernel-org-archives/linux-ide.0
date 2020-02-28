Return-Path: <SRS0=Wmko=4Q=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109DCC3F2D2
	for <linux-ide@archiver.kernel.org>; Fri, 28 Feb 2020 10:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BEA246A8
	for <linux-ide@archiver.kernel.org>; Fri, 28 Feb 2020 10:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgB1Kuv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:50:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:49412 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgB1Kuv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 28 Feb 2020 05:50:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 02:50:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,495,1574150400"; 
   d="scan'208";a="350902228"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2020 02:50:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4940414B; Fri, 28 Feb 2020 12:50:49 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH] ahci: Add Intel Comet Lake PCH-V PCI ID
Date:   Fri, 28 Feb 2020 13:50:48 +0300
Message-Id: <20200228105048.75786-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Intel Comet Lake PCH-V PCI ID to the list of supported controllers.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 5f461a92998f..cf069b369723 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -402,6 +402,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0xa252), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa256), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
+	{ PCI_VDEVICE(INTEL, 0xa386), board_ahci }, /* Comet Lake PCH-V RAID */
 	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_mobile }, /* Bay Trail AHCI */
 	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_mobile }, /* Bay Trail AHCI */
 	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_mobile }, /* Cherry Tr. AHCI */
-- 
2.25.0

