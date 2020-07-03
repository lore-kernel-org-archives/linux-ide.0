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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B18C433E2
	for <linux-ide@archiver.kernel.org>; Fri,  3 Jul 2020 08:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F15207FF
	for <linux-ide@archiver.kernel.org>; Fri,  3 Jul 2020 08:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUDbOX7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGCIQk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGCIQj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Jul 2020 04:16:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1188DC08C5C1;
        Fri,  3 Jul 2020 01:16:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 72so1801508ple.0;
        Fri, 03 Jul 2020 01:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJozJ1j72j2TPhbNEWh15qJXYyA6M4xq/pVyTeWMQoY=;
        b=LUDbOX7ZjE2lg/+Z4HMA7mUyOwRW+tSaegsAS8BVGRtTC6wbrqf88LI563Pw7dUPEu
         a4YlqQxr6SX/+4Bv9OII7MgzT+xbjBHIgWfV2TU3uV1H8674geBDtms/QNycjICzWx+I
         iy1mEPRIMh9/KcuP2wBuOwU41T/NrmGt3+j6U8wFkiXQO3hnfnsWPhM0DH5+YpY8YYJj
         nlGJljJdIGLYtbSoefs8qOlkD20afrW95ZvtxE7PCyKHkLK4sstiWyZO1fX4CY8a+3jE
         /ItoFztt+QKfwyBbVhoBVhPghkqGPVWUGQf7OYxMnbPuokhXsccM/F36BdCzBdz8fe0Q
         2q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJozJ1j72j2TPhbNEWh15qJXYyA6M4xq/pVyTeWMQoY=;
        b=g3rVonLtukSA0asNfUGBNP0tMFmCgf5GdTh7h3qN6NAllxD4q/U7s9RdN8B1rzcook
         BHpdtp9DHTqp4VU8B6Ci8aZaoA96ViX41jlfYQ4LCyu53rBh/GpJ0VxorGDqxU1tnkZ4
         hkesWJld8uiPxpoNE4JQSgebawirNiOV8BpIjqVI8sQDMGDJubRF82u56YaWdIUBTeJl
         XVtCQB2YNTlmo8FHpq1MJT3UMCRgdm+1QnkUXA/gj79kvRX//lUgE0hXekgiRvNs9L5h
         VhcdiX2CznXG2+dwcfr0mGhdRAqO/2yIOTJrVpVuYWP3Vf1glRWkWaN+8AnIzSG/c4au
         w9wA==
X-Gm-Message-State: AOAM532wW85cNjhRH+75jRK2B1aW8nMfB/vlE1K+Sx7LD5rErlC4HO6m
        27LeyG/PjZj5h8oNfIosVRI=
X-Google-Smtp-Source: ABdhPJyZIRdDAQWEtma0XTe3g5RjEI9UtTLQefwxFASVjHtZWociJvIv2qiKtVPGaBWqokDp9OWFiQ==
X-Received: by 2002:a17:902:9b93:: with SMTP id y19mr30651940plp.241.1593764198594;
        Fri, 03 Jul 2020 01:16:38 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.57])
        by smtp.gmail.com with ESMTPSA id y198sm8437085pfg.116.2020.07.03.01.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:16:38 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: [PATCH v2 3/4] ide: sc1200: use generic power management
Date:   Fri,  3 Jul 2020 13:44:27 +0530
Message-Id: <20200703081428.1011527-4-vaibhavgupta40@gmail.com>
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

