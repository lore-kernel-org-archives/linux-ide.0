Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521BFC433ED
	for <linux-ide@archiver.kernel.org>; Tue, 27 Apr 2021 01:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265BD610A2
	for <linux-ide@archiver.kernel.org>; Tue, 27 Apr 2021 01:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhD0Bwy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Apr 2021 21:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhD0Bwy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Apr 2021 21:52:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458E6C061756;
        Mon, 26 Apr 2021 18:52:12 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h20so29977093plr.4;
        Mon, 26 Apr 2021 18:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ip0eSI1farMX4K3ODhmhyZChk4nnRpiFSszhZ85Hdf0=;
        b=LQzTHxQoV8KV5DU+t8nyytrlnHJVZFfwIEAkBqQxbcA9Xn2Ok7CbVZe+lkGicjERJm
         20aS1msgES1liR2v34OqSC7UpJk5kXnts87+q4mglWMeTjikgPIZn1OqFbCGv9CA7B0R
         bhRZFt7ggO46a84yggZyD/W3Og9uBANgKTtL+6rKO7TOanFtekvtvHO94RKFOCZFo6iI
         EbFkx1BeeRTttADS7iSijSMByNW6YMuaenTkn8VehVNcXjv8hC0eHvDZa1loN8Ewiqv0
         QJ7hW2J4ar4sgi6iWJAKyiC7qPXqIMA5Q8EYSQTDoCjD5QnLbz/AMAWc1g/9Pd2Affz1
         gpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ip0eSI1farMX4K3ODhmhyZChk4nnRpiFSszhZ85Hdf0=;
        b=qUBEbGKG3D3DzcxwJsUrj878U8spi/gW1SLiV0t/Xx2G+UY6UX7hZs3X4ABxwpqPiH
         8dSbKxwUvdcZiIQoVC7qv4VaFpD6TvT0/DLAxdEkzlnZLw/KbVJsX5uHId2zXK80XK/X
         QxPjypfZ7FlS1pZiYYCSkTRsj+6YCEZVwhuRc9UeI9+X4y4aihrEoGAyYFU+2LrQB7ZE
         I3Qj+Q2Ru30ABMenAp7Hr8McvTFt6AbHJSDXMVZ/alKeJ1WCbDKFjhwdIn+b+RC1z6ln
         5VoC/AMHW7zpa3NSXEC+hMDMkHhARHKuyTHIj2MCTDNwRgmFYmuymY2DBw+BAxRtmv4T
         Mo/Q==
X-Gm-Message-State: AOAM5300Tpi0BZtzrmSS8mbPNjv44VXaIKO4do+6xnswiOoGH6uwwAhr
        adz1/9BkskTVdUF6OLGGdzm+qrLYgMHFUw==
X-Google-Smtp-Source: ABdhPJxvsVjkRZWoVnSOrnpiC1eSw6ZXTpruPjC8s1HqMbxtWRnt9wdHU5QEzbK50KAuDO2UjZsqHQ==
X-Received: by 2002:a17:90a:b947:: with SMTP id f7mr24886598pjw.28.1619488331538;
        Mon, 26 Apr 2021 18:52:11 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:2d50:30a4:47de:1dd6? ([2001:df0:0:200c:2d50:30a4:47de:1dd6])
        by smtp.gmail.com with ESMTPSA id w18sm791728pfq.133.2021.04.26.18.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 18:52:11 -0700 (PDT)
Subject: Re: [PATCH] m68k/mac: Replace macide driver with generic platform
 driver
To:     Finn Thain <fthain@fastmail.com.au>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Joshua Thompson <funaho@jurai.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <793432cca963b632709c4d1312baa9874d73e1d8.1619341585.git.fthain@telegraphics.com.au>
 <ba908b1d-eab5-a4e5-0c0a-2c745287d121@physik.fu-berlin.de>
 <10a08764-c138-9fe5-966c-ce68349b9b6@nippy.intranet>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <65f01f42-31d9-522a-e690-73d286405a01@gmail.com>
Date:   Tue, 27 Apr 2021 13:51:57 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <10a08764-c138-9fe5-966c-ce68349b9b6@nippy.intranet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

On 26/04/21 7:37 pm, Finn Thain wrote:
> Was macide the only IDE driver in Debian/m68k kernels without a libata
> alternative? If so, this patch would allow you to finally drop CONFIG_IDE.
>
There's still q40ide.c (ISA IDE interface, byte-swapped, so would need 
treatment similar to Falcon IDE). Hasn't been updated to a platform 
device yet.

Cheers,

     Michael



