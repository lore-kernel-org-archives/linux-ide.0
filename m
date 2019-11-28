Return-Path: <SRS0=sTlp=ZU=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E74C432C3
	for <linux-ide@archiver.kernel.org>; Thu, 28 Nov 2019 08:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA7E2176D
	for <linux-ide@archiver.kernel.org>; Thu, 28 Nov 2019 08:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="FNYJx1kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfK1ILV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:11:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43358 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfK1ILV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 28 Nov 2019 03:11:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id q16so7075982plr.10
        for <linux-ide@vger.kernel.org>; Thu, 28 Nov 2019 00:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/GhN/CYsiRUWVz52gd5JGKtSUoupS+PdXzJYF/Cc8k=;
        b=FNYJx1kdbLHj9iR60nnvsEGZEaKFTjOmg0G0MnY7CRSlyNtEP87oYykgt5psRsa4ml
         GlZrAQhtDLsEBX37OjvTNtYW35kq0TJdbTaSja19RHqqWG50iR3FS8GA64hyhQJGRFKZ
         vAIENIzkxv4CImBHl8k4Q1cVi0nsFCGtrn5LzbdBo8LcJhZfTfQP6W5oiaWLOyzfS02o
         C/H/lw9trG4KdA1d2ARKEKPrVAslqtflACgdY3RWUO8Kh6XGM3vKIct0vliVDwCipmGK
         587hZF/fC1fWuOc2ZmAlcUMQhj7XsCRgLhXBotNVsGdrCEP1w4grLZWLxiDW7lZueVx8
         NwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/GhN/CYsiRUWVz52gd5JGKtSUoupS+PdXzJYF/Cc8k=;
        b=dijwFYHVLQv9p3JHH48dtXK+CuRf0sXcNkEgxkW4eNB91tOGNqxI3ldDyylaDovx7x
         JNrjXfDbRERdle3B0sleE2AM3lUkuXYYXu4c7jbp4cNtSkdH3VM7tmZtU17iHjA2/Sq1
         8CDrDgFS9RNfN7hDjqgtr/S0TsBcqr0LhzhaUZpB8j5AuFDdzVzpDI5Bvu4ehQVu5otS
         4jAa1iERCQyg4ChNIRDArisqiXnYmHzRMVQuuLn0Yqose3unRr41gQX/q3/g4uPlCVQz
         4U/dgyqnm+znGhMrCDLB+SSu+6ZvtRe051VVKIj20nznYRF3jhU/dnZstlunhHcjp0v7
         syrA==
X-Gm-Message-State: APjAAAVbDf0aTRAxvgg5B45/VA47FTFcaYf90ic1wlWc20E7GgvdSqpT
        DgHxfXx7P0ZveUGUziHfu9kPvA==
X-Google-Smtp-Source: APXvYqznYal4NAldeLQ4QS7qBNETlYZpDDXWJse1Y/WYjGufOSeGy5IbkPuTp+1EmglENTh/B1Gfew==
X-Received: by 2002:a17:90b:46cf:: with SMTP id jx15mr11476702pjb.19.1574928678161;
        Thu, 28 Nov 2019 00:11:18 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id a3sm9364110pjh.31.2019.11.28.00.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 00:11:17 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] ahci: Add Intel Comet Lake PCH RAID PCI ID
Date:   Thu, 28 Nov 2019 16:10:42 +0800
Message-Id: <20191128081041.6948-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Intel Comet Lake should use the default LPM policy for mobile chipsets.
So, add the PCI ID to the driver list of supported devices.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ec6c64fce74a..d9b3a9f7a4ee 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -405,6 +405,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_mobile }, /* Cherry Tr. AHCI */
 	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_mobile }, /* ApolloLake AHCI */
 	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_mobile }, /* Ice Lake LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_mobile }, /* Comet Lake PCH RAID */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-- 
2.20.1

