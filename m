Return-Path: <SRS0=RB9J=7Q=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF339C433E0
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jun 2020 23:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A93820825
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jun 2020 23:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VUpMlsS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgFCXcR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFCXcQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jun 2020 19:32:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC772C08C5C4
        for <linux-ide@vger.kernel.org>; Wed,  3 Jun 2020 16:32:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f3so2472655pfd.11
        for <linux-ide@vger.kernel.org>; Wed, 03 Jun 2020 16:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mP7HDY2ZN5ivM9lomEi6uc16BWfE9HMAWk/tyOctczk=;
        b=VUpMlsS8luWYC3XyHHaZc+nRVPBUhMgVRgY7r6ereTmxJ2CV63CmoY9G8LrGOkuSTQ
         K47uNjixFZ1fYU9L0oHIXbtPGyL3X2bOpWgIhpXRvnlBLqW0qd3WjT492H4d1foUpJxP
         H25ReL/ps5emEFx5QusYD9+rH0F1unUcjPs5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mP7HDY2ZN5ivM9lomEi6uc16BWfE9HMAWk/tyOctczk=;
        b=fM6vT+8R/ckcKHg5gtDps5veIRxTi1faIdny8IG1L/up9dh5ZLMyZLHoGZryncJ1U7
         8frnFjoEsv4J4mYT0unvyE7XZgpzurXcAA8ZfLZnHZ5wSyxUgdMCRaz68fszv/HVyAqU
         A8LODkUgSzCAjU5mbyucTTTMpu7T9D5KRAIOazWKJEZP9RXcA3LfYVS14HMhwGU7C+6P
         16yodFIg6haeNco8j9t7DKIugN+fNTEQqivkdbmdNHX5geiNlAycV+msBN1x5oP5FSMR
         F5Tm8dk170SPagUCWv6ZN4+AKwDnOHxnNZrNP3dPsNEysW/9Ht2ek6oAifH4P3AR3hm4
         VmCQ==
X-Gm-Message-State: AOAM533iXctAxwF/pP2988r9imvsiFmOaeYeDRh6TzbK1senJjg6EH/u
        ZNiziREvLHqacjeCQ74A6teDkg==
X-Google-Smtp-Source: ABdhPJx7JrP50eeA2KfLnLeonR3ATTZL4fgn8xfVLKyPbfOSa9aQRBoHTRs7znIl54UHsuA1YKgyUQ==
X-Received: by 2002:a63:6541:: with SMTP id z62mr1735576pgb.320.1591227133920;
        Wed, 03 Jun 2020 16:32:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x77sm2799667pfc.4.2020.06.03.16.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 16:32:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mm@kvack.org, clang-built-linux@googlegroups.com
Subject: [PATCH 04/10] rtlwifi: rtl8192cu: Remove uninitialized_var() usage
Date:   Wed,  3 Jun 2020 16:31:57 -0700
Message-Id: <20200603233203.1695403-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603233203.1695403-1-keescook@chromium.org>
References: <20200603233203.1695403-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Using uninitialized_var() is dangerous as it papers over real bugs[1]
(or can in the future), and suppresses unrelated compiler warnings (e.g.
"unused variable"). If the compiler thinks it is uninitialized, either
simply initialize the variable or make compiler changes. As a precursor
to removing[2] this[3] macro[4], just initialize this variable to NULL,
and avoid sending garbage by returning.

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
index f070f25bb735..5b071b70bc08 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
@@ -592,7 +592,7 @@ static void _rtl92cu_init_chipn_one_out_ep_priority(struct ieee80211_hw *hw,
 						    bool wmm_enable,
 						    u8 queue_sel)
 {
-	u16 uninitialized_var(value);
+	u16 value;
 
 	switch (queue_sel) {
 	case TX_SELE_HQ:
@@ -606,7 +606,7 @@ static void _rtl92cu_init_chipn_one_out_ep_priority(struct ieee80211_hw *hw,
 		break;
 	default:
 		WARN_ON(1); /* Shall not reach here! */
-		break;
+		return;
 	}
 	_rtl92c_init_chipn_reg_priority(hw, value, value, value, value,
 					value, value);
-- 
2.25.1

