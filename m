Return-Path: <SRS0=g8lw=BU=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF886C433E5
	for <linux-ide@archiver.kernel.org>; Mon, 10 Aug 2020 08:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BBC220729
	for <linux-ide@archiver.kernel.org>; Mon, 10 Aug 2020 08:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVXduCsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgHJIub (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgHJIub (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Aug 2020 04:50:31 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7599C061756;
        Mon, 10 Aug 2020 01:50:30 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w14so8675587ljj.4;
        Mon, 10 Aug 2020 01:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2vy5WK0/lZz1ewdjEJ/g1nZeGw5MBX8oCLLIJ1fU9Bo=;
        b=RVXduCsjsI1KO/t7jAETjHGfpJeIfBkNLlUdPZQLbIvZJXw1A7nNDa7rQ3p6FXYjhG
         TNaAfEriRKSt6fTkDhNBKJS4Ye72JJuXQggjStSGEVPwDw25sN8BYj2yNNZhH7R9FK8L
         2OlOYujONBOc43ByZbz646sekkhZliKDQF6bdQXePc7kxBD+kCr3jlqzOkaasB+gcIs5
         qll9KEywhbWs6TUmlhTxOtVBlEe5Wn4oyl7fTUmiSVO/l4GauqgmJkPhpalzxIusIn79
         YzBZf+M88uBOYHw2rmonuNOdMGzTmoiUHda5qzBlNGXGXl6P9pGuTn6FX9rrlkDEoJ0k
         SrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2vy5WK0/lZz1ewdjEJ/g1nZeGw5MBX8oCLLIJ1fU9Bo=;
        b=eg2cpGNBTSmz/+XktP1b2Wl0PRwQAquFq/+a+pClsjs2Ym7i4QAEz4Y6AzqNAcrfpd
         7V4qVKaKeHXVrfoVR6XsE8g4+iwr5FN0lVdBFileCpDw4b9/8lCaX6h0nx83Jb/Zhtfl
         eJV/lplEUjIwGQcF9U8w4+5jAeuSSUK+lNk3lyan+M7tgyyLMXXS6v8ur+FCEaqTceIl
         E2abELiGz8Jkc+EEJxSVEMFgo0Q+Zc87zEkAUFybo0DZgWAtjdoa++CISSb6G+Rm5nlh
         xjNVOMjA+Pd/vUI2n4EdlYvzqNCJ5uLOxHgZvSSnsRslxyjJqwgN/bLfhvo8xGj2i6L3
         UiNg==
X-Gm-Message-State: AOAM530M5FKF9SJYYPwXpyNJLzexCNmqxfDt6Gxr/TAtVnE929lBIOX/
        I3yE7JE7qv/owQc/QdXDWPz85fVR
X-Google-Smtp-Source: ABdhPJzAKqKsxBUQ6dMvRHeeew+CCTavJevMHcIrxLQGzCgyq6bCmkzedAvzc2gB+iPcDqXEXN7ggQ==
X-Received: by 2002:a2e:5018:: with SMTP id e24mr34551ljb.261.1597049429209;
        Mon, 10 Aug 2020 01:50:29 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:656:4d4d:4047:314a:a423:d91? ([2a00:1fa0:656:4d4d:4047:314a:a423:d91])
        by smtp.gmail.com with ESMTPSA id o16sm8976071ljc.66.2020.08.10.01.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 01:50:28 -0700 (PDT)
Subject: Re: [PATCH 3/3] drivers/clk/clk-asm9260.c
To:     YourName <argoz1701@gmail.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     mturquette@baylibre.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20200810005941.20581-1-argoz1701@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <bdab839e-1aba-5b0f-e5de-52ddebc8b9ed@gmail.com>
Date:   Mon, 10 Aug 2020 11:50:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810005941.20581-1-argoz1701@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 10.08.2020 3:59, YourName wrote:

> From: Daniel <argoz1701@gmail.com>

    Full name needed here.

> ---
>   drivers/ata/acard-ahci.c  |  6 +++---
>   drivers/bluetooth/bfusb.c |  5 ++---
>   drivers/clk/clk-asm9260.c | 12 ++++++------
>   3 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
> index 2a04e8abd397..3ffb21f3e88b 100644
> --- a/drivers/ata/acard-ahci.c
> +++ b/drivers/ata/acard-ahci.c
> @@ -79,10 +79,10 @@ static struct ata_port_operations acard_ops = {
>   
>   #define AHCI_HFLAGS(flags)	.private_data	= (void *)(flags)
>   
> -static const struct ata_port_info acard_ahci_port_info[] = {
> +static const struct ata_port_info acard_ahci_port_info[] ={
>   	[board_acard_ahci] =
> -	{
> -		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ),
> +	
> +        {       AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ),

    This does nothing except ruining the valid code formatting.

>   		.flags		= AHCI_FLAG_COMMON,
>   		.pio_mask	= ATA_PIO4,
>   		.udma_mask	= ATA_UDMA6,
> diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
> index 5a321b4076aa..dc6a62cb1941 100644
> --- a/drivers/bluetooth/bfusb.c
> +++ b/drivers/bluetooth/bfusb.c
> @@ -355,15 +355,14 @@ static void bfusb_rx_complete(struct urb *urb)
>   	while (count) {
>   		hdr = buf[0] | (buf[1] << 8);
>   
> -		if (hdr & 0x4000) {
> +		if (hdr & 0x4000)
>   			len = 0;
>   			count -= 2;
>   			buf   += 2;
> -		} else {
> +		 else {
>   			len = (buf[2] == 0) ? 256 : buf[2];
>   			count -= 3;
>   			buf   += 3;
> -		}

    This just ruins the code.

>   
>   		if (count < len) {
>   			bt_dev_err(data->hdev, "block extends over URB buffer ranges");
> diff --git a/drivers/clk/clk-asm9260.c b/drivers/clk/clk-asm9260.c
> index bacebd457e6f..4e608807a00a 100644
> --- a/drivers/clk/clk-asm9260.c
> +++ b/drivers/clk/clk-asm9260.c
> @@ -92,8 +92,8 @@ static const struct asm9260_div_clk asm9260_div_clks[] __initconst = {
>   	{ CLKID_SYS_CPU,	"cpu_div", "main_gate", HW_CPUCLKDIV },
>   	{ CLKID_SYS_AHB,	"ahb_div", "cpu_div", HW_SYSAHBCLKDIV },
>   
> -	/* i2s has two deviders: one for only external mclk and internal
> -	 * devider for all clks. */
> +	//i2s has two deviders: one for only external mclk and internal
> +	//devider for all clks.

    Divider. :-) This is not the preferred multi-line comment formatting anyway.

>   	{ CLKID_SYS_I2S0M,	"i2s0m_div", "i2s0_mclk",  HW_I2S0MCLKDIV },
>   	{ CLKID_SYS_I2S1M,	"i2s1m_div", "i2s1_mclk",  HW_I2S1MCLKDIV },
>   	{ CLKID_SYS_I2S0S,	"i2s0s_div", "i2s0_gate",  HW_I2S0SCLKDIV },
[...]

MBR, Sergei
