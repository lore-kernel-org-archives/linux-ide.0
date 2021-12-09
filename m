Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B61C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 00:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbhLIBCI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:02:08 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2146 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238306AbhLIBCH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 20:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639011513; x=1670547513;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2vsq91EE6kc/9mP0dfxWhoCzijqbXO3RUB8z6Fcjk90=;
  b=B6Kt9cTjnLLL5s9X/kRzeBZ+s+TQ9Pg08ZDJ6i98FkRJJ2nHBAwVkAIN
   enOSb8ovyWl6iawn9r3AkaEXJq7vcuoN0Ulyz7rChN7bWXA9ZNSU08UzZ
   QAgn6bFzcYLQ1X3YhQrDFroGlPWELMaMXbCW55CRFDv6rl4C40sUAqLGf
   WWNnYvEYsyGC7p7yW3BC00/R3DXMjbighecnNi/ggramU7O2EG0Y/EbN5
   H17W4VaqRihSc9uKRZpMUldeUVmqQJjTNYEb9h5xg+7tudg7IANiH3nC5
   McCceooVh45Z7rSvE92bhC2n/hGP1ILO5zdwRD8F+oXQ00RldhLwu/NJz
   A==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="192574914"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 08:58:32 +0800
IronPort-SDR: Uf0LYMYIgarBAmZ8R3oQ0ZBG9MkbEXEF/nSco96ZCj4oLdErbw1nAsCjWre5aU5NsacrapTTKl
 s73cJ/EuafeRCnI/tP/qpU9zDxbdN8xL11VRtL/zPW/BgMsuYA/B4jSZflgCpwFWRiQA+2xDBH
 7cGTwfJTXuAUZEK2hu3V1EsnGKQ/ycqGbTyC25bsYXqq4KobqZUtt5KXp4Eur5ZBe3f12l+IiA
 HDXYbe0C4/NfnFTzEl/9Nu0lM0nZiJhBf1RWrdisMCrWpSitqB9Up6U/okkq2KC0jyMd+1E0ij
 5ErncZ8mi7YLrH/9dG21iYuB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:33:08 -0800
IronPort-SDR: MlmuCqhqSJpyNkEQq/OSxlYUKhieT7yuhEicG2ph5sc4M+XPfONrYilV86d1x9edCnmz5CW6Jv
 dIxDL3zJs42RH4zyv24nSbfztm1GwGeh9UR+I8O4nQaZDUhRye3REsMA6pfC1DtRHzJhkLzdrT
 GWiGhinZv0OehHU7/q+iMqN5vv8ZjNli5jl7QVKXrO947N/tvbdtIZ97nr1U/JpAijCrbxMzV+
 CAG2DiXl4eTliSWghWdwcNQDclzjR19RiQWqiE3Ui8wxlRrK8jDFz5w8EKqjNFZ+u9CSgEYQX4
 wKk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:58:36 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8bJB4Sj8z1Rvlf
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 16:58:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639011514; x=1641603515; bh=2vsq91EE6kc/9mP0dfxWhoCzijqbXO3RUB8
        z6Fcjk90=; b=N9GyjuUKIBFL1XWVQJ61jG6HIlomTjz9BbD/2w7lB9OEsM+dJsb
        eHCN8rB4gSTD4rgPIH+PcN9ofiuNTDaOHEj68ECK895+6V2cS/zzPmqfW+d6Rc7c
        8TkHbmuTmnjHlXcwekcRhAoJwnCgs5Hx0xQTwHfH4CwGqNNHo9hOzf8FrSWN0tT7
        nffbMHS32lXxLwdFv+6IBW/q2WSrrvJQo8mBpjyx03A/ZEHVGT1sLvbc9IjYH54I
        VVnsv5jf31FxmcbQKheJi61POB685gNjZ3ll7iKqePA1/wMvbaBy6OA/sY1tMqje
        HhbEgWFGpSsCyFfnHuEJwiBtui6i9z68BFg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EAFgeaRG3b44 for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 16:58:34 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8bJ96vyrz1RtVG;
        Wed,  8 Dec 2021 16:58:33 -0800 (PST)
Message-ID: <ac7673f0-995f-195e-2a0d-0e150f621bcb@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 09:58:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 24/73] pata_octeon_cf: remove DPRINTK() macro in interrupt
 context
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-25-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-25-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:32, Hannes Reinecke wrote:
> There is only so much information to be glanced when the interrupt
> routine in called and exited, so remove these DPRINTK() calls.

s/in/is

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/pata_octeon_cf.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index f86dabcecf9d..7b80bbd9b1ed 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -668,7 +668,6 @@ static irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
>  
>  	spin_lock_irqsave(&host->lock, flags);
>  
> -	DPRINTK("ENTER\n");
>  	for (i = 0; i < host->n_ports; i++) {
>  		u8 status;
>  		struct ata_port *ap;
> @@ -722,7 +721,6 @@ static irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
>  		}
>  	}
>  	spin_unlock_irqrestore(&host->lock, flags);
> -	DPRINTK("EXIT\n");
>  	return IRQ_RETVAL(handled);
>  }
>  
> 


-- 
Damien Le Moal
Western Digital Research
