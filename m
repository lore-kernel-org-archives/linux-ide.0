Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256D2C433E0
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC1A16024A
	for <linux-ide@archiver.kernel.org>; Mon,  1 Feb 2021 14:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhBAOlR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhBAOlH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2021 09:41:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E0BC061786
        for <linux-ide@vger.kernel.org>; Mon,  1 Feb 2021 06:39:47 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c12so16832236wrc.7
        for <linux-ide@vger.kernel.org>; Mon, 01 Feb 2021 06:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gat9ASy8Tcpn7xEHDYjYiqg8W2NDPEgsm5bh/q38djM=;
        b=fH2blJ/9WloA7c89067CkGeyLeJbGeZw97hzfm2jXLSDKqrGNCmhB0L6CaC6Zc6ufn
         kT9E8zZ2amBOvGyKjiU7u6EtNTshpZDBlKJZ9uiaqv561tbIbxQ+VLATlcCWlbW2IVfY
         JMm5X0w4Rs2ddWn+z17hxVYRLfJWpafg08jgGQwrPATJw1kl0hky35KbS9ZPBdg5EhyF
         Ye7J7RO7U8gfgqG7JFMjLgSvurKEtqr45gZcCreyIlJnnPL9N7FpwjO2jrhgL4YvQW2M
         Czqy/DUiI9GXpNu5zHk/OImSrwrqCGCU6e9gksGS/GERyHaCx8MUFfEvjyz4wCSv9h4e
         nTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gat9ASy8Tcpn7xEHDYjYiqg8W2NDPEgsm5bh/q38djM=;
        b=Nwq1GflFBQsHFZqtTgQT/1n5Ee5ZcRoFnClMl8aWjKW6J3eIQBsRxufCwOKg5PDgkF
         dM1O6LAYOAdFUXT+QRfdyyWzpixNV1Z1GMcOC9gLbXb/+XP+5yk+tPynj8Gywfqnv+by
         v+l1wiwwLcK4VrcNazCQM4vbH46GhSX3NbAXwa3Zwb7Lp+QQBCT7OrthzKKkOQZ0B5ts
         YK7a6CjLt1Ck2kYksyMBjR8FsU+/tyJPtLcEvXOBLeVHFATZQe+k1MLA0bbWkgBVgqr8
         ZFvLa/UfgkAoJtWe1pXtvB+cT2mY3BymfeG/5SAxlDeMgrI9xXypMuMCalwRfiZYZl6V
         ePkQ==
X-Gm-Message-State: AOAM5329GTUDexco2lieSbQfsPYplfHvvPwBResgnzQa6PDquBR8j6Ax
        91xClTWOUZCsDFgzE7Qsi0PaL77zEHItURfT
X-Google-Smtp-Source: ABdhPJw+uU75gzUzR2FPFtHoivrzYTgwqNZQDYPKKKrkJsc+UJDKK4YBDEFjSE8aXRzHRkuVgLBA7A==
X-Received: by 2002:a5d:4806:: with SMTP id l6mr18974135wrq.389.1612190386171;
        Mon, 01 Feb 2021 06:39:46 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org
Subject: [PATCH 02/20] ata: libata-sata: Fix function names in header comments
Date:   Mon,  1 Feb 2021 14:39:22 +0000
Message-Id: <20210201143940.2070919-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/libata-sata.c:1085: warning: expecting prototype for port_alloc(). Prototype was for ata_sas_port_alloc() instead
 drivers/ata/libata-sata.c:1140: warning: expecting prototype for ata_port_stop(). Prototype was for ata_sas_port_stop() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/libata-sata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index c16423e445255..8adeab76dd382 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1067,7 +1067,7 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
 
 /**
- *	port_alloc - Allocate port for a SAS attached SATA device
+ *	ata_sas_port_alloc - Allocate port for a SAS attached SATA device
  *	@host: ATA host container for all SAS ports
  *	@port_info: Information from low-level host driver
  *	@shost: SCSI host that the scsi device is attached to
@@ -1127,7 +1127,7 @@ int ata_sas_port_start(struct ata_port *ap)
 EXPORT_SYMBOL_GPL(ata_sas_port_start);
 
 /**
- *	ata_port_stop - Undo ata_sas_port_start()
+ *	ata_sas_port_stop - Undo ata_sas_port_start()
  *	@ap: Port to shut down
  *
  *	May be used as the port_stop() entry in ata_port_operations.
-- 
2.25.1

