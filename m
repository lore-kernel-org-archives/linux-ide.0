From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/10] ide: fix ide_fix_driveid()
Date: Tue, 22 Jul 2008 23:12:13 +0200
Message-ID: <20080722211213.20478.17317.sendpatchset@localhost.localdomain>
References: <20080722211159.20478.74184.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:64452 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983AbYGVVOX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2008 17:14:23 -0400
Received: by nf-out-0910.google.com with SMTP id d3so761467nfc.21
        for <linux-ide@vger.kernel.org>; Tue, 22 Jul 2008 14:14:22 -0700 (PDT)
In-Reply-To: <20080722211159.20478.74184.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Fix byte-swapping for id->words161_175[], id->words206_254[]
and id->words206_254[].

[ Luckily all words previously left in LE byte-order are marked as
  reserved so this fix shouldn't affect user-space applications. ]

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -484,11 +484,11 @@ void ide_fix_driveid (struct hd_driveid 
 	for (i = 0; i < 3; i++)
 		id->words157_159[i] = __le16_to_cpu(id->words157_159[i]);
 	id->cfa_power      = __le16_to_cpu(id->cfa_power);
-	for (i = 0; i < 14; i++)
+	for (i = 0; i < 15; i++)
 		id->words161_175[i] = __le16_to_cpu(id->words161_175[i]);
-	for (i = 0; i < 31; i++)
+	for (i = 0; i < 30; i++)
 		id->words176_205[i] = __le16_to_cpu(id->words176_205[i]);
-	for (i = 0; i < 48; i++)
+	for (i = 0; i < 49; i++)
 		id->words206_254[i] = __le16_to_cpu(id->words206_254[i]);
 	id->integrity_word  = __le16_to_cpu(id->integrity_word);
 # else
