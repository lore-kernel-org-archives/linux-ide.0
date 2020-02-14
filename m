Return-Path: <SRS0=vZIR=4C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A8AC2BA83
	for <linux-ide@archiver.kernel.org>; Fri, 14 Feb 2020 09:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDD62086A
	for <linux-ide@archiver.kernel.org>; Fri, 14 Feb 2020 09:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSql39Rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgBNJQf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 Feb 2020 04:16:35 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35634 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgBNJQe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 14 Feb 2020 04:16:34 -0500
Received: by mail-pj1-f68.google.com with SMTP id q39so3690651pjc.0
        for <linux-ide@vger.kernel.org>; Fri, 14 Feb 2020 01:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SamqXB13vClsnlyT9BZrLwMImFNxpmaB+An7pUStsRE=;
        b=nSql39Rd2BlF0sNMcEpYTohGxvT+ndH7/UDNBABVGXmzW7imOTgqpQRz1GBGQkHnik
         lSBt7ZVm7QuvPcrVii02zmVKwcdrUSOVmCjbhBR2lbueGCa+MondzqaGNtBt8J4MXabZ
         kFQMSWIazXlSz2cXhmvu2ZGua5Y6uPlAmhkcyXisWEj3lG2DVnZVfFWS1WJ3fRXAiV9W
         RsKr421dwAsvtlTtDLm0h3wCx2udgxT1iZr+bV0LYzWns7k8RiWrUJ4z2i/+WwLiJj7d
         DjFshDVs26+m7zyf1fFonmW4A5sGETJXYD3DsdFcjY+Gx1VF3XSKXAG3DgkhQRmHKYeU
         Oz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SamqXB13vClsnlyT9BZrLwMImFNxpmaB+An7pUStsRE=;
        b=Z7DCxb67WB7+Z9A0h4q8xukrduhvv8RR0uNJtm2oJiv6H4kDbcIrx4s1rl0NctlA/i
         Ru2D/2bqpwO7ZkyGLWTdgXucQ9rhhcq7+jSkQscRl8VILgD+dflF18A24U0jxautAx96
         2uPHoTt3EaxicatO8RXx/oxWj0mWnT9KYJ+FakTJLkruJHdPdr/pb9VHKzDslU+qyS9P
         dYYgyI+qvHpqfUWVU2ZBR8IcCPUH4F3xZjVLV+qipU1/9tjV22eX6PNn5CAX/WWStPsn
         wafobadILxZNyvmghOzAmp5zWJIOgqKHxz7Ct33S7L8V2GBW0GgZFys92sPKqONJGU/8
         qf4A==
X-Gm-Message-State: APjAAAVMnV3a8GRpXgiyg5bAGRx7jCw6rWJ0juPR18TTJmdACTos9UMw
        Q4Zq0wbllCc+3mMpafTqFDpt8ItZ
X-Google-Smtp-Source: APXvYqz95o4TJhC4wWLzISgnwuhspyKvOwwWLHoRzLw0Bhn0BEdQyYKEbNnnnjCD6ESC34HaPKHZew==
X-Received: by 2002:a17:90a:8545:: with SMTP id a5mr2385017pjw.43.1581671792869;
        Fri, 14 Feb 2020 01:16:32 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id q7sm6152111pgk.62.2020.02.14.01.16.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Feb 2020 01:16:32 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] drivers/ide: convert to list_for_each_entry_safe()
Date:   Fri, 14 Feb 2020 17:16:25 +0800
Message-Id: <1581671785-25125-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Use list_for_each_entry_safe() instead of list_for_each_safe()
to simplify the code.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 drivers/ide/ide-scan-pci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-scan-pci.c b/drivers/ide/ide-scan-pci.c
index acf8748..383f0d8 100644
--- a/drivers/ide/ide-scan-pci.c
+++ b/drivers/ide/ide-scan-pci.c
@@ -89,8 +89,7 @@ static int __init ide_scan_pcidev(struct pci_dev *dev)
 static int __init ide_scan_pcibus(void)
 {
 	struct pci_dev *dev = NULL;
-	struct pci_driver *d;
-	struct list_head *l, *n;
+	struct pci_driver *d, *tmp;
 
 	pre_init = 0;
 	for_each_pci_dev(dev)
@@ -101,9 +100,8 @@ static int __init ide_scan_pcibus(void)
 	 *	are post init.
 	 */
 
-	list_for_each_safe(l, n, &ide_pci_drivers) {
-		list_del(l);
-		d = list_entry(l, struct pci_driver, node);
+	list_for_each_entry_safe(d, tmp, &ide_pci_drivers, node) {
+		list_del(d->node);
 		if (__pci_register_driver(d, d->driver.owner,
 					  d->driver.mod_name))
 			printk(KERN_ERR "%s: failed to register %s driver\n",
-- 
1.9.1

