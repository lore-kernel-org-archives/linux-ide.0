Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF34C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 23 Dec 2021 00:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhLWAf2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 22 Dec 2021 19:35:28 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:1817 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhLWAf2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Dec 2021 19:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640219727; x=1671755727;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FJoVc4dAwzd533OMIKZS9+1/T26+GvCBRtbTTG2MG3g=;
  b=PHErUyB76Fv1NRUwiJa5Xfbm9r0q2dL5dA9vUW/6kNj3CPCECZqJ8IqS
   eLAO0uRd40AqBbcooKVVigd3TKOxEkoPr6+ugZ2Fx7Nf50qiqUHtVRNT/
   4ccs9ufBqtF8Mr9VdDjsEMIUdGkmmJ4P7D6+4Tzj7TdYKFx14Gk2SDMbF
   kbs2p/dwr77sw37R/0YIRkFB+BtTXS4gTxjL04U2405OlQ56vWl8RF5AB
   aT29G8hiQc6OfujdSzNMtJ77KeOWW8huxIZIlYp/pehkK/p/i1otQbKoG
   cpdF9WKZnnPhjQaO6x4k5lgj0VU50Dchhkp1nS/vPn81sLXzwvN4SxjvE
   A==;
X-IronPort-AV: E=Sophos;i="5.88,228,1635177600"; 
   d="scan'208";a="187873535"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Dec 2021 08:35:27 +0800
IronPort-SDR: irFjC6puP5JongogNFwOJdVL2PwIBP0Hwoy52Bv4uhYsmE+Ja8IzHaTlmMtW2Y3GRQP05pUTeK
 4dAQb8szqKPPK6XINLC72MKPEN2R22TsFhfBd6DReMa4uf3x0/yXeNL9qLack4YDMsRP7NBn8i
 8IX4GOsngnV1PULxJ/K3Nby1POjQkQRyYxOR06M59yqFM038gm6e5YRL3rq/Rhp9vbO3bEkBZf
 8uGmYjTdoLs4uMOiwksiGIfq5DeZ0f9LGLLJ5ZkibDzN9ReV+X37vuRu61vfjZBjMZqSC7AdYR
 fl8FcsWNW9CI/UG5cOafDjID
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:08:14 -0800
IronPort-SDR: 82itpgBGS8AI6z6vX4+3VZnsqkyCCM8mNBWcJeWdLQMr7u5sfXrw4Qum8LdTzVP95uoBLiBfhx
 pyUMFkj0wcahko6AyhJ0hV5ami/bvKJzfBZJIRvOrN9Y6/d0bTXdWvtytDYwrSFdGMgV+R4sHI
 43YkFPPd+ilQEcW1tiRkZdo4GCqS1ZJ7R+U6YPzifhBqRTmp8QIHOTn8oMLFC+0PhcLz9YGazV
 QtopgjVhW7ur5lxocNjdFDopHKXypbu9cDzB7jKJKu55lxQTdEIhTJsKaPenTg9qZJ/KVf/kMs
 IsA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:35:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JKB731DZnz1RwFN
        for <linux-ide@vger.kernel.org>; Wed, 22 Dec 2021 16:35:27 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640219726; x=1642811727; bh=FJoVc4dAwzd533OMIKZS9+1/T26+GvCBRtb
        TTG2MG3g=; b=B2nhR3cayhmNKO9nGybK/8FxEQDeMnII2cYvbb3R/Q6TrVLg8E0
        xRkape75ud1R63ChmYQviHQaVqckRQ9oXjyppRuJnMduyFCxq6hUS9b/lzqxvyTT
        gxHYJnN3zpondXbkjmDCdKFU8bWaJ1oJnMLjf1tkpDyB9dendjPdQ2dPv8xXqOdF
        czAecT3P0dS+ILGBXwGHt22vyqSsjfS/lUBs42doNBXN+f1d3RVfrQZiBiM/W85E
        jT2LH+H4C6o/pDCrDEoOJxyLByzp/uCp1rfLVsLU/wKQ/GL3c+rTthg/N1w9tP2o
        Ok08b/e2o8HKeN94Yk89GfEypck7zVJ2o3g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Buc2Tk31ZsPK for <linux-ide@vger.kernel.org>;
        Wed, 22 Dec 2021 16:35:26 -0800 (PST)
Received: from [10.225.163.35] (unknown [10.225.163.35])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JKB7127BFz1RtVG;
        Wed, 22 Dec 2021 16:35:25 -0800 (PST)
Message-ID: <d851cdc5-78c6-ff35-979f-7aec71f3cb9b@opensource.wdc.com>
Date:   Thu, 23 Dec 2021 09:35:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/4] ata: pata_platform: make use of
 platform_get_mem_or_io()
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20211221162614.25308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211221162614.25308-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211221162614.25308-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/22/21 01:26, Lad Prabhakar wrote:
> Make use of platform_get_mem_or_io() to simplify the code.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1-->v2
> * No change
> ---
>  drivers/ata/pata_platform.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> index 028329428b75..cb3134bf88eb 100644
> --- a/drivers/ata/pata_platform.c
> +++ b/drivers/ata/pata_platform.c
> @@ -198,22 +198,16 @@ static int pata_platform_probe(struct platform_device *pdev)
>  	/*
>  	 * Get the I/O base first
>  	 */
> -	io_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> -	if (io_res == NULL) {
> -		io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		if (unlikely(io_res == NULL))
> -			return -EINVAL;
> -	}
> +	io_res = platform_get_mem_or_io(pdev, 0);
> +	if (unlikely(!io_res))

This is not the hot path, so I do not think that the unlikely() is
necessary here.

> +		return -EINVAL;
>  
>  	/*
>  	 * Then the CTL base
>  	 */
> -	ctl_res = platform_get_resource(pdev, IORESOURCE_IO, 1);
> -	if (ctl_res == NULL) {
> -		ctl_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -		if (unlikely(ctl_res == NULL))
> -			return -EINVAL;
> -	}
> +	ctl_res = platform_get_mem_or_io(pdev, 1);
> +	if (unlikely(!ctl_res))

Same comment here.

> +		return -EINVAL;
>  
>  	/*
>  	 * And the IRQ


-- 
Damien Le Moal
Western Digital Research
