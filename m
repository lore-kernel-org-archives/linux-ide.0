Return-Path: <SRS0=dVMU=AU=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79334C433E0
	for <linux-ide@archiver.kernel.org>; Thu,  9 Jul 2020 19:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FDB820775
	for <linux-ide@archiver.kernel.org>; Thu,  9 Jul 2020 19:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgGIT2W (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:28:22 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:57656 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgGIT2V (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 9 Jul 2020 15:28:21 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 72870BC0FF;
        Thu,  9 Jul 2020 19:28:19 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     davem@davemloft.net, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] IDE SUBSYSTEM: Replace HTTP links with HTTPS ones
Date:   Thu,  9 Jul 2020 21:28:13 +0200
Message-Id: <20200709192813.26413-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 drivers/ide/Kconfig  | 2 +-
 drivers/ide/hpt366.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 973ed4b684ce..410d717d5ab2 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -98,7 +98,7 @@ config IDE_GD_ATAPI
 
 	  For information about jumper settings and the question
 	  of when a ZIP drive uses a partition table, see
-	  <http://www.win.tue.nl/~aeb/linux/zip/zip-1.html>.
+	  <https://www.win.tue.nl/~aeb/linux/zip/zip-1.html>.
 
 	  If unsure, say N.
 
diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index fd3b5da44619..209e5b01cac0 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -13,7 +13,7 @@
  *
  *
  * HighPoint has its own drivers (open source except for the RAID part)
- * available from http://www.highpoint-tech.com/USA_new/service_support.htm 
+ * available from https://www.highpoint-tech.com/USA_new/service_support.htm 
  * This may be useful to anyone wanting to work on this driver, however  do not
  * trust  them too much since the code tends to become less and less meaningful
  * as the time passes... :-/
-- 
2.27.0

