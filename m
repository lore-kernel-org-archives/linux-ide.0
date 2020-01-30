Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFB2C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 03:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB63F2067C
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 03:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RadBBNr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgA3Dzw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 29 Jan 2020 22:55:52 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39226 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgA3Dzv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jan 2020 22:55:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id 4so928294pgd.6
        for <linux-ide@vger.kernel.org>; Wed, 29 Jan 2020 19:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=I3AOoB4BVW8uaRJZ04U3JIII5zrShAvO5sglvQCWhf4=;
        b=RadBBNr48vimUOI4d8ABMHCaQUGYu4/bSMhzpH6zz9cW5meRy6G5yx5d89Y4pmLqpP
         OPy4uwQVmQ1VQz72YzrIRVPPWZAEgB8h5mKtb97Bf0IYKHOS5JN7YyycYXVJOpJpUuOW
         XYu+In33IfPwvmmvWKANgaoodQFZlHOWo1yZj4Lj4eCP/Ctu1XF8y+xLrtev8Vq0RuQ3
         Bqmf2Fq4WYe8qa0nMiVy26cXwM548kUZN1mNF1ZcrfjPQaMo+KUCQiLDW+Nodae8YOsR
         wtV6TCGyH9GmZAeUtJ43bhdx7CDhWqBiH7f17c8yMfyfx9HoUWn8gSDsZ1KJn9WQOBVl
         8LlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I3AOoB4BVW8uaRJZ04U3JIII5zrShAvO5sglvQCWhf4=;
        b=JIoI16R72ZR7kh20XfYJjoG1O1IDBGIIEJ8eFoVG1Kj8r+fvYZ0WjmP4mqhPt6RhD8
         Uy8uJf4NHww3Jxe5JsJ5hw63uCtdBrrCtB+SfeYlEx8IZKru7DFbTBr3naaun6S43cRv
         0WuA1G76SGD+S0ZiKIVqUyvQIGD7mILnXzpduUDRMyXTmyHUCY8YgDLYaHE4XL+ASEjs
         DEPNayH35adpSKpB+IUnkVs9oVHiqJdnu+nWQgNNgsLUx+N0rJU8qPuo+jCBSil7gFrW
         xV2dLzETL93G+ollssYcphnlMVH0wQysEDtlgM+i6UA1UbSdewz2hpcFZdl07J8wVepp
         JySA==
X-Gm-Message-State: APjAAAWiz+RkpPLpvO+mmbgVIkunARMw9MwSA8tBMp8eoGLgq+XtHoV+
        Leu4tnP141anMql6Q+5fIISItWM6Goo=
X-Google-Smtp-Source: APXvYqyjjUMyPD7rP9P9yDw/XWHBw1z6VQgPANDnjxMJnIFrvmIuCx2+rPgqX0q5Ygxu2PYsipnqdA==
X-Received: by 2002:a62:1d07:: with SMTP id d7mr2911052pfd.159.1580356551188;
        Wed, 29 Jan 2020 19:55:51 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y6sm4236371pgc.10.2020.01.29.19.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 19:55:50 -0800 (PST)
Subject: Re: [PATCH] Using of new SanDisk High (>8G) CF cards with the
 pata_pcmcia driver
To:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        linux-ide@vger.kernel.org, Christian Zigotzky <info@xenosoft.de>
References: <c88372ea-1cb7-6ae4-21dd-ff67304c7885@xenosoft.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <24ffb33b-8ccb-3dfb-7a18-bb791f020e08@kernel.dk>
Date:   Wed, 29 Jan 2020 20:55:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c88372ea-1cb7-6ae4-21dd-ff67304c7885@xenosoft.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/28/20 1:49 AM, Christian Zigotzky wrote:
> Add new SanDisk High (>8G) CF cards to the pata_pcmcia driver.

This patch is corrupt, you need to check your mailer setup. I've
applied it by hand, thanks.

-- 
Jens Axboe

