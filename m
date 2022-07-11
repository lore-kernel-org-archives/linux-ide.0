Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C553AC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 11 Jul 2022 11:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiGKLQf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiGKLQT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jul 2022 07:16:19 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E1761136
        for <linux-ide@vger.kernel.org>; Mon, 11 Jul 2022 03:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657535853; x=1689071853;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l241aSfbDFRaiDAjISjeppEbmJl16Z4pyYiIsz0YFbE=;
  b=IS3iwwmKdgHq86O5lTdMgRot+DNCASGGL+GpyM6rfaCvJXK+EvMxjc8/
   9Opia+hkC/XlHFZIu3MfLtL9+Mhv/4Q2dL+aMTj7VSxz2BujFNA2wVdhk
   aji/9kjYE8Lyi3QvRXmzK5RiPL41Z0xexxv+uvyPrbs3K0yf40bSVZlqm
   8cR2e5juWPXooxqgQZ8swia5CxbEpxgWuRgtIRJHHZefmI/Yqney0vsH2
   Q9sT1Q8qh0sFmOtZUEplFqzhw7IPWOeO31DtzDIIgSIBe0AcYb6CRh8E4
   5rz8rfHz8UhTppuKHKy+DKobG4Gje/QSs+XDfmqfukzMU8TQ3UmvJ1DRT
   A==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650902400"; 
   d="scan'208";a="206061590"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2022 18:37:26 +0800
IronPort-SDR: 0rB9M+RcWER7YIHhHSWuemzISQ8GDNVG7vSDcrIZrEHoTwCRXyaa9vLRH+Fw+t8xkCiDWwFz9R
 vXWN2hTWzmazw19m8V8X1/W/Zau4nDLlYiQJO+tWDKoj55H1OasNtH87+p73k49aDZmaT3mZQu
 nt1H+h0wapcTm5WgxsUCVUt0LYuLAudTIA/Bru56M8VQRfY7rWrrGuzI1HbYCNDtlkeEeXNhtJ
 Y7V/1vHhRlWoPkvtvdTzpPicEEtLhx6HzC4sh6fSy1Maw4006PWMo+WPhiLtNIQu2I7Gd/eP3x
 bZXY2excpVx1/dxV6D4NppyU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jul 2022 02:54:24 -0700
IronPort-SDR: 32bEeMRw8vh4hzALgmqP+5VGR54/YmxMGjsNNVAKJ0d2BS5gmC8Ig3Wb9btCOYwZ0f/E/GgXY6
 HjlDMYnsbdVCAeaWn4WEvbKd8evRZ1s7NtMtKquwreot+Zzs8ZqoXLJstk28B9uU5p6OAV4QZ9
 EuoS7Zgzbj4lUTOrg8NQ/jbZs/0rdQlITQRCHK83gPVrIB5uJgV7VbAUL0lW5emq0C0k/GtFv8
 cxX+xGV77C7tWCPbsyLF0p7g1tE+Mkr7tQPlD+EKqAIPWdIEUG34qBawft5Uj5cmTPnQHdEdow
 GjQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jul 2022 03:37:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LhL1K1YKPz1Rwqy
        for <linux-ide@vger.kernel.org>; Mon, 11 Jul 2022 03:37:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1657535843; x=1660127844; bh=l241aSfbDFRaiDAjISjeppEbmJl16Z4pyYi
        Isz0YFbE=; b=D+dgphWpbQtmqqcc+FxZZu/64TAs2ZjAGXSftALS1SDOGp7JQ2f
        CojEAzzUBnuw5csmiCrKaHDxOtEc8Wgzjh0p2Kx2llCSyJ38Zq2b26gcEI2QxVGz
        UGP2IkTZlpJS0rWVu5TDB5ra9RlnJ+7dVnVObunIaEwcK6cPbN8TM0jOL7clnFxg
        MzorR70DpeqCUgXpFLsMShGYPICq8ZePrdOSlyzjMUdXSaWJJavhbfKdtNMnA6SU
        KVCZJ8OXnF+LkWEZsOwuiT7xuKM5OwJNcYlUMwkuNPuk47HgDgv11QRu3/L9ZDp4
        BzuiWBvw6YFJqZqLJG7Z3YL/qQUoSu6rHvA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WVB9UH_j0deu for <linux-ide@vger.kernel.org>;
        Mon, 11 Jul 2022 03:37:23 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LhL1F1m4vz1RtVk;
        Mon, 11 Jul 2022 03:37:21 -0700 (PDT)
