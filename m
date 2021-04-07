Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9D5C43460
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 13:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE2A61353
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 13:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243136AbhDGNrF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 09:47:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:15225 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhDGNrE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Apr 2021 09:47:04 -0400
IronPort-SDR: i8sm+2zfLpMV+zazkImUf3hI0WEp6/uwPR9bFYiKsfIktUkV/a2W39T7A54PckoMuB/f22vDjO
 oMlKP3Uw5QxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="257294490"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="257294490"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 06:46:54 -0700
IronPort-SDR: kMBIirvaSjG+DQejpM94NQUxNVyTb+7EmWvRRwj3POLzovONat6TwNlKZpTzeT7g8CSTg4EFPN
 itgXAKpBUR1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="448256023"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Apr 2021 06:46:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B84EC12A; Wed,  7 Apr 2021 16:47:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v1 1/1] ata: Drop unneeded inclusion of kernel.h in the header
Date:   Wed,  7 Apr 2021 16:47:06 +0300
Message-Id: <20210407134706.81383-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

There is no need to have kernel.h included, I do not see any
direct users of it in ata.h. Drop unneeded inclusion of kernel.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/ata.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 6e67aded28f8..21142b17245f 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -13,7 +13,6 @@
 #ifndef __LINUX_ATA_H__
 #define __LINUX_ATA_H__
 
-#include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <asm/byteorder.h>
-- 
2.30.2

