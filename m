Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19889C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 21 Oct 2022 08:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJUItU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Oct 2022 04:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiJUItR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2022 04:49:17 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8F624F79F
        for <linux-ide@vger.kernel.org>; Fri, 21 Oct 2022 01:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666342153; x=1697878153;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=o4JHXVAUf37rMqm+dJCHgZOPpwNeJ9KckhEpYcbaEnA=;
  b=TfAH7UDk02/yg53CP8qOjmEf6NY9Aa75tuuM2SCcKUESyZ4liNj032fc
   +y5W/ADab4FExLR5/QfqmYUrYt0srX8xVTdDHizQoC4G/vpLIuc1pjnVU
   tsCB6rmr6/m8+GdVlK32HubimHGh3fZtxbV8nNq1C6AqHCJluswj6wluD
   li+TsVsMYMl+e+luDz40Dj3bHjLbbhnip6RgNBbtUph6vpJdVYw+K4YFr
   MwhNncIQV8gv7wOBNudN2PmSZYMyglUMIc7JPb0LVZrOV8ebSCiH4oqou
   TtHEHciQJiW3Cl/UCqih95dr1LGPxdRX8KvZRyq1aW+QYGs+dyRM5k9gw
   g==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="219582267"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 16:48:26 +0800
IronPort-SDR: bzA62TRUTS2GKheHniNvVBjqjiS7tJF0HfsYB0xTJicC9F1NJW1qewOt7VZlSCQnXDlw7wXsok
 LaMTYPxLWgZOdFtlkCS70SZusaqyFdlqa9APWs3F1AVMSUPXUv+rNE3F1cXGyC647JZhQ89oJz
 rDK9FikL1uZkrRsvekv2/lRn9Zkt1Si2S7V2YUg0sEDZsPqADHi4aIEdTmGjRLLlMwyAF9azeI
 dVd2PYa+WsRpids/uwDoWBYcUyaU5DwevsvkQeBXXw41/O5uGihljNtLB/MMDisXcjpjmc2xX3
 AIMXVzYNcR+qELUwIaI6VUCv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2022 01:07:48 -0700
IronPort-SDR: +hQAEKEUR82L6Wd5VUtltyoLz6lDEgmrvWsxmqx0sPLAK2ntGmJdjOecDGLH8YEt/10oA65eP6
 jPvahvTyopZtxFlUHa5b36nLwnBMIXB1/B+UxThcQKgt0XwyEF/jZLx368W6zaoE9UHUObElyd
 NOErOOcwlDREKwEg+dW9aUl7TSdWh8iUT3Z5VuA8alQcPYQdY3IxsptQxH8iYQ1MglIiFD/ack
 e4CXItZJLgbgmK8wTiBfqkSCFvlk5yd32pj+KpqalrlUEBtwJ8Swyr6R24+lZ/DBmbzIxcNKgE
 Ric=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2022 01:48:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MtymN06PRz1RvTp
        for <linux-ide@vger.kernel.org>; Fri, 21 Oct 2022 01:48:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666342099; x=1668934100; bh=o4JHXVAUf37rMqm+dJCHgZOPpwNeJ9KckhE
        pYcbaEnA=; b=W9H7EOiSSVYWCfVnkt0dd70ahM6kZXSPypdXBwp6HLIPP6SATdf
        JVE4DTqGSJDzCL3CzVG2ankIqSH2AVocl50t4n/j2qdQz1LcpZ5+YwktXbPV4uzv
        OYVMP27p/agcijQPGK//fy1+71ra9fWDzB6GBFYadox/SOXLeUX/kvuJoT0Cyalg
        SJOWPjk2Lgvjewn+4Zj6KrjMt+00ei6PA6gQKqbWWLRLgjgSKdxMhybSeaYdSDKb
        uW10ETK1OG6EQz08/qp4xIxGtlzshoYrwcqnC1PhL7BdGnjiIL4WzMrUt6NAdgoP
        sJWWV8ldckznNCi9WrFI4dAZxi8NTG5txIg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LsX8UQfGrJqD for <linux-ide@vger.kernel.org>;
        Fri, 21 Oct 2022 01:48:19 -0700 (PDT)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MtymM0snZz1RvLy;
        Fri, 21 Oct 2022 01:48:18 -0700 (PDT)
