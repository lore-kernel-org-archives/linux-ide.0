Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CA2C6369E
	for <linux-ide@archiver.kernel.org>; Thu, 19 Nov 2020 10:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6E5238E6
	for <linux-ide@archiver.kernel.org>; Thu, 19 Nov 2020 10:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgKSKnZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 19 Nov 2020 05:43:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:2426 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgKSKnY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 19 Nov 2020 05:43:24 -0500
IronPort-SDR: GJujsEwDbMrNSXA6+fUQ9sD/q3xBxx+MCv+PsltXM3hZdRcrHCDdK+f4vtIvzyzL/bVt6b4d1y
 OViQzjZ8gDeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="171436952"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="171436952"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 02:43:23 -0800
IronPort-SDR: 77JW204Hn+ovc01Ar8ULv6B54SZLSQoKnCzpWxJY6zUp7fIUh7F3jBPXcEnMZlcABgmK97umgC
 9W4Sr5NaW9Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="311601545"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 19 Nov 2020 02:43:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4655A11E; Thu, 19 Nov 2020 12:43:18 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH] ahci: Add Intel Emmitsburg PCH RAID PCI IDs
Date:   Thu, 19 Nov 2020 13:43:18 +0300
Message-Id: <20201119104318.79297-1-mika.westerberg@linux.intel.com>
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

