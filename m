Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0A0C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 14 Oct 2022 07:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJNHxn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 Oct 2022 03:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJNHxm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 14 Oct 2022 03:53:42 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9751B94C2
        for <linux-ide@vger.kernel.org>; Fri, 14 Oct 2022 00:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665734021; x=1697270021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e43rx5lrlAT5OV5I6ek/4TNY/F1pHFYbWzrhPY/2w98=;
  b=ramSKuGiQHneWdAC//MfUKvEOVtfdk3DtYLhMayJLr/zZJIRhzSUTD/G
   hhMtG0noiz5H1bDUbsreYr11bMLY/frGtwt/o4FdV1wdRaFJt76b2dRBK
   cdJRnbrIBpAlJCiXUUuibIvTJWVq7qEyBf2o0w/wNuGpIC7uqBWT6W+a+
   jreSmgFy7g50dUTjCqzGg5I73Rk1mR8DJwilE6tq4eqVR8kMzLCXDN3aV
   0Wz3txv27f0Vp2Ph/QYNm4yIxlFqcSLS3f0thr1WxX4i+fuBJoFS9pE4D
   X2rRxyTGe9ok8d6aEDNiili6d7M9x/oWQr1SM60upJ2YdUZFHoGb0H6Rg
   g==;
X-IronPort-AV: E=Sophos;i="5.95,182,1661788800"; 
   d="scan'208";a="214178933"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2022 15:53:40 +0800
IronPort-SDR: dzAi24TN6p+lwiJctN5yaCrje1/o+q9T+a6ULpTU9xQeoDglS1l6mr89FKFJIaZ9YPgCN3rbCR
 OL0zOwsFdKvD8QcWiR8Q68PkETW5Dil9P6YrKaR/uj8nPlVHyBnhN0Fkv4jkMMWozcYo1KRDf/
 6Ax0cDrRXJ0wis42tPan5PWLCjAGgJDsSuLWqo+VZ5lKofErK+X5PqUHM8znezTt8cTFi8OWEJ
 rS6q9DIFCZQRh51Oo/y0nG1qnnpgmbXx2Ql0kE9K0UU/S8wRA+TDjXjSvNK1BnxHXqPBuvUrXF
 152O17VmNweSfRw1IOKw/LtP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2022 00:07:39 -0700
IronPort-SDR: f91k1eHyjbJtgQpoznynWweJlHvGBU4K8b374pY9Lu6GcnnGY08Gp3aX/GwwNkGUKBAZmw/HFc
 KMXbaqk57UkW1qP6ZDCrEX2NY8EgXOVcEy4w4wgeVW9fqNYPXXQSugpC2TSI7b5/r5BnehAoMY
 mp5DH3AH20FasB2g+9GYdEYICohKcXgkLw58guwlH2ezZXCoLYL0VJRT5GqppMNecLQjjrwjSh
 oYWb0lR5U9d5nKFn4/foZvOcQG5eA5LTxbLdDlYx0d7GqL190xon9nESkQUOOGN7NTAFHPGpN6
 uHU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2022 00:53:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MpdtW1Qk1z1Rwrq
        for <linux-ide@vger.kernel.org>; Fri, 14 Oct 2022 00:53:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665734017; x=1668326018; bh=e43rx5lrlAT5OV5I6ek/4TNY/F1pHFYbWzr
        hPY/2w98=; b=ZTiK/j8LiDrFrYQOd7HxyM5cMqE5uz+yNC4GEjFhtf2+wCIRQW6
        zzNi6YjPUrTmFAoGxHiT4jQbNBKxjDG64kaUU/ksyjSxIO7f4MVMCGO+/WOzsqA6
        LFLEBj06NRiV+pG7k5Yckl0OKagqyX/m/6PZ6edAwbZa/CRrNDZC+b6iJ6CW/Abz
        TZZNzOTY9ONH3vdKHFPSLuu1CwTD5wcLdyS2mGBU+vxjf2DwBRQY7N4vd6FeDHTg
        GadKmMeCIfeDUs2fV2M4hqvMA3d8M6/iT6Y7UAcmdgSo7lUvu5My/A1bPCjzcSuv
        IbOMvnoqXn1pXr5US+zL3mNqu5ElzjBTAJQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fE4zCmipH1js for <linux-ide@vger.kernel.org>;
        Fri, 14 Oct 2022 00:53:37 -0700 (PDT)