Message-ID: <e8f91504-2b2d-76b9-cfe3-8f027824854f@opensource.wdc.com>
Date:   Mon, 11 Jul 2022 19:37:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 25/33] ata/drivers/ahci_imx: Switch to new of thermal
 API
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linexp.org>, rafael@kernel.org
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
 <a424890d-8647-48c5-68ab-742a95bb6865@opensource.wdc.com>
 <e50842cf-0179-7b70-3925-dacb4ce728ea@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e50842cf-0179-7b70-3925-dacb4ce728ea@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/11/22 18:14, Daniel Lezcano wrote:
> On 11/07/2022 01:18, Damien Le Moal wrote:
>> On 7/11/22 06:24, Daniel Lezcano wrote:
>>> The thermal OF code has a new API allowing to migrate the OF
>>> initialization to a simpler approach.
>>>
>>> Use this new API.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
>>> ---
>>>   drivers/ata/ahci_imx.c | 15 ++++++++++-----
>>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
>>> index 79aa9f285312..5ad9a890e71a 100644
>>> --- a/drivers/ata/ahci_imx.c
>>> +++ b/drivers/ata/ahci_imx.c
>>> @@ -327,7 +327,7 @@ static int read_adc_sum(void *dev, u16 rtune_ctl_reg, void __iomem * mmio)
>>>   }
>>>   
>>>   /* SATA AHCI temperature monitor */
>>> -static int sata_ahci_read_temperature(void *dev, int *temp)
>>> +static int __sata_ahci_read_temperature(void *dev, int *temp)
>>>   {
>>>   	u16 mpll_test_reg, rtune_ctl_reg, dac_ctl_reg, read_sum;
>>>   	u32 str1, str2, str3, str4;
>>> @@ -416,6 +416,11 @@ static int sata_ahci_read_temperature(void *dev, int *temp)
>>>   	return 0;
>>>   }
>>>   
>>> +static int sata_ahci_read_temperature(struct thermal_zone_device *tz, int *temp)
>>> +{
>>> +	return __sata_ahci_read_temperature(tz->devdata, temp);
>>> +}
>>> +
>>>   static ssize_t sata_ahci_show_temp(struct device *dev,
>>>   				   struct device_attribute *da,
>>>   				   char *buf)
>>> @@ -423,14 +428,14 @@ static ssize_t sata_ahci_show_temp(struct device *dev,
>>>   	unsigned int temp = 0;
>>>   	int err;
>>>   
>>> -	err = sata_ahci_read_temperature(dev, &temp);
>>> +	err = __sata_ahci_read_temperature(dev, &temp);
>>>   	if (err < 0)
>>>   		return err;
>>>   
>>>   	return sprintf(buf, "%u\n", temp);
>>>   }
>>
>> I do not see why the above changes are necessary. Please explain.
> 
> sata_ahci_read_temperature() is used by sata_ahci_show_temp() also.
> 
> So in order to change the function prototype for the get_temp ops which 
> does not take a void* but a thermal_zone_device* structure, this 
> function wraps the call.
> 
> Do you prefer sata_ahci_read_temperature() becomes sata_ahci_get_temp() 
> and keep __sata_ahci_read_temperature() name untouched ?

Understood. You can keep the name changes you have, but please add this
explanation to the commit message.

> 
>>>   
>>> -static const struct thermal_zone_of_device_ops fsl_sata_ahci_of_thermal_ops = {
>>> +static struct thermal_zone_device_ops fsl_sata_ahci_of_thermal_ops = {
>>
>> Why remove the const ?
>>
>>>   	.get_temp = sata_ahci_read_temperature,
>>>   };
>>>   
>>> @@ -1131,8 +1136,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
>>>   			ret = PTR_ERR(hwmon_dev);
>>>   			goto disable_clk;
>>>   		}
>>> -		devm_thermal_zone_of_sensor_register(hwmon_dev, 0, hwmon_dev,
>>> -					     &fsl_sata_ahci_of_thermal_ops);
>>> +		devm_thermal_of_zone_register(hwmon_dev, 0, hwmon_dev,
>>> +					      &fsl_sata_ahci_of_thermal_ops);
>>
>> This is the only change that seems necessary.
>>
>>>   		dev_info(dev, "%s: sensor 'sata_ahci'\n", dev_name(hwmon_dev));
>>>   	}
>>>   
>>
>> And it is hard to review a patch without the full series for context.
>> Please send all patches next time.
>>
>>
> 
> 


-- 
Damien Le Moal
Western Digital Research
