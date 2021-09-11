Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612B1C433F5
	for <linux-ide@archiver.kernel.org>; Sat, 11 Sep 2021 14:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DCD6101A
	for <linux-ide@archiver.kernel.org>; Sat, 11 Sep 2021 14:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhIKOPn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 11 Sep 2021 10:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbhIKOPn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 11 Sep 2021 10:15:43 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6B1C061574
        for <linux-ide@vger.kernel.org>; Sat, 11 Sep 2021 07:14:30 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a22so6072682iok.12
        for <linux-ide@vger.kernel.org>; Sat, 11 Sep 2021 07:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=xKRPZHBwyRzm6J+IJT5wbTNByNz3R+Iq322Cco9cG00=;
        b=y1OJLi1/33PdJ4lhfFUEgGt5OR6WQs2h6iF2bSolVwnt1q/5ngeQROXSvKavlLbQ6j
         ltrUPq+tLj/Vt0rAfZytYru/jwkM0rJCVmDSd8Oej/arDH8F4nroBeQ2Ui6OSo+l0Pqa
         wMMFOOQzRdZZr9eMwwNMp2jET5Ppo/UwzlgJKDPNKNfGmTsSNzKNYSGjHxV1yDl2lwAK
         jxUur+DBdUSVYUMuQ8vfN+0UBnjrx2ctkKxqC4+Hwm66agOBYSWvsMCV4tSTSc2JBQ7z
         XHaEVz6ScQ79ryTYryWwq8/eWtAiMuXdSoVHM0XR6y78mcA/+3pWXscuiOYIhI19OW9n
         WK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xKRPZHBwyRzm6J+IJT5wbTNByNz3R+Iq322Cco9cG00=;
        b=aeFOdkHpeSfF6muRO9bWK6mEptUwCaxzCvFHogFB/ZdjX5TsLx2XSGeZSLR5v1KWCU
         9LdmsTupYSDxsMGI3H+ldE91Uhk3sUvylT0heu7GE8aCWH4Dv8ugROgL3A3sS5zdLbUh
         ltccg8iTcw2f/FMte9yuJY1lg46iZBa+hY4fEuMY5av1LznhO57Z7PYPPBJnIzDLZh9L
         5rHDTvN2V+oM17MKQt830jH33n3jAVJxEz2aRjtvi6+X2MFWp4JplXcxgoQjKZ3PeMsj
         G2ph0c+gehjo86H9ZcRLLytFFrDVQsGye40WROcWUu1/Y2+RGHf0NyX3aaMHOUe9WeM+
         YWoA==
X-Gm-Message-State: AOAM533XrU5Vpg8gqSa0r3AyEQHb8zMmTwFwhi+1Ajr0adxYTSSMN9vH
        oaRijnknzpjL4plNaTqxLnzQ6/vojBs0gw==
X-Google-Smtp-Source: ABdhPJyknwI0gpAOfFpBhQnW5aD4e8nhTkyFtU/bacPMYW2vkER/sCU0Z+duP/dJuHwRI3GtSrACoQ==
X-Received: by 2002:a02:878f:: with SMTP id t15mr2312326jai.102.1631369669985;
        Sat, 11 Sep 2021 07:14:29 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id f13sm990238ilk.45.2021.09.11.07.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 07:14:29 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ALWAYS copy <linux-ide@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata maintainers update
Message-ID: <539469f5-f812-ec9a-2204-1591fff283f1@kernel.dk>
Date:   Sat, 11 Sep 2021 08:14:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Linus,

Damien agreed to take over maintainership of libata, and he would be a
great candidate for it. Update the MAINTAINERS entry to reflect the
change in maintainer and git tree.

Please pull!


The following changes since commit 7a8526a5cd51cf5f070310c6c37dd7293334ac49:

  libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI for Samsung 860 and 870 SSD. (2021-09-03 08:06:02 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/libata-5.15-2021-09-11

for you to fetch changes up to 5ac749a57e0ebb334b1b2c3d28d4d5b1ef85f8ed:

  libata: pass over maintainership to Damien Le Moal (2021-09-06 20:09:09 -0600)

----------------------------------------------------------------
libata-5.15-2021-09-11

----------------------------------------------------------------
Jens Axboe (1):
      libata: pass over maintainership to Damien Le Moal

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Jens Axboe

