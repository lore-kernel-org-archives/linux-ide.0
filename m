Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CD4CCA480
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jun 2022 14:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385900AbiFMOzD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Jun 2022 10:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386741AbiFMOyR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jun 2022 10:54:17 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F447CC14A
        for <linux-ide@vger.kernel.org>; Mon, 13 Jun 2022 04:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655121404; x=1686657404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5z0q0w5OItpES+QDBr5ihpTk03DpUbOM45YW6YxxVvU=;
  b=bHmloLlwJxWIK/2UYsOs5HaWotHtzm78uSpyCtYa62NlS1cLfkia3wjD
   KAYPIIdfeKoc8OMpy5tQvQhxP3Wc7Rbu1NbvRl/GyaBn9TCvl+oFaZbai
   6qEfPBC2BSINdLRU9psbEym5D9TC+X/ZoUtFqAPOAT+qXd+YGTGkWQRbH
   +83IXDmyYgjof1orrC1+IZ3oBzUAaKQ8/GD+GyX37eQ174BJlwS8AjAB1
   oaJZOnqs3+rLXOENiMX31e/t5h3VqanEAaHtlIZMValAXF8OF+bNE//H6
   WRnKV1RfAXOWmeo4e4kl9lGMsgkOf/h8hE5Xyev9skiN4T+zQP/qv2FY6
   w==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647273600"; 
   d="scan'208";a="207845363"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2022 19:56:28 +0800
IronPort-SDR: 0X/vdwAFlJNmL2S6I1Zo1JffGTWKlDbheqAlyOTb+GC5gosK86Gw+HM4SVdDpFyeFWwteAqzxd
 FqPXCEnFRjx5byD55LM/NiDxwdqyzlhOKyybYdBNXijGKuACO1JuonyQGhN3SEmbUOjVpCYTw/
 WPu0UFagiH0VQcpnyfBj5KJWj0N6DYvdV9PQpTiyNr3YFVmMZMNCxzDAFjKnYscuZxPmFltxXd
 nuPN2ZuKpMIJQpC6z+0wH+eCPced3c/wyAVdpUvDZ3CiwGAvj+uvIGnkDV30OS6hQSYxvfd7OS
 +8ijKqabo4ExRbNxeBj1USNd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2022 04:19:33 -0700
IronPort-SDR: jakWeq3ddmA8BtlBlTzTCwkD+zX8Vm2ah20LFK0pPAfHXzztTzQpY28yizPXe+pep1z+yVQaoN
 zb+XjbMgiYAVCz/yx5Ogkz0bsxqJMedcM6L0YqazxdrtbUL8UAttYlRN9J7AL8FxaewVEIByH7
 cBcCYBLQI2aODv49OEqP+4FK6t2vMYnDxQg9t49WdSgaaU7wY7VtdbFhLsvfZpPpov8//iZ4Ju
 6ZSX2D5HV2Pmx2q7PlPqqesQVsKyhLSZo7DoAm5WRoMl3JOFSGhWPilEep/AUB9oqWAplHDmWA
 bHg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2022 04:56:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LM95T66pPz1Rwrw
        for <linux-ide@vger.kernel.org>; Mon, 13 Jun 2022 04:56:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655121389; x=1657713390; bh=5z0q0w5OItpES+QDBr5ihpTk03DpUbOM45Y
        W6YxxVvU=; b=dIkwE9MwdBCmXPlKfGKpuzh0E49uHAe+XrVMUJTW1B08nk3sH3z
        UzzDIJurzVgG/LakZZMpllT70P0KNKUkTz0xEnWY2dtJnQ7pfzOvt5B8JAOY4bqT
        nh1VqAup+RjpdiEXtbS/am0uk+Ai7MSohYKbmfWNQstDnbtR+Oz33gdL7K8+LM/e
        QvuicGiZvau8zNHOPW2DwnU/KAfx85LrYHBfKHktNi34w91bu/UpyoSHsjPfI7em
        LjvuF92jUZstGkPkpyKFRXnAGhAk0K9M6+tMrfvRjzB3JOndLaGvn9Ol/stffzJe
        Osv5FBX+37CN20+ZDtDCPVRTcR11ofd8HUQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xbYzu_xrSfRv for <linux-ide@vger.kernel.org>;
        Mon, 13 Jun 2022 04:56:29 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LM95S2m4gz1Rvlc;
        Mon, 13 Jun 2022 04:56:28 -0700 (PDT)
Message-ID: <98ba9715-13b6-1b0f-92dc-f649f0178697@opensource.wdc.com>
Date:   Mon, 13 Jun 2022 20:56:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] ata: pata_pxa: handle failure of devm_ioremap()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Li Qiong <liqiong@nfschina.com>
Cc:     linux-ide@vger.kernel.org, yuzhe@nfschina.com, renyu@nfschina.com
References: <20220612073222.18974-1-liqiong@nfschina.com>
 <20220612125700.11740-1-liqiong@nfschina.com>
 <fbbed055-fa60-cdee-589b-5d8c12672e94@gmail.com>
 <097b7e93-4a85-1b6a-1772-67976f834108@opensource.wdc.com>
 <80cc4026-a6bf-255f-69d9-d1c1d390f83e@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <80cc4026-a6bf-255f-69d9-d1c1d390f83e@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/13/22 20:50, Sergey Shtylyov wrote:
> On 6/13/22 1:47 AM, Damien Le Moal wrote:
> 
>>>> As the possible failure of the devm_ioremap(), the return value
>>>> could be NULL. Therefore it should be better to check it and
>>>> print error message, return '-ENOMEM' error code.
>>
>> This error is very unlikely. So unless you are seeing actual problems in
>> the field, I do not think it is worth fixing.
> 
>    The error paths should absolutely be fixed. It helps avoid an oops later...
> 
>>>>
>>>> Signed-off-by: Li Qiong <liqiong@nfschina.com>
>>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>> ---
>>>> v2:
>>>> - add driver's name (pata_pxa) to subject.
>>>> ---
>>>>  drivers/ata/pata_pxa.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
>>>> index 985f42c4fd70..cd1a8f37f920 100644
>>>> --- a/drivers/ata/pata_pxa.c
>>>> +++ b/drivers/ata/pata_pxa.c
>>>> @@ -228,6 +228,11 @@ static int pxa_ata_probe(struct platform_device *pdev)
>>>>  	ap->ioaddr.bmdma_addr	= devm_ioremap(&pdev->dev, dma_res->start,
>>>>  						resource_size(dma_res));
>>>
>>>    Looking again into this driver, this statement doesn't make sense: dma_res
>>> points to a DMA resource, calling devm_ioremap() on it is just wrong... and
>>
>> Yes, having to do an ioremap of an IORESOURCE_DMA resource is rather
>> unusual. dmaengine_slave_config() should be doing anything that is
>> required for that resource.
>>
>>> 'ap->ioaddr.bmdma_addr' doesn;t seem to be used anyways...
>>
>> It is used in lbata-sff.c.
> 
>    Where exactly? To me, it looked like all ata_bmdma_port_ops were overridden
> by the driver... Even if not so, I don't think such code is correct...
> 
>>
>> A much cleaner fix would be to use
>> devm_platform_get_and_ioremap_resource() or
>> devm_platform_ioremap_resource() which will also remove the call to
>> platform_get_resource(().
> 
>    This is an -rc1 material.
> 
>> But as mentioned above, unless this is fixing an
>> actual bug in production, I do not think this is worth it.
> 
>    I strongly disagree here.

Not opposed to fixing this driver. But definitely low priority.

> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
