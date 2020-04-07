Return-Path: <SRS0=Xbu2=5X=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FC8C2BB1D
	for <linux-ide@archiver.kernel.org>; Tue,  7 Apr 2020 20:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B858C20730
	for <linux-ide@archiver.kernel.org>; Tue,  7 Apr 2020 20:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kMRk+d3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDGUuD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:50:03 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35167 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgDGUuD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2020 16:50:03 -0400
Received: by mail-pj1-f67.google.com with SMTP id g9so261604pjp.0
        for <linux-ide@vger.kernel.org>; Tue, 07 Apr 2020 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8KnDK4lPfD3ThErmqjMOkJqIG1D+dLUhlEHhC7zHGyQ=;
        b=kMRk+d3kGoGcM14Fj8KK6z5Yvpj78HolILDt022nsA80s67Q95IBM+hKdlhH5N2RnO
         3/mgjP1ddXUULum6oNJhSEnrIeKVodpQSFDuAZqRhtagyUSceqFxyFLGfXYu5tqTQbh9
         HHanuj64WLpepEnv+UBQbLWE317V4JxGa1/DxCnMYQ75WmEymU8yYpuQ9elGGMpTDaFQ
         MprXCN7RI5uVTYSTxBL659EZZWhXHh6rOJm5qLunYqEBNkovi++89DtaQAR/CCLjAOdk
         jO4BLYH5uXWuCmjm5s40CHFXjoCwsKKDfEbOhaIJROGqz7uC63sa0/msjf7CDQT77wvr
         tx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8KnDK4lPfD3ThErmqjMOkJqIG1D+dLUhlEHhC7zHGyQ=;
        b=FfMRSIZsTBJnJljSK85of/XU2Sxu2RGlC6vJcvUuooQmB8dnHndwE9CPwav/cbSbPi
         Y7XJU1t0nnda6uvcz3Nj5E5ZveMqTnM1f7yMqf9nbRJXjR+NMFWT6VvTaU00Q9mJwwq2
         TyeBGeMz309spELGZQdpErJMI+0dGrUTlIwagSVefOeku0Q8jHNlB5ecf6oRcPZ/1KwN
         Ow4F2WAM3a1CM+7zKLK3XvssNrBSUEyY5ZDeUidhIJAPeRoPBNP9PWYTOA6tS9KUnwBd
         Ivk0PZMIWWOas8aXnzMzcZQ/Ttkp4hnj6OH+WMDVUNPRhqxUrg4MxI4LuEabqKrzz+C8
         +bWw==
X-Gm-Message-State: AGi0Pubo81aZZ7FjIzty60Id1Qs/mBnJ8SlUG9AnXM+DvF5ye0GjLwWf
        CeYOIlXnpT0sUi0BjP+7iCwXUA==
X-Google-Smtp-Source: APiQypIxqfTmYOscCTssroZulr1ZWx6qppCwC/i48VMqcar+nE80Hxbwwzzdacvkw01iJ8lW+FtHrg==
X-Received: by 2002:a17:90a:1784:: with SMTP id q4mr1232457pja.174.1586292600830;
        Tue, 07 Apr 2020 13:50:00 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab? ([2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab])
        by smtp.gmail.com with ESMTPSA id b11sm862891pgj.92.2020.04.07.13.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 13:50:00 -0700 (PDT)
Subject: Re: [PATCH] ata: ahci-imx: remove redundant assignment to ret
To:     Colin King <colin.king@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200405115120.366864-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ac93c383-fdc3-a818-9e3b-faed462c31e5@kernel.dk>
Date:   Tue, 7 Apr 2020 13:49:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200405115120.366864-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/5/20 4:51 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.

Applied, thanks.

-- 
Jens Axboe

