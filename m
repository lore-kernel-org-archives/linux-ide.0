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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722FCC433E7
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jul 2020 17:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F7B2075D
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jul 2020 17:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Apxn/0ow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgGMRjm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgGMRjl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jul 2020 13:39:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B883C061755;
        Mon, 13 Jul 2020 10:39:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k71so214110pje.0;
        Mon, 13 Jul 2020 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJozJ1j72j2TPhbNEWh15qJXYyA6M4xq/pVyTeWMQoY=;
        b=Apxn/0ow0f66cwPy2V02qp3gW05kJVRQX9wUkIztm8FsQBSdqKK93JBQf9csYYsyYe
         E8Evzd+K22hPzOEogE80ynZlRBPvdlXkwoaBKzCfnl6rzpTn/S0+EtMtqU7sREb4ySky
         eW5FoLtyjM1v4PHxzrhi5d65iNUYtYNrnETtLS130Ydsc0JANGbgNNGWbCBtNX2c3rOk
         p3rbj9BnCGxAUl1JhE9AgtHJ74lIJs6KQQvtmdIHg4oUbOyLvxgYkVbxbdce5QXh7irW
         /FWy792M56yjvn/uMAvML5yT2rhW2Dz3A7tr7XyjoqRZRYNXqvDU0yYfrFi4Xz1Utuin
         xiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJozJ1j72j2TPhbNEWh15qJXYyA6M4xq/pVyTeWMQoY=;
        b=tm1camEWqGFNBZCn/VmBcCQZ3O7qGLxIfeGVPmGAgqKwCb1/8kLqxMtTdh5qMcfbuB
         AIWtjvqFzzZrA5TVcqNX0TzxOSnzhl5wi5xY5Rgx3Fxl+js8aXMUQT9gO4+TncdrP3rF
         vbgFgvyWAwH/9Wa6cw/rMCX07p8i5WBDGFNRTIj79JtveWUG0/hjsqUQM0mFTokUiZQr
         i0KELoWA8MO1uLSWcX0j9SwJvuOXl01L22VQByuFBAwo0yhvsLOYo7f35gC/SUlvpdmQ
         Ig2wS3oOL76mfheDqGZz1+IJU0aicdVxfhvTTFndLXtW+Trneraf0EsoixTyhbDfofyv
         NElw==
X-Gm-Message-State: AOAM530PcLlzM9OIvwTwJVCgL5ky+e5AY3k77GIe5EbZCsTxnPrJjRV7
        9WMr7Vauy8Rcx0wAoRwKbI4=
X-Google-Smtp-Source: ABdhPJx+oYUmozuuSRlNJBXRPp4H5LFeqXIBIb8CkNLdcZPUd/IDmxqDALDVHVN5pd7SagphpLpqeA==
X-Received: by 2002:a17:902:a418:: with SMTP id p24mr652601plq.55.1594661981023;
        Mon, 13 Jul 2020 10:39:41 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id w9sm186540pja.39.2020.07.13.10.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 10:39:40 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: [PATCH v3 2/3] ide: sc1200: use generic power management
Date:   Mon, 13 Jul 2020 23:06:12 +0530
Message-Id: <20200713173613.2095-3-vaibhavgupta40@gmail.com>
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
changes and device's power state themselves. The required operations are
done by PCI core.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/ide/sc1200.c | 43 ++++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/ide/sc1200.c b/drivers/ide/sc1200.c
index a5b701818405..91a197832d1f 100644
--- a/drivers/ide/sc1200.c
+++ b/drivers/ide/sc1200.c
@@ -222,46 +222,33 @@ static void sc1200_set_pio_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 	sc1200_tunepio(drive, pio);
 }
 
-#ifdef CONFIG_PM
 struct sc1200_saved_state {
 	u32 regs[8];
 };
 
-static int sc1200_suspend (struct pci_dev *dev, pm_message_t state)
+static int __maybe_unused sc1200_suspend(struct device *dev_d)
 {
-	printk("SC1200: suspend(%u)\n", state.event);
+	struct pci_dev *dev = to_pci_dev(dev_d);
+	struct ide_host *host = pci_get_drvdata(dev);
+	struct sc1200_saved_state *ss = host->host_priv;
+	unsigned int r;
 
 	/*
-	 * we only save state when going from full power to less
+	 * save timing registers
+	 * (this may be unnecessary if BIOS also does it)
 	 */
-	if (state.event == PM_EVENT_ON) {
-		struct ide_host *host = pci_get_drvdata(dev);
-		struct sc1200_saved_state *ss = host->host_priv;
-		unsigned int r;
-
-		/*
-		 * save timing registers
-		 * (this may be unnecessary if BIOS also does it)
-		 */
-		for (r = 0; r < 8; r++)
-			pci_read_config_dword(dev, 0x40 + r * 4, &ss->regs[r]);
-	}
+	for (r = 0; r < 8; r++)
+		pci_read_config_dword(dev, 0x40 + r * 4, &ss->regs[r]);
 
-	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
 	return 0;
 }
 
-static int sc1200_resume (struct pci_dev *dev)
+static int __maybe_unused sc1200_resume(struct device *dev_d)
 {
+	struct pci_dev *dev = to_pci_dev(dev_d);
 	struct ide_host *host = pci_get_drvdata(dev);
 	struct sc1200_saved_state *ss = host->host_priv;
 	unsigned int r;
-	int i;
-
-	i = pci_enable_device(dev);
-	if (i)
-		return i;
 
 	/*
 	 * restore timing registers
@@ -272,7 +259,6 @@ static int sc1200_resume (struct pci_dev *dev)
 
 	return 0;
 }
-#endif
 
 static const struct ide_port_ops sc1200_port_ops = {
 	.set_pio_mode		= sc1200_set_pio_mode,
@@ -326,15 +312,14 @@ static const struct pci_device_id sc1200_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, sc1200_pci_tbl);
 
+static SIMPLE_DEV_PM_OPS(sc1200_pm_ops, sc1200_suspend, sc1200_resume);
+
 static struct pci_driver sc1200_pci_driver = {
 	.name		= "SC1200_IDE",
 	.id_table	= sc1200_pci_tbl,
 	.probe		= sc1200_init_one,
 	.remove		= ide_pci_remove,
-#ifdef CONFIG_PM
-	.suspend	= sc1200_suspend,
-	.resume		= sc1200_resume,
-#endif
+	.driver.pm	= &sc1200_pm_ops,
 };
 
 static int __init sc1200_ide_init(void)
-- 
2.27.0

