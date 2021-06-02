Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72CBC4708F
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B111D613B8
	for <linux-ide@archiver.kernel.org>; Wed,  2 Jun 2021 10:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhFBKT3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFBKTV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2021 06:19:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B782CC061574
        for <linux-ide@vger.kernel.org>; Wed,  2 Jun 2021 03:17:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z17so1707676wrq.7
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2021 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ontm/1WjcLjJ2DXWD0FtXaoVFZvxs8qoCFJzel5PQ0U=;
        b=W38vU/EW6bYFmOA3g3xYUpPqncKZOBFgP9FE8Tajyv8VOuIXHZ4sFj45NbAfVw0Ztd
         X06O3VbAHu8/lN5gKQtvHjeMujdGrrBTh/agWJMJDKUyQkiOnzYXyWAQ63rqOwH7YCG8
         J0T7+GhlyneCD1udpwhQUdG7Cg+YCHkEK9ptIA96DFfoM61B+eRVWWbt5ii5JE+BS9wj
         6NOMO+Ee7cbGi1qaoR0lsUCGc2e8HPpT0dqFUjCerFFZmDCrFxHMEC5X3gfkv+mW8/j/
         ww5GYUMGGVOdhZV7vUlReDDba0yi/UUCcg8hMwKrNto9/D0LhSAnD8Ci+B4f6pyyzFRD
         LP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ontm/1WjcLjJ2DXWD0FtXaoVFZvxs8qoCFJzel5PQ0U=;
        b=YOOrIiyKQYlge6GUBdpZQOzHu7PBU4p0xgPI16Gvm0aEOCx+E+DZeo7I/p4sIK/vBA
         wDtz3FQvFuFQzXvH82UtA5HtkxaN+LuU1DosZ5v8s4F9GrK9R9hLTnDUk+A9KcdSuCNr
         TVV6oz0kYW7AqGvuoYeNllhsjJkedXfW+k4Pd+k/mvONc3ow04xTX47IF1zol/Nc3Eg9
         CJaenZzAkkWz4tP4RlpbdyuwkzQPz9LhZlNZ7ABVIQ9FmljTXYnlBiH4mi9N/VfnT4YR
         OjquFI43O2dXkiKAePi0KZjn1Wgc20uu5BpWga6J+gsZ92RNjccHrnR/vypQYtu9dTNJ
         xw9w==
X-Gm-Message-State: AOAM5317co3LuaudROVMKQKRZI4YaAGGc7I5rhn7EHpzTF3iK/6Bya98
        ixs3Fkxc679Ob8UgdWNBj2U/dA==
X-Google-Smtp-Source: ABdhPJw86cyIoSYEuZJ5FX7mQpXBSkjDtnc6mTjjIZvtpDICzcmb8kvc5REqdHugefdD2Pndm3mV0Q==
X-Received: by 2002:a05:6000:50d:: with SMTP id a13mr31458994wrf.130.1622629055271;
        Wed, 02 Jun 2021 03:17:35 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, CJ <cjtsai@ali.com.tw>,
        Andre Hedrick <andre@linux-ide.org>,
        Clear Zhang <Clear.Zhang@ali.com.tw>,
        "Software, Inc" <source@mvista.com>, linux-ide@vger.kernel.org
Subject: [PATCH 01/21] ide: alim15x3: Document alim15x3_init_one()'s 'id' param
Date:   Wed,  2 Jun 2021 11:17:02 +0100
Message-Id: <20210602101722.2276638-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/alim15x3.c:536: warning: Function parameter or member 'id' not described in 'alim15x3_init_one'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: CJ <cjtsai@ali.com.tw>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Clear Zhang <Clear.Zhang@ali.com.tw>
Cc: "Software, Inc" <source@mvista.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/alim15x3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/alim15x3.c b/drivers/ide/alim15x3.c
index a5043e048f919..39684d12d45e5 100644
--- a/drivers/ide/alim15x3.c
+++ b/drivers/ide/alim15x3.c
@@ -526,6 +526,7 @@ static const struct ide_port_info ali15x3_chipset = {
 /**
  *	alim15x3_init_one	-	set up an ALi15x3 IDE controller
  *	@dev: PCI device to set up
+ *	@id: PCI ID
  *
  *	Perform the actual set up for an ALi15x3 that has been found by the
  *	hot plug layer.
-- 
2.31.1

