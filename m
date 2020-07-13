Return-Path: <SRS0=Kv9U=AY=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A236C433E1
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jul 2020 17:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C18D2075D
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jul 2020 17:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWthblwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgGMRj6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgGMRj6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jul 2020 13:39:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02858C061755;
        Mon, 13 Jul 2020 10:39:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ls15so211698pjb.1;
        Mon, 13 Jul 2020 10:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o79HY/YJ97Muwh9uDvJ9rHuVKiZwBdetcBhADyrjYKw=;
        b=pWthblwx4XS1nTxr4C2EivA/n5vv+TetehgxG5VGGx9WqnFEWfMCBfc0TnNl8a6oTs
         L3u03MGf06on2PbEQEZWSOI0dG94IDHDfXJRjGW9GeBTbpgUdaGRHtvVGfonR50uo074
         +x1A7PJp/jcmMqede3M99hONPcWyW0Wx9qATi6QChEEWYMqIuUhH1j8zgDgnu1kcE8oj
         Nwy3nqR6yzT7vxGUz4koXImCaaHxMyBU5aZo70/4Saz8IHhuVGMZjIdO2kJPklUc78Or
         EjOcY2VUetIeMyOywIeIKuyWWHsYHfK2Q7mH58ZxVIDSJGD61ZeRWT8LpUV6Hc0W5XOw
         U9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o79HY/YJ97Muwh9uDvJ9rHuVKiZwBdetcBhADyrjYKw=;
        b=DQHl7rtbmF8ENY0K/B1KNHNEbuGIj7jBMIrLG+niL1htVV7HXv0HzKViNewU8mhGyK
         uzi1shucv1rEplRwGZa3EjttfhKGl0AlZzh3TWxr4wueWRraYtP6xGkufRZuxZOoklem
         U9KvX5AKqU3OXt6iNM8MbIj+QvWRd78Fi0rtzqVji9W2RGZpqzLu/AtJQBsdiI6PGAtw
         xKm3Ue1BAuu4TkrvYllr6awcZlCwXMqIGxTUDqwdngWPqBDm3r9UBebmcyx27HNidx8t
         dWQlErTkbzwO2OvDUxecMuR/u5aodihSb11XmIeTXZoXZGcZnQwfzXBjXtDx+4bmqGJi
         fbXQ==
X-Gm-Message-State: AOAM53286xbZCBqhX+YXWOk/x0/aWZK6Qf4bv46Pw8MbF2JESpwg/eQO
        2OS50UrsakC9oW1ba7e6oH0=
X-Google-Smtp-Source: ABdhPJwFpk4uhnBWldMu3apGnerq6DPfo3aCG0/+xTt75ei2oqKCcpBQCcfgWekDts+hfCPSNpLScQ==
X-Received: by 2002:a17:902:7008:: with SMTP id y8mr605240plk.85.1594661997540;
        Mon, 13 Jul 2020 10:39:57 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id w9sm186540pja.39.2020.07.13.10.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:39:57 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: [PATCH v3 3/3] ide: delkin_cb: use generic power management
Date:   Mon, 13 Jul 2020 23:06:13 +0530
Message-Id: <20200713173613.2095-4-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713173613.2095-1-vaibhavgupta40@gmail.com>
References: <20200713173613.2095-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

With the support of generic PM callbacks, drivers no longer need to use
legacy .suspend() and .resume() in which they had to maintain PCI states
changes and device's power state themselves. All required operations are
done by PCI core.

After converting it into generic model, suspend() became an empty function.
Hence, it is defined as NULL.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/ide/delkin_cb.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/ide/delkin_cb.c b/drivers/ide/delkin_cb.c
index 300daabaa575..a711b64dbd1c 100644
--- a/drivers/ide/delkin_cb.c
+++ b/drivers/ide/delkin_cb.c
@@ -123,39 +123,18 @@ delkin_cb_remove (struct pci_dev *dev)
 	pci_disable_device(dev);
 }
 
-#ifdef CONFIG_PM
-static int delkin_cb_suspend(struct pci_dev *dev, pm_message_t state)
-{
-	pci_save_state(dev);
-	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
-
-	return 0;
-}
+#define delkin_cb_suspend NULL
 
-static int delkin_cb_resume(struct pci_dev *dev)
+static int __maybe_unused delkin_cb_resume(struct device *dev_d)
 {
+	struct pci_dev *dev = to_pci_dev(dev_d);
 	struct ide_host *host = pci_get_drvdata(dev);
-	int rc;
-
-	pci_set_power_state(dev, PCI_D0);
-
-	rc = pci_enable_device(dev);
-	if (rc)
-		return rc;
-
-	pci_restore_state(dev);
-	pci_set_master(dev);
 
 	if (host->init_chipset)
 		host->init_chipset(dev);
 
 	return 0;
 }
-#else
-#define delkin_cb_suspend NULL
-#define delkin_cb_resume NULL
-#endif
 
 static struct pci_device_id delkin_cb_pci_tbl[] = {
 	{ 0x1145, 0xf021, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
@@ -164,13 +143,14 @@ static struct pci_device_id delkin_cb_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, delkin_cb_pci_tbl);
 
+static SIMPLE_DEV_PM_OPS(delkin_cb_pm_ops, delkin_cb_suspend, delkin_cb_resume);
+
 static struct pci_driver delkin_cb_pci_driver = {
 	.name		= "Delkin-ASKA-Workbit Cardbus IDE",
 	.id_table	= delkin_cb_pci_tbl,
 	.probe		= delkin_cb_probe,
 	.remove		= delkin_cb_remove,
-	.suspend	= delkin_cb_suspend,
-	.resume		= delkin_cb_resume,
+	.driver.pm	= &delkin_cb_pm_ops,
 };
 
 module_pci_driver(delkin_cb_pci_driver);
-- 
2.27.0

