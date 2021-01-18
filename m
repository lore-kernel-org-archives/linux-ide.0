Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA84C433DB
	for <linux-ide@archiver.kernel.org>; Mon, 18 Jan 2021 12:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE394222B3
	for <linux-ide@archiver.kernel.org>; Mon, 18 Jan 2021 12:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404258AbhARMta (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 18 Jan 2021 07:49:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:59140 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404281AbhARMs0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 18 Jan 2021 07:48:26 -0500
IronPort-SDR: E0xCD3XH6qKM7p1Wtqmdt7Grpfee8nvYfWpg+ATex54PSX/P1Uyn5S2oGd7kxiXuwQoq+wYMCa
 gsInaVaxHdnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="158571069"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="158571069"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 04:46:39 -0800
IronPort-SDR: M5mTnnJ5XgAz+wwhDzmlbCyCYL+XJQ2nQ5zdB1FlJPdOfz4pCO4pdYe2gYQKrToZK7q69weakh
 LkVs4RZzs8ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="466362381"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2021 04:46:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4451511E; Mon, 18 Jan 2021 14:46:37 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH RESEND] ahci: Add Intel Emmitsburg PCH RAID PCI IDs
Date:   Mon, 18 Jan 2021 15:46:36 +0300
Message-Id: <20210118124637.69206-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Intel Emmitsburg PCH RAID PCI IDs to the list of supported
controllers.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/ata/ahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 00ba8e5a1ccc..0b39f0e7fd8f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -398,6 +398,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Lewisburg AHCI*/
 	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x282b), board_ahci }, /* Emmitsburg RAID */
+	{ PCI_VDEVICE(INTEL, 0x282f), board_ahci }, /* Emmitsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
 	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0xa1d2), board_ahci }, /* Lewisburg RAID*/
-- 
2.29.2

