From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] hpt366: kill unused #define's
Date: Fri, 9 Oct 2009 17:36:39 +0400
Message-ID: <200910091736.39797.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:58960 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756959AbZJINeY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Oct 2009 09:34:24 -0400
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org

These two have been long unused but I've just noticed...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against ide-2.6.git tree...

 drivers/ide/hpt366.c |    2 --
 1 files changed, 2 deletions(-)

Index: ide-2.6/drivers/ide/hpt366.c
===================================================================
--- ide-2.6.orig/drivers/ide/hpt366.c
+++ ide-2.6/drivers/ide/hpt366.c
@@ -426,14 +426,12 @@ static u32 sixty_six_base_hpt37x[] = {
 };
 #endif
 
-#define HPT366_DEBUG_DRIVE_INFO		0
 #define HPT371_ALLOW_ATA133_6		1
 #define HPT302_ALLOW_ATA133_6		1
 #define HPT372_ALLOW_ATA133_6		1
 #define HPT370_ALLOW_ATA100_5		0
 #define HPT366_ALLOW_ATA66_4		1
 #define HPT366_ALLOW_ATA66_3		1
-#define HPT366_MAX_DEVS			8
 
 /* Supported ATA clock frequencies */
 enum ata_clock {

