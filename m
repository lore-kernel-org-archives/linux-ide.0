Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0BBC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 01:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbiCXByG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241153AbiCXByE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 21:54:04 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EA3931BB
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 18:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648086753; x=1679622753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xtEHPsUcqm/rH0/iF1sw/vJnnphazuSa8vU8F+aZBJE=;
  b=WlOPJy9cBeln0Z56OsNxU7Et+qyAqNWBeQvzXizwpfaiC+GhGOFdKV48
   QvdYHWb4zpbNb24AGuypYj5+07Y16Kiulv7e0OK0d9SkFDrm4+74NuWE8
   9cg2kRggJUWndXiDsccbjWRedHP6mEA8uUhp0U576QmQrA426ApCUN9gv
   BkxChagvaCiX19BpXFlYEZ09tlaavDO+HcS+GKTuiORA/PPP1yfMIaEWp
   XGgFFrExt/4DJbcp/Xmf6/Po9iUG+dEbrBN08k/F1GKiQvluOA5UKLZzw
   xtqL5RouN4i/EwM5QCzz2QqSnGIVsDNrxmz1Cc1tVBKlpA4Wz5Xn7fLp1
   g==;
X-IronPort-AV: E=Sophos;i="5.90,206,1643644800"; 
   d="scan'208";a="300268226"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 09:52:31 +0800
IronPort-SDR: OQfywJWkGs9xEvil+YvnmYiYmpsoQTqLtmyg8CslonAky7dKj8IUSYfNTqTVzqYVDWE8Pn/mac
 ujK5q3lxhYDoy/5K6w7Qegy1VPiaUTvNDTzXKK+LUcDc0BKBjI89udZm/LDBAvxlaWcN+K29Jm
 tthOI0zi7ZlTiQ2U4h2IU0w06dtvuUf3aUkX/oNnhTlk60UZOlCr8mX3ZImpdTvrWZbu+Lrxrp
 clOX0ehbanOjB4zlO/zKdWa0acGecw8H0Ent7D17dD4sIDoYZ2dltGDuM1NbStfN40F30QhWOZ
 HadCXbiW64SJRyaSDdY8RT+a
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:23:29 -0700
IronPort-SDR: +nsl27IYkoFPK1MmoqwtGRb2PhH188KcaEA0VhhO+N+/GDgPY4436nIEOrqLF8p3U7tXGeJOZT
 JW6fUCGvoMqqeXpO/7yFwkm6vFL+rtc045ranjBuFNUVqJQUmjQLarQBf2vy5KVEhbOruTcSsf
 UDDM4GP5fmOU65+PtAzH4+GfqzxDkg0doO61jTxwhcsgmaSI7fsBF60eF5kdd4h5yVrEA2zIYP
 5Sr3ZiEb7Q0i5uPZ5VhnfizP41d4la3ynwcxwNBrGB9ZAZXcbZFAvLJAVZpgioJowDTcQHwm2M
 t/k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:52:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP7Wz371mz1SVp4
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 18:52:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648086750; x=1650678751; bh=xtEHPsUcqm/rH0/iF1sw/vJnnphazuSa8vU
        8F+aZBJE=; b=uDSN8I8Dvj+gQVHlIn1bJZd2mv4TQ3m1KtEnqnjoUE4gDMIdTep
        ZqnnaV2rguA5jEmbZNjYUGULYhep7jGlcLGmezLqAFSckz7WKhilzEwTwBZelqHt
        IeNKnO55deknLGkDKiLKQ8r/nOQT4E/kOVvodGjux51bTJOwwpa0NYfdxZ9VG5NA
        oDvWbgDMt2wm9JcFUeFopEAHjmb4iY9RqsgKl4Luwh+9DHZrhxODjJhdsNJlJmj7
        9X0Gjb0ugu5Qy0L12h3UOYVkZBgLNERf0qUecjNmCPxQkxe5i5ramDm+pW2ygvOy
        j+zU4dg7S58RrPOCMtLoTX7awWOjeyOBbRw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eoF8xIc2uO_s for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 18:52:30 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP7Ww493zz1Rvlx;
        Wed, 23 Mar 2022 18:52:28 -0700 (PDT)
Message-ID: <96c85e40-1ebc-81f7-a786-0d5bb01ce0da@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 10:52:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 09/21] ata: libahci_platform: Introduce reset
 assertion/deassertion methods
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
 <20220324001628.13028-10-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-10-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 09:16, Serge Semin wrote:
