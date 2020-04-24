Return-Path: <SRS0=v2qC=6I=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CA4C54FCB
	for <linux-ide@archiver.kernel.org>; Fri, 24 Apr 2020 18:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE57120704
	for <linux-ide@archiver.kernel.org>; Fri, 24 Apr 2020 18:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zXmNZI0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgDXSBv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgDXSBv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 24 Apr 2020 14:01:51 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E22C09B048
        for <linux-ide@vger.kernel.org>; Fri, 24 Apr 2020 11:01:50 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b12so11276261ion.8
        for <linux-ide@vger.kernel.org>; Fri, 24 Apr 2020 11:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1oybE4UtsY48E1oQ+JXQwXzrfFrfANiZUHOgOeRFdfk=;
        b=zXmNZI0RhF7dF0NTK8G5HNlv0404xgwYGNIY5mXaHBm/uKjEtz0sWjLHF1zBW66EFG
         VGHd309EDujjzuQeAIIIdxcjkGWJVEljsrIll7MQ1QvwAwo/7OeU1BG/UsT+hkBa7Elw
         qXr6NAZ9E33GSXKhCxWbmmF1uM1n2zuM84cR7ATH6wgeilE7uXpKjUQmj8tAGpXbgpUk
         DPxkVup+PY4HnOLs/UC6/JILfhS5FJIqpTZ4159IxCH9V4t+J0HGf51jUOynvHnltQGx
         aBD8aOmrUD/nfF5z0MmOlqumAguPiDBMYS0mNjSWuXswSHh6SnTRgDxnqxsRKTSg0rVI
         hExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1oybE4UtsY48E1oQ+JXQwXzrfFrfANiZUHOgOeRFdfk=;
        b=SVuNrjJofkyvnRQgPYEOoc4HBJ+UwBRK8wcq5+GQzNbc4tkq1fmpK+CcY7rSeJmZgy
         ZodAZWKAVxPg90AiizsOOIrK1mmfdK3nVCwpfhP+JKBUEptYqbqPKc+/jL31SYPYIsrp
         7G2+bSorjJM5uiTddj5futX529vH7TbXlDhebALa00oIiptmk5r19Tahgk6TxfhG6XcI
         2KcHu9UHm4S8PhJnno2ZzdTMZ/u/cpoBfFafZU7UPaXW543JcbQuvSpNSpRjp/kBRDcG
         A7wfeclFM9hlNH2/JSk0JyXvSeBYplVYHcbpwqRbJJWToQg5Pr9A2UJkDmpgIC9fhN4Y
         6PUg==
X-Gm-Message-State: AGi0PuZVN838McUNWmsjBrJBMf2ibvfkNK7k/sVyZv96J65U/V+oHEe6
        nUJa+/FAvz3pigWa8YIzk0eGVm9wOh+3Sg==
X-Google-Smtp-Source: APiQypJACSWzxwOk8iJW0Gzgk3N2pnEr13CJ8ialCy5jJK+w7nqfsGeIP0nWZX+GwT+4TYpCMEQrnQ==
X-Received: by 2002:a02:6a4e:: with SMTP id m14mr9598661jaf.17.1587751309737;
        Fri, 24 Apr 2020 11:01:49 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k18sm2019958ios.18.2020.04.24.11.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 11:01:49 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata fixes for 5.7-rc3
Message-ID: <0c2ac794-edf3-671a-7e6b-3b497e7c36ec@kernel.dk>
Date:   Fri, 24 Apr 2020 12:01:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Linus,

Minor spelling error fix for libata. Please pull!


  git://git.kernel.dk/linux-block.git tags/libata-5.7-2020-04-24


----------------------------------------------------------------
John Oldman (1):
      ata: sata_inic162x fix a spelling issue

 drivers/ata/sata_inic162x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Jens Axboe

