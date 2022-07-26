Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3912C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 26 Jul 2022 03:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbiGZDnQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 25 Jul 2022 23:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiGZDnO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jul 2022 23:43:14 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E272A42C
        for <linux-ide@vger.kernel.org>; Mon, 25 Jul 2022 20:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658806993; x=1690342993;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vt84amRQOiVRnZk+EYa9ZDlXy2/jQrtxfSttKXecpxM=;
  b=QxfKDQs6jJGqa5gdAlJhVlAa07btTCUA1Z0/HtqzZyBnV8nPBGCBSNIb
   wYBLKJBGGiAxf1Gfkhm3HnelTLaijaawouyK6abUhzFDSqqoTcDYGqygA
   +y570rT+E6cF0MyOfsD7zz9vv72Bt9S6LeCvEhmAYePxx1f+kZmkDu6NA
   SUsGd9aT/vHXOx5clEo1tmgFtXjjfhR1qqo8J2awUvyYLeRRI85SVPUCg
   BzGf5KC27/NCqKyFghuSsI4f3aN8U1z70ZOoktBHwyXbL8V1qB/T3ejFk
   qVcCYn0Hytg/GWcpa96oDoWKW8ia3Y8Z+pYE+zCJmTyLemHc5ASvS9ff+
   A==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654531200"; 
   d="scan'208";a="205452418"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2022 11:43:12 +0800
IronPort-SDR: Cdik0RZc3w9ZVtXBZ0lvX/PAQpyh3XZtEN4JOYuRN1SHgLILo+22rEB2KDl3tiqMDaQf4SP1eq
 1TnoekFGQzsUYZ8EgLGOaI6W93WyXJbdw6r63E73KREZmuUe8h3STmQVgi3qQtjnxziWP1TELm
 7tPEVgZgKZkgx0h4ZyGuo/+3b7GvyfIlABmgMLwKmpWXEdvfg3MY/mnpmvFleXyncZOVo0Sf+9
 vLWluNtmnw3Y1DRg73IkOdoqLvyduirH1LnTkNSzYDuPFdPuZHkapMj+TqFL07BVmlhMhcAUwL
 oEFhlm5dL5ODwmsvaOK8mA/5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2022 19:59:28 -0700
IronPort-SDR: MigrtqNSah1L4dJ/2p+vlDAmr/aNoKNys83B97QKOhnbBLhaKAshpZhVTCSbRbiYsBbZnJwLmy
 iaYouAC2Zmbd9syB3wbgxDlRjUaojglhDZmq8tr+WpR33V9M9T903auz0nGG9fw0P7umojHU6m
 RTFaBY6hBiSFIj4qm08oTNfDQ8cmDhqCDn80OZJ2bkavdyD+sxQU1sA3JLzYkAmSS7/S2eIkZu
 E4X9a3FzD64geIh+2QZO9XNLtDP5Njf/xB79iw3v2qrHDEcCgVants3jBc6FNX9CiwQows3o1B
 3UQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2022 20:43:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LsN6S1Qhlz1Rwnm
        for <linux-ide@vger.kernel.org>; Mon, 25 Jul 2022 20:43:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658806990; x=1661398991; bh=vt84amRQOiVRnZk+EYa9ZDlXy2/jQrtxfSt
        tKXecpxM=; b=NmUQGOfaZyqdbFPdIFJvfhAjQevr30CV+vNmhQE11dOmTR0lT8d
        s7Sq0miyzoXWAH98SzbpLQu9bVq6Dr52Wguqm6Bwt52WzE3jKCMkiv0voMHlVCEV
        hRztjEidts5lBpAlL9wwe/NflP8bxFNnghkn+Xy5ITJIAxKEQQvtkIFSnfaBqIt4
        ydZpz+PJYDKI+iFQkVogU5LF+OJzsoXsi+LYFdbFJ1yPzDAMOe+AVpNlG0lzRbq7
        sPAOvkP3Tx0lW1uosb7pN34AuiSkGTZ/+a3nH5kJvJdZ3SUxmGrxno8VX0aol2RY
        AAsqOVq9pGaKQWSBT0ki2JaKL8ma3FR/dOA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x37QHAM1HgXH for <linux-ide@vger.kernel.org>;
        Mon, 25 Jul 2022 20:43:10 -0700 (PDT)
