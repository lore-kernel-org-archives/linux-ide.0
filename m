Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3EEC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 08:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C477B60EBD
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 08:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbhJKJBu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 05:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbhJKJBu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 05:01:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757B8C061570
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 01:59:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g25so7239599wrb.2
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 01:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XkKROncgENSnRjTIrJAnQlc/JMhbx8Zp/rLJ67auIjU=;
        b=eHqmxBoDnCHOYVIo7n7ckk0QA6+QHZm+NREFYxmbKIu+Wdr0eypxU/QYli1K0KlACU
         CZH639oh53Dn2DMK6mt1qpwu1OCZIJMBppPo1Dq4b4qmHV4/gPKoEN8R8X+4YVT/KUTv
         q3LPXJNfkJbqs1NRF3w4hgh++f3QwwrB3VrQelzaU8K0OJo0KcEkjlxgQ1wCxtjdXzD9
         hwWsQDj8/TzCEHRTteh95m8qA0X4FwEIbIsr3vx41w2DJ46L65WvjCvhLi3G+Ou6uX2P
         tiohOpoO2dnqG9E5MoamuIpH2c0ViwDcmE4dr4xZoLrjYdJFgdre3GlQH9cvkOhROlZn
         XO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XkKROncgENSnRjTIrJAnQlc/JMhbx8Zp/rLJ67auIjU=;
        b=o0MwIEQamcc5YJGpMbQvuau3J1eb1LnOIZ6NGa7LEvSjEsRMucSfBJlfHlRCo9GDVJ
         ZrC+2qjlRRs63W61AqBhRNwUYVBbqub9DgUi5wj3ySfdb4IhWx82Qw09OkP6S9NkRx6i
         oAF4qlKH+wTnMk6Wj31aV6/7BoUZZKDOMCLiukLkXZjpx6Rgp3QC8xe2q/tHrSwYtHWe
         66LFk5u1HQ7VNRrBpHUtWMW07q0IxzmY+JYlv6ngorHqT0cn53jDcxcAuG+RYjlCtilq
         sHO0LsQt9Xy60+lFAAna55FqaRNMmfyAd9F9lm7SE1QVEqh7lhscPa8G3f+YN+3jM34X
         MIHA==
X-Gm-Message-State: AOAM530D+HqLt2GiWj5odYzukhSVAQrxlIXMOqMZxgGiYXavgMX7hXL8
        Dxza4X/GT4oWR7WdfqFO523yRfUseHQ=
X-Google-Smtp-Source: ABdhPJzeRHrpGTT5RLCqImrx8+Y2Atg12dyoWKNNVp2lBxTzFcvY34NkARlPHhegsB0sLzT9Zk7RXA==
X-Received: by 2002:a05:600c:4f53:: with SMTP id m19mr19872449wmq.118.1633942788941;
        Mon, 11 Oct 2021 01:59:48 -0700 (PDT)
Received: from hal9001.startit.hu (hal9001.startit.hu. [213.134.5.39])
        by smtp.googlemail.com with ESMTPSA id 25sm4072125wmo.18.2021.10.11.01.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 01:59:48 -0700 (PDT)
From:   =?UTF-8?q?Istv=C3=A1n=20Pongr=C3=A1cz?= <pongracz.istvan@gmail.com>
To:     linux-ide@vger.kernel.org, damien.lemoal@opensource.wdc.com
Cc:     =?UTF-8?q?Istv=C3=A1n=20Pongr=C3=A1cz?= <pongracz.istvan@gmail.com>
Subject: [PATCH] Add AHCI support for (noname) PCIe sata cards based on ASM1062+JBM575 cards, usually 10 SATA ports or more. DeviceID: 0624 (rev 01)
Date:   Mon, 11 Oct 2021 10:59:36 +0200
Message-Id: <20211011085936.4307-1-pongracz.istvan@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

---
 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 186cbf90c8ea..f8199f021ed4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -592,6 +592,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
 	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
+	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASMedia Technology Inc. Device 0624 (rev 01) based PCIe port multiplier cards (ex. 10 ports card with 1 x ASM1062 + 2 x JMB575 */
 
 	/*
 	 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
-- 
2.20.1

