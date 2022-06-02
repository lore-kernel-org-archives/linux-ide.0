Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E762C43334
	for <linux-ide@archiver.kernel.org>; Thu,  2 Jun 2022 06:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiFBGcb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Jun 2022 02:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiFBGca (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jun 2022 02:32:30 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D171153
        for <linux-ide@vger.kernel.org>; Wed,  1 Jun 2022 23:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654151549; x=1685687549;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=RTvVdtkUpGa346JSx46gZWuxl7DtHHBLcONhUZYtf48=;
  b=DI6tFEB2pGVPFIdkBOOu82CvFsWy4v1nhAu0GLfOegKypmf/E7VJnqvB
   oBunmfG//x0nS3Ou1AtKaNTdtBqKVkdM2HOG71e8Ni6YntRDjmv3qI0ew
   VBMGCEkJKO9bYnqdkCQrFEp1uttH5wxUCT3WD8rS/SJEZ7bfXexn2k0NZ
   3KmcDxHAeOFwmQAVh9NmoutqzvF2s9vMKZoBXgW+6SB4BAHjFrRmlPQqD
   oZaQ33gXYL7sxuFnFCRNHU2TlzG6r/D4Bmz86OZ6e7YQNSeuN7jJM31Ps
   +m+n9REtJFqkQKa/swTIlGkvxPjFiSgvie/vSsfj8uX4PftdmGYVoqeUL
   w==;
X-IronPort-AV: E=Sophos;i="5.91,270,1647273600"; 
   d="scan'208";a="314101618"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2022 14:32:28 +0800
IronPort-SDR: OQc2IIa+3jkNO9TGBz0avECmbAV3OrErlVmeNnjuaFrCoUn7L4HhRdjfeRom8knrKM5TT8dwx/
 3Z3VfJz66Xppr7eoORJSOprtUvOPKSwT+2UdFIChNTm2LrYbXjEiZaUmAtBgkp9WW3yy5axkdx
 qspltSJxU6V11ktiIo0nyibw4Hvl0pk6GfKQufYIb6PyK77MknZoAvQiSRV8kCZhBqYk0Iq/Zc
 lcZ0QJPGGk8LCYDFxB+Ai7RxwmeMr1GjTxjJdwM8morR/X0XHpHPOrY+3ko01ClfIr4i0YVz51
 z5M9PSRCQszyQSYssjbNgqGk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 22:56:04 -0700
IronPort-SDR: ngucwud8Hlatq3QOuq8sS6DXWf81eqUkRPrdmIHX2i85gQL7to71fvUxK98okqqta5/Mr5gKyO
 +rUb+/4OrRQGqdHh6sm+qI3ev2cTgZa2s1vy0C6VKf+J13ePQwXRYAWkXDhib7wOHceAlrYCnM
 y5LP6xHy2Vwn0OYK8000uUFSp37hZ4GZeuRhYYkNaGTOLdF2o3MEw5nXZMn66ACV9SIEu2ghtH
 UVQvkCmHUI4tEtCsx/WQIkFdG7t9e7d0u6YaHNTZ//XCpsEewuAT/0DqwwcGDTbQGxMEKYbQUl
 RZk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 23:32:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LDGQg69PHz1Rwrw
        for <linux-ide@vger.kernel.org>; Wed,  1 Jun 2022 23:32:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654151547; x=1656743548; bh=RTvVdtkUpGa346JSx46gZWuxl7DtHHBLcON
        hUZYtf48=; b=lwQhoeQ3qsyyYDZi20JnxmUFWoqbLSPiGmXLTlz6fSXa8B6UZTe
        wi+1X33bEV7eG8AwBvi7q/tTnhDNhVNEl0Y5HaLb7nJkI26op58Mh3Tnll4Yo0SG
        DN2rgmacrsflzKnyKLG6IFjiZjm3G5n2gRrUOfaRlLS9/t31R1klL06WzXx/iFbf
        xyhCCp+EaRaa+XKic+Oxn8K6JVKb/JDlfYtV8zwO682m1RsomnKxsj4U6yPE2B+G
        jhLXg7mVj351rsqYUg9KCf7eE+ExdatPpF6XEW9n7FHuBrCleRb2hxcja/4UzBEf
        vVPD0J7EIg+pqC8ILAFQigXMtDGPcD0gz/A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6yYL4kGfasXi for <linux-ide@vger.kernel.org>;
        Wed,  1 Jun 2022 23:32:27 -0700 (PDT)
Received: from [10.89.84.115] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.115])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LDGQf28fXz1Rvlc;
        Wed,  1 Jun 2022 23:32:26 -0700 (PDT)
Message-ID: <87953d70-198d-e146-b67d-b320603d52d3@opensource.wdc.com>
Date:   Thu, 2 Jun 2022 15:32:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2] ata: pata_octeon_cf: Fix refcount leak in
 octeon_cf_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jeff Garzik <jgarzik@redhat.com>,
        David Daney <david.daney@cavium.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220601085926.45183-1-linmq006@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220601085926.45183-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/06/01 17:59, Miaoqian Lin wrote:
> of_find_device_by_node() takes reference, we should use put_device()
> to release it when not need anymore.
> Add missing put_device() to avoid refcount leak.
> 
> Fixes: 43f01da0f279 ("MIPS/OCTEON/ata: Convert pata_octeon_cf.c to use device tree.")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - Add put_device() at the end of if (dma_dev).
>   we need the null check and do handling only if dma_dev!=NULL.
> - call put_device before of_node_put() in error path. keep the
>   reverse order of resource allocation.
> 
> v1 link:
> https://lore.kernel.org/all/20220511062723.56652-1-linmq006@gmail.com/
> ---
>  drivers/ata/pata_octeon_cf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index 6b5ed3046b44..35608a0cf552 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -856,12 +856,14 @@ static int octeon_cf_probe(struct platform_device *pdev)
>  				int i;
>  				res_dma = platform_get_resource(dma_dev, IORESOURCE_MEM, 0);
>  				if (!res_dma) {
> +					put_device(&dma_dev->dev);
>  					of_node_put(dma_node);
>  					return -EINVAL;
>  				}
>  				cf_port->dma_base = (u64)devm_ioremap(&pdev->dev, res_dma->start,
>  									 resource_size(res_dma));
>  				if (!cf_port->dma_base) {
> +					put_device(&dma_dev->dev);
>  					of_node_put(dma_node);
>  					return -EINVAL;
>  				}
> @@ -871,6 +873,7 @@ static int octeon_cf_probe(struct platform_device *pdev)
>  					irq = i;
>  					irq_handler = octeon_cf_interrupt;
>  				}
> +				put_device(&dma_dev->dev);
>  			}
>  			of_node_put(dma_node);
>  		}

Applied to for-5.19-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