Received: from [10.225.163.10] (unknown [10.225.163.10])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LsN6J3N7Fz1RtVk;
        Mon, 25 Jul 2022 20:43:04 -0700 (PDT)
Message-ID: <8e506701-e934-e9de-1a2f-ee252e514741@opensource.wdc.com>
Date:   Tue, 26 Jul 2022 12:43:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 25/32] ata/drivers/ahci_imx: Switch to new of thermal
 API
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        heiko@sntech.de, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, talel@amazon.com, thierry.reding@gmail.com,
        digetx@gmail.com, jonathanh@nvidia.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, baolin.wang7@gmail.com,
        f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        mcoquelin.stm32@gmail.com, glaroque@baylibre.com,
        miquel.raynal@bootlin.com, shawnguo@kernel.org,
        niklas.soderlund@ragnatech.se, matthias.bgg@gmail.com,
        j-keerthy@ti.com, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
 <20220725212637.2818207-26-daniel.lezcano@linexp.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220725212637.2818207-26-daniel.lezcano@linexp.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/26/22 06:26, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach. The ops are no longer device
> tree specific and are the generic ones provided by the core code.
> 
> Convert the ops to the thermal_zone_device_ops format and use the new
> API to register the thermal zone with these generic ops.
> 
> sata_ahci_read_temperature() is used by sata_ahci_show_temp() also.
> 
> So in order to change the function prototype for the get_temp ops which
> does not take a void* but a thermal_zone_device* structure, this
> function wraps the call.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/ata/ahci_imx.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 79aa9f285312..b734e069034d 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -327,7 +327,7 @@ static int read_adc_sum(void *dev, u16 rtune_ctl_reg, void __iomem * mmio)
>  }
>  
>  /* SATA AHCI temperature monitor */
> -static int sata_ahci_read_temperature(void *dev, int *temp)
> +static int __sata_ahci_read_temperature(void *dev, int *temp)
>  {
>  	u16 mpll_test_reg, rtune_ctl_reg, dac_ctl_reg, read_sum;
>  	u32 str1, str2, str3, str4;
> @@ -416,6 +416,11 @@ static int sata_ahci_read_temperature(void *dev, int *temp)
>  	return 0;
>  }
>  
> +static int sata_ahci_read_temperature(struct thermal_zone_device *tz, int *temp)
> +{
> +	return __sata_ahci_read_temperature(tz->devdata, temp);
> +}
> +
>  static ssize_t sata_ahci_show_temp(struct device *dev,
>  				   struct device_attribute *da,
>  				   char *buf)
> @@ -423,14 +428,14 @@ static ssize_t sata_ahci_show_temp(struct device *dev,
>  	unsigned int temp = 0;
>  	int err;
>  
> -	err = sata_ahci_read_temperature(dev, &temp);
> +	err = __sata_ahci_read_temperature(dev, &temp);
>  	if (err < 0)
>  		return err;
>  
>  	return sprintf(buf, "%u\n", temp);
>  }
>  
> -static const struct thermal_zone_of_device_ops fsl_sata_ahci_of_thermal_ops = {
> +static const struct thermal_zone_device_ops fsl_sata_ahci_of_thermal_ops = {
>  	.get_temp = sata_ahci_read_temperature,
>  };
>  
> @@ -1131,8 +1136,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
>  			ret = PTR_ERR(hwmon_dev);
>  			goto disable_clk;
>  		}
> -		devm_thermal_zone_of_sensor_register(hwmon_dev, 0, hwmon_dev,
> -					     &fsl_sata_ahci_of_thermal_ops);
> +		devm_thermal_of_zone_register(hwmon_dev, 0, hwmon_dev,
> +					      &fsl_sata_ahci_of_thermal_ops);
>  		dev_info(dev, "%s: sensor 'sata_ahci'\n", dev_name(hwmon_dev));
>  	}
>  


-- 
Damien Le Moal
Western Digital Research
