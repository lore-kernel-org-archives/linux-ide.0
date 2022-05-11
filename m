Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B60EC433EF
	for <linux-ide@archiver.kernel.org>; Wed, 11 May 2022 07:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbiEKHgw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 11 May 2022 03:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiEKHgt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 11 May 2022 03:36:49 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A745552E72
        for <linux-ide@vger.kernel.org>; Wed, 11 May 2022 00:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652254601; x=1683790601;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Alb1xrnJhldpzE9osSqFp3an/3P5dB47J8vJc3iL0z8=;
  b=EcfpxLcwx5kqRW7mSnaaViHCPWT9EJjRS5LkSfcWEEm+sSJEsH0FPlg+
   Wps6bGiOeP9BFyx5jqRgfxy+f6NdrSnkUXlfUqPsn9gsPEnyfubv0z0/c
   S9L3FUhuSVz1Fi1vWAvXST7OwNj/R7ku2qG8fnq4TUkul8Lq7r/vUX2Ps
   05Hx2Okh0hq/izaVaThKxLj/FzSPBLuIlwqGOgZfayJS5v1mFNAFSYuAK
   +79spugDgdpGdqRMFMQ46rnxuFviAgiSEjtvrb2wuqcnm7WCVSk55PJHx
   5cZBCVhMqdlojL9zbk7zdx+Brbn/kqaUoqWNyeq/39yUauiLW5GuT/sS4
   g==;
X-IronPort-AV: E=Sophos;i="5.91,216,1647273600"; 
   d="scan'208";a="200041026"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 May 2022 15:36:40 +0800
IronPort-SDR: PswPcAg7gUvLfyk7Cb9H8hts8GHuTrb7xW+Gy5LF+6Vanbrmg99pMTzSfist+Y1q2erA6F2g8j
 2u+7Qw5o6ns6dmmpbmN59ewyVT3nnHkNXvp96Ofh6UhT0IhKE90IB87y3LjIItOUwrpCkDvbLK
 vsQOV0xvGsnprHYQE5ViMEGdsJVXPfg0QQT6f/EAwksA95TJNq2BnVZEUZqkskWcVHbl7K4w+h
 Y+TNqRdtmeQrt+xjA2zjC0nGn/DnJWZR+lCZGB7YqA1Wb7AovE0bErQqx1dl2ZGwIBa0EHBSfc
 nuV3krh3U6/hJsKFPKuqlGaX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 May 2022 00:05:24 -0700
IronPort-SDR: ZvucuVv8FyuHqtfuRM/MqsJtgrH+DVTbgrgjsEq5aNUV5ImPXpSF946mZmq9TCJC2Zyb70cAEn
 pBOx1xW/+TZBewUZEgYIma+FP5p2qUhfgXpuAGOAWPeP+smG9SwZn9xW7xjIPuuLutqFHOmtKQ
 dGwO9DbAuqeu/Vh0yZsx0GHblv8YpuoEgA+5IUmX/Rhd7WqaBZyHA2O2kCrGFXMRvLUh7x1bd6
 8Vk5CEfM/FDHUnaiSLfeWshjtveoQ8CtNREEDxr4jztQb3S4bxbXutfDTndAvoKhbPk119wnn7
 cqc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 May 2022 00:36:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kymtw6HHtz1SVnx
        for <linux-ide@vger.kernel.org>; Wed, 11 May 2022 00:36:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652254600; x=1654846601; bh=Alb1xrnJhldpzE9osSqFp3an/3P5dB47J8v
        Jc3iL0z8=; b=iPLP+9bmh/sFRDsMlN+61U1UJdWQoEHUHr0wBj2xpGR4NfO9Qnh
        D+BLwpemayAbg3CNkK3Vyi5moF5RlN2y6Rx99yhj/em7ldb3F5OXFy7RivHw1/ei
        xG/MoansLkmsDPcsJvDSY/mDgdJX6g9vfj21+DZKWRB6tIquVLmKsOqp8EkPTD4B
        vn6MonKHv0be5DwoqvInLNRgXBRm1vSpBxYQyc7PgwmTJAlaw34Vi57d2xfEKtM4
        YefRD/Vt/Fxdhj/9+INTW/LYzXmAH2PtghuKol1ru68h6/ooqdP5DJO08Z4HEUVZ
        zRqkvdWiubI7LfsnpmZ96wBIulR/d7pViqQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WUg8Q9KzXE77 for <linux-ide@vger.kernel.org>;
        Wed, 11 May 2022 00:36:40 -0700 (PDT)
Received: from [192.168.10.49] (unknown [10.225.164.111])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kymtv0jPxz1Rvlc;
        Wed, 11 May 2022 00:36:38 -0700 (PDT)
Message-ID: <6122a113-9ea2-c3b3-153d-dac1f6a38dbb@opensource.wdc.com>
Date:   Wed, 11 May 2022 09:36:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] ata: pata_octeon_cf: Fix refcount leak in octeon_cf_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jeff Garzik <jgarzik@redhat.com>,
        David Daney <david.daney@cavium.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220511062723.56652-1-linmq006@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220511062723.56652-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/05/11 8:27, Miaoqian Lin wrote:
> of_find_device_by_node() takes reference, we should use put_device()
> to release it when not need anymore.
> Add missing put_device() in error path to avoid refcount
> leak.
> 
> Fixes: 43f01da0f279 ("MIPS/OCTEON/ata: Convert pata_octeon_cf.c to use device tree.")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/ata/pata_octeon_cf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index 6b5ed3046b44..65688459acf1 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -857,12 +857,14 @@ static int octeon_cf_probe(struct platform_device *pdev)
>  				res_dma = platform_get_resource(dma_dev, IORESOURCE_MEM, 0);
>  				if (!res_dma) {
>  					of_node_put(dma_node);
> +					put_device(&dma_dev->dev);
>  					return -EINVAL;
>  				}
>  				cf_port->dma_base = (u64)devm_ioremap(&pdev->dev, res_dma->start,
>  									 resource_size(res_dma));
>  				if (!cf_port->dma_base) {
>  					of_node_put(dma_node);
> +					put_device(&dma_dev->dev);
>  					return -EINVAL;
>  				}
>  

The extra reference should also be dropped at the end of the "if (dma_node)"
too, no ? Otherwise, early returns due to errors after that "if (dma_node)" will
also leak the extra ref.

Note that looking around at places where of_find_device_by_node() is being used,
very few users call put_device()... Looks like there are lots of device ref
leaks with that.

-- 
Damien Le Moal
Western Digital Research
