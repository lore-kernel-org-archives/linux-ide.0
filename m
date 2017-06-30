From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] sata_rcar: fix error return code in sata_rcar_probe()
Date: Fri, 30 Jun 2017 23:03:05 +0300
Message-ID: <e7f03776-d0d7-d007-57c9-df75822e73be@cogentembedded.com>
References: <20170630052210.GA19186@embeddedgus>
 <e71b065e-554e-4dee-06cc-b1cea6b3de53@cogentembedded.com>
 <20170630120106.GB16820@htj.duckdns.org>
 <20170630143645.Horde.FKDELy036LbmnxownuGOszF@gator4166.hostgator.com>
 <20170630144633.Horde.7_6XB0hRnIIuucUlRN2ico3@gator4166.hostgator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34761 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbdF3UDP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2017 16:03:15 -0400
Received: by mail-lf0-f54.google.com with SMTP id l13so76046858lfl.1
        for <linux-ide@vger.kernel.org>; Fri, 30 Jun 2017 13:03:14 -0700 (PDT)
In-Reply-To: <20170630144633.Horde.7_6XB0hRnIIuucUlRN2ico3@gator4166.hostgator.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/30/2017 10:46 PM, Gustavo A. R. Silva wrote:

>>>>> Print error message and propagate the return value of
>>>>> platform_get_irq on failure.
>>>>
>>>>   You should have probably mentioned that this function no longer returns 0
>>>> on error.
>>>
>>> Yeah, the patches looks good to me but I'd really appreciate more
>>> context in the changelogs.  Gustavo, can you please respin the
>>> patches?
>>>
>>
>> Absolutely.
>>
>> What do you think about the following changelog:
>>
>> platform_get_irq() returns an error code, but the sata_rcar driver
>> ignores it and always returns -EINVAL. This is not correct, and
>> prevents -EPROBE_DEFER from being propagated properly.
>>
>> Print error message and propagate the return value of platform_get_irq
>> on failure. Also, with this change function sata_rcar_probe() no longer
>> returns 0 on error.
>>
>
> Errata, this would be final the chagelog:
>
> platform_get_irq() returns an error code, but the sata_rcar driver
> ignores it and always returns -EINVAL. This is not correct, and
> prevents -EPROBE_DEFER from being propagated properly. Also,
> notice that platform_get_irq() no longer returns 0 on error.
>
> Print error message and propagate the return value of platform_get_irq
> on failure.

    Now I'm OK with that.

> Thanks

MBR, Sergei

