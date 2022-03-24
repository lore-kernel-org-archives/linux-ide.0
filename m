Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25733C433FE
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 08:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345836AbiCXIPW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 04:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbiCXIPU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 04:15:20 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119536D3A0
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 01:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648109629; x=1679645629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y+OmNmasAg+uGRzoRTsfVJSLekyZ3BG1ai2QuN3eWrQ=;
  b=obLcF43r+iiGiBlHo65//xNeyxY4JKnm2VEeqvZVegvrxho7rxP2QtzB
   aMew5TymHrXfVrbnS0CyGgOkQf5IfDN1Zc3qw4hG4p0rqC10pz5hYHHhe
   kyswJA1UGhBo+XywZpzd4gny6FlVKwkbyP/WWidEHGCCcfECp8bJEdyFQ
   Hr2QGR1ytFSoScpdZz9veYZ3fycodPJ/76HOPL6rIg4lz6JpACTGPS/VY
   CqEKX+oned7tDElaHUGEgbGMO8kO37TDHvsiIjf1y6nEIDc2nv5s0Z1vt
   QVXi/2psL7WaZ0M6PuuT2oU8A3uDNqfXkRM9BmXxIAkhYlde92nN9Cdtx
   w==;
X-IronPort-AV: E=Sophos;i="5.90,206,1643644800"; 
   d="scan'208";a="200993368"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 16:13:48 +0800
IronPort-SDR: H5F/A/rBV/Mpz7bRxMLbUVA6mTxzgReAaZd9RjSUiUcQC7XTFbSApTZbCm8CRE1fYH6eWYcBZt
 4+l4OPFagQ+J8vp414kHDt4HgoZEpO4JoYwD60iL5dx59D7vs2j9HRbw65E0JrnyTTq68zonmf
 VfhByg0Ai7Am98VbKzWUbdGeWz05y/zeKp+kqyFeajZ3ahvAfryf/YlgYDKxwyDIkRAqyOSM33
 MzvKEeeJj7Ww7RxoIoPiNwITWjUHOVRFySDfMrKmQ71FwDn+dk0NojbIWNZb+2tZY+qolr2XlA
 dohBVw487ObWD+LX6/6RuUhz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 00:45:41 -0700
IronPort-SDR: PwO88X9ZMnR/FvUzdISSpjrN/ffcjSIRCRnZRJm25q6XuBlRboDao+hyPQ2hrSLEDk0KLjl9Us
 NHUPgMp6EtCG/y3y8Lv/RRFBxDjEwPM8AXDwOENjdezrvzdWZU151IpAB0Q9gAorclkPBWtwFk
 ztZmjMJxt3/uRyqxZChbXTIebqSrhqWkXrZA5CNI/70VrTmP6G0kgn6G8he+oilCS88O3vkK6/
 NXYqiH7jFMjsK6u/DpiNauldR3vsCXmRpDVxtaW1FVv0M3/80irRWS4jGpjKEdHbUoJ5SsNcOq
 DIw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 01:13:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KPHzw6Nm8z1SVp1
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 01:13:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648109628; x=1650701629; bh=y+OmNmasAg+uGRzoRTsfVJSLekyZ3BG1ai2
        QuN3eWrQ=; b=pg2bEz07oGxdXmpxAdqx5CiWo+lbPA8ExWDu+IGtArrFco4TFmy
        X3vCpyfX9DDZRIfkReBy5F8pUES50iyUXFuYMafhR2P/Zv+43bn+Dmv34HFxG6ci
        VQL10z4jl2r/GNXbAyEb6EkI/APaM46kU/eQ9aDcAr5WagFIQXps6TeWuzNDKpAb
        Nd1kmovjgd35ty7//BYEH8Dx6BylCU0zPFuuJiDI+pUUYMfIABvyZimaxswYQcur
        dKXzi8DWqACQl1hF4W3mYK8kCFQ4oGqaStQ9PYkLPji7AILlhhE/FBfnpL+rSQNY
        1AFHE2bJfvIqdISpfU+ZyAy3f//FNBFahqA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wK3T5ZnJr23e for <linux-ide@vger.kernel.org>;
        Thu, 24 Mar 2022 01:13:48 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KPHzt45LXz1Rvlx;
        Thu, 24 Mar 2022 01:13:46 -0700 (PDT)
Message-ID: <a2597470-8998-92a4-8085-0503974ce237@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 17:13:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 07/21] ata: libahci_platform: Sanity check the DT child
 nodes number
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-8-Sergey.Semin@baikalelectronics.ru>
 <ab7f2a2e-0ca9-ed97-e4ed-bf8ef0ed69a5@opensource.wdc.com>
 <d651ccef-1ba6-3063-66d8-410b5517cc3d@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d651ccef-1ba6-3063-66d8-410b5517cc3d@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 17:12, Sergey Shtylyov wrote:
> On 3/24/22 4:40 AM, Damien Le Moal wrote:
> 
>>> Having greater than (AHCI_MAX_PORTS = 32) ports detected isn't that
>>> critical from the further AHCI-platform initialization point of view since
>>> exceeding the ports upper limit will cause allocating more resources than
>>> will be used afterwards. But detecting too many child DT-nodes doesn't
>>> seem right since it's very unlikely to have it on an ordinary platform. In
>>> accordance with the AHCI specification there can't be more than 32 ports
>>> implemented at least due to having the CAP.NP field of 4 bits wide and the
>>> PI register of dword size. Thus if such situation is found the DTB must
>>> have been corrupted and the data read from it shouldn't be reliable. Let's
>>> consider that as an erroneous situation and halt further resources
>>> allocation.
>>>
>>> Note it's logically more correct to have the nports set only after the
>>> initialization value is checked for being sane. So while at it let's make
>>> sure nports is assigned with a correct value.
>>>
>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>> ---
>>>  drivers/ata/libahci_platform.c | 16 +++++++++++-----
>>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>>> index 4fb9629c03ab..845042295b97 100644
>>> --- a/drivers/ata/libahci_platform.c
>>> +++ b/drivers/ata/libahci_platform.c
>>> @@ -470,15 +470,21 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>>  		}
>>>  	}
>>>  
>>> -	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
>>> -
>>>  	/*
>>> -	 * If no sub-node was found, we still need to set nports to
>>> -	 * one in order to be able to use the
>>> +	 * Too many sub-nodes most likely means having something wrong with
>>> +	 * firmware. If no sub-node was found, we still need to set nports
>>> +	 * to one in order to be able to use the
>>>  	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
>>>  	 */
>>> -	if (!child_nodes)
>>> +	child_nodes = of_get_child_count(dev->of_node);
>>> +	if (child_nodes > AHCI_MAX_PORTS) {
>>> +		rc = -EINVAL;
>>> +		goto err_out;
>>> +	} else if (!child_nodes) {
>>
>> No need for "else" after a return.
> 
>    You meant *goto*? :-)

Yes :) No need for the else after goto.

> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
