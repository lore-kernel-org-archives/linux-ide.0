Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516D6C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 23 Dec 2021 00:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhLWAl6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 22 Dec 2021 19:41:58 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45744 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhLWAl6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Dec 2021 19:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640220118; x=1671756118;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nawvsT6Jcs6FdqzmEDlZNXwO7jnwvDFq4+tAcedUs0g=;
  b=Jsv4V7gNrvSzVKh2depaiRhCbfaFtkJLa5DcNB/A8ryhx0hoaNFcymes
   B7LTDKrkRI9uJPJ86ZuYrVzqli5NaRAyjbe6WZQD7hjpKjzZ60+Ickbik
   /pbAXfl7xnVb76+0ZAeFgDQvIA5VSpHVH0cW3eCkagYZ0f0gpZ3qYN37g
   mCF/K73LPv7r4cnWh6h4cRF203GM8Xasxetz4lzua3Z7Y9lgm+ABvQuBo
   xabWBgJlA00B+YkOPWpc8y3TaAgza4pnlXb6XPb0jv0l7R9MAGp5lo19R
   KOAMzSmPkP/usWimnkeYbq2I/BI4Saoh+70uirwwKnFltkihbRG6+ljps
   g==;
X-IronPort-AV: E=Sophos;i="5.88,228,1635177600"; 
   d="scan'208";a="187873862"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Dec 2021 08:41:57 +0800
IronPort-SDR: 2mSYTFjhueNf5OubS/AnuBvOyv66rhfb08TTM8oUMXLVx1pI0q4/7ozN1OBgXdI7H4unzZhAY1
 le0Cb47c9k77AMH77xTlp0t5n8RpNhMs9mvk+I3EJbb5KQrjAszfX1UiunxdyYpMZqoNwMPnbA
 9CNasoUkBi6wZhAE81nssfsXJAJMfZSAXMJeU68NoIfd6pQuxStEijrXC6sgw253cLNJfM/C2D
 t6xI/8ccTBQZPa9EUyzcE+rZxRP7q0W2ieZRvYly4fhgYSR9tOf0QpUj+VBNfmB+skiR0mgip6
 JkFAbg6PxIMuz/sF9c53YMFF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:14:44 -0800
IronPort-SDR: UKmjFqJJSu2Xe59vcXi79NjoAJGrP6fmwQV8hGioh5AiKWLfWFLM5i6uqtAck2i9jpiIDFL7SR
 a638xCU3ANnvM3S1BXfzp65O5onhKrsyL+87aXL4ye8D4TTuUi5seuBzfFexI69d10NNoe5tFQ
 cfKD3JjGpdrYv0cAj1UEqPt9rCD/2ZTUs5flxrioZD+AdjEJgbpxtb2HXZW0U0YXGUQh0PRwMv
 Yr12MJ6eIo/amo75TJj+u/E8zwJlDax7zMLPjRE/3nRbTrdhlCadEUlCmxmtrOjYIJJ59skv+U
 2Os=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:41:58 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JKBGY53w4z1Rvlf
        for <linux-ide@vger.kernel.org>; Wed, 22 Dec 2021 16:41:57 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640220117; x=1642812118; bh=nawvsT6Jcs6FdqzmEDlZNXwO7jnwvDFq4+t
        AcedUs0g=; b=GUNjZImKROI52sBhA8G3jNqp0klE9jG5u/3KxmTHV+gVb+xjK1G
        oDLpYMaUJWXKN4tJ+jqi0WaoqS43hvnKe7CsMKxGnsnCk3ByPYSnJ38qu5yJPxxm
        rv818//Ogj+SfS17x0ImlqFDfyPG3pZjRXYKRU3Qm0Qi7w3Fl0hzvTCIDq3bJwF3
        K4LQ8U8Dj0W2Q5w1PJ/WNZmbGcFf2zEo6yq9h41O5I6Yj7rJG1PBTG4fHIXgU6H0
        5t6wqb0/FS5XfHR6aK7Wxg0s/Cml6gxL/lPr5JG66sA6i4IMDdIdun0CKsxpTo4u
        l6+OhKnfW92VG7iriDfhaFHSjXJD7sr1D/g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id E_aaLjXPKp1y for <linux-ide@vger.kernel.org>;
        Wed, 22 Dec 2021 16:41:57 -0800 (PST)
Received: from [10.225.163.35] (unknown [10.225.163.35])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JKBGX0r4Jz1RtVG;
        Wed, 22 Dec 2021 16:41:55 -0800 (PST)
Message-ID: <dd6e6054-3d7e-b43a-0386-71323c49ab27@opensource.wdc.com>
Date:   Thu, 23 Dec 2021 09:41:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ata: libahci_platform: Remove abundant check
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, hdegoede@redhat.com,
        axboe@kernel.dk, p.zabel@pengutronix.de
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211222072446.1096168-1-jiasheng@iscas.ac.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211222072446.1096168-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/22/21 16:24, Jiasheng Jiang wrote:
> It can be found that platform_get_irq() returns nagative code but not
> null when fails.
> The comment of the platform_get_irq clearly shows that.
> Therefore it should be better to remove the useless check.

Nope, platform_get_irq() can actually return 0 (the comment for that
function is wrong). So testing for !irq is valid and must be kept.

> 
> Fixes: fd990556f0fa ("ata: move library code from ahci_platform.c to libahci_platform.c")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/ata/libahci_platform.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index b2f552088291..5ec68f138c28 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -587,8 +587,6 @@ int ahci_platform_init_host(struct platform_device *pdev,
>  			dev_err(dev, "no irq\n");
>  		return irq;
>  	}
> -	if (!irq)
> -		return -EINVAL;
>  
>  	hpriv->irq = irq;
>  


-- 
Damien Le Moal
Western Digital Research
