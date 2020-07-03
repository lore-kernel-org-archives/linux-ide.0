Return-Path: <SRS0=r3tH=AO=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D959C433E2
	for <linux-ide@archiver.kernel.org>; Fri,  3 Jul 2020 08:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B482207FF
	for <linux-ide@archiver.kernel.org>; Fri,  3 Jul 2020 08:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtQYdBra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGCIQp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgGCIQo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Jul 2020 04:16:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7970AC08C5C1;
        Fri,  3 Jul 2020 01:16:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 72so1801600ple.0;
        Fri, 03 Jul 2020 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x4o+ZvPMksH/mCK/c/HDn/RkcQN7O7pX0UDd4MLfNlo=;
        b=AtQYdBra+JVvn7sj0HuVvPfyV1r50bN0iVzn7jdSs2k+//yzu6cTSzWBMz8S1hW31d
         bOKth8SXUtKb7zsPAxXQ+ON/CROJ0PfiTI2wxUkgefQcR3dI9E1lowVXGbGhNS3SHBb8
         p2Il4tpZmjvqUQU2Vpn3mI1k3QecOwv6y9Q0dX9IJCO4dClSRVNqfsPzA6T0CrqJJGN8
         9PPnc9lnfT77XLRLLEp39G2LnAt/V417LsYwto6Dr3NYKay0aSL/2yX9cBTifRBVDfqr
         Bb5fIJy39QsBGnAR+r2lLk6PXv9+/kv8mKlUvbTn6TmgfgFTscUHOeXFcRADOBiTk4ey
         dXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4o+ZvPMksH/mCK/c/HDn/RkcQN7O7pX0UDd4MLfNlo=;
        b=j2JAIe8SSG+c4KLD7vhc6CtK4CxIX6YJN2i1COhu/eGGvOtMN+Jvgx0YODszQJnNC6
         V/PCvZXxXUm3ph1E5ZrIihyg2JcX4agXnMSgeSasaEGI5Oq+vawxvcAVJ5oJm3dKek0F
         Y9Af5wSdJqneJKx46jpZqPLn3jOgxiwzMn4t06pnfzGcfB8wEwhVkH1IzleZ99Ggudwi
         5gtEEm1yVgo9Fy4gx8TpEigFifyqzWGkn3cNXJnpm3UsAO70NtBg5PVUpqtVNOd8OcQ5
         4Hqt7OH+OF77M4kZ18BkpCLx3eBoMy2ywb8+1pj1khs2mSx4adeizsHtN/WivppFuKCF
         SJJQ==
X-Gm-Message-State: AOAM531g9HvLHbEldPiCLdIydBIum8HZasDfjwXuxrhO3XcJ2n0B0Uxm
        O/X+vQ4rQk/dT/N4EbRVng0=
X-Google-Smtp-Source: ABdhPJwcLuW1N9f00/vsxYLUKzRnYyskZOoTPkdh2DaBblE/O9vUa5fbHi6nQfPhfqUr2oI7fnv7Lw==
X-Received: by 2002:a17:90a:20ad:: with SMTP id f42mr25987368pjg.96.1593764203990;
        Fri, 03 Jul 2020 01:16:43 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.57])
        by smtp.gmail.com with ESMTPSA id y198sm8437085pfg.116.2020.07.03.01.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:16:43 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: [PATCH v2 4/4] ide: delkin_cb: use generic power management
Date:   Fri,  3 Jul 2020 13:44:28 +0530
Message-Id: <20200703081428.1011527-5-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703081428.1011527-1-vaibhavgupta40@gmail.com>
References: <20200703081428.1011527-1-vaibhavgupta40@gmail.com>
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
 drivers/ide/delkin_cb.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/ide/delkin_cb.c b/drivers/ide/delkin_cb.c
index 300daabaa575..a8a1af6aa1c1 100644
--- a/drivers/ide/delkin_cb.c
+++ b/drivers/ide/delkin_cb.c
@@ -123,28 +123,13 @@ delkin_cb_remove (struct pci_dev *dev)
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
 
-	pci_set_power_state(dev, PCI_D0);
-
-	rc = pci_enable_device(dev);
-	if (rc)
-		return rc;
-
-	pci_restore_state(dev);
 	pci_set_master(dev);
 
 	if (host->init_chipset)
@@ -152,10 +137,6 @@ static int delkin_cb_resume(struct pci_dev *dev)
 
 	return 0;
 }
-#else
-#define delkin_cb_suspend NULL
-#define delkin_cb_resume NULL
-#endif
 
 static struct pci_device_id delkin_cb_pci_tbl[] = {
 	{ 0x1145, 0xf021, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
@@ -164,13 +145,14 @@ static struct pci_device_id delkin_cb_pci_tbl[] = {
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

