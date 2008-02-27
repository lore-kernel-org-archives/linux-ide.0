From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 1/5] ide-cd: include proper headers
Date: Wed, 27 Feb 2008 19:20:45 +0100
Message-ID: <1204136449-9490-2-git-send-email-petkovbb@gmail.com>
References: <1204136449-9490-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48608 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756330AbYB0SVY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2008 13:21:24 -0500
Received: by ug-out-1314.google.com with SMTP id z38so460544ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 27 Feb 2008 10:21:22 -0800 (PST)
In-Reply-To: <1204136449-9490-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 8877b7b..4d39567 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -41,10 +41,10 @@
 
 #include <scsi/scsi.h>	/* For SCSI -> ATAPI command conversion */
 
-#include <asm/irq.h>
-#include <asm/io.h>
+#include <linux/irq.h>
+#include <linux/io.h>
 #include <asm/byteorder.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/unaligned.h>
 
 #include "ide-cd.h"
-- 
1.5.4.1