Message-ID: <aa11cbe5-ef78-e760-762a-13bf846e405f@opensource.wdc.com>
Date:   Fri, 21 Oct 2022 17:48:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/3] ata: libata: allow toggling fua parameter at runtime
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
 <20221021053809.237651-3-damien.lemoal@opensource.wdc.com>
 <c1fc6322-d6d4-4579-1281-130e0546883b@suse.de>
 <1ccb3faa-a727-6b4b-cabc-320c7a21ca09@opensource.wdc.com>
 <3a08e4a4-417f-8dbb-42d1-f81c94cf26dc@opensource.wdc.com>
 <ac069cbd-1a90-4d60-3eef-d1d58def73b0@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ac069cbd-1a90-4d60-3eef-d1d58def73b0@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/21/22 17:45, Hannes Reinecke wrote:
> On 10/21/22 10:00, Damien Le Moal wrote:
>> On 10/21/22 15:50, Damien Le Moal wrote:
>>> On 10/21/22 15:21, Hannes Reinecke wrote:
>>>> On 10/21/22 07:38, Damien Le Moal wrote:
>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>
>>>>> Currently, the libata.fua parameter isn't runtime-writable, so a
>>>>> system restart is required in order to toggle it.
>>>>> This unnecessarily complicates testing how drives behave with FUA on and
>>>>> off.
>>>>>
>>>>> Let's make this parameter R/W instead, like many others in the kernel.
>>>>>
>>>>> Example usage:
>>>>> Disable the parameter:
>>>>> echo 0 >/sys/module/libata/parameters/fua
>>>>>
>>>>> Revalidate disk cache settings:
>>>>> F=/sys/class/scsi_disk/0\:0\:0\:0/cache_type; echo `cat $F` >$F
>>>>>
>>>>> [Damien]
>>>>> Enabling fua support by setting libata.fua to 1 will have no effect if
>>>>> the libata module is loaded with libata.force=[ID]nofua, which disables
>>>>> fua support for the ata device(s) identified with ID or all ata devices
>>>>> if no ID is specified.
>>>>>
>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>>>> ---
>>>>>    drivers/ata/libata-core.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>>>> index 6008f7ed1c42..1bb9616b10d9 100644
>>>>> --- a/drivers/ata/libata-core.c
>>>>> +++ b/drivers/ata/libata-core.c
>>>>> @@ -128,7 +128,7 @@ module_param(atapi_passthru16, int, 0444);
>>>>>    MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
>>>>>    
>>>>>    int libata_fua = 0;
>>>>> -module_param_named(fua, libata_fua, int, 0444);
>>>>> +module_param_named(fua, libata_fua, int, 0644);
>>>>>    MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
>>>>>    
>>>>>    static int ata_ignore_hpa;
>>>> Hmm. I guess you'll need to revalidate the drive when changing that; but
>>>> this can be done in a later patch.
>>>
>>> Well, this is not sysfs, we cannot do this automatically easily...
>>> And thinking about it now that you mention it, going from fua=1 to fua=0
>>> can actually cause problems. The reverse not, since scsi side would still
>>> see fua=0 until revalidation.
>>>
>>> So... Unless we find a way to link the param write to reavlidation, we
>>> should actually not allow this.
>>> Maciej ? Thoughts ?
>>
>> I looked at this a little more. We could define the operations (struct
>> kernel_param_ops) manually together with the fua parameter declaration,
>> but that would be really ugly...
>>
>> Given that we are switching to fua=1 by default, do you still need a
>> dynamic argument ? I am now thinking that this patch should be dropped.
>>
> I'd kill it, and let users it handle via blacklist flags only.

Yep, with the default set to 1 that is the goal. I kept the fua module
parameter for backward compatibility, in case some setups out there use
it. But the force=[ID]nofua or force=[ID]fua module parameters should be
the preferred way to control this now.

> 
> Cheers,
> 
> Hannes

-- 
Damien Le Moal
Western Digital Research

