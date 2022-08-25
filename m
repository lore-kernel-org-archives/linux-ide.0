Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0AEC3F6B0
	for <linux-ide@archiver.kernel.org>; Thu, 25 Aug 2022 11:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbiHYLej (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Aug 2022 07:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241723AbiHYLeP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Aug 2022 07:34:15 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32924AFACD
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 04:33:50 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z6so27806926lfu.9
        for <linux-ide@vger.kernel.org>; Thu, 25 Aug 2022 04:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Tq0s9B485yoq3tV5HmxMkObKnV3Mr1APkcEYUXUMsb0=;
        b=lFelrwdgyU0S7QCGZG4WC4OD1o/tcyBXsjjSh54M9wMD+cwqfLYayIQCN/GqBHbHxZ
         oLJ4G1d44o0bIJYbyVz5CWA/FevFy7L/b1qtl34SgeGctg7orXBdL5PKecyygfI/2xxt
         tVAjPszcQXAkc8iaB48dn+ob+iWxr8wpQwR1eUdvngppmoBJugWt3nsMqfGJmVFm5V7d
         1p4OuhZCQYxqHYTII8q9h+li56i6UW2cdgAPwri77xsWvxNhx7hPFyJtp0TZ/oz85ZFd
         95+sRXVj0Rxap9qMy+GQz2N9aXsJDQTPP77tlYUWwgSJ7D8MGXKP+Nh3J01EnpYPRZUn
         98WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Tq0s9B485yoq3tV5HmxMkObKnV3Mr1APkcEYUXUMsb0=;
        b=BTdCl1+LpXejUbzrE33dZRyWiv+cFaEXh1LgizJ5mbE0c2Ylp+GG8o/qz+VKUpjRhm
         20OnOB9jXLESfMBM9O0wZo1FC4NydB4Tjuk3Jbd1Hd9gSdQN/eJcboOZD0V/m22CkNaK
         Q8soR0ScdOJP1Tyhc01IeTCv03Y+2gZiR9PbtO/6ES5ouMnW2yVTwyls2+EIeVc3uVFE
         buz/6viIBMv5BNtB3zvzCPO7rU7S/dQnJCuFLa3JhLzS731JV13Npl66akSBjbBhfa/l
         HRhA/8Oi7U9mtgRikoAU0LoKHuSTqXML+VuMvlciv92k2RSu+wGHaOFnrqtAq9SbxzIe
         lldw==
X-Gm-Message-State: ACgBeo2g8X9EkYHljcmQ3v1O8WKEs0tehevVwJEk6pkvv2sMWr1SRW8T
        qaWTUrnC1ikSTZ7FegdLy0tBpg==
X-Google-Smtp-Source: AA6agR7uYhTEmWfh0/JQDYwVaRIxA3JmwcnbxkFxOGoCltN/foI9prmdgFxeyJpRr7c/V2eZZ6Nk6w==
X-Received: by 2002:a05:6512:2611:b0:478:da8f:e2d8 with SMTP id bt17-20020a056512261100b00478da8fe2d8mr990459lfb.460.1661427227697;
        Thu, 25 Aug 2022 04:33:47 -0700 (PDT)
Received: from krzk-bin.starman.ee (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id e18-20020a195012000000b0048b0aa2f87csm446764lfb.181.2022.08.25.04.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 04:33:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Marek Vasut <marex@denx.de>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/5] dt-bindings: display: drop minItems equal to maxItems
Date:   Thu, 25 Aug 2022 14:33:34 +0300
Message-Id: <20220825113334.196908-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825113334.196908-1-krzysztof.kozlowski@linaro.org>
References: <20220825113334.196908-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

minItems, if missing, are implicitly equal to maxItems, so drop
redundant piece to reduce size of code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml   | 1 -
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 --
 Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml | 2 --
 .../bindings/display/samsung/samsung,exynos5433-decon.yaml      | 2 --
 .../bindings/display/samsung/samsung,exynos5433-mic.yaml        | 1 -
 .../bindings/display/samsung/samsung,exynos7-decon.yaml         | 1 -
 .../devicetree/bindings/display/samsung/samsung,fimd.yaml       | 1 -
 .../devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml  | 1 -
 .../devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml   | 2 --
 9 files changed, 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
index 2ebaa43eb62e..b19be0804abe 100644
--- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
@@ -25,7 +25,6 @@ properties:
     const: ldb
 
   reg:
-    minItems: 2
     maxItems: 2
 
   reg-names:
diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 880bfe930830..3b609c19e0bc 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -66,13 +66,11 @@ properties:
       2 DSI links.
 
   assigned-clocks:
-    minItems: 2
     maxItems: 2
     description: |
       Parents of "byte" and "pixel" for the given platform.
 
   assigned-clock-parents:
-    minItems: 2
     maxItems: 2
     description: |
       The Byte clock and Pixel clock PLL outputs provided by a DSI PHY block.
diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
index 716f921e3532..d9ad8b659f58 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
@@ -37,7 +37,6 @@ properties:
 
   qcom,phy-rescode-offset-top:
     $ref: /schemas/types.yaml#/definitions/int8-array
-    minItems: 5
     maxItems: 5
     description:
       Integer array of offset for pull-up legs rescode for all five lanes.
@@ -49,7 +48,6 @@ properties:
 
   qcom,phy-rescode-offset-bot:
     $ref: /schemas/types.yaml#/definitions/int8-array
-    minItems: 5
     maxItems: 5
     description:
       Integer array of offset for pull-down legs rescode for all five lanes.
diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-decon.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-decon.yaml
index 921bfe925cd6..6380eeebb073 100644
--- a/Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-decon.yaml
+++ b/Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-decon.yaml
@@ -24,7 +24,6 @@ properties:
       - samsung,exynos5433-decon-tv
 
   clocks:
-    minItems: 11
     maxItems: 11
 
   clock-names:
@@ -59,7 +58,6 @@ properties:
       - const: te
 
   iommus:
-    minItems: 2
     maxItems: 2
 
   iommu-names:
diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-mic.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-mic.yaml
index 7d405f2febcd..26e5017737a3 100644
--- a/Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-mic.yaml
+++ b/Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-mic.yaml
@@ -24,7 +24,6 @@ properties:
     const: samsung,exynos5433-mic
 
   clocks:
-    minItems: 2
     maxItems: 2
 
   clock-names:
diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml
index 969bd8c563a5..c06f306e8d14 100644
--- a/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml
+++ b/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml
@@ -22,7 +22,6 @@ properties:
     const: samsung,exynos7-decon
 
   clocks:
-    minItems: 4
     maxItems: 4
 
   clock-names:
diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
index 5d5cc220f78a..210d856b3b57 100644
--- a/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
+++ b/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
@@ -27,7 +27,6 @@ properties:
     const: 1
 
   clocks:
-    minItems: 2
     maxItems: 2
 
   clock-names:
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
index dbdf0229d9f6..4755a73473c7 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
@@ -59,7 +59,6 @@ properties:
     maxItems: 2
 
   power-domain-names:
-    minItems: 2
     maxItems: 2
 
 allOf:
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml
index 4154ae01ad13..5f4f0fb4b692 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml
@@ -42,11 +42,9 @@ properties:
     maxItems: 1
 
   interconnects:
-    minItems: 6
     maxItems: 6
 
   interconnect-names:
-    minItems: 6
     maxItems: 6
 
   operating-points-v2:
-- 
2.34.1