Received: from [10.225.163.119] (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MpdtS2PLzz1RvLy;
        Fri, 14 Oct 2022 00:53:36 -0700 (PDT)
Message-ID: <75eaeab3-7781-d60a-ae61-ae837f5dcec9@opensource.wdc.com>
Date:   Fri, 14 Oct 2022 16:53:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sergey.Semin@baikalelectronics.ru
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        regressions@lists.linux.dev,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com>
 <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
 <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
 <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
 <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/14/22 16:31, Arnd Bergmann wrote:
> On Fri, Oct 14, 2022, at 2:22 AM, Damien Le Moal wrote:
>> On 10/14/22 07:07, Anders Roxell wrote:
>> [...]
>>>> 8)
>>>>> If reverting these patches restores the eSATA port on this board, then you need
>>>>> to fix the defconfig for that board.
>>>>
>>>> OTOH,
>>>> Anders, enabled the new config CONFIG_AHCI_DWC=y  and tried but the
>>>> device failed to boot.
>>>
>>> I thought it would work with enabling CONFIG_AHCI_DWC=y, but it didn't...
>>
>> As mentioned in my previous reply to Naresh, this is a new driver added in
>> 6.1. Your board was working before so this should not be the driver needed
>> for it.
>>
>>> However, reverting patch 33629d35090f ("ata: ahci: Add DWC AHCI SATA
>>> controller support")
>>> from next-20221013 was a success, kernel booted  and the 'mkfs.ext4' cmd was
>>> successful.
>>
>> Which is very strange... There is only one hunk in that commit that could
>> be considered suspicious:
>>
>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>> index 9b56490ecbc3..8f5572a9f8f1 100644
>> --- a/drivers/ata/ahci_platform.c
>> +++ b/drivers/ata/ahci_platform.c
>> @@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
>>  static const struct of_device_id ahci_of_match[] = {
>>         { .compatible = "generic-ahci", },
>>         /* Keep the following compatibles for device tree compatibility */
>> -       { .compatible = "snps,spear-ahci", },
>>         { .compatible = "ibm,476gtr-ahci", },
>> -       { .compatible = "snps,dwc-ahci", },
>>         { .compatible = "hisilicon,hisi-ahci", },
>>         { .compatible = "cavium,octeon-7130-ahci", },
>>         { /* sentinel */ }
>>
>> Is your board using one of these compatible string ?
> 
> The x15 uses "snps,dwc-ahci". I would expect it to detect the device
> with the new driver if that is loaded, but it's possible that the
> driver does not work on all versions of the dwc-ahci hardware.
> 
> Anders, can you provide the boot log from a boot with the new driver
> built in? There should be some messages from dwc-ahci about finding
> the device, but then not ultimately working.
> 
> Depending on which way it goes wrong, the safest fallback for 6.1 is
> probably to move the "snps,spear-ahci" and "snps,dwc-ahci" compatible
> strings back into the old driver, and leave the new one only for 
> the "baikal,bt1-ahci" implementation of it, until it has been
> successfully verified on TI am5/dra7, spear13xx and exynos.

OK. So a fix patch until further tests/debug is completed would be this:

diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
index 8fb66860db31..7a0cbab00843 100644
--- a/drivers/ata/ahci_dwc.c
+++ b/drivers/ata/ahci_dwc.c
@@ -469,8 +469,6 @@ static struct ahci_dwc_plat_data ahci_bt1_plat = {
 };

 static const struct of_device_id ahci_dwc_of_match[] = {
-       { .compatible = "snps,dwc-ahci", &ahci_dwc_plat },
-       { .compatible = "snps,spear-ahci", &ahci_dwc_plat },
        { .compatible = "baikal,bt1-ahci", &ahci_bt1_plat },
        {},
 };
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 8f5572a9f8f1..9b56490ecbc3 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -80,7 +80,9 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
 static const struct of_device_id ahci_of_match[] = {
        { .compatible = "generic-ahci", },
        /* Keep the following compatibles for device tree compatibility */
+       { .compatible = "snps,spear-ahci", },
        { .compatible = "ibm,476gtr-ahci", },
+       { .compatible = "snps,dwc-ahci", },
        { .compatible = "hisilicon,hisi-ahci", },
        { .compatible = "cavium,octeon-7130-ahci", },
        { /* sentinel */ }

Anders, Naresh,

Can you try this ?

-- 
Damien Le Moal
Western Digital Research

