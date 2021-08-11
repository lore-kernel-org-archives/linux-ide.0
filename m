Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFECC4338F
	for <linux-ide@archiver.kernel.org>; Wed, 11 Aug 2021 08:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7468860527
	for <linux-ide@archiver.kernel.org>; Wed, 11 Aug 2021 08:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbhHKIlM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 11 Aug 2021 04:41:12 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:45500
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236230AbhHKIlK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 11 Aug 2021 04:41:10 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 18F043F078
        for <linux-ide@vger.kernel.org>; Wed, 11 Aug 2021 08:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628671246;
        bh=xETS7pTthRHC8+5ho9sOrckBPi3/jBX7rIt6D4JMI8Q=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=OnFqVkvftX64dC3gEHXLf36+K1DGdNqn8+fFXaSGN0oN8BVyghwYc2LxmfT7mXJ2Z
         8cVhVcj5Ch98cuDwpTEG6Ir1n/OZzsSHrJYoa58yfHK7a0Cl5j06UlRn3bbX5raLQp
         YxZwR7Kq4uGNNucG4d2nWOYauBY3NFmybOIDZOFfeS2+3U6b53K5QmdY8S/xlep/YY
         KkiRu7NUSLJqwD9WH59ZVk6RUNeltUTP1z+RwXpIY6HyP1c2otqWsiyWlP9Nzj+FEF
         /EFz+F4leeErHjy1K/oXkatg55K00SrlWy0Pr+hi9eB5SZZRqmOakPkqyhJ8NAYhRT
         4LQVFFkQL9osw==
Received: by mail-ed1-f69.google.com with SMTP id v11-20020a056402348bb02903be68e116adso859798edc.14
        for <linux-ide@vger.kernel.org>; Wed, 11 Aug 2021 01:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xETS7pTthRHC8+5ho9sOrckBPi3/jBX7rIt6D4JMI8Q=;
        b=lRTysGsMz9B5eL9yot5LudQUNbLMG7IsiqIfSF8tgBPE+gmkiOC/rlZIrkEkFJ2NQe
         5yxW3HtL0cuvucL2ID/tHnLXlp0ZSsQpZ8PBmOBtRBrymPYcYFQue0K8x4084Ksw/D7P
         YyditCRvH8aqlYfsamlgY3KxAKqyCp5edHIfASLFbewRApUrL+pzCnGA9Tsx1Gk0Luks
         FrQubjZWo+JxiewaNDiNw82H5pN/Le1DVFYsxeoSdnlvpXDjvRlKr452vtibYc4K9o8Q
         0UD/bpH3xBb08mNTDwo/BI/whgjPYY7C//osRSsSEiPtYowynr7ONZeqaifn5ATCzNJ5
         05SA==
X-Gm-Message-State: AOAM531D/feeKKcW83YGqNsr+z92cU8GbGaH+YB35a/a4L4XI/iRXRap
        stFAbbrD5dhCyfT7xG+7FR+RnCUSevxew2ibEDzK8vbs3Uyg/ZdZrbjbr9KDyPGnjraSJdNgXH9
        vfVqU7/ZrEL6raX2/HnFAN87kfKsmydDx8vR21g==
X-Received: by 2002:a17:906:d057:: with SMTP id bo23mr2621804ejb.208.1628671245814;
        Wed, 11 Aug 2021 01:40:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRutEoaNpBIB6hB7tIolNE6IZ8nEmjFzT7/cj75Jmq+O5UqZbp6bvS24UYMqMbCfU/Hsgb+w==
X-Received: by 2002:a17:906:d057:: with SMTP id bo23mr2621791ejb.208.1628671245668;
        Wed, 11 Aug 2021 01:40:45 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id t25sm10875617edq.29.2021.08.11.01.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 01:40:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: ata: drop unused Exynos SATA bindings
Date:   Wed, 11 Aug 2021 10:38:58 +0200
Message-Id: <20210811083859.28234-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The Samsung Exynos SoC SATA bindings are not implemented in the kernel,
not used and superseded by generic
Documentation/devicetree/bindings/ata/ahci-platform.txt bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/ata/exynos-sata.txt   | 30 -------------------
 1 file changed, 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/exynos-sata.txt

diff --git a/Documentation/devicetree/bindings/ata/exynos-sata.txt b/Documentation/devicetree/bindings/ata/exynos-sata.txt
deleted file mode 100644
index cb48448247ea..000000000000
--- a/Documentation/devicetree/bindings/ata/exynos-sata.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Samsung AHCI SATA Controller
-
-SATA nodes are defined to describe on-chip Serial ATA controllers.
-Each SATA controller should have its own node.
-
-Required properties:
-- compatible		: compatible list, contains "samsung,exynos5-sata"
-- interrupts		: <interrupt mapping for SATA IRQ>
-- reg			: <registers mapping>
-- samsung,sata-freq	: <frequency in MHz>
-- phys			: Must contain exactly one entry as specified
-			  in phy-bindings.txt
-- phy-names		: Must be "sata-phy"
-
-Optional properties:
-- clocks		: Must contain an entry for each entry in clock-names.
-- clock-names		: Shall be "sata" for the external SATA bus clock,
-			  and "sclk_sata" for the internal controller clock.
-
-Example:
-	sata@122f0000 {
-		compatible = "snps,dwc-ahci";
-		samsung,sata-freq = <66>;
-		reg = <0x122f0000 0x1ff>;
-		interrupts = <0 115 0>;
-		clocks = <&clock 277>, <&clock 143>;
-		clock-names = "sata", "sclk_sata";
-		phys = <&sata_phy>;
-		phy-names = "sata-phy";
-	};
-- 
2.30.2

