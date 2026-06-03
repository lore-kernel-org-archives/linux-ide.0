Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19D83F23B6
	for <linux-ide@vger.kernel.org>; Wed,  3 Jun 2026 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515515; cv=none; b=ajgj5zMpeRcloO6ScBSq5nh5jGLggvsSLDk55cRCITMq57GnOUJRhH4rEW9Q9ZKpU+CWlBt15RyC2YUjPvOAyPox/lGgR6dZrhSOcMM/DgrC5Bzm+BwRr1+ssKB8s+h0dy1RWY7jgGnT56svjh2srcsG30e2kLTc0F9pAmCBxUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515515; c=relaxed/simple;
	bh=+1XQ3Szm38rXGThGP1fTq4I/sypwvXRUOmHF1pwSyM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMMYd6HWVKM/Mf9ZCiVh6S5919mr0CMHXRTa47Qa0WH0Fj9APGyOgWGDzpayrQPIOVAxgv3mzNEK92LJieuHvgkbVyVxKdlG9vp1eIfA63VDyNYHBjRtoQ/ZbZShceq+ishIASWxDc0HksHDXfahE0vv6uALkd/F3HrX5xOtSuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ol5Ng5WS; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol5Ng5WS"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39664fe2dd8so37883651fa.3
        for <linux-ide@vger.kernel.org>; Wed, 03 Jun 2026 12:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780515512; x=1781120312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hQkIO6GXdfrVuD2j4hh87FXMA2VWe2X4YdQxcNyjzY=;
        b=Ol5Ng5WSfDNLEGLnBfpVmoS6JYDzXkeya/KlGlDQwCqKmPReznCcwpb5L+jK+lH0f0
         3U2KboA1rKtZ4RdSa5b32DUUlQKCL6sKEDb6dtsu/wdcJvzRvUcvZsSYmMisflxaK+07
         NXjxCfB4NS0ic0BjWEAckn+RKY6mg2LdTimyrio1reetHOUoq8kqYLGUFUw9q9L1zm1w
         gaEAHg0GiTV1VYDdV1Z/QtqB/6byc6aM5ZGAJuvpBYccZDa/1cAIcAnhfSpNSsi6mTgR
         Ecc8+/NJR6EeWiVwHdR5Cu93KUIC97t+38XSTa891XPxYQ49v5J6mHDEjoyXXj20Rj6X
         mOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780515512; x=1781120312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hQkIO6GXdfrVuD2j4hh87FXMA2VWe2X4YdQxcNyjzY=;
        b=Mo40wbkSHxGWxqZjf2qWzoTCUH30TSSMPmg6sNKQ9YjnLcZcSG7eO1lL8l7rBQrQk0
         MID4pKz9/SsrKmv2spAFJwQ3jZqS0NeYDbYkhz5zcq1FrGR+e57JkDZ5o/Z63VJNSo9P
         v6G7CJm1PT1xhnAvDagGawefzZDNl4OLbkcDacM8smNoInalREPJh4ThH7bRynHi3nby
         vMf2qDwl21QXhUIViTtUwIyN6trK226KWN69UL+xMXP20X6MbRrV4vD0fRnoJW9eOmKZ
         3nwraiQGFohwaYFwYJ+xx1yhSAEOKep3GlxiiAzbSExUgVN4jXJ3AYIhxqZUxwvxdsnk
         IPPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fLCTOLBoD+5rrOEeFOjhOZd86bXkNXDFpUpJV+2ncMVFquYQGARYwNErz41Z1HJNtQf8U2WAwuaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiA9moXcTgViYGnz2mHuB69MK8F8YUzG38IMc0kCtDiwmakXrD
	K9WMSvWRUDn6Cv/TgrMOzWb3on1dwXAU7krV5A8Iz2t3zLmH+asf91hy
X-Gm-Gg: Acq92OF+lDgHqZ6JfIbjI5lRd2syYwcH8h2aZ0jk59IFUWlN4VfqHjb7GrcRR90UTKc
	UQUCyaHa/UMI4FYlsexrYVK90svddZhz9Ptw8Ov2CQFr+3E5Mra4dsalJsiHMJJR8dy1CfPFtqH
	j8H9mcP7Bt5EeMgIz9QUn4zm2mfSv5jypxmHp6dq4/34SQ/CAhHyQYqv9yU5m65gxlU1N1xfVOp
	u7eh0GiTzK+OXroh6rjbXuYaiOQA0UkXM8JVj7ZCVOJmA9Nz44vgX/clrJov5mnizY5ocZ3QM3D
	DMPZEOmsSru41wxMHJs0x0DqqykDZSMz5jXuZzZdvtzz/mExsFHBGpJo+VvdwJH6cqjGVo9XXK7
	MIXSl8t77osk6dycPL00y67JhmO8mCVXuCYtD1F5CVu5gBuGQXjYJ0GZdazJypSpxsUR6cRHBzD
	QagT8HP69b0ZvQNRBRy7BLFoIEM8XnlpbYAbBDqqkuTY92bs572iPDZ576ghrGMxU0hPkBeGJxJ
	2bL6qMpo73jZ0xVFc9Wi+1N
X-Received: by 2002:a05:6512:3e12:b0:5aa:6603:5256 with SMTP id 2adb3069b0e04-5aa7c0dc6e8mr1586061e87.28.1780515511635;
        Wed, 03 Jun 2026 12:38:31 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:4322:28:5bcf:7f50:ed88:1440? ([2a00:1fa0:4322:28:5bcf:7f50:ed88:1440])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fbe1dsm812806e87.27.2026.06.03.12.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 12:38:31 -0700 (PDT)
Message-ID: <1379ffa1-ccb8-4ca7-991f-b9a55d519baf@gmail.com>
Date: Wed, 3 Jun 2026 22:38:29 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_mpc52xx: convert to platform_get_irq()
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260603192028.5818-1-rosenp@gmail.com>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20260603192028.5818-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/26 10:20 PM, Rosen Penev wrote:

> Replace irq_of_parse_and_map() with platform_get_irq(), which returns
> a negative errno on failure and integrates with the platform device
> model. Since platform_get_irq() does not create a separately managed
> mapping, the corresponding irq_dispose_mapping() calls in the probe
> error path and remove function are no longer needed.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/ata/pata_mpc52xx.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 210a63283f62..f8ecd58765dd 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -730,10 +730,10 @@ static int mpc52xx_ata_probe(struct platform_device *op)
>  	if ((prop) && (proplen >= 4))
>  		udma_mask = ATA_UDMA2 & ((1 << (*prop + 1)) - 1);
>  
> -	ata_irq = irq_of_parse_and_map(op->dev.of_node, 0);
> -	if (!ata_irq) {
> +	ata_irq = platform_get_irq(op, 0);
> +	if (ata_irq < 0) {
>  		dev_err(&op->dev, "error mapping irq\n");

   s/mapping/getting/?
   But actually platform_get_irq() loudly curses on error already... :-)

[...]

MBR, Sergey

