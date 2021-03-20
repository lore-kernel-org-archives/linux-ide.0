Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D130BC43381
	for <linux-ide@archiver.kernel.org>; Sat, 20 Mar 2021 11:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C14A619AF
	for <linux-ide@archiver.kernel.org>; Sat, 20 Mar 2021 11:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCTLMh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 20 Mar 2021 07:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhCTLMP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 20 Mar 2021 07:12:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B65BC05BD12
        for <linux-ide@vger.kernel.org>; Sat, 20 Mar 2021 04:11:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a1so15061988ljp.2
        for <linux-ide@vger.kernel.org>; Sat, 20 Mar 2021 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m0pvzwNnNnhKQa4/kcusCE21PqIYQHUV+Iio31Pv2cA=;
        b=RfdRBbnb1zGEIhdUqtRT7HYBsXmnm6mC+csE31tXsxCcMTD3NiRkPXQEV0EWSQGX6a
         95TZfigc6SyKXC7xZD99Dik61Wr76O3m2HkSOo+AswNX0mDzyAEaUyi/OygWN6ATWnhN
         +g3Y+C1kjJQ606omEEI2PzNtsuS7G0joo9aoMwvi9Y4kzuJustXVMiFtL1mSGLMDj4SV
         MAf9kKCXAdRQ7sHUk6reS6Yu0pnOZgoJdgql1n0gq5Eif5zuKihEhMgog23eYlLwflb7
         ItcjeOvEwpD5PSgjCswILPKbip7F7Eur46oklm/N2yTRaWLPDVJyIMQzGpcqj2O25Yle
         yRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=m0pvzwNnNnhKQa4/kcusCE21PqIYQHUV+Iio31Pv2cA=;
        b=hXvbW0FQ0GgjNMdt+UQV+FPqggW9jYtqRbkSSr/ZwcbgZD9vtQo5ZhUJ3MW6whzs89
         J/oNvRRIQnvRA4s/Bd+hsLhg2ijU6p2FJeDryybMcNcLOCC2QApxakjBiKGjh/3Ezwss
         BEOFujSMM1yYeabLWhAasPgQeaR3z59tbge6jfcrOvZSFlEGbFRrg26vBExnhd9YqusD
         yO4RVTtu6kHV+7dtY2tCjQKa/iq96hwNS3Bwk4gPJSfZE4PQgKfuxPjZuHvUk8RwjJcm
         05N5wic8uRlckv6TiTV/ZWuZGOEJInWWGrB3kIoBTZyZ0rxwPehhKFMObZriIn66zlFx
         67sw==
X-Gm-Message-State: AOAM530+uS2yxerL5J7FjcOn7wJAyVai8jRjF01vEhnoFD12aRP2UILR
        EHNVuNW56p0ey52gSp9rNnHPgsom02k=
X-Google-Smtp-Source: ABdhPJzVswXQTlm1Yo6EMlG/Qd5Ky0OJf09Cu+/HIiReQl0KS8RvYg9r7LTtUN2OQ72niqTovXLfZw==
X-Received: by 2002:a2e:505d:: with SMTP id v29mr3099111ljd.131.1616227010960;
        Sat, 20 Mar 2021 00:56:50 -0700 (PDT)
Received: from [192.168.1.100] ([178.176.76.249])
        by smtp.gmail.com with ESMTPSA id f15sm876207lfr.51.2021.03.20.00.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Mar 2021 00:56:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] driver: ahci: Allow disabling dlpm for all bios
 version
To:     Gwendal Grignou <gwendal@chromium.org>, tj@kernel.org,
        linux-ide@vger.kernel.org
References: <20210320034033.396854-1-gwendal@chromium.org>
 <20210320034033.396854-2-gwendal@chromium.org>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <bc2d27af-c5d1-d5fc-4afc-2c2944a6b6eb@gmail.com>
Date:   Sat, 20 Mar 2021 10:56:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210320034033.396854-2-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 20.03.2021 6:40, Gwendal Grignou wrote:

> In ahci_broken_lpm(), dmi->driver_data is encoded as a date: if the
> date of the current BIOS is older than driver_data, the LPM horkage is
> not applied.
> Allow dmi->driver_data is be empty in case a problem is not fixed in any

    s/is/to/?

> BIOS version.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
[...]

MBR, Sergei
