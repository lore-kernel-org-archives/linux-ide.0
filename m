Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63F4C433E0
	for <linux-ide@archiver.kernel.org>; Sun, 28 Feb 2021 23:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE9E601FF
	for <linux-ide@archiver.kernel.org>; Sun, 28 Feb 2021 23:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhB1Xsk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 28 Feb 2021 18:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhB1Xsk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 28 Feb 2021 18:48:40 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA2FC06174A
        for <linux-ide@vger.kernel.org>; Sun, 28 Feb 2021 15:47:59 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k22so8781809pll.6
        for <linux-ide@vger.kernel.org>; Sun, 28 Feb 2021 15:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=VQtKUs0gnmEn/DXU1pPTPmPzdWNCzkmjyYRwwctrfPo=;
        b=0NlY0Ffd42/CsFYrsosRTMkOhP7VkDeuEdoeBBVDNEkZ33oVApACKn3xmKWvRUXRVx
         vZboZkYCF6xiuS/R53CVTcA/fb4iy8dvVDLg7QMPj55f67g2iWyx6xv/+20HUgcxSOt1
         I41fi5N2j/VIhlncjVPlcq/8MTY3HIA0lAO3/1LhrI9d8Vi7jICmMa52464Ivc7DoAF9
         7QlXzg8ErMdRJr2E5jw0x/ioVgMk1G884JWNHfzjmx3iX98iPRsx+gOIZ4HrP7hbs8A6
         B4XSnmgJQYqACMo8uJPrCs72zs4SITDBQTed5g2CVl2MZ7JaYyguDbS8PRvLW0Fnk5rL
         E85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VQtKUs0gnmEn/DXU1pPTPmPzdWNCzkmjyYRwwctrfPo=;
        b=hWaf/k6Xr9TaenJI4XfDyisLQenl3pzkodnKqTmpFcTdLb94FGrauge7ArW1UCQlSs
         +V5scT2ePjeAxgIjdcHdRc6c2JMAT0pCGtLsk8hHYoMuauvHySbjJtlgoEgv2C1hbnEb
         SwbwtD9y/U2LkVWN2Z6U2KRj+kHV7CZLvh+pTMliJBjZHnJlkQykYujYf5gs9AcFua87
         uMDAGpmc64dcE/h1fu0OdCcGQERwDm9qOqhqLioWFU9VAdA9T3gy+1YNihWtNW97wqFj
         6xRURFdobIRCjgG4nDDfmrIHgeJM+p5fWQMQ2LbWslKuofSi3GbdRN+WzJppQhvlTs/B
         TB2g==
X-Gm-Message-State: AOAM5312hrbtoUZxthJaSnK3joyC33PJBpAoUx7avC2ExQlbrZ72hxW4
        mxnHTXSjiuovK74X0IiMTDzcu2nTcP5kag==
X-Google-Smtp-Source: ABdhPJxNqS7/p1EoWWjmKJqHj8CLdLGdTg4QSjMfoOwXdPANbWKKeDAMR64VidQfaa73MOGlR3Lhrw==
X-Received: by 2002:a17:90a:ba16:: with SMTP id s22mr15034953pjr.88.1614556079240;
        Sun, 28 Feb 2021 15:47:59 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x23sm10687346pfq.167.2021.02.28.15.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 15:47:58 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ide@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Forgotten IDE fix
Message-ID: <ce99da11-1b6e-2734-3a5d-bc83d68b4ed3@kernel.dk>
Date:   Sun, 28 Feb 2021 16:47:57 -0700
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

This is a leftover from 5.11, where I forgot to ship it your way. So no
rush on this one, it doesn't have to make 5.12-rc1 or anything like
that, just sending it out so I don't forget again...


The following changes since commit 3516bd729358a2a9b090c1905bd2a3fa926e24c6:

  Merge tag 's390-5.11-3' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2021-01-02 12:22:46 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/ide-5.11-2021-02-28

for you to fetch changes up to 07f1dc8cc85bbfb2f9270f25060c4755f4509f45:

  ide/falconide: Fix module unload (2021-01-03 11:16:06 -0700)

----------------------------------------------------------------
ide-5.11-2021-02-28

----------------------------------------------------------------
Finn Thain (1):
      ide/falconide: Fix module unload

 drivers/ide/falconide.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
Jens Axboe

