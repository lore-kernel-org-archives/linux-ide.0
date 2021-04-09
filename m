Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC57C433B4
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 15:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6BF9610FC
	for <linux-ide@archiver.kernel.org>; Fri,  9 Apr 2021 15:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhDIPfA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:35:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:46596 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231402AbhDIPe5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 9 Apr 2021 11:34:57 -0400
IronPort-SDR: JblP59kHhP8eZJDQbNX2htGPy7Q93aqRMrML3MbMWoW6LlgnoFp5Bi5Zd8wXhZK7HcECFnypeQ
 S5USfyM5EKVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="193825786"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="193825786"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 08:34:42 -0700
IronPort-SDR: FVJd+3rp/57Vkn9pB/BjYjj4tsF6Zn7H4gFq2B/cFZcox+dgHa7Bey77+1Hb6hv3+AXsVBxUe8
 auyWa1IZJvWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="397512634"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Apr 2021 08:34:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9C49BFC; Fri,  9 Apr 2021 18:34:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 1/1] ata: Replace inclusion of kernel.h by bits.h in the header
Date:   Fri,  9 Apr 2021 18:34:56 +0300
Message-Id: <20210409153456.87798-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ata.h uses BIT() macro, hence bits.h must be included. Otherwise
there is no need to have kernel.h included, I do not see any
direct users of it in ata.h. Hence replace inclusion of kernel.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: replaced kernel.h by bits.h (lkp), tested allmod/yesconfig on x86_64 (Jens)
 include/linux/ata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 6e67aded28f8..1b44f40c7700 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -13,7 +13,7 @@
 #ifndef __LINUX_ATA_H__
 #define __LINUX_ATA_H__
 
-#include <linux/kernel.h>
+#include <linux/bits.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <asm/byteorder.h>
-- 
2.30.2

