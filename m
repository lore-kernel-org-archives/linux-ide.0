Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD53BC43460
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 16:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C32D61177
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 16:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhDGQJx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 12:09:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:47512 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354229AbhDGQJY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Apr 2021 12:09:24 -0400
IronPort-SDR: 4n3Y1/lTbymyj6Rk1hQ8g8A+H21fKyGtVAS4WD7ODnmz2JoWo+pj7SiBYII/Wim2auO+6QTb+P
 /La7Vf8v5Ong==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="190139049"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="190139049"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 09:08:25 -0700
IronPort-SDR: 7BtkWc5zfVSznSN4oIMpm4mtHUwH7YKJWbPwgIYhoeXVIX0tzu5FVe9spwV4Rj1NXtEmcHhfR7
 PZEEr54BmDRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="612979982"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 07 Apr 2021 09:08:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0D346F2; Wed,  7 Apr 2021 19:08:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] ata: Add bits.h inclusion
Date:   Wed,  7 Apr 2021 19:08:36 +0300
Message-Id: <20210407160836.49809-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ata.h uses BIT() macro, hence bits.h must be included.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Jens, feel free to fold this into v1, or tell that you want me to send a v2.

 include/linux/ata.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 21142b17245f..1b44f40c7700 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -13,6 +13,7 @@
 #ifndef __LINUX_ATA_H__
 #define __LINUX_ATA_H__
 
+#include <linux/bits.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <asm/byteorder.h>
-- 
2.30.2

