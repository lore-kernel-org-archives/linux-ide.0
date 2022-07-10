Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E6EC433EF
	for <linux-ide@archiver.kernel.org>; Sun, 10 Jul 2022 23:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiGJXTF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 10 Jul 2022 19:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJXTE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 10 Jul 2022 19:19:04 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21FEB4B6
        for <linux-ide@vger.kernel.org>; Sun, 10 Jul 2022 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657495142; x=1689031142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9U1yowspje4FdTFucTBGWccDXl2PpYAhcwMntZrTWFk=;
  b=MCCySD6Fro5QjQLvrn5rWYG0x34Y0B9zRtzp0SIb+GXWo0hLQpUuB5St
   sMrte3DGmxq5Nu6o0YS03eqHQD+xP5Y1WXNAMN6tJb81q58+VAUM5d/Yl
   +rCTHwVqr0bonkGcrdlQhXBOlz2BDhB7wot5xisxKTvYYXVuxXy9YRX9B
   KPBKCltaP/dQA3uTPIYnSq1Llc/F1DREMmgfgE2vae5GOY/vmvc9dw0/Y
   cJED4/yNDOQ8es/rNuyzahNsu3Av5rhSSgIl72lY9FMj2v25ug6xayVp7
   U1VlTznfKEMzNJsOH0xUSejekq322CpdkUBQQ1a877SQH/IFzA3Uh6J7B
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,261,1650902400"; 
   d="scan'208";a="206013757"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2022 07:19:01 +0800
IronPort-SDR: ofK0JoL1qPVRmp+RTZoxJac6bU/oKFKDgxhoZ23U/FwNSnMrLQa/VXRrYs8tIyUPdXYw2ey2mH
 8uTNkjKWaUSemB8Xu3YjlsFuO3VVF1Qv5VS3jaylOedoJ7GmaaEAmFsqdT45iVIBEEXkY93Sdn
 srizj2WFHpwpnY56/k5QuYI3ANb5lUErePGV2duVboMRXQJNc6K9c+JdrGLQTFSaJQsu7lRd/D
 otIGH3Z2WOGG9QRqe7SSu/sS6KM1yfBlVd8C3UyYzBHtlHoebxVOhM76IbtU6Ggxg76JXKm8s+
 QyC1j/UKMeaLuydLLp1rhc59
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2022 15:36:01 -0700
IronPort-SDR: /sBRyPbwyoT+gn0pAVjU9Q4yGKUEXT6SBWKv6i8YrqNlBWPU4aJDGTjP/J40mwLt6+G0SaP9A7
 EozysUfx7ItsKKc1DVxgUaFjlz0Xgv5GjlH556usBsKb/mX4BcoWiYk4HlCklPMq3wSkzYbPqP
 P0MleA1/yeKKCA3cGzG1giMjwaDfoLGK9pNnEjJDqEBifUSWRO+9ySIRk5BiKZEoR+Twc86VH3
 nWvlSJC822LuZR1bnX2sFHbMNEP73ExNNvT+nid6urLZTih8S5x1x7rlcCjr1Nx0530+KBhy+9
 OGw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2022 16:19:01 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Lh2yY1t1wz1Rwry
        for <linux-ide@vger.kernel.org>; Sun, 10 Jul 2022 16:19:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1657495140; x=1660087141; bh=9U1yowspje4FdTFucTBGWccDXl2PpYAhcwM
        ntZrTWFk=; b=Pv1uRX3RO20K/ITFSgBCCPV6CDfLNqYAw0/wPpkimhh5JMM7JIv
        L6lSx5tjheWKMgGbRLNLy3Wcv7lLwBwDvcr8gnOUT55ObuGJeQ+XhM9T8+SgY9Kl
        8gH3YW8X+oNaKlK+PMLfOMBfGHzyeaCBhn/tTgDWPWRRivPdcJzYjroBBumLmZOB
        h/VKCHxD1Bjx7nKMZKojJGocV0TU3gOQhqeWV6hLCtM0GO9sstiomk0AACH000b6
        EVFLX97jxEXfPaIxTVtTYPaaWAFjRk9PbNJxrrjbNR3z7/qi0ZtewZXMOyEcfVRv
        nWFjwrs+xLhml7ZT4QGcOVr29sdI+qW4ZLg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pl6IElh3pZij for <linux-ide@vger.kernel.org>;
        Sun, 10 Jul 2022 16:19:00 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Lh2yT5gN9z1RtVk;
        Sun, 10 Jul 2022 16:18:57 -0700 (PDT)
Message-ID: <a424890d-8647-48c5-68ab-742a95bb6865@opensource.wdc.com>
Date:   Mon, 11 Jul 2022 08:18:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 25/33] ata/drivers/ahci_imx: Switch to new of thermal
 API
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-26-daniel.lezcano@linexp.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220710212423.681301-26-daniel.lezcano@linexp.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/11/22 06:24, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach.
> 
> Use this new API.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>  drivers/ata/ahci_imx.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 79aa9f285312..5ad9a890e71a 100644
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

I do not see why the above changes are necessary. Please explain.

>  
> -static const struct thermal_zone_of_device_ops fsl_sata_ahci_of_thermal_ops = {
> +static struct thermal_zone_device_ops fsl_sata_ahci_of_thermal_ops = {

Why remove the const ?

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

This is the only change that seems necessary.

>  		dev_info(dev, "%s: sensor 'sata_ahci'\n", dev_name(hwmon_dev));
>  	}
>  

And it is hard to review a patch without the full series for context.
Please send all patches next time.


-- 
Damien Le Moal
Western Digital Research
