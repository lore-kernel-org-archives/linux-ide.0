Return-Path: <SRS0=vYjz=DQ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D72BC433DF
	for <linux-ide@archiver.kernel.org>; Fri,  9 Oct 2020 15:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9A9223B0
	for <linux-ide@archiver.kernel.org>; Fri,  9 Oct 2020 15:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="K4b3qCjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389406AbgJIPbg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Oct 2020 11:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389351AbgJIPbg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Oct 2020 11:31:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B825C0613D5
        for <linux-ide@vger.kernel.org>; Fri,  9 Oct 2020 08:31:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d23so4620982pll.7
        for <linux-ide@vger.kernel.org>; Fri, 09 Oct 2020 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ebuBhX2+OnZ2g8gjXhG5Whso/NiZdq5IVoUzSX1VC3g=;
        b=K4b3qCjIlGa7QpahTMy5KQ9mTu+mBvRcJqYQ6TXSswBe5TurjFg3V44zCtdzqMMXUF
         IC8JdkYcCTs+yTt1EimfFZonockgPCkelROoLvRXQwnENCtGGKwbr4RYZuC74mD3Ou+z
         zNzUJKp9fBWgft9muzkhlkL7csymtR0sWk7TaZSA2b3H9j8sjw1kYeyutzWc3f4GV+ni
         9v07unky7mVGC2g7Tt7Md3gOR1e7JofknxN8iZ5LeaaUnT5X8hn+8EcCUJwXh3wQSJ+l
         ZxhzHzoO+OPWcX+6xnQRCKJcjj7Ezb1hTwOEqLoQggzzsvvXsNl5cco3CUX589rS6l32
         x0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ebuBhX2+OnZ2g8gjXhG5Whso/NiZdq5IVoUzSX1VC3g=;
        b=fljabds5duVeI0T7uKexTtBpNCIE3M+DFhpwkbVE6RXMINW1d3J468iU6WB0DGhshE
         4+fOhP9HyGqYWr+Od7tnNaoGrObqqNhXz9UH6ueCUUZCE+JZda9ZznAKx6rvg9lzTbGL
         ZFYEzCLNCB7Zb9PnZtDrmy8l/75xPP+5arewLdJoocepE54DRbgjixzSiKzKwxZqeb+0
         R/JnYVAgVk4t4uHk5ajRLW5DJxnd2fdHhXEQtTFDY8derk0qbBlMFivcE/61Xpa5amzA
         9X3K1tkc0wlAEgaFCcmmjzhb7vacaLHSjCoS5LbGvnB3SpqxTQVnd83IwWwCINHTmrBT
         P7Lg==
X-Gm-Message-State: AOAM530zeVkg1zbCFWXoPznJYt+OcaHafET+pdDZpU3igAfQbOzp9XU7
        8mH6U/fy+R7gQobScANqjb6p+l/fcRG5Y4ZW
X-Google-Smtp-Source: ABdhPJykXqTArhzl2768Gp+TQuNId627QWe71O5CbJum81jKePVl0r0tgS26dJeL0FrwznFGlkoQeg==
X-Received: by 2002:a17:902:c3c2:b029:d3:df24:1584 with SMTP id j2-20020a170902c3c2b02900d3df241584mr13080680plj.33.1602257494522;
        Fri, 09 Oct 2020 08:31:34 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w10sm11485722pjy.13.2020.10.09.08.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 08:31:33 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: remove LIBATA PATA DRIVERS entry
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200924112252eucas1p2e372d1ce6d6f8cf8106572adeb200fee@eucas1p2.samsung.com>
 <1c6cdd00-93a2-55f7-9494-1c0058de384a@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d6a81ee-6d17-ab1e-b4d5-1e9e6a525a88@kernel.dk>
Date:   Fri, 9 Oct 2020 09:31:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1c6cdd00-93a2-55f7-9494-1c0058de384a@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/24/20 5:22 AM, Bartlomiej Zolnierkiewicz wrote:
> Even though there is not much happening for libata PATA drivers
> I don't have time to look after them anymore.
> 
> Since Jens is maintaining the whole libata anyway just remove
> "LIBATA PATA DRIVERS" entry.

Sorry to see that Bart, I'll queue this up for 5.10.

-- 
Jens Axboe

