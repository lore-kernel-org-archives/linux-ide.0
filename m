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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE1EC433DF
	for <linux-ide@archiver.kernel.org>; Wed, 24 Jun 2020 17:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1881220768
	for <linux-ide@archiver.kernel.org>; Wed, 24 Jun 2020 17:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnLb42tQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405573AbgFXRab (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405412AbgFXRa1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2020 13:30:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E42C061573;
        Wed, 24 Jun 2020 10:30:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p3so1738028pgh.3;
        Wed, 24 Jun 2020 10:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UL6+9R7vje0BZ0kQ5AFUpy2CeEkUyuEVadPnyq+JkCk=;
        b=UnLb42tQPS9hg3JnXZozz25v4pvQoNS34zoJ56oVVYBz5nVC87FFf+Oi1z1AtOuUMZ
         cMfElNuuN4O4g0UTxzLVbpaW1GykIvKhAGguR6BaKiSRK0Rf83kO/QQywLDrboW0br8M
         oyFzrZ8nwauun68VrBVUyuLt2qj9bLUI1ivbYVxjXuVSoWYRIeqlFdiGKNfLWjX5kAXL
         qjofIkJIUOwwyb9MSiGOTA9wAgXJszozSZWzK0og6tWSRvfWFJi766qdcAMlTbaYq4Ef
         q7hZ/fxUWSXKGH0sAcKeL4jGARM9UDwBw8IHQLu6GxnrJVJv97WZPQnwhwdzjv09Rv+s
         lMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UL6+9R7vje0BZ0kQ5AFUpy2CeEkUyuEVadPnyq+JkCk=;
        b=jR2QEzhPmA+q34as1lxvEuwPqTxlMtMSrm2UI5HNA/TbVI32Pav31pApk7rEMswDN9
         TKRUnP7VgBR71v7eInXadEtykPuKq67NQoIAftZzFXKbV3MIAzpo5Xj5TxCbZi0dbEtF
         u4LeKr7V0evpvpZ4+8dZe9h1GsRkJ0kG4X1bHYs3BMFhZncyeGytNpEjDyBOzipSUMw7
         Ocr+cFS2w1nG0EwCqKeBDkR3amXboN4qicpyofK0U7UUKAeKksfaHT8zGNThx5EhH015
         RX7juJI1egCMS09vtr0H4ukkhy0WzMlqn7DWqn7o3xaAjBaGYPFqmqhklZPAx2rqDisx
         02Lg==
X-Gm-Message-State: AOAM531hrIxedcqfkXDA1ED7Oz5eVToOiTzzWX+YWzsSopvwHlQJXo4W
        DucpZ6JDFkICbYCOvMemMhA=
X-Google-Smtp-Source: ABdhPJyfmfN0NevwIeJlwy0n0TdrqsSRHkuPtL4isO/xRnzAtczF8CVudTR+uCdC/389p0ioTL2aMQ==
X-Received: by 2002:a65:6799:: with SMTP id e25mr17316445pgr.364.1593019826946;
        Wed, 24 Jun 2020 10:30:26 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.57])
        by smtp.gmail.com with ESMTPSA id z11sm21187215pfk.141.2020.06.24.10.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:30:26 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: [PATCH v1 2/4] ide: triflex: use generic power management
Date:   Wed, 24 Jun 2020 22:58:55 +0530
Message-Id: <20200624172857.60915-3-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624172857.60915-1-vaibhavgupta40@gmail.com>
References: <20200624172857.60915-1-vaibhavgupta40@gmail.com>
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

