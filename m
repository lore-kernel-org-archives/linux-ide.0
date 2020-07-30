Return-Path: <SRS0=8fsn=BJ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49550C433E0
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jul 2020 16:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D0FF20829
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jul 2020 16:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgG3QKu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:10:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:41509 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbgG3QKt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 30 Jul 2020 12:10:49 -0400
IronPort-SDR: wMFzm5+JdSiWPFJ5rvBJ8M/j0epBUpuqYajn2gfC4Idj1AHe3JqwdTR+JGaRcB6YsPGZ58UNnp
 Ooa156Mer5pA==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="131698927"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="131698927"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 09:10:46 -0700
IronPort-SDR: SauiCJzHrcqnkcbEQT5pRUkuaSYCy1JFy1mITJiVvNzSlUt0WNre9568a5hMxBPm6USYfRp50H
 N3klzR81n+cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="330790504"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Jul 2020 09:10:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E9C9D119; Thu, 30 Jul 2020 19:10:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ide-acpi: use %*ph to print small buffer
Date:   Thu, 30 Jul 2020 19:10:42 +0300
Message-Id: <20200730161042.41392-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use %*ph format to print small buffer as hex string.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ide/ide-acpi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index 05e18d658141..9a4ec281b985 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -320,10 +320,7 @@ static int do_drive_set_taskfiles(ide_drive_t *drive,
 		u8 *gtf = (u8 *)(gtf_address + ix * REGS_PER_GTF);
 		struct ide_cmd cmd;
 
-		DEBPRINT("(0x1f1-1f7): "
-			 "hex: %02x %02x %02x %02x %02x %02x %02x\n",
-			 gtf[0], gtf[1], gtf[2],
-			 gtf[3], gtf[4], gtf[5], gtf[6]);
+		DEBPRINT("(0x1f1-1f7): hex: %7ph\n", gtf);
 
 		if (!ide_acpigtf) {
 			DEBPRINT("_GTF execution disabled\n");
-- 
2.27.0

