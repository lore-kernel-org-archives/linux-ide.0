Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD588C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  7 Sep 2021 00:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4B6604E9
	for <linux-ide@archiver.kernel.org>; Tue,  7 Sep 2021 00:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbhIGAqk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 6 Sep 2021 20:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbhIGAqg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Sep 2021 20:46:36 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D643C061575
        for <linux-ide@vger.kernel.org>; Mon,  6 Sep 2021 17:45:31 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b10so10588927ioq.9
        for <linux-ide@vger.kernel.org>; Mon, 06 Sep 2021 17:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=j8YxQcROwCl/RBFwz0r5ZTihqa2CjxD9xZnX1pM79hk=;
        b=uNLe9KNUQWF4066HCiwAWYdHTMr7zrL82FJ48R4+umuloso8JhI3UANoBiUUc63etl
         So+QRRxIcvgKbKiFWghr7WJZrf3Pmxv2wLKDu6NXJ60GqyaJ8MlPu7Zh8gHx9g53rAQm
         rvnOeyBEYC+Ij+yYo8AnDCLgZoa81e71L2gs12nomQaF4sjqoWWt7hq0ke+282Pscav1
         GzwvBDyfU5CXrN2EmfwDeXZ8BPVUr/nmV0YtrOwCbhDi1+IoHrb+AFa/IBL14OFILg0T
         wfdxWax6oZBaKDrkzkHVJzeGiWTjqNq992aU7dxwZyn6fO4fCXDkdyyF4n/G5WL8obHp
         4+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=j8YxQcROwCl/RBFwz0r5ZTihqa2CjxD9xZnX1pM79hk=;
        b=UJPpoGiZKUh+rNLNW8spV2+/0iQ0PC1FVEAkt27U/ZcqjzSpdU+QDByl0vD524Zv9A
         mSDPIjZuQ+00DJqNxBNa9JVDIlU3v+wx48jJuYhE6b3qcFfKw1Rt/ssWpA4goH1QfI05
         FFgH+n1pZ7RdUNS3/spsBjvSIKcoU+49UEUgQRBtbWyuJfj5JBI7xXkW+WJyehZKOsrg
         VApP321KbQEAzB9rqHiJVQvH1sgg4T0teqkJtlwcYpMqDIKnMnIWb54JJdiUP3J9cj4u
         daImbeALdlJrp8SXSXTxaHpIf2r2ZA2EmI6n3rrh/Hcz50YcsdnRXMwrHsxZiogDaNjL
         ikaw==
X-Gm-Message-State: AOAM531sa+XXnA4ZMxnIdupnGEPsRUOoeRkLSub7i9AdVdlgiM9OprO7
        yj78NndHSHnLVc0NghnSDB+7hHpGuuvc7Q==
X-Google-Smtp-Source: ABdhPJwtBtvfYmToLJ4w9NXfe3nztcUxqYVAc9ugCkYetLErYy+uKPgB0Dljc5Qa41FKrQPK3cUWmg==
X-Received: by 2002:a6b:3f08:: with SMTP id m8mr11522992ioa.117.1630975530531;
        Mon, 06 Sep 2021 17:45:30 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l25sm5509229iob.41.2021.09.06.17.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 17:45:30 -0700 (PDT)
To:     ALWAYS copy <linux-ide@vger.kernel.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] libata: pass over maintainership to Damien Le Moal
Message-ID: <b4cafca7-ad37-ec70-7b89-9025c35902a8@kernel.dk>
Date:   Mon, 6 Sep 2021 18:45:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Damien has agreed to take over maintainership of libata, update the
MAINTAINERS file to reflect that.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/MAINTAINERS b/MAINTAINERS
index fb1c48c34009..ed9e3770d8b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10597,10 +10597,10 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 F:	drivers/ata/sata_promise.*
 
 LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
-M:	Jens Axboe <axboe@kernel.dk>
+M:	Damien Le Moal <damien.lemoal@opensource.wdc.com>
 L:	linux-ide@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
 F:	Documentation/devicetree/bindings/ata/
 F:	drivers/ata/
 F:	include/linux/ata.h

-- 
Jens Axboe

