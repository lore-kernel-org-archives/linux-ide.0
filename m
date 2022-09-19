Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A703C54EE9
	for <linux-ide@archiver.kernel.org>; Mon, 19 Sep 2022 11:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiISLQz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 19 Sep 2022 07:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiISLQx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 19 Sep 2022 07:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008D8101DC
        for <linux-ide@vger.kernel.org>; Mon, 19 Sep 2022 04:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663586211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+Bz0UOQAJOXRrtdCnmyKdFMTMhYr8+15WKdruE59Rlc=;
        b=L9YGiNDSPdrtnbHPEmwLi07HgdqrQ5+jJ6wsB/03HVjG12/VccOPy4ENm6+GpjZuntSjXc
        TeO/gejrrn1d8UKZ28fAQfCls2EpsJ7wXuzZKTBTu33Nfbky59unMgeiRr5+FUDjkZ3T5w
        2aZnIVTHhPEGcac61TTJSCNJ+5aYpcM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646-T7u_gLRUNNmKtYYhujPKng-1; Mon, 19 Sep 2022 07:16:49 -0400
X-MC-Unique: T7u_gLRUNNmKtYYhujPKng-1
Received: by mail-wr1-f72.google.com with SMTP id d9-20020adfa349000000b0022ad6fb2845so1428872wrb.17
        for <linux-ide@vger.kernel.org>; Mon, 19 Sep 2022 04:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+Bz0UOQAJOXRrtdCnmyKdFMTMhYr8+15WKdruE59Rlc=;
        b=J1QpEtTJ6FGZ2ReeqpWSjPy4qLGKHXdBlyO6DyLFb3Vgjv2+SQdzx7Tk4OBLPkb73Y
         gC+uuv3EfWU1yNwIByyU60Isk4XlumggVBGMnx1srWjJRoS5kLB+DJxn7I3/Lm31gU6P
         jhKxPBPTO/rVyiE4hEZqUSCzFwiTEmFlvqmhdeinqVoTkGb8q/jqDx8NzZmenyFbhMJQ
         hZErnPXF2BbOTjti7aeBQoqwDz3pPP0aHfuM4azI0pzl8CSYL02i+11AtOxSzngTb1kC
         aKus1KskniWHfy3j6pdc+yCxZqMuu0l+ZlJLGXFEAij3O5rt1BIz1oVTTWm2O7jmsmJs
         Qq1A==
X-Gm-Message-State: ACrzQf0qGOTR5c+iM5FWum+QJRSRpKHeCtac5h9pgIHaeOcWgbzzpWmK
        7rDcdM+ygOQUBC/P1onpcXbKwNrrGa7f9GmN8N/BHMj786KOK4S/K/V76T87u7H88wJ5H9tBTr4
        q44uCR4neLigcB7Zlz67M
X-Received: by 2002:a5d:58f8:0:b0:22a:f284:496e with SMTP id f24-20020a5d58f8000000b0022af284496emr5928697wrd.501.1663586208789;
        Mon, 19 Sep 2022 04:16:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4+YoLASGIvhgO3CYh57x41pdBvHMpazmIJpNV+9J15jjkYoSQD4i/JuZFbP+vWbBIeHI/u/g==
X-Received: by 2002:a5d:58f8:0:b0:22a:f284:496e with SMTP id f24-20020a5d58f8000000b0022af284496emr5928681wrd.501.1663586208587;
        Mon, 19 Sep 2022 04:16:48 -0700 (PDT)
Received: from p1.Home ([2001:8a0:6724:4500:dc68:d331:1862:9fcb])
        by smtp.gmail.com with ESMTPSA id k21-20020adfb355000000b0022584c82c80sm13424911wrd.19.2022.09.19.04.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 04:16:47 -0700 (PDT)
From:   Eric Curtin <ecurtin@redhat.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     Eric Curtin <ecurtin@redhat.com>, linux-kernel@vger.kernel.org,
        Brian Masney <bmasney@redhat.com>, Al Stone <ahs3@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Joe Konno <joe.konno@intel.com>
Subject: [PATCH] ata: ahci: Enable/Disable ATA Staggered Spin-up by default
Date:   Mon, 19 Sep 2022 10:46:39 +0100
Message-Id: <20220919094635.184804-1-ecurtin@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On some kernels tuned for performance, you want to always favour
spin-up time versus power draw. This adds the ability to always favour
spin-up time by default (disabling Staggered Spin-up favours
performance, rather than power draw).

Regardless of whether this is enabled or disabled the
libahci.ignore_sss option will override any kernel config.

Signed-off-by: Eric Curtin <ecurtin@redhat.com>
---
 drivers/ata/Kconfig   | 15 +++++++++++++++
 drivers/ata/libahci.c |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 1c9f4fb2595d..36b11fbcf644 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -67,6 +67,21 @@ config ATA_FORCE
 
 	  If unsure, say Y.
 
+config ATA_SSS
+        bool "Enable ATA Staggered Spin-up by default"
+        default y
+        help
+          This option denotes whether Staggered Spin-up capability on
+          storage controllers is used. Staggered Spin-up reduces
+          peak power draw, but decreases performance. If this config is
+          set to N, Staggered Spin-up capability will be ignored by
+          default.
+
+          This can be overridden by using the kernel argument
+          libahci.ignore_sss.
+
+          If unsure, say Y.
+
 config ATA_ACPI
 	bool "ATA ACPI Support"
 	depends on ACPI
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index cf8c7fd59ada..b7b573d47fda 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -33,7 +33,7 @@
 #include "libata.h"
 
 static int ahci_skip_host_reset;
-int ahci_ignore_sss;
+int ahci_ignore_sss = !IS_ENABLED(CONFIG_ATA_SSS);
 EXPORT_SYMBOL_GPL(ahci_ignore_sss);
 
 module_param_named(skip_host_reset, ahci_skip_host_reset, int, 0444);
-- 
2.37.3

