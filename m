Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7525C433FE
	for <linux-ide@archiver.kernel.org>; Tue, 19 Oct 2021 10:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8C56137F
	for <linux-ide@archiver.kernel.org>; Tue, 19 Oct 2021 10:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhJSK1N (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 19 Oct 2021 06:27:13 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:57664 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235187AbhJSK1N (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 19 Oct 2021 06:27:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Usuq-co_1634639084;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Usuq-co_1634639084)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Oct 2021 18:24:59 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        chongjiapeng <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] scsi: ata: make ahci_sdev_attrs static
Date:   Tue, 19 Oct 2021 18:24:42 +0800
Message-Id: <1634639082-1007-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: chongjiapeng <jiapeng.chong@linux.alibaba.com>

This symbol is not used outside of libahci.c, so marks it static.

Fix the following sparse warning:

drivers/ata/libahci.c:134:18: warning: symbol 'ahci_sdev_attrs' was not
declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: c3f69c7f629f ("scsi: ata: Switch to attribute groups")
Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
---
 drivers/ata/libahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 28430c093a7f..8a6835bfd18a 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -131,7 +131,7 @@ const struct attribute_group *ahci_shost_groups[] = {
 };
 EXPORT_SYMBOL_GPL(ahci_shost_groups);
 
-struct attribute *ahci_sdev_attrs[] = {
+static struct attribute *ahci_sdev_attrs[] = {
 	&dev_attr_sw_activity.attr,
 	&dev_attr_unload_heads.attr,
 	&dev_attr_ncq_prio_supported.attr,
-- 
2.19.1.6.gb485710b

