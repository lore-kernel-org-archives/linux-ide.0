Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75645C00140
	for <linux-ide@archiver.kernel.org>; Tue, 26 Jul 2022 17:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiGZRgb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 26 Jul 2022 13:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiGZRgb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jul 2022 13:36:31 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0192A94C
        for <linux-ide@vger.kernel.org>; Tue, 26 Jul 2022 10:36:29 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m9so17228128ljp.9
        for <linux-ide@vger.kernel.org>; Tue, 26 Jul 2022 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uI50YXH2Ww7hxsG1ebSERshM/LbYIaGrD6XYTXxMuRE=;
        b=ROGQEmdnXGLR5BrUfMqv488rBW9CZiBjMN1IENiYp7QqUNApt5aI7Ym2EIEL55ONRE
         reBn2bkXfHWHZK3vNTj6xHxeZ4EAWkLv1cVFwU4LqtAEff+syJVLNo4fvRuaDmbk4TLv
         p5jiMzf1dFWyJvS1Sr21K0d78jAtzy2RcZZfIFjLH9xr/NWaguB1cgQcZ8UxQAALyTvU
         rrv4RxHFqd1l5WUIkHGRmTYTilTkEXMyuDGbLUFv4zPjffV0WJ0SRaNf1tIINbw1DX14
         ++JZQbsOqKm7hkMcsimxlv06BeRAYpjBtY3l0gkb0gCnXqvqzUlW+PpYLMK474mFmvE4
         o94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uI50YXH2Ww7hxsG1ebSERshM/LbYIaGrD6XYTXxMuRE=;
        b=BZV13REIcmo4AdcrvCgBW/tziCu5QQV19uOYJ5p/pdbURwMsUv700vsg0labUTz57g
         +Pf51y1JmIIH+wXUu5r8SPts/jnQ895A6eDIA6KWCFHZ7/KpI/MmFkY8r5dUQ4WwNtc/
         d0zWB9449b+CJSC6XSOePeuWK9SD99nLSEltIh34ELIPjA+FfGf7EG/ud3IDrMvW6Uua
         bQpEKHHa6BVwT0OPTh8bfDFO0iO2k/L/Ze0BuE07T8xBD89OJcLHexdVAWm6BzK40RuO
         cZxk0PwBai5HmeHSLB/DAsUOUWSiovnzLUxrSS0aY+NVUiJETtvkJNI8q33icKcVug0f
         V61A==
X-Gm-Message-State: AJIora9GF8cSvBnUjFtDZvvsXl2W8J5XSkD5wwYqyGLx/H62QR7S4BHP
        Wx1waST0ThDH2/+ABffOJohj4DXAyd4=
X-Google-Smtp-Source: AGRyM1uW8FaZVvuvEZHOBKXbjwahbThG/hTtZl1uqPjPc9cVuDUAmIWetxT4qhS4zulwpXGMvBYf0g==
X-Received: by 2002:a2e:9941:0:b0:25b:c885:3143 with SMTP id r1-20020a2e9941000000b0025bc8853143mr6764509ljj.477.1658856987737;
        Tue, 26 Jul 2022 10:36:27 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.84.90])
        by smtp.gmail.com with ESMTPSA id v16-20020ac258f0000000b0048a9e899693sm571976lfo.16.2022.07.26.10.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 10:36:27 -0700 (PDT)
Subject: Re: [PATCH] libata: specify timeout value when internal command times
 out.
To:     Tomas Henzl <thenzl@redhat.com>, linux-ide@vger.kernel.org
References: <20220726170108.25087-1-thenzl@redhat.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <7d985315-bedb-78e6-a6cc-c18e31ab3c5d@gmail.com>
Date:   Tue, 26 Jul 2022 20:36:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220726170108.25087-1-thenzl@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 7/26/22 8:01 PM, Tomas Henzl wrote:

> Specifying timeout value may help in troubleshooting failures.
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
> ---
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 40e816419f48..e1f8a01a3b92 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1578,8 +1578,8 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
>  			else
>  				ata_qc_complete(qc);
>  
> -			ata_dev_warn(dev, "qc timeout (cmd 0x%x)\n",
> -				     command);
> +			ata_dev_warn(dev, "qc timeout after %lu msecs (cmd 0x%x)\n",
> +				timeout, command);

   The 'timeout' parameter is now *unsigned int*, please generate the patches
against the libata repo's for-next branch.

[...]

MBR, Sergey
