Return-Path: <SRS0=/3H8=UW=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E7DC43613
	for <linux-ide@archiver.kernel.org>; Sun, 23 Jun 2019 09:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF1820679
	for <linux-ide@archiver.kernel.org>; Sun, 23 Jun 2019 09:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="revNQguT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfFWJHC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 23 Jun 2019 05:07:02 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40779 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfFWJHB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 23 Jun 2019 05:07:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so7889692lff.7
        for <linux-ide@vger.kernel.org>; Sun, 23 Jun 2019 02:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8uUFPYYsBjgmgqXtdG/aFORmD5gxcktbPqZxjSpl2DM=;
        b=revNQguTInKk47Hr/SSfbkqetE70ACqSrOFnN5/4F1fVO+v7In4Y/VYEeuXSLTTsxi
         Z/Rf5/9gepnAzaLe9Fgyt+LpXb8bv+Rh2zSaUTPG5F+/4V00/2RG+BBqjSoG00tcSvBo
         X+wijkcxxu//pGwjDr9wMCw2zSyIviYWvhDVwcIN2Xi3/CCGOZNH5ah1d7WzakCFKHig
         B/z3l39139cEjGNOOgzDv5rVKddOm7g5y1AiTx6zVq7beCU8uNz9Uwuovvsh9dsRlpCP
         6kma+7w+6QhACIPtuWiklIfyhx9gClndWthHcYOWBf5QfD88tQgFheo9qTuH40CqelcU
         z/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8uUFPYYsBjgmgqXtdG/aFORmD5gxcktbPqZxjSpl2DM=;
        b=HRqYmKBeXqfmdVkIYw/nMzgXKZP2L/fcMQS4Gg90fQM8ruwrcA9PadU+RKVoIFHt0e
         JdC6Qr1d/lD3oCyOUCISscaKfjXySv093xv422g7cwyYkeGZ17BOGKYxeoelVxyLwU3a
         +QoCq36q6bxpemuU7kvse/sYbwq+PvaC7IqjiFndZkJLckDC6KT17cJu6/7ksCsAKoDR
         PRFvXAZV1ZEaRVIpz9Ox5HJJ5Jy0eTMQNAko92S173IlZZRxO+Y+0vs8wKkbMzoYniDV
         aqW1EDSxn28XV6BkS5G6dHtoPUM3NUwoPCjMht5hqQoLDduciftXOk5+ZWLAWPduxMvi
         FpNQ==
X-Gm-Message-State: APjAAAVoeQ6r7liN2CEtDdGV5WhFJowxhZplhDNtzNYKosP58byH88u0
        qXQlvHty4WIWbG2mBdZjxqaDSw==
X-Google-Smtp-Source: APXvYqwMEpcDhKinIMAI8pNExY/Z1k08sxwUpefe78j254IPjtPa7+2bk1XsdUiJjeTusIlLafUFJg==
X-Received: by 2002:ac2:4202:: with SMTP id y2mr4980428lfh.178.1561280819089;
        Sun, 23 Jun 2019 02:06:59 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.81.196])
        by smtp.gmail.com with ESMTPSA id p5sm1200613ljb.91.2019.06.23.02.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 02:06:58 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k/atari: add platform device for Falcon IDE
 port
To:     Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org,
        linux-ide@vger.kernel.org
Cc:     geert@linux-m68k.org, b.zolnierkie@samsung.com
References: <CAMuHMdUcUqWWGNngNV3EpEq5wSsf5qTVeZvTB9gX1e26Jrq1xA@mail.gmail.com>
 <1561063642-13900-2-git-send-email-schmitzmic@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <f820e822-deae-87a3-cb05-0ca2ba4608f4@cogentembedded.com>
Date:   Sun, 23 Jun 2019 12:06:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1561063642-13900-2-git-send-email-schmitzmic@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 20.06.2019 23:47, Michael Schmitz wrote:

> Autoloading of Falcon IDE driver modules requires converting
> these drivers to platform drivers.
> 
> Add platform device for Falcon IDE interface in Atari platform
> setup code in preparation for this.
> 
> Add Falcon IDE base address in Atari hardware address header.
> 
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> ---
>   arch/m68k/atari/config.c        |   20 ++++++++++++++++++++
>   arch/m68k/include/asm/atarihw.h |    6 ++++++
>   2 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
> index ca8469e..2d7133a 100644
> --- a/arch/m68k/atari/config.c
> +++ b/arch/m68k/atari/config.c
> @@ -896,6 +896,21 @@ static void isp1160_delay(struct device *dev, int delay)
>   };
>   #endif
>   
> +#if IS_ENABLED(CONFIG_PATA_FALCON)
> +static const struct resource atari_falconide_rsrc[] __initconst = {
> +	{
> +		.flags = IORESOURCE_MEM,
> +		.start = FALCON_IDE_BASE,
> +		.end   = FALCON_IDE_BASE+0x40,

    You probably forgot to subtract 1 here...

> +	},
> +	{
> +		.flags = IORESOURCE_IRQ,
> +		.start = IRQ_MFP_FSCSI,
> +		.end   = IRQ_MFP_FSCSI,
> +	},
> +};
> +#endif
> +
>   int __init atari_platform_init(void)
>   {
>   	int rv = 0;
[...]

MBR, Sergei
