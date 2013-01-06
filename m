From: y b <ycbzzjlby@gmail.com>
Subject: Fix ahci don't retry commands after a success error handler.
Date: Sun, 6 Jan 2013 13:14:24 +0800
Message-ID: <CAPoh-nbV0yc_QH-D3L5ms_n_83BkPFC6ZUJHd=H9t=hqKRKVWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:59457 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab3AFFOZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jan 2013 00:14:25 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so8088799dak.11
        for <linux-ide@vger.kernel.org>; Sat, 05 Jan 2013 21:14:25 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, kernel@teksavvy.com
Cc: linux-ide@vger.kernel.org

>From 78c0fb104c9957db682518b97ce6a01ce1bc07b6 Mon Sep 17 00:00:00 2001
From: Bian Yu <bianyu@kedacom.com>
Date: Wed, 12 Dec 2012 22:26:58 -0500
Subject: [PATCH] It should be a mistake introduced by commit 8d899e70c1b3afff.
 because only qc->flags can't be set AC_ERR_*

Signed-off-by: Bian Yu <bianyu@kedacom.com>
---
 drivers/ata/libata-eh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index bf039b0..bcf4437 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2094,7 +2094,7 @@ static unsigned int ata_eh_speed_down(struct
ata_device *dev,
  */
 static inline int ata_eh_worth_retry(struct ata_queued_cmd *qc)
 {
-       if (qc->flags & AC_ERR_MEDIA)
+       if (qc->err_mask & AC_ERR_MEDIA)
                return 0;       /* don't retry media errors */
        if (qc->flags & ATA_QCFLAG_IO)
                return 1;       /* otherwise retry anything from fs stack */
-- 
1.7.1
