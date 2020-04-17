Return-Path: <SRS0=5KCk=6B=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9837C2D0EF
	for <linux-ide@archiver.kernel.org>; Fri, 17 Apr 2020 15:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABAB521924
	for <linux-ide@archiver.kernel.org>; Fri, 17 Apr 2020 15:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rq2k6P67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgDQPMF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728272AbgDQPME (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Apr 2020 11:12:04 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6719BC061A0C
        for <linux-ide@vger.kernel.org>; Fri, 17 Apr 2020 08:12:04 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a7so983203pju.2
        for <linux-ide@vger.kernel.org>; Fri, 17 Apr 2020 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=VssLVJtiB325wjdikuLcJO7qQVio1ynuoUzBYLGhnNA=;
        b=rq2k6P675E8FoDCpcGOEyjYIk5Uu5aNHQHq/wjW42K2inZYWG54BH4x3amLttLWrew
         jQVZAVPQhT6izA1LzJAKUn6lHqdRrLsLrbJ//hVQgsTCpzn3NCYDI5qsFTmM7bDm3rq9
         7vMsw2WYNAETz5majoV2NIn2AE742Cu7KjVT936+lqATI6C8j4YVG7LOXgY6CJMLCRZF
         toy6pjvJGreL8tJUaTsRMf8k52xpUt9eNyGl+nQ/51f1jgf09l2JLdc+irrGvC5SntCS
         GHUIzoY1MHbEOu4fKlOhhHFa7yZk7hBLiyWyvieZLqxUPMZqi4cRYFZtDkvjJJXX1MEI
         FLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VssLVJtiB325wjdikuLcJO7qQVio1ynuoUzBYLGhnNA=;
        b=Qb7Fr/iTqKGoGYOutQ/TREopvvjnqhhe1Y5pO/3Gk1DJQXcwH2N3M8uuXLGg2XRA+N
         W3yewg+vtcaZI/6jOsKX8cT8tXnIFChWb+5T1lPXRhE0ANOTLM8mqyzMsop5x7rsYp0a
         A0SycukZ3ZJ1HUpc/96098bdNCng4KajbO/dXNCrrKl/vGe1y6lK4eVvOKihlIQ1Xjdd
         vPri8B6ulWHSsbNaPqEtbzxrOsSGFiJdYWcChbDN7j0ady0XQTH8LbqfKdWl1AUpL19U
         B7V/26S3s5TPfZ3Y8seSxrwn4qOpRZR2XKcpxTuazwKRwrYbhvssMmVkPE150BLuRD+v
         crpw==
X-Gm-Message-State: AGi0PuZ7MGxaZraj8bCtYHYfEnmPn0+TjzbYOD85gcg87sFhgIURgo3x
        3m202MLoEWY/VDWEhbCyD8E+zQ==
X-Google-Smtp-Source: APiQypINOYdpsKWP7KepoP5+mAhJ99M+w/Qzo8/kTs+zMqUSKPmGL5ez8nr9Lie1TaawbtoChO0pig==
X-Received: by 2002:a17:902:9b95:: with SMTP id y21mr3919438plp.101.1587136323895;
        Fri, 17 Apr 2020 08:12:03 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id c84sm11569505pfb.153.2020.04.17.08.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 08:12:03 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata fixes for 5.7-rc
Message-ID: <635fe4ef-c1e1-cba6-f4f6-a0c795b5fac8@kernel.dk>
Date:   Fri, 17 Apr 2020 09:12:01 -0600
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

Add yet another Comet Lake PCI ID for ahci.


  git://git.kernel.dk/linux-block.git tags/libata-5.7-2020-04-17


----------------------------------------------------------------
Kai-Heng Feng (1):
      ahci: Add Intel Comet Lake PCH-U PCI ID

 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Jens Axboe

