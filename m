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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCEAC433E1
	for <linux-ide@archiver.kernel.org>; Fri,  3 Jul 2020 08:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C777206A1
	for <linux-ide@archiver.kernel.org>; Fri,  3 Jul 2020 08:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vOZfyO1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGCIQ2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgGCIQ0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Jul 2020 04:16:26 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04A1C08C5C1;
        Fri,  3 Jul 2020 01:16:26 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cv18so7008186pjb.1;
        Fri, 03 Jul 2020 01:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UL6+9R7vje0BZ0kQ5AFUpy2CeEkUyuEVadPnyq+JkCk=;
        b=vOZfyO1WAiqg1QRdEXq/qgxvjuqJQJ8oI+Utf7kPwIa5AM7PJSKzNIYSMJoDIHwMoZ
         3uhc7vHe40p6dR9jWlhIihLnO+DYHoitu0wUyIRF3RdQpiusqkNPquq0R1kUJPdvjt0d
         +ny24UoUbQ9nwdTTVOG0nydNfKkc+Qc28np4jtbXR3y0ys4w9W/cV4ZNElhzvvm3NBvM
         8YBdd3CXWT1Ku19EzSwZ+a/yfKkDbfUa5IvC4FvapLKjvs4CxBhNkYCmD+gOy3jh/gbP
         venVCiqqsRgim1m7sDshGUAMhpbiGIvyh7cWk2tvpHeIp9gKAZekuf3ccZQmPYsHto2e
         LY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UL6+9R7vje0BZ0kQ5AFUpy2CeEkUyuEVadPnyq+JkCk=;
        b=akDOlEpnr681n4gVd9a2Pt8wJCGNhLq5cTANggn4lQlzetpBSYv6MImYG+so2YDl8x
         lwJ8dK+x5ssQYbacnJL1VyFWlCgBuYxwRXlIGUXCAxporu9xLyhz7PAbrFwuBtKrZ7J0
         hxvY3UTJUE933JOCGecXgIBQGv5hY0kxL0MokDo6xH6EuiH4nUzu0aZWTsyqWE+/m1fZ
         i0vGmIagoyrMuc5GcCHwNI7Gs5UQAFZ395iROS/GHkbm6u8qdgzXf5UrxPokGmAW+JZb
         k0lN2uv2l4RxFnV49//nbRCExF0OvJ7dmByg+OLvxreMt/0BowsSixZuE7XF3t3WSREs
         mgfA==
X-Gm-Message-State: AOAM531QepnQHcAUfc0rklZhlD28TgAEh1zHMMFKTPnlXi2Q1D7/0Q4N
        KlzRl5XLBGjzKRx572cP2sA=
X-Google-Smtp-Source: ABdhPJzgvXfwOhiSxhFXSeCk71Y5AdrtaoedTbMnZkaDsN+ETUN7cefI6v61LLojF6YoAqwOmbmi8A==
X-Received: by 2002:a17:90b:194f:: with SMTP id nk15mr22777711pjb.189.1593764186406;
        Fri, 03 Jul 2020 01:16:26 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.57])
        by smtp.gmail.com with ESMTPSA id y198sm8437085pfg.116.2020.07.03.01.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:16:26 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: [PATCH v2 2/4] ide: triflex: use generic power management
Date:   Fri,  3 Jul 2020 13:44:26 +0530
Message-Id: <20200703081428.1011527-3-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703081428.1011527-1-vaibhavgupta40@gmail.com>
References: <20200703081428.1011527-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

While upgrading ide_pci_suspend() and ide_pci_resume(), all other source
files, using same callbacks, were also updated except
drivers/ide/triflex.c. This is because the driver does not want to power
off the device during suspend. A quirk was required for the same.

This patch provides the fix. Another driver,
drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c, makes use of
a quirk for similar goal. Hence a similar quirk has been applied for
triflex.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/ide/triflex.c | 45 +++++++++++--------------------------------
 1 file changed, 11 insertions(+), 34 deletions(-)

diff --git a/drivers/ide/triflex.c b/drivers/ide/triflex.c
index 1886bbfb9e5d..f707f11c296d 100644
--- a/drivers/ide/triflex.c
+++ b/drivers/ide/triflex.c
@@ -100,48 +100,25 @@ static const struct pci_device_id triflex_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, triflex_pci_tbl);
 
-#ifdef CONFIG_PM
-static int triflex_ide_pci_suspend(struct pci_dev *dev, pm_message_t state)
-{
-	/*
-	 * We must not disable or powerdown the device.
-	 * APM bios refuses to suspend if IDE is not accessible.
-	 */
-	pci_save_state(dev);
-	return 0;
-}
-
-static int triflex_ide_pci_resume(struct pci_dev *dev)
+/*
+ * We must not disable or powerdown the device.
+ * APM bios refuses to suspend if IDE is not accessible.
+ */
+static void triflex_pci_pm_cap_fixup(struct pci_dev *pdev)
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
-
-	if (host->init_chipset)
-		host->init_chipset(dev);
-
-	return 0;
+	dev_info(&pdev->dev, "Disable triflex to be turned off by PCI CORE\n");
+	pdev->pm_cap = 0;
 }
-#else
-#define triflex_ide_pci_suspend NULL
-#define triflex_ide_pci_resume NULL
-#endif
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_COMPAQ,
+			PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE,
+			triflex_pci_pm_cap_fixup);
 
 static struct pci_driver triflex_pci_driver = {
 	.name		= "TRIFLEX_IDE",
 	.id_table	= triflex_pci_tbl,
 	.probe		= triflex_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= triflex_ide_pci_suspend,
-	.resume		= triflex_ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init triflex_ide_init(void)
-- 
2.27.0

