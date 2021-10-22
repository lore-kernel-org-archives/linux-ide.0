Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD5FC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 22 Oct 2021 01:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D216128E
	for <linux-ide@archiver.kernel.org>; Fri, 22 Oct 2021 01:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhJVBoL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 21 Oct 2021 21:44:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:52066 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhJVBoK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 21 Oct 2021 21:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634866914; x=1666402914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0GBEnQOgShUxem7vnjYXTpBVavyzGngAN6kWGPfkKB4=;
  b=C071h3GQxXhNvjqj+0WvBghVtTfjK54ReQaI4i/m9VrO7he4okpmG4US
   R9VI4AcJ4dM40fI5835+cEJ7Ar06pY1k7M8qOSB3iFFTLHvz4BB35j/e0
   Y4P81yXXjhcMVp4dC4FAW8cOfmB7v8BKXUguBiqc2xl2pSBIDm7RV5cNN
   OK1SO+ic0CbMUf7tidTi774CzJFmlirT55ot6hXVvZ3x28dm3pfm6bmUS
   M5xeCi38e/JELVbY4D6HnLbUUYGLFCAlx513YLDP6toY+I+7ebDa9fge7
   YJDx/oPiv3qAJf4mT6pAvogZpwPg0xg5eO2ra6oatbKigVdwx8LikXRyu
   w==;
X-IronPort-AV: E=Sophos;i="5.87,171,1631548800"; 
   d="scan'208";a="183572331"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2021 09:41:53 +0800
IronPort-SDR: O7OuUZseTvLJMKqpJFiodlbrM3fpJbUejOCi4luUQ80Bo03s+Gq478TlpP0T6K73AZlBpGzM1i
 yjsLDzoGNNx/Mvik1bIPu58DOB6qnjMNZ7F7H16kyJc6Zwi2gufDtcNW24R+qzKPIVTKnWqJf5
 MqwBM7CFB7tkSUGusumPaUO3MKfvFh6Gm5/CFDWWrAFaUVvSqsawO/IA4539EdJ5oSWS+tjCnA
 oj3ELIrMyRBh4cb4I1gyzvTtyDruexbgXjAgC50y9/LXREW7WvD5oQXSfaYJZEBoZoHck6KT7K
 UShhFF7fjpPfNmgbg9LEzruI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 18:15:56 -0700
IronPort-SDR: DIuWuojc9bgUV5C3qY1EwpSDrlS/5KuSk9C0OdgRMg71gGrT7KvR8Ixx33qlJ6PDnYifjHbVUS
 rDQkojq3Q5uCpKKPa/m9hHKwLT39n6MXLSR57q9Pcu6sOxiXdP3fWD6wreJtt78McIyC8L6fqj
 6ZuPnR+H5G3S0TSuzc4Cs10U76HUznCXCRLfO/P/+7XLXyvVaJE+b7+HNl8db0ecyVsVS41gwC
 3drARU63SY7xaUtA1oVxqpZJptLqphRATepH1BwSm0MbvH7GYXGgHJmZbNg5Rx/eZ1goABTiB0
 Rzw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 18:41:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hb6XK1wZSz1Rvlv
        for <linux-ide@vger.kernel.org>; Thu, 21 Oct 2021 18:41:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1634866912; x=1637458913; bh=0GBEnQOgShUxem7vnjYXTpBVavyzGngAN6k
        WGPfkKB4=; b=Mpd7gCVrDYXQcY77OZlJfELf94YO/s7Tpk0RPoKb1UnBzyLtYr1
        IrnWPDcQCbLEaoh4EakgyJsPg+LbK7O61++bXxq90HjPsNeDQSNSyianN+FwW5vc
        J7vTnMhp2OYP5hR8s43S4abSSxc5F0i4GAu8FRAPNVKARg4LliozlEnOeQDV0Net
        G+1d8ctMhPX1iiFPyXxkkGoCb3YOVZucJtIWn6chk2WtNmPz2hMbzfapj009p1Pp
        FWaqZ5YiWHBIVDrk87lpOSJmVGXBG2KgS0ypHT0F6mumMzwnNQnFCwIR1wpFNIEy
        uQ0eUdXaZBBVCVkWbyzn+XgNHaGTycZrn6w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qkDng2CriLsr for <linux-ide@vger.kernel.org>;
        Thu, 21 Oct 2021 18:41:52 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hb6XJ1YKpz1RvTm;
        Thu, 21 Oct 2021 18:41:52 -0700 (PDT)