> Currently the ACHI-platform library supports only the assert and deassert
> reset signals and ignores the platforms with self-deasserting reset lines.
> That prone to having the platforms with self-deasserting reset method
> misbehaviour when it comes to resuming from sleep state after the clocks
> have been fully disabled. For such cases the controller needs to be fully
> reset all over after the reference clocks are enabled and stable,
> otherwise the controller state machine might be in an undetermined state.
> 
> The best solution would be to auto-detect which reset method is supported
> by the particular platform and use it implicitly in the framework of the
> ahci_platform_enable_resources()/ahci_platform_disable_resources()
> methods. Alas it can't be implemented due to the AHCI-platform library
> already supporting the shared reset control lines. As [1] says in such
> case we have to use only one of the next methods:
> + reset_control_assert()/reset_control_deassert();
> + reset_control_reset()/reset_control_rearm().
> If the driver had an exclusive control over the reset lines we could have
> been able to manipulate the lines with no much limitation and just used
> the combination of the methods above to cover all the possible
> reset-control cases. Since the shared reset control has already been
> advertised and couldn't be changed with no risk to breaking the platforms
> relying on it, we have no choice but to make the platform drivers to
> determine which reset methods the platform reset system supports.
> 
> In order to implement both types of reset control support we suggest to
> introduce the new AHCI-platform flag: AHCI_PLATFORM_RST_TRIGGER, which
> when passed to the ahci_platform_get_resources() method together with the
> AHCI_PLATFORM_GET_RESETS flag will indicate that the reset lines are
> self-deasserting thus the reset_control_reset()/reset_control_rearm() will
> be used to control the reset state. Otherwise the
> reset_control_deassert()/reset_control_assert() methods will be utilized.
> 
> [1] Documentation/driver-api/reset.rst
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/ata/ahci.h             |  1 +
>  drivers/ata/libahci_platform.c | 47 ++++++++++++++++++++++++++++++----
>  include/linux/ahci_platform.h  |  5 +++-
>  3 files changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 1564c691094a..0b1d5c24cb8c 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -342,6 +342,7 @@ struct ahci_host_priv {
>  	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
>  	unsigned int		n_clks;
>  	struct clk_bulk_data	*clks;		/* Optional */
> +	unsigned int		f_rsts;

Why ? using flags directly is not OK ?

>  	struct reset_control	*rsts;		/* Optional */
>  	struct regulator	**target_pwrs;	/* Optional */
>  	struct regulator	*ahci_regulator;/* Optional */
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 5998e735a813..febad33aa43c 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -150,6 +150,41 @@ void ahci_platform_disable_clks(struct ahci_host_priv *hpriv)
>  }
>  EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
>  
> +/**
> + * ahci_platform_deassert_rsts - Deassert/trigger platform resets
> + * @hpriv: host private area to store config values
> + *
> + * This function desserts or triggers all the reset lanes found for the AHCI

s/desserts/deasserts ?
s/lanes/lines ?

> + * device.
> + *
> + * RETURNS:
> + * 0 on success otherwise a negative error code
> + */
> +int ahci_platform_deassert_rsts(struct ahci_host_priv *hpriv)
> +{
> +	if (hpriv->f_rsts & AHCI_PLATFORM_RST_TRIGGER)
> +		return reset_control_reset(hpriv->rsts);
> +
> +	return reset_control_deassert(hpriv->rsts);
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_deassert_rsts);
> +
> +/**
> + * ahci_platform_assert_rsts - Assert/rearm platform resets
> + * @hpriv: host private area to store config values
> + *
> + * This function asserts or rearms (for self-deasserting resets) all the reset
> + * controls found for the AHCI device.
> + */
> +void ahci_platform_assert_rsts(struct ahci_host_priv *hpriv)
> +{
> +	if (hpriv->f_rsts & AHCI_PLATFORM_RST_TRIGGER)
> +		return (void)reset_control_rearm(hpriv->rsts);

return void in a void function ? How does this even compile ?
And what if reset_control_rearm() fails ? What happens ?

> +
> +	reset_control_assert(hpriv->rsts);
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_assert_rsts);
> +
>  /**
>   * ahci_platform_enable_regulators - Enable regulators
>   * @hpriv: host private area to store config values
> @@ -247,18 +282,18 @@ int ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
>  	if (rc)
>  		goto disable_regulator;
>  
> -	rc = reset_control_deassert(hpriv->rsts);
> +	rc = ahci_platform_deassert_rsts(hpriv);
>  	if (rc)
>  		goto disable_clks;
>  
>  	rc = ahci_platform_enable_phys(hpriv);
>  	if (rc)
> -		goto disable_resets;
> +		goto disable_rsts;
>  
>  	return 0;
>  
> -disable_resets:
> -	reset_control_assert(hpriv->rsts);
> +disable_rsts:
> +	ahci_platform_assert_rsts(hpriv);
>  
>  disable_clks:
>  	ahci_platform_disable_clks(hpriv);
> @@ -285,7 +320,7 @@ void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
>  {
>  	ahci_platform_disable_phys(hpriv);
>  
> -	reset_control_assert(hpriv->rsts);
> +	ahci_platform_assert_rsts(hpriv);
>  
>  	ahci_platform_disable_clks(hpriv);
>  
> @@ -468,6 +503,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  			rc = PTR_ERR(hpriv->rsts);
>  			goto err_out;
>  		}
> +
> +		hpriv->f_rsts = flags & AHCI_PLATFORM_RST_TRIGGER;

Why not use hpriv->flags ?

>  	}
>  
>  	/*
> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> index fd964e6a68d6..57d25d30a9fa 100644
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -26,6 +26,8 @@ struct clk *
>  ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id);
>  int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
>  void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
> +int ahci_platform_deassert_rsts(struct ahci_host_priv *hpriv);
> +void ahci_platform_assert_rsts(struct ahci_host_priv *hpriv);
>  int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv);
>  void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv);
>  int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
> @@ -44,6 +46,7 @@ int ahci_platform_resume_host(struct device *dev);
>  int ahci_platform_suspend(struct device *dev);
>  int ahci_platform_resume(struct device *dev);
>  
> -#define AHCI_PLATFORM_GET_RESETS	0x01
> +#define AHCI_PLATFORM_GET_RESETS	BIT(0)
> +#define AHCI_PLATFORM_RST_TRIGGER	BIT(1)
>  
>  #endif /* _AHCI_PLATFORM_H */


-- 
Damien Le Moal
Western Digital Research
