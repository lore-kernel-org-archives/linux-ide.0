Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70087C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 20 Oct 2021 05:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52DF36112D
	for <linux-ide@archiver.kernel.org>; Wed, 20 Oct 2021 05:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhJTFop (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 20 Oct 2021 01:44:45 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43300 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTFop (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 20 Oct 2021 01:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634708551; x=1666244551;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XOt0lfXCjaK90OK/ZD52uvJ3+faLGJ2KJwv/fci2Yxc=;
  b=d0tsp7YNbIjXwk1nHgiI5uIqvHz6UWiohqd1kCFS4f8qzLUa4t3hLipf
   GdquCSb6wf+nSvbtfonCBfp6vBgulL9+4EXdUMwzHi4AhH9VYiaJyt+5d
   ZD1ehiU5GT9RNyHNUllUT1S+TMfrjw3AvCIn3q2mjsvHzrb0Bb1LbUgwS
   /xvbdvjaHZXCtrmpH8Iuh29MYaoqHI7E+6HHJg3blNCzXnzA7ABCYMXFB
   gbQIc9+8EXVIymBaQy5/x7W9nBX78QhMxXufcKK8EP9EB6z4WS3w9iicR
   zUY6m9weO+mq8j1BdCxLq1ykI2bl9Cz8wR2HIEwndFahNTiNh+csdtnGU
   g==;
X-IronPort-AV: E=Sophos;i="5.87,166,1631548800"; 
   d="scan'208";a="184320718"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2021 13:42:31 +0800
IronPort-SDR: QWW5WZn7Aji222+bXnJ13VpBB4dst5qsxt/L7n2AYuwTJLEkUsl6aRcsUXB2L2eXv2HG4Td/tb
 rneN3GlKVAkx/AmJYAoVfi0XDM4TvI5te6UhsZBw0c8oxqjcxNmtJLQZlRZrZN5/qgDcnLfUml
 XGoPfIzhcOYgiEqu1E7ItL9mzz8XUr1Fz0Sq+DD1wqqGlIJDY+4xrYy5E2Jk6GJKz5k1cTY9c2
 e+aHjzXJXGO63kIaME2h/7fyyFKKtqpc/l03nlfEteyg7USOzBwzAMO3nAjNgiDAFTNK7Q66QM
 Gcrm9+oICruiK8YXG4bYC+ae
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 22:18:08 -0700
IronPort-SDR: YveGH0s50FaC+03c34nY+iBZ8SY6wQJJ/ACphMeyu2TRMouAzgEQgsgFvkGVx50LTDv3g/44My
 J2ifCxWbnmah8PsW8G2heAmj+x9htqp9oNPdZloiKdS2P/wwwo2zp+lE7wOC3sZ83k8X6J8KVB
 NUd9ToAAjxTrBCyvG3zKpp0vkFOKPPqrX1wJiwkKiFeannl2sezkaSAHLcqXqw4I8AOGb/mO4Y
 6exihwqqD6btu+sECs4OqbXzry4uebkBHovz6ZrWCbsbQx3usPrV+sqCjsyrvRGFzIP8lWUrJx
 gJw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 22:42:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HYzyt4X3Yz1RvmD
        for <linux-ide@vger.kernel.org>; Tue, 19 Oct 2021 22:42:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1634708550; x=1637300551; bh=XOt0lfXCjaK90OK/ZD52uvJ3+faLGJ2KJwv
        /fci2Yxc=; b=eTIuK/qqmgfRjgjp0A+Pl5CDbimBGIT9irw//lA3Sx6nNa6FnzU
        p7MtlF727I7F6sn/S0YKcBE13tYzKeEKnUI2vDjXhBwemwRmX88sO74YMB8A7XQp
        0+d6z0iZHmwzgNYGSqvMu/vCPFwoW/rW0dIij6hSskg+IKeoWGRhVwFBemxcGerA
        mTtAJC+IX6iiuQp/AEn3KrLRMCkzQ4UGG39PII+Wymie/pzsp4QRtt3TXa5Fa9T+
        T8/9/oDmXwd0m0h4c8jmpnczD8PIOCV4NABd4ACH6Sw3F4bqhPZd8+nKgitfjyUM
        S8uT/ELbyW7IUJ0Ypexk3U6V3qwcaRZ5Rsg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0M0anOQx4G4Y for <linux-ide@vger.kernel.org>;
        Tue, 19 Oct 2021 22:42:30 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HYzys54kSz1RvlZ;
        Tue, 19 Oct 2021 22:42:29 -0700 (PDT)
Message-ID: <f4795aee-c29e-1561-fc05-0cc518ad6cfc@opensource.wdc.com>
Date:   Wed, 20 Oct 2021 14:42:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH] scsi: ata: make ahci_sdev_attrs static
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-ide@vger.kernel.org
References: <1634639082-1007-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <af043ccc-6287-47d4-d5b5-7bbef4e3380e@opensource.wdc.com>
 <59795405-fe7c-2181-b1a0-6beda1963911@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <59795405-fe7c-2181-b1a0-6beda1963911@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/10/20 12:27, Bart Van Assche wrote:
> On 10/19/21 15:44, Damien Le Moal wrote:
>> +Bart
>>
>> On 2021/10/19 19:24, Jiapeng Chong wrote:
>>> From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
>>
>> The patch title should be:
>>
>> ata: libahci: make ahci_sdev_attrs static
>>
>>>
>>> This symbol is not used outside of libahci.c, so marks it static.
>>>
>>> Fix the following sparse warning:
>>>
>>> drivers/ata/libahci.c:134:18: warning: symbol 'ahci_sdev_attrs' was not
>>> declared. Should it be static?
>>>
>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>> Fixes: c3f69c7f629f ("scsi: ata: Switch to attribute groups")
>>> Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
>>> ---
>>>   drivers/ata/libahci.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>>> index 28430c093a7f..8a6835bfd18a 100644
>>> --- a/drivers/ata/libahci.c
>>> +++ b/drivers/ata/libahci.c
>>> @@ -131,7 +131,7 @@ const struct attribute_group *ahci_shost_groups[] = {
>>>   };
>>>   EXPORT_SYMBOL_GPL(ahci_shost_groups);
>>>   
>>> -struct attribute *ahci_sdev_attrs[] = {
>>> +static struct attribute *ahci_sdev_attrs[] = {
>>>   	&dev_attr_sw_activity.attr,
>>>   	&dev_attr_unload_heads.attr,
>>>   	&dev_attr_ncq_prio_supported.attr,
>>>
>>
>> Looks OK to me.
> 
> The above patch looks fine to me too.

Can I add your reviewed-by tag ?

> 
> Thanks,
> 
> Bart.
> 


-- 
Damien Le Moal
Western Digital Research
