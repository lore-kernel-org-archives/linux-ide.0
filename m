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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A304C433E1
	for <linux-ide@archiver.kernel.org>; Wed, 24 Jun 2020 17:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC5820768
	for <linux-ide@archiver.kernel.org>; Wed, 24 Jun 2020 17:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG9nr2JY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405584AbgFXRaf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405412AbgFXRae (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2020 13:30:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0266DC061573;
        Wed, 24 Jun 2020 10:30:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 35so1328686ple.0;
        Wed, 24 Jun 2020 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJozJ1j72j2TPhbNEWh15qJXYyA6M4xq/pVyTeWMQoY=;
        b=OG9nr2JYFkHQeALLtyTKcxsbgE7wCbLEiBdPfxHp10CmN1aBLQERA1m+bNX5N4F3Pg
         m7y5Esmy4AXqqIj6ynXenmNmWaZKi6lZJZgnKwPPr06VZXfgvDhEwBfIpts8Q/J9EFvy
         ajgp9LX83oXGuRoLijPkz4SM7zvdMb/zuga4Wnga7fvnUeibCRAOO4hmbNdHgiDiISO+
         YugxogygMh9AmaRiQzsnBe+jPQY1a4+fbDP0VE8A6NEv8WK/PHfgEm+VxHjq2z4b3P7K
         NjMRsZZFfnWrmGkvk7/Y6No11mxjPkQSk/L0GHqUsSopN4EhKYSfw3hDVfaQ8h//WSQ9
         om2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJozJ1j72j2TPhbNEWh15qJXYyA6M4xq/pVyTeWMQoY=;
        b=TgcIcrTSBfaPIA6cKGLVRKI17FsKXaTV0Dk4UWUmjmflp9t01PI52tVIXZwp8zVP+p
         vCl+HpLocY7TDA7WDqzqwUO4uqCs3p0D1vRpzL7h6ozM1iyyDHworVtIT8n69YxSx4Ah
         M9hEi2ius8hU7uRQrsfkbFh1S8Y6DSERrip0z42E3eBxFmRkIXQnckO2ZDVIHENkts1e
         +yDKDmHtzRYqjMi7KXc8z7opRtAGBeAS3EpXnNaRdBNgywkzYufNIMHTPBpFmZ+3JPG6
         RPtJ89BR5BgYTMK/LWBcMwXTocjkXHr9QVlFNjNLDFbRY+inIpNuMNxPQMe5NRQtL2tb
         tBJg==
X-Gm-Message-State: AOAM533ErpqmnxF7c5EBTJqxYp6SsoB2Yc0xFy9FDcxr4UHc/HDEr8Jy
        O7aCXbUkVJbverBuUO9dPvc=
X-Google-Smtp-Source: ABdhPJz239rrFDKODjZnmMjv567clz1XhGbUtxzIf/rRXiatnuQRf92A5OuBWGvTApB3hN+B8cU1JA==
X-Received: by 2002:a17:902:a60e:: with SMTP id u14mr4275213plq.238.1593019832464;
        Wed, 24 Jun 2020 10:30:32 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.57])
        by smtp.gmail.com with ESMTPSA id z11sm21187215pfk.141.2020.06.24.10.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:30:31 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: [PATCH v1 3/4] ide: sc1200: use generic power management
Date:   Wed, 24 Jun 2020 22:58:56 +0530
Message-Id: <20200624172857.60915-4-vaibhavgupta40@gmail.com>
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

