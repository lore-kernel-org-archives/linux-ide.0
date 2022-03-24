Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C679AC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 01:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiCXBhp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiCXBhm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 21:37:42 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B303D92D2B
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 18:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648085771; x=1679621771;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gsAck33gFP7RxtLhhR89Z8++2bilhvSOMcQfDm+nq8c=;
  b=AbyAzyFmvKrcEl9aQz3u5dN+ZeIG4w6GiP1kGeJfdk5xq07Qm7WEnoy3
   hMUWnUkj00AIP5UHOOUFX4sJWQ4iGLcQkZsQptjTysHlQjClmsEloSyvo
   v0MGerSQ0MEanLftRm0bFC6ZQPYGdwjRsiS6jwU2Wt9d10mcKHl6lOQTC
   9x/0HzD1p0CvcIeyw66GpJYOxRmQ2jZ4FRLxwNyEjSxnY2RU5g1Dp71TI
   vC+P49t5210xMG24IiIpGJEIO4Agrj/GaZAH9Bg6X2G+RgPR8pOlbpUBi
   h4WnYtnueaRZVkYAK6CmiSIWyo4fSv8cYchPO/DsVD4jJBMTz5HtauNRu
   A==;
X-IronPort-AV: E=Sophos;i="5.90,205,1643644800"; 
   d="scan'208";a="195019573"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 09:36:08 +0800
IronPort-SDR: AQ9QbIXDDI+UUIgtDquprIr/DwSveFmtnC4xx+C8k6+ecqtd/+8LAn17GkMRGe8qs7+PuIH1Cy
 aiKrnSsmr2tOeb0FYLPvbBu+D1GSwwmNMfX4a3E/scnfYGov6OHCRC0aDXLmGyLX+DmM7MERs6
 ixiL3e9gAUyB7Ff1S4/VWUSUKmT3Hau5bVwatcgMGJW/00C9MviLjWEqN0+LVFqzKGM9UcuIug
 1WxqelsxKbxc0B995Icws9xhk4ly8iwuoY4rl/DUn/zKcaM403/KawPYmFp3Rtg8C+zUGieiPZ
 RVfTA/7polhOS55cYyYTbdYk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:07:05 -0700
IronPort-SDR: MzBSUEMZ69o9T6yAlrb5KTGJAnBTse+FCcoulYFap/gnq4WRWzPSc3QaM8ZE0Z39oLgvlK6A9F
 R+tFHzpT0idfHRMe1gLMTF8P7fMxXXKqBS4yIFJGMAsjQ7Q+KCKxjYxoSaXKpf6GRYMwjPjKmd
 Nc08NpEqViTfY/EM6mrGhOjgwipJvPBMawjj2yTHiErNW4c+TI+4K8+DjrJRoJRGzmtA3dlvqe
 7tAoT5yjZJ8aS9PngFScaeNzjPiNyYwdGuJB9YaMDYFjo5TKojR+li6JIyVZA3HWlHzCnL5x4I
 uhM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:36:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP79411N5z1SVp0
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 18:36:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648085767; x=1650677768; bh=gsAck33gFP7RxtLhhR89Z8++2bilhvSOMcQ
        fDm+nq8c=; b=k1Rwmz/bIjpWeV8Jh9O+EbBMvmLx9z7xfmIXdZERzPVelBEkNcu
        suPyirWqQUEQCdXl1NZc7HD1Eq+ByEt4xdFv12VJEfRbaSQ/sZnUK7YTWf9HbZOs
        /jf7VwHNqAI31TRUOfa2aivNHcnh6BKKiVGrB85Vs58zeinbV1s3P0fSz3UBcuSj
        b2NutWJjlUr5XdEoC3k8r1jpi4bhwDu3oz9T+kSKRQzV1MNJV3v73MyIJ0IQSqkM
        9Pf1dRiu656y/WTLviLM9AfrqZT1hVNpeBtJaNaWYcpFpqoHXBuGVtUAp7tVRLpp
        AGWVWHTRES83kA/3APp8w3RlRN9LVCjLWJw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LviAoPzUWl4o for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 18:36:07 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP7916Yjlz1Rvlx;
        Wed, 23 Mar 2022 18:36:05 -0700 (PDT)
Message-ID: <b2a8b347-8029-9df3-edcd-a526ba3eef82@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 10:36:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 06/21] ata: libahci_platform: Add function returning a
 clock-handle by id
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-7-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-7-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 09:16, Serge Semin wrote:
> Since all the clocks are retrieved by the method
> ahci_platform_get_resources() there is no need for the glue-drivers to be
> looking for some particular of them in the kernel clocks table again.
> Instead we suggest to add a simple method returning a device-specific
> clock with passed connection ID if it is managed to be found. Otherwise
> the function will return NULL. Thus the glue-drivers won't need to either

"glue-drivers" is really unclear. What do you mean ?

> manually touching the hpriv->clks array or calling clk_get()-friends. The
> AHCI platform drivers will be able to use the new function right after the
> ahci_platform_get_resources() method invocation and up to the device
> removal.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/ata/libahci_platform.c | 27 +++++++++++++++++++++++++++
>  include/linux/ahci_platform.h  |  3 +++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index d805ddc3a024..4fb9629c03ab 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -94,6 +94,33 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
>  }
>  EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
>  
> +/**
> + * ahci_platform_find_clk - Find platform clock
> + * @hpriv: host private area to store config values
> + * @con_id: clock connection ID
> + *
> + * This function returns point to the clock descriptor of the clock with
> + * passed ID.
> + *
> + * RETURNS:
> + * Pointer to the clock descriptor on success otherwise NULL
> + */
> +struct clk *ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id)
> +{
> +	struct clk *clk = NULL;
> +	int i;
> +
> +	for (i = 0; i < hpriv->n_clks; i++) {
> +		if (!strcmp(hpriv->clks[i].id, con_id)) {
> +			clk = hpriv->clks[i].clk;
> +			break;
> +		}
> +	}
> +
> +	return clk;
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_find_clk);
> +
>  /**
>   * ahci_platform_enable_clks - Enable platform clocks
>   * @hpriv: host private area to store config values
> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> index 49e5383d4222..fd964e6a68d6 100644
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -13,6 +13,7 @@
>  
>  #include <linux/compiler.h>
>  
> +struct clk;
>  struct device;
>  struct ata_port_info;
>  struct ahci_host_priv;
> @@ -21,6 +22,8 @@ struct scsi_host_template;
>  
>  int ahci_platform_enable_phys(struct ahci_host_priv *hpriv);
>  void ahci_platform_disable_phys(struct ahci_host_priv *hpriv);
> +struct clk *
> +ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id);

No users for this function ?

>  int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
>  void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
>  int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv);


-- 
Damien Le Moal
Western Digital Research
