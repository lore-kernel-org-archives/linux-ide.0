Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE63CD484D
	for <linux-ide@archiver.kernel.org>; Fri, 22 Sep 2023 17:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjIVRxl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 22 Sep 2023 13:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjIVRxV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 22 Sep 2023 13:53:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB0410C6
        for <linux-ide@vger.kernel.org>; Fri, 22 Sep 2023 10:52:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c5c91bece9so21532385ad.3
        for <linux-ide@vger.kernel.org>; Fri, 22 Sep 2023 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405133; x=1696009933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P4lFdFSF/WMtJZ1n0IFqHz6mtLvevkit742tpw5OZis=;
        b=TUltBHeCRYJUzVo8fVnGboc37KWD2XGgCL6pMasy80W4bhqo4tBxLiHWPwkomfGOnn
         p2S3UeiOUOaoK14y2ATMxh1h/eRsSjtcpz4zOEGZTi58msCxUxAQ38qVJB19e7bHofgx
         HKvV/9RB7HLpB+ilyMejoIoCHrdxcIllBq1ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405133; x=1696009933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4lFdFSF/WMtJZ1n0IFqHz6mtLvevkit742tpw5OZis=;
        b=rve49vV0w1BdzCnS8SNg1m4wXs/gEN+byny0gKYQwx6Rk/KFudN0YawXNhaa36WOYk
         IuHObMThn6kzV+VTQeucjFGJBVFj6oUImtSFjx/fy3IXGzj8BXkjow0EhHwALraxSL43
         IpPfZm4x9elp255ngn+6Vl2Xqiq7bwTvkqtoVYrKVpFK39DudhV8eBq43F9VSEQ9xYzh
         EswE7mBulYEOVHl1pV6upH1lIdI5akRDICGnAA5VaIiN/JKIuplSrtmqnHUqGGYkiIqx
         syI+CzFNPVGqhoiCn1jbhDH9hBaP4eVMQYrXKmC1RUzcSmxEdinJcELQqXyWIrL48EsN
         uCyQ==
X-Gm-Message-State: AOJu0YzuHRtCoJxrc8DgmQQX8Oge9bJPdTxnHEYVPU1bEU/MQM+//Qg4
        rqU1qCqmIM3jx8qdfXXFfZm/kw==
X-Google-Smtp-Source: AGHT+IFNUyiAriBD2um7pITTD+eP5MvtFjnaKTM4jvzlaWc7m2Pz8Xlfs5hzadPTiz+e5UX0XZawsg==
X-Received: by 2002:a17:902:a407:b0:1c0:aa07:1792 with SMTP id p7-20020a170902a40700b001c0aa071792mr169699plq.36.1695405132793;
        Fri, 22 Sep 2023 10:52:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902e88c00b001c5b8087fe5sm3784878plg.94.2023.09.22.10.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-ide@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] libata: Annotate struct ata_cpr_log with __counted_by
Date:   Fri, 22 Sep 2023 10:52:11 -0700
Message-Id: <20230922175210.work.239-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ei96zfUMfrVFB3I3JdJNLz4izHCeTaYCT55cR6z67TQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdRLFoAwT1mCQLgtm1SMCJS/1dZx+seXgkUyx
 yYvrZTRLmuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3USwAKCRCJcvTf3G3A
 Jm/NEACCMtnhoEgknOC6Ec69yaNMsjXyzdjGfPY/uDjWB8+n6l4ZY/abY54yTq6xlFNSbERWzy8
 tTgTWRYZDHWLWFGja0Ov7FyVjLOC4LQcdhbsOu31k8bck/BANRCs2UHtkK5AVLxBnVqZ1zDWQNa
 W2CdnFimXRaOo8wIg4eyi2gKj4pA95HuBP8w4WIzCkuucorP7rfyu5lPvE1/SmwfIf6j89Q2W82
 suLkFQycstU6zebJDhPSs+V0gswuVmna0ifYiKJ+CnBVqQE4Vct/HJKGFxycica7769JXfk3DCX
 /c/MwvwlYinM8lTmzRUjbZVCfPx/mMO4MmSmmIUpl5+BELtQqZ+2TaP8tbJ8gmbLoy4uqx44huH
 +ks/vzrsMA2RdTm4+mZ+qekAIBc7wlp8EG+heSZ7BqKhgulEnhWg0wuKGID2fo5MlQw8+Ax4Vu7
 uxlfbml1ExdKOuuFoD5Iwi8jbQEJYM8fpdArxCmQPCa8MMJ3J9HuCmmX6dtQqQQMS4J9kvDaiTx
 VQVH4SdBkWJTgt96MILMcCvQNVZLXqimqbWvXGQQ1C7QX+CtwPZiOSI/wteKNiWnSUwc2iMLKFB
 p45aN0buN27a4uTP2QaKsutqZT1vM/vbj7jSDTlcmLITJjEBl1uMh8SVnPLEYHnfOJvkWs4kjiZ
 0d4Giey 7//WndUQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct ata_cpr_log.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/libata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3c17a5053f00..f91e8e7f1c00 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -656,7 +656,7 @@ struct ata_cpr {
 
 struct ata_cpr_log {
 	u8			nr_cpr;
-	struct ata_cpr		cpr[];
+	struct ata_cpr		cpr[] __counted_by(nr_cpr);
 };
 
 struct ata_device {
-- 
2.34.1

