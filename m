Return-Path: <SRS0=R/8C=W2=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC53C3A5A4
	for <linux-ide@archiver.kernel.org>; Fri, 30 Aug 2019 07:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1A62070B
	for <linux-ide@archiver.kernel.org>; Fri, 30 Aug 2019 07:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="mTMAOFUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfH3HRy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:17:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40556 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfH3HRx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Aug 2019 03:17:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id t9so6251779wmi.5
        for <linux-ide@vger.kernel.org>; Fri, 30 Aug 2019 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJ3jA3jqw74ejYTjUbB0mp9lyvRd71pqTZw+q0oRxOk=;
        b=mTMAOFUkMew1v7pMgdQz/GR1Gl3qWQuKOinB8L2um2FtedkhA5Sfw9YH5Jxak6epjS
         Bu7YqjySAvwlI8nM2LT39F1wsCGPgkKopI19hmcJX4md2re7H9Hfe4ipr6Y6pQoCjcjv
         sn891n3Br8qzEM/wf8x8bZDEU0+dTrCKkIpOeLby2+tdgkykuRRweQ+QpcUe2Vv+cJjR
         aX5+uU1DJmiUVhR7zGparDrb/a7l2oD4ZKEXYEtVjIoslsr6moNuudZmwSBxB1ntQll/
         ic+8fKxMf5bTO0otFL+RTKwRecld9SFYZwUSNDDh3ByTy+sS27Sayf4hFdbsT6h+YO75
         ryyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJ3jA3jqw74ejYTjUbB0mp9lyvRd71pqTZw+q0oRxOk=;
        b=oTXS52oFKWRQFfACGYvoexj8ffczD67ChKB5sFtstpnRxmeoFhf0Er4D2eeNOH0hEE
         Y40I5IIZg3jnlk8N6C3FnjYGjWJ/TWAfLbvrBvwhdgqAgefM8AfZAlKzIM38WlKAbBcH
         E9asZgKVwHUg7LB8hQtl+rtvkt9ArcP8qkrtXf3BgrC9j3A/GTcS5lXm9dHOaAVjIyQX
         nk+qMH/oQsROUvtrosUjSQ4GEYitizcj2HGqP7Mnol9t+PegLG6DEJ6J8bQqlnT+Jd7h
         TTHGSYPWa9mf5TGJmMe35I9QSSvuPqDExCTn+jS2+BAFQsUZdratr7Q9wsfBFpQfGMBl
         eCbA==
X-Gm-Message-State: APjAAAWtwEf5XZDl8bVWR4qqwzAcIRR1GdaUfMGGa9TLN5/AgDsLoNaG
        bdxcFAX/XzzAJ2UVscvUiWSkZQ==
X-Google-Smtp-Source: APXvYqxemBS0LBW/mvFuTE9jbX36U7PFxqQSOkXKrtTPR0X6Ija4G2zISp42Ghiz2NTitl8E9gPQQw==
X-Received: by 2002:a1c:1ac2:: with SMTP id a185mr16660285wma.96.1567149470963;
        Fri, 30 Aug 2019 00:17:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x6sm7637529wrt.63.2019.08.30.00.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 00:17:50 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/4] regulator: provide regulator_bulk_set_supply_names()
Date:   Fri, 30 Aug 2019 09:17:37 +0200
Message-Id: <20190830071740.4267-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830071740.4267-1-brgl@bgdev.pl>
References: <20190830071740.4267-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are many regulator consumers who - before using the regulator
bulk functions - set the supply names in regulator_bulk_data using
a for loop.

Let's provide a simple helper in the consumer API that allows users
to do the same with a single function call.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/regulator/helpers.c        | 21 +++++++++++++++++++++
 include/linux/regulator/consumer.h | 12 ++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 4986cc5064a1..ca3dc3f3bb29 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -860,3 +860,24 @@ int regulator_get_current_limit_regmap(struct regulator_dev *rdev)
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(regulator_get_current_limit_regmap);
+
+/**
+ * regulator_bulk_set_supply_names - initialize the 'supply' fields in an array
+ *                                   of regulator_bulk_data structs
+ *
+ * @consumers: array of regulator_bulk_data entries to initialize
+ * @supply_names: array of supply name strings
+ * @num_supplies: number of supply names to initialize
+ *
+ * Note: the 'consumers' array must be the size of 'num_supplies'.
+ */
+void regulator_bulk_set_supply_names(struct regulator_bulk_data *consumers,
+				     const char *const *supply_names,
+				     unsigned int num_supplies)
+{
+	unsigned int i;
+
+	for (i = 0; i < num_supplies; i++)
+		consumers[i].supply = supply_names[i];
+}
+EXPORT_SYMBOL_GPL(regulator_bulk_set_supply_names);
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 815983419375..6d2181a76987 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -281,6 +281,12 @@ void devm_regulator_unregister_notifier(struct regulator *regulator,
 void *regulator_get_drvdata(struct regulator *regulator);
 void regulator_set_drvdata(struct regulator *regulator, void *data);
 
+/* misc helpers */
+
+void regulator_bulk_set_supply_names(struct regulator_bulk_data *consumers,
+				     const char *const *supply_names,
+				     unsigned int num_supplies);
+
 #else
 
 /*
@@ -580,6 +586,12 @@ static inline int regulator_list_voltage(struct regulator *regulator, unsigned s
 	return -EINVAL;
 }
 
+void regulator_bulk_set_supply_names(struct regulator_bulk_data *consumers,
+				     const char *const *supply_names,
+				     unsigned int num_supplies)
+{
+}
+
 #endif
 
 static inline int regulator_set_voltage_triplet(struct regulator *regulator,
-- 
2.21.0

