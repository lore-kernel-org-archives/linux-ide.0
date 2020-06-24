Return-Path: <SRS0=5ANp=AF=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88930C433E0
	for <linux-ide@archiver.kernel.org>; Wed, 24 Jun 2020 17:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B6620773
	for <linux-ide@archiver.kernel.org>; Wed, 24 Jun 2020 17:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fq3jmg6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405577AbgFXRam (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405412AbgFXRaj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2020 13:30:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0339AC061573;
        Wed, 24 Jun 2020 10:30:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u128so1711871pgu.13;
        Wed, 24 Jun 2020 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HVSIsIhF4vtA9M97P2wIfI+PdikMXEfJ9b+6szRz+k=;
        b=Fq3jmg6viJhUzrrzBnM9gPXNXEbFgCrImbOXtH5xts6XpWmb5+BtyusDL897IoSNec
         lFUL8GGVo1w3QxzTvfSCtZzMUdLsbEWhDFx/E4HB2gvvDevXaiSsvOoRuPG+5h3/gKxM
         9PrOLyO2GK8J1RvN/hxg3skw4+gxo7l6WOC/A7WG/YtXU0xHHYLcZJITERyAz4EjN+Iu
         jiO6e6quoM8/pncGxDhnQRworCqCW+HxYcJtpF6TVV9AReReCoIXy+j+EUX428i7LwuE
         jXw+18WBbqUcIK5PIMkDtvie35lmCH3YQxPbfVtSOqN0YQrKqNllMGqUIQcEtiq+1mL+
         UOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HVSIsIhF4vtA9M97P2wIfI+PdikMXEfJ9b+6szRz+k=;
        b=rsncTgCDls1P7cgLCQr7dTrNGRIqQ4kBfcCjDkDNq0lbuOebnD8QTt9VDP6g7aLJdk
         6ORys04EgK5xHHmIzWFavICGfxQ9wJvv3O9/YkUHG6at+gAXju+xweIRVRBNG6wYiACa
         r2Ab9/rtTbo4KlopmFo3UqWn57MiTXMWj/A6m9kuZhqa5kk/EGU1gEYm7OQN7p5iludK
         FGEmV9/QRvdZ8grU2kGpnuvVv8bwEFQPzn1hbB1eE8PLkVV3LK5Ytt806XIL9h7Gu+10
         KDbekR+bXgWiuvloPexVvDAt1Q8SCB2xGCWMqD+4OAbevhdawgUY91lZI4VwxpdDs5dt
         0QSA==
X-Gm-Message-State: AOAM531K5RSHB+7q6VcEomcUYS+s07VuXOF896EToOy7uRoyu7pC8KRE
        yUR4r9caSvUNdjqs6hlDleFFbZuMqermeA==
X-Google-Smtp-Source: ABdhPJyr353InAhP3GPBTsaACmUaSmfDnL6l6uOv9TYFVlWaY/FPStDKebr2lqV4JJ/wMB7HUYyE0g==
X-Received: by 2002:a63:c58:: with SMTP id 24mr12305638pgm.343.1593019837527;
        Wed, 24 Jun 2020 10:30:37 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.57])
        by smtp.gmail.com with ESMTPSA id z11sm21187215pfk.141.2020.06.24.10.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:30:37 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: [PATCH v1 4/4] ide: delkin_cb: use generic power management
Date:   Wed, 24 Jun 2020 22:58:57 +0530
Message-Id: <20200624172857.60915-5-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624172857.60915-1-vaibhavgupta40@gmail.com>
References: <20200624172857.60915-1-vaibhavgupta40@gmail.com>
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
 drivers/ide/delkin_cb.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/ide/delkin_cb.c b/drivers/ide/delkin_cb.c
index 300daabaa575..8a3dc4dd6e66 100644
--- a/drivers/ide/delkin_cb.c
+++ b/drivers/ide/delkin_cb.c
@@ -123,39 +123,17 @@ delkin_cb_remove (struct pci_dev *dev)
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
-	struct ide_host *host = pci_get_drvdata(dev);
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
+	struct ide_host *host = dev_get_drvdata(dev_d);
 
 	if (host->init_chipset)
-		host->init_chipset(dev);
+		host->init_chipset(to_pci_dev(dev_d));
 
 	return 0;
 }
-#else
-#define delkin_cb_suspend NULL
-#define delkin_cb_resume NULL
-#endif
 
 static struct pci_device_id delkin_cb_pci_tbl[] = {
 	{ 0x1145, 0xf021, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
@@ -164,13 +142,14 @@ static struct pci_device_id delkin_cb_pci_tbl[] = {
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

