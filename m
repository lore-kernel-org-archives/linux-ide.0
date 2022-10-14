Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E19C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 14 Oct 2022 00:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJNAWl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 13 Oct 2022 20:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJNAWk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2022 20:22:40 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433784598A
        for <linux-ide@vger.kernel.org>; Thu, 13 Oct 2022 17:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665706959; x=1697242959;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sVhzWB6bJ4Xda1JmI82UJgmAYd2X09c+MflqD/NibXE=;
  b=A0ztsuUC9jd4spyEZRWW3GBgAIul2t7W3T8Tu39l9pUwxYO6zP7DkuZz
   rXw6A4aiUgE5ysnOAq47QzoJ5/zdll1SGp/edcVcyqp64m1D/pqGl4mUT
   NPLStB8R5wB8FQgAOAhHZWxeIcFjbT5PpSRVqc7MEZZRIklrnT3VYm8YA
   7xZqurHrNQ+/ONn9BABLQw8F5WR1NrrOLb+vxttOCXwAILb2n9LrO1tF+
   gw5wDA2NXG8GfAmZJxUk1KJRRbJSeGU7g6Srd7Bipt85kCx7n7Fn8mQpy
   EXtUQyqq2ec3SHTL5yuEQpEDzaVikb0MavydhRMr19GTJvtYIag4PJAEQ
   g==;
X-IronPort-AV: E=Sophos;i="5.95,182,1661788800"; 
   d="scan'208";a="325854413"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2022 08:22:38 +0800
IronPort-SDR: U//QG6zzWIbOUmuo63bim/4bc5JCjQfiqnVKry1jWaZr1x4aRCzvR+cUdEQR6YCzdjBc8VHvJ/
 ngbnKt6S1SElglz1uKNLtUxnKp3EaQXw1HYrpKXqwk3dj4Wx+SX48V8Aqpu6TiqqzsIAYuj6l0
 355Puu4MpdJxfZZ6Olv98F0eUChB9V1baTontfc/PEg9JyoKLIIjZdck/sYzIhaNPnV5OVryhd
 gkNZOfza22ossKR05KQtl4epufYhleaEA4ZzWM2uZAHnFpbDl5jTuIQo2j03LTfXT/gC7qrgjl
 AN2sBDqhww5LMzKJH3u+GLUf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2022 16:42:15 -0700
IronPort-SDR: wUrOhPHsCLw9QkhkYZb3DEPAAgd1aP19I6voVq9WdCJ4RXFR5Y0Z3BpaNQcpCGSpjdnJ6ahXii
 roQhZwp3EBWAtR3kgcpBCzc2wTIuK28ioFn2lKvD9KpNA94TFp+KmATTRYvfZ1cdiZafvhStNL
 JrD8+gjSMx/FPOuY+UXdl55mROtkXdLPnIuUjhC1pmEw7vYYv7koWdMCfV8DRt+VAcx4Tp9sFD
 RcVt+KSnHsLWMxQF5Ghls3CIgnXvlBAtvqBsHhXSKeoJ2iaoylE6wJuIqTPRkJNGrty0cZYYdK
 rKk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2022 17:22:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MpRt60xStz1RvTp
        for <linux-ide@vger.kernel.org>; Thu, 13 Oct 2022 17:22:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665706957; x=1668298958; bh=sVhzWB6bJ4Xda1JmI82UJgmAYd2X09c+Mfl
        qD/NibXE=; b=fmPjxKj7HqP7bSr4u6/wQXre40p8RobYeqHiB4MWenOb/AL5efD
        qUCl9JZA9dKmNbOFRETfkHyP7K7Ve112eVqoGkZWCVGShGbKzKGldwhDdEDxAZvd
        1ezoR5W6/ZRsMzGy6abAcF4MyodwsVnCBhk2UkrweJGNP1NLOGQ0TWmOycFcGW4y
        OLWjcJpXKH7UxxhEtRGaVfbqeTnDTJoX6Fj7qtv46HeSLJ9xmljuLD916kML7tyW
        m0rmu8oJRO/8I9bppMSTDR5jLP9tB/LAYm0B7FADrS85GPKXNvz1PHWGgSwIevDt
        EHT0JeL4/cG3QTEzVlF3k6KPFgASlQDm1Ew==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tBNtR1c8rQes for <linux-ide@vger.kernel.org>;
        Thu, 13 Oct 2022 17:22:37 -0700 (PDT)
Received: from [10.225.163.119] (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MpRt36XHsz1RvLy;
        Thu, 13 Oct 2022 17:22:35 -0700 (PDT)
Message-ID: <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
Date:   Fri, 14 Oct 2022 09:22:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag
Content-Language: en-US
To:     Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sergey.Semin@baikalelectronics.ru
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        regressions@lists.linux.dev,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com>
 <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
 <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/14/22 07:07, Anders Roxell wrote:
[...]
>> 8)
>>> If reverting these patches restores the eSATA port on this board, then you need
>>> to fix the defconfig for that board.
>>
>> OTOH,
>> Anders, enabled the new config CONFIG_AHCI_DWC=y  and tried but the
>> device failed to boot.
> 
> I thought it would work with enabling CONFIG_AHCI_DWC=y, but it didn't...

As mentioned in my previous reply to Naresh, this is a new driver added in
6.1. Your board was working before so this should not be the driver needed
for it.

> However, reverting patch 33629d35090f ("ata: ahci: Add DWC AHCI SATA
> controller support")
> from next-20221013 was a success, kernel booted  and the 'mkfs.ext4' cmd was
> successful.

Which is very strange... There is only one hunk in that commit that could
be considered suspicious:

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 9b56490ecbc3..8f5572a9f8f1 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
 static const struct of_device_id ahci_of_match[] = {
        { .compatible = "generic-ahci", },
        /* Keep the following compatibles for device tree compatibility */
-       { .compatible = "snps,spear-ahci", },
        { .compatible = "ibm,476gtr-ahci", },
-       { .compatible = "snps,dwc-ahci", },
        { .compatible = "hisilicon,hisi-ahci", },
        { .compatible = "cavium,octeon-7130-ahci", },
        { /* sentinel */ }

Is your board using one of these compatible string ?

Serge ?
Any idea ?

-- 
Damien Le Moal
Western Digital Research