Message-ID: <e10d2ea8-859d-7e5a-e132-411dec748df9@opensource.wdc.com>
Date:   Fri, 22 Oct 2021 10:41:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH] ata: sata_mv: Fix the return value of the probe function
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1634795836-1803-1-git-send-email-zheyuma97@gmail.com>
 <e1f96f77-cf44-7783-bf88-0814bbabbfbc@omp.ru>
 <1d5064f6-0498-c78c-d98f-df7ca74e0a8d@opensource.wdc.com>
 <CAMhUBjnFebrick3dt4CtYPANU69Uy0vPagZd-PEo+mFg6BTGEA@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <CAMhUBjnFebrick3dt4CtYPANU69Uy0vPagZd-PEo+mFg6BTGEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/10/21 20:23, Zheyu Ma wrote:
> On Thu, Oct 21, 2021 at 6:38 PM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 2021/10/21 17:37, Sergey Shtylyov wrote:
>>> On 21.10.2021 8:57, Zheyu Ma wrote:
>>>
>>>> mv_init_host() propagates the value returned by mv_chip_id() which in turn
>>>> gets propagated by mv_pci_init_one() and hits local_pci_probe().
>>>>
>>>> During the process of driver probing, the probe function should return < 0
>>>> for failure, otherwise, the kernel will treat value > 0 as success.
>>>>
>>>> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
>>>> ---
>>>>   drivers/ata/sata_mv.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>>>> index 9d86203e1e7a..7461fe078dd1 100644
>>>> --- a/drivers/ata/sata_mv.c
>>>> +++ b/drivers/ata/sata_mv.c
>>>> @@ -3897,7 +3897,7 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
>>>>
>>>>      default:
>>>>              dev_err(host->dev, "BUG: invalid board index %u\n", board_idx);
>>>> -            return 1;
>>>> +            return -ENODEV;
>>>
>>>     Doesn't -EINVAL fit better here?
>>
>> If the error message is correct and this can only happen if there is a bug
>> somewhere, I do not think the error code really matters much. The dev_err()
>> should probably be changed to dev_alert() or even dev_crit() for this case.
>>
> 
> I don't think so, the error code does matter. If mv_chip_id() returns
> 1 which eventually causes the probe function to return 1, then the
> kernel will assume that the driver and the hardware match successfully
> (even if that is not the case), which will cause the following error
> if modprobe is called to remove the driver.
> 
> [   21.944486] general protection fault, probably for non-canonical
> address 0xdffffc000000001b: 0000 [#1] PREEMPT SMP KASAN PTI
> [   21.945317] KASAN: null-ptr-deref in range
> [0x00000000000000d8-0x00000000000000df]
> [   21.954442] Call Trace:
> [   21.954624]  ? scsi_remove_host+0x32/0x660
> [   21.954923]  ? lockdep_hardirqs_on+0x7e/0x110
> [   21.955240]  ? _raw_spin_unlock_irqrestore+0x30/0x60
> [   21.955634]  ? mutex_lock_io_nested+0x60/0x60
> [   21.956027]  ? _raw_spin_unlock_irqrestore+0x41/0x60
> [   21.956395]  ? async_synchronize_cookie_domain+0x35f/0x4a0
> [   21.956802]  ? async_synchronize_full_domain+0x20/0x20
> [   21.957179]  ? lock_release+0x63f/0x8f0
> [   21.957468]  mutex_lock_nested+0x1b/0x30
> [   21.957761]  scsi_remove_host+0x32/0x660
> [   21.958054]  ata_host_detach+0x75d/0x830
> [   21.958349]  ata_pci_remove_one+0x3b/0x40
> [   21.958649]  pci_device_remove+0xa9/0x250
> [   21.958949]  ? pci_device_probe+0x7d0/0x7d0
> [   21.959261]  device_release_driver_internal+0x4f7/0x7a0
> [   21.959647]  driver_detach+0x1e8/0x2c0
> [   21.959929]  bus_remove_driver+0x134/0x290
> [   21.960234]  ? sysfs_remove_groups+0x97/0xb0
> [   21.960552]  driver_unregister+0x77/0xa0
> [   21.960859]  pci_unregister_driver+0x2c/0x1c0
> [   21.961178]  cleanup_module+0x15/0x28 [sata_mv]

How do you trigger this ? A bad device tree or something like that ?

> 
> This is not the case if the correct error code is returned.
> 
>>>
>>> [...]
>>>
>>> MBR, Sergey
>>>
>>
>>
>> --
>> Damien Le Moal
>> Western Digital Research
> 
> Regards,
> Zheyu Ma
> 


-- 
Damien Le Moal
Western Digital Research
