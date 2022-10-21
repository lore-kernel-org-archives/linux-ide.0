Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5A1C4332F
	for <linux-ide@archiver.kernel.org>; Fri, 21 Oct 2022 08:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJUIAd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Oct 2022 04:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJUIAb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2022 04:00:31 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881AC14D8C4
        for <linux-ide@vger.kernel.org>; Fri, 21 Oct 2022 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666339227; x=1697875227;
  h=message-id:date:mime-version:subject:from:to:references:
   in-reply-to:content-transfer-encoding;
  bh=PZSIu7Jrkolwkvb4Wl47VFmIk5SZTHuyRO+3Ch08laQ=;
  b=YeJQCGnVrZUW23YZJqANw/eoqFcQ0L+LJ8xJitoHyfeRouDXnYWFIwd/
   UxeAhz+l9psFsHmS41BF5TDL9Y4tL5w6NQeyW2xr2l85jUsnDEyBwR+DW
   J2Dh/o4mkCIbQ1ie8SScmyZKWyM6l9ckKuMlEw8u5PPF+f5t9EIYT1g9k
   lKX9sIXaCkYlJ6Jk2/pwwMHd/6elwlzgyuq0UCiTlMUPWISFvUTHJLl6W
   lL7VMR/zLWNETQ8RPNM50hjGym8gUeCPa7ZoCjqj72gl01LcbyjZFTsby
   pwqXOkO3/zx/izbv7ofSxZHu0DUkyl8sCkPMKQj/jrcKJ6LdbzLVv82dI
   w==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="214792547"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 16:00:24 +0800
IronPort-SDR: +38YtcH3oflPvV3Mb/ra8FO590tdNkJ4D+zVQsa2BwGG4AeQqXty//TmMnWdzFKyY5/xZoEgSz
 BH7AdYLb1+LAOHkfIQHqJu+XSW06zrcccU1DU1VsrZnfh8Y8BTZZInpZAcfbYzjoEjfez1+JyH
 Gc8bcW8aIm1rtKYI95pQug3JnFwFYt5Y8Rj6KW3hCKmA4kSJVz48Yi/sF1nLun9z9WnjSxdOU2
 iCqOeEkAxFWd2V7IQ15hNwlEOGZR+439cexzL5mDWZF8igDENcCDqdNmYTsh5PqTYu/YwkhoxL
 ekPvPoh139AtNMmluc7z13Qv
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2022 00:14:11 -0700
IronPort-SDR: 9nLyPfAaURIz3cpP1tJrp2nFMbYEDBzoO/6K5f6BLt7ysfmjbS7jJJvOjFxZAw0RrwSbO9e087
 IpsqhurAXBigXFuPy2VA8keSmSj7VOFMmBvDYfLaTGaKQ+mKxLQ5p7Gkj9vJYyrpsvt4kpV6pD
 U147Gc/FWWHArKOMydvzVBVgE73b9bX5YBix3huioSh8e8osVddqW8kzPKnnBJpzpKiTfRgxKx
 PeYTUYJd0Amd/IlGEW0T7Z9NQE3gahhBlmJrEolLmhS5+tBhB9Meg9h1owITKgm3WIt1Nn5Spb
 Bqk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2022 01:00:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mtxj26MHlz1RvTp
        for <linux-ide@vger.kernel.org>; Fri, 21 Oct 2022 01:00:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666339222; x=1668931223; bh=PZSIu7Jrkolwkvb4Wl47VFmIk5SZTHuyRO+
        3Ch08laQ=; b=ELHvHdL1/nDgnGAkrOEfzhXMGINx8UDN/OEunNI+3C0wdHMoauc
        ZkMT+Ad3L7+iIBAYr2c3sqJG/s9zlNrHOaEgibNm/krj13li2DiCyHRY5rV6noPX
        rfreJZCI4PA0pbdItktgICXjGldNqtZXbr2ILnAu0Ii7qYr37VAdfI8W8W/Kmmvs
        fM3WqwPPkuKXaYMf8sIfHJZE8/TNl39nusGdhHSJ4A7nQMkOfMTDN5zYVZ3W2j1K
        +qg3phWrjae02UmL/gjhH8xAUd7mgnfkT50cKcSDDWnGl4Q13qShaZ9QzY77uFVI
        fSC2BGt2ARCfNhvHMN5kKXdfddNhN9Ib80A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2t7lbC4G_0Xe for <linux-ide@vger.kernel.org>;
        Fri, 21 Oct 2022 01:00:22 -0700 (PDT)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mtxj15Jfpz1RvLy;
        Fri, 21 Oct 2022 01:00:21 -0700 (PDT)
Message-ID: <3a08e4a4-417f-8dbb-42d1-f81c94cf26dc@opensource.wdc.com>
Date:   Fri, 21 Oct 2022 17:00:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/3] ata: libata: allow toggling fua parameter at runtime
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
 <20221021053809.237651-3-damien.lemoal@opensource.wdc.com>
 <c1fc6322-d6d4-4579-1281-130e0546883b@suse.de>
 <1ccb3faa-a727-6b4b-cabc-320c7a21ca09@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1ccb3faa-a727-6b4b-cabc-320c7a21ca09@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/21/22 15:50, Damien Le Moal wrote:
> On 10/21/22 15:21, Hannes Reinecke wrote:
>> On 10/21/22 07:38, Damien Le Moal wrote:
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Currently, the libata.fua parameter isn't runtime-writable, so a
>>> system restart is required in order to toggle it.
>>> This unnecessarily complicates testing how drives behave with FUA on and
>>> off.
>>>
>>> Let's make this parameter R/W instead, like many others in the kernel.
>>>
>>> Example usage:
>>> Disable the parameter:
>>> echo 0 >/sys/module/libata/parameters/fua
>>>
>>> Revalidate disk cache settings:
>>> F=/sys/class/scsi_disk/0\:0\:0\:0/cache_type; echo `cat $F` >$F
>>>
>>> [Damien]
>>> Enabling fua support by setting libata.fua to 1 will have no effect if
>>> the libata module is loaded with libata.force=[ID]nofua, which disables
>>> fua support for the ata device(s) identified with ID or all ata devices
>>> if no ID is specified.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> ---
>>>   drivers/ata/libata-core.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index 6008f7ed1c42..1bb9616b10d9 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -128,7 +128,7 @@ module_param(atapi_passthru16, int, 0444);
>>>   MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
>>>   
>>>   int libata_fua = 0;
>>> -module_param_named(fua, libata_fua, int, 0444);
>>> +module_param_named(fua, libata_fua, int, 0644);
>>>   MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
>>>   
>>>   static int ata_ignore_hpa;
>> Hmm. I guess you'll need to revalidate the drive when changing that; but 
>> this can be done in a later patch.
> 
> Well, this is not sysfs, we cannot do this automatically easily...
> And thinking about it now that you mention it, going from fua=1 to fua=0
> can actually cause problems. The reverse not, since scsi side would still
> see fua=0 until revalidation.
> 
> So... Unless we find a way to link the param write to reavlidation, we
> should actually not allow this.
> Maciej ? Thoughts ?

I looked at this a little more. We could define the operations (struct
kernel_param_ops) manually together with the fua parameter declaration,
but that would be really ugly...

Given that we are switching to fua=1 by default, do you still need a
dynamic argument ? I am now thinking that this patch should be dropped.

> 
>>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>
>> Cheers,
>>
>> Hannes
> 

-- 
Damien Le Moal
Western Digital Research

