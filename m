Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B16C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 16 Jun 2022 00:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347032AbiFPAdf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jun 2022 20:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347575AbiFPAd3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2022 20:33:29 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C90A10547
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 17:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655339607; x=1686875607;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MBRiA3OhDc8T/PLUdbazDe1hOAsO2DxX0LERaRgF55U=;
  b=VcGosERU8093PYmYmaDclEbfSrRZqEA2TcywScn89x0tfW192GyaKqv9
   wedg0tCNggCam7LRZmcqbXk/6OANmAANAPJ+wKYjsGAXpbKNkUwfXW8vp
   SmVttBbKeqpAGTSR+DIX3luqkFALWHa/UhfPe8uElYqIE1v+ThOvFHW6f
   LPQ9TDccmku7tTBFeC7LkKzif0+lJRlmIHSIfKeJrYHxhvH/zPy4Dc/pG
   mSz7GXAhNXwN/drQdcWBhNyRBE6+dPZr98EWGVvlrK0umxPqnwpEuHiPl
   VglGE1XKhBuhty/SSZC9X5AfCVpZvNfmvC3Q+T/CcgLjzw27cazxJ9WJU
   g==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="307573862"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 08:33:26 +0800
IronPort-SDR: gDHxGwwVTcl4K3w0im7QsdCQg22WmyPEx78SCQWPx1dJWxv9XnEDhxZbn1eOvShOuCHqNp28vx
 1QSs4Jy3pA/b7PnEHUQdP/AVgznUSxZDIGoMRr74h7hJhfCsdh8gHocDlxlYOZa0PdQH3Iicg4
 E71vxNTbAgBD+KEOiZMn77BeKnoJctBzCzUVxjM6lWiubyNUd2edE/cl3K0O8M7LIDvaBxC+Ay
 EL3jolFdh9ZtHjtTTDGdoKd7a9160DPHBlHZGOeasz/v7wPwVghv7sTadrdjlkBDNxXeuMD+HY
 T6xeVF2Qfc22sWMBceeLrR8w
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 16:51:49 -0700
IronPort-SDR: 0k8UyaLdIpI3OBnxfHzbiPTV9rvT8hJ36rbL+P1Dj6WTdLlunyuCfBxVXP70Gv9AYGcOaqbfDs
 diZGFt0hO5s1n2eKV2MaCnv+r8mDQsiY52lJggVvnhOxL5AzyAjCgxAipiqyfg0odMAhHujFI8
 +bU+2KszT7sTxqmahevAJSqkLdj+MfDimFHhhzEEVuJKIjMNlAV2OPf27OIcMOMPCaOKuKKmGI
 RlOYUjkuOCn+kxTm3/Mspc6D5wuelGwjEChpwZvuzu0bQkGds1QqAQRtVDtISDrH2o6uMt9xpY
 hP4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 17:33:27 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNjny1HzJz1SVp3
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 17:33:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655339605; x=1657931606; bh=MBRiA3OhDc8T/PLUdbazDe1hOAsO2DxX0LE
        RaRgF55U=; b=NQ4xGNcQzg1Zyef+8rgqEIjYNd8niORzlDHXxrfykwqLeJ6C9SH
        kR/EIsOZCp0/vFPaby6+AkXO2nrb1Lt2Erk1IdVAHN2nsR5m0iNV7YbyCAlzk1tB
        cijbbxoH+HHjFtjqk/SF1ndzYzDIT0bpmzvoFWeZ3075/injaYqwUVnHLfdiJMY+
        qgP9fSaj4Yn6xMy+fmSe3F/zLalPsIBqlgucVxY728XynQg99Vf69JZXI+LIQ5EN
        gNzl/0f+TZj2nqReCr7mmbHMSGZyi6OB8eJfb0EONr+uLXBjloM6ORkQATO4OCTf
        EWsRGHC6spuSCTMORLwlwL7ZSAbYYWHaWrA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tQm6Kf26QwER for <linux-ide@vger.kernel.org>;
        Wed, 15 Jun 2022 17:33:25 -0700 (PDT)
Received: from [10.89.84.185] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.185])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNjnv4BqNz1Rvlc;
        Wed, 15 Jun 2022 17:33:23 -0700 (PDT)
Message-ID: <5f1edbd8-018a-bcd0-10f2-94767f341b45@opensource.wdc.com>
Date:   Thu, 16 Jun 2022 09:33:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 19/23] ata: ahci: Add DWC AHCI SATA controller support
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-20-Sergey.Semin@baikalelectronics.ru>
 <52c9ca79-769f-4426-db94-7aad05a68258@opensource.wdc.com>
 <20220615214802.ke6owp5cuv5l77hu@mobilestation>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615214802.ke6owp5cuv5l77hu@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/06/16 6:48, Serge Semin wrote:
[...]
>> MODULE_LICENSE("GPL v2");
>>
>> To match the file header SPDX.
> 
> No. Please see the commit bf7fbeeae6db ("module: Cure the
> MODULE_LICENSE "GPL" vs. "GPL v2" bogosity") and what checkpatch.pl
> says should the "GPL v2" string is used in the module license block.
> More info regarding this macro and the possible license values are
> described here:
> Documentation/process/license-rules.rst

ah ! OK. I was not 100% sure. Doing a quick grep, there is still a lot of (half
?) of "GPL v2" vs "GPL".

Ignore this then.

> 
> -Sergey
> 
>>
>>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>>> index 9b56490ecbc3..8f5572a9f8f1 100644
>>> --- a/drivers/ata/ahci_platform.c
>>> +++ b/drivers/ata/ahci_platform.c
>>> @@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
>>>  static const struct of_device_id ahci_of_match[] = {
>>>  	{ .compatible = "generic-ahci", },
>>>  	/* Keep the following compatibles for device tree compatibility */
>>> -	{ .compatible = "snps,spear-ahci", },
>>>  	{ .compatible = "ibm,476gtr-ahci", },
>>> -	{ .compatible = "snps,dwc-ahci", },
>>>  	{ .compatible = "hisilicon,hisi-ahci", },
>>>  	{ .compatible = "cavium,octeon-7130-ahci", },
>>>  	{ /* sentinel */ }
>>
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research
> 


-- 
Damien Le Moal
Western Digital Research
