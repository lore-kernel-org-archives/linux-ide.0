Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0074C433C1
	for <linux-ide@archiver.kernel.org>; Wed, 31 Mar 2021 02:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99468619B9
	for <linux-ide@archiver.kernel.org>; Wed, 31 Mar 2021 02:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhCaCWM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 30 Mar 2021 22:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhCaCWB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 Mar 2021 22:22:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D690BC06175F
        for <linux-ide@vger.kernel.org>; Tue, 30 Mar 2021 19:22:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso438169pjh.2
        for <linux-ide@vger.kernel.org>; Tue, 30 Mar 2021 19:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EzGPZze2rxZ5ckak4efZEC8hTHEU66acZEHiJwumMu8=;
        b=q0WYGltBETSjrz66ziaGgKL0wMUSu6IL7mmgOt3LEuyY0H9q78WSOHIhgxph+WjrWd
         c8S1y/lDaNtxbDxNGyqNd9g8T0f3OVFm5+jOnoiU6ugIJzJ44PlDYAdPs32cZOgbsCOV
         kMA6uk3iy0AeWx3qU3kqbmDk92ci6VSCm6nWz/IvToINxPLoe8vx8/Gs7qxXcJ1qRuUI
         6RrU3q6QKmrFndx1syyehDJ9+UWCjYvRp64+eLoENG1qKNRNmMU2HuCUIqEIF7x3JNCs
         p9H8CAnf17PyJA/pRKHR0wqxCbFhh6kWMW6KdCWGFC/LiQjPVkjmimrzgiHB3dfFa/aK
         KPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EzGPZze2rxZ5ckak4efZEC8hTHEU66acZEHiJwumMu8=;
        b=UmUkzCMNIj9O3S7cbXlBCdJDA4lB61u3qYsK3IR+LQVHCNx4jK7Wg7+T7u0DDVZXG2
         kTEfPMNc5s1cLpWjITTW3hnrm6Vg0vlJYF1ZUa+rENBQCqvltIsO6tBE6XoKreT388ue
         SVr120+GJuhT/zJMdc33xRCiU3YAgzqtAnYTFNa1UXO0s3LjR3mcc9LROLCMW3k/G+oH
         EpI2kRJ/l5wSgKdxFhpI6SJLpfqU9Yfvja5PeU7DXXRME+VbnxslvDiXfzQOLCiq+qp2
         6Do9IKC8kNMzamLXa4batVy4KcxUyIolFVaW1FVoMHNdbuY4+BgDj+133GsE7rqn+K8U
         7CeA==
X-Gm-Message-State: AOAM531MruPiGBZR3gio7azt7P63499fCYjY3w+E4OduszZOx3fZW+K8
        qGsZbMnEIEvk+NFcKPdWZGgjXQ==
X-Google-Smtp-Source: ABdhPJz/1xeV8h/a0ujmMXoNrk7xFaIvOPc4DH5SzBrfbA8/srLkePGygB3p3Y/nFWXIS0lqGL0mHw==
X-Received: by 2002:a17:90b:4395:: with SMTP id in21mr1184209pjb.201.1617157320363;
        Tue, 30 Mar 2021 19:22:00 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t6sm365028pjs.26.2021.03.30.19.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 19:21:59 -0700 (PDT)
Subject: Re: [PATCH 00/15] [Set 2] Rid W=1 warnings from ATA
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>,
        Colten Edwards <pje120@cs.usask.ca>, Hat Inc <alan@redhat.com>,
        Jan Harkes <jaharkes@cwi.nl>, Jaromir Koutek <miri@punknet.cz>,
        "L.C. Chang" <lcchang@sis.com.tw>,
        Lionel Bouton <Lionel.Bouton@inet6.fr>,
        Mark Lord <mlord@pobox.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Torben Mathiasen <torben.mathiasen@hp.com>,
        Vojtech Pavlik <vojtech@suse.cz>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e4b9785d-ba31-e1ce-dbab-0fd31605e9d1@kernel.dk>
Date:   Tue, 30 Mar 2021 20:21:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/18/21 2:51 AM, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> This is set 2 out of 2 sets required.

Applied, thanks.

-- 
Jens Axboe

