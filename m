Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BE7C433EF
	for <linux-ide@archiver.kernel.org>; Sat, 19 Mar 2022 20:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiCSUM3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 19 Mar 2022 16:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244081AbiCSUM3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 19 Mar 2022 16:12:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD75B15469B
        for <linux-ide@vger.kernel.org>; Sat, 19 Mar 2022 13:11:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bg10so22966030ejb.4
        for <linux-ide@vger.kernel.org>; Sat, 19 Mar 2022 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=43K6fafFnDymtIccBY3GcLmigADp3OIjZx9+u5nMKI8=;
        b=LHrjTgzKc33TUzFpXC/9uBXgciJXw3Ami9XetrqvSt7bgn0bStEqimzCZjxyfrXksl
         82LNbW2b/LJpT/Kt2QMni+ZdGnPfiTMzd+nKIJrGy8TAopmM5/KM+jMGYMbHQXGOPMJg
         KMi43O+sqAUJUqeiTQK1Pn7DWhINLR1KjxE51LnH24tUttPSetI2J8XwBKX402FqxV2D
         S8shdjkVQmIu+eXQp9/RCiXj+8KKltHHJOatbDBB8jP16g06NFJ7HggusGRinm6opCqw
         If1ygnhPQs5tSQ4r/mBjlu49Jleg6M0cOvBDc3PllTzHbHeIYvOrv1C5XslLe6e/163W
         2PDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=43K6fafFnDymtIccBY3GcLmigADp3OIjZx9+u5nMKI8=;
        b=OOsdvio4VbMJcVczb49SOTA9BD4OgMEbv/dCCMFe76qyw9TeNMEAq1WIrmMYgIMVv2
         TcpGl5XI+4KAgfOUnLiawTGNBg+FtnVe9zJuKAjuaiAZ03lDfPGHNlx1MDa1AuftlY6X
         4PFOb8wVQs44IotqzCRih5MbwtXE1UKmGet9bgbcNteY46BiNXL15Klf1L3Wn1rsosFJ
         eyJ9Badu328sj6dFsjW8rMrVPXd4PKoBN6qXJ0vTjk1RwzjfxHTHIi57e6DmtvYdB4nI
         2lBLPna0QBFITaCRppelNt+6MstfhxaulinNwled/xAXpXfxKrLgQyYu1suel7MvjRKd
         HGBQ==
X-Gm-Message-State: AOAM531KvpSNPVZMZHZ6DgFiX5ow5vUHsaXbO7I3QstPLZmfPq2tf4Yn
        N9pd91sAlNACKz749U65AGJrP4tR64o=
X-Google-Smtp-Source: ABdhPJyOJWX8rHpf4AjTfzptNPXxlKtckVmP20G3d9+KlGNljRxR1a12gR/t4eLko940kZ0Jbmks1A==
X-Received: by 2002:a17:906:17db:b0:6da:f8d8:ab53 with SMTP id u27-20020a17090617db00b006daf8d8ab53mr14158217eje.274.1647720666052;
        Sat, 19 Mar 2022 13:11:06 -0700 (PDT)
Received: from debian64.daheim (p4fd09f18.dip0.t-ipconnect.de. [79.208.159.24])
        by smtp.gmail.com with ESMTPSA id z7-20020a05640240c700b00416cee953dasm6135632edb.24.2022.03.19.13.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 13:11:05 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nVfPk-0007nG-1p;
        Sat, 19 Mar 2022 21:11:04 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-ide@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] ata: libata-core: Disable READ LOG DMA EXT for Samsung 840 EVOs
Date:   Sat, 19 Mar 2022 21:11:03 +0100
Message-Id: <fe2ff41a52ce2647fd12f69a0d6eba8e3cf05b06.1647720651.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <47b12037459a0df1748dac7440c0f5030e5c3ef4.1647720651.git.chunkeey@gmail.com>
References: <47b12037459a0df1748dac7440c0f5030e5c3ef4.1647720651.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Samsung' 840 EVO with the latest firmware (EXT0DB6Q) locks up with
the a message: "READ LOG DMA EXT failed, trying PIO" during boot.

Initially this was discovered because it caused a crash
with the sata_dwc_460ex controller on a WD MyBook Live DUO.

The reporter "Tice Rex" which has the unique opportunity that he
has two Samsung 840 EVO SSD! One with the older firmware "EXT0BB0Q"
which booted fine and didn't expose "READ LOG DMA EXT". But the
newer/latest firmware "EXT0DB6Q" caused the headaches.

BugLink: https://github.com/openwrt/openwrt/issues/9505
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
v1 -> v2: removed Reported-by Tag (Damien)
	  opened up a issue + added BugLink (Andy)
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0c854aebfe0b..760c0d81d148 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4014,6 +4014,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Samsung SSD 840 EVO*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_NO_DMA_LOG |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung SSD 840*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.35.1

