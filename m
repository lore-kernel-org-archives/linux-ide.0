From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] sata_rcar: fix error return code in sata_rcar_probe()
Date: Fri, 30 Jun 2017 14:36:45 -0500
Message-ID: <20170630143645.Horde.FKDELy036LbmnxownuGOszF@gator4166.hostgator.com>
References: <20170630052210.GA19186@embeddedgus>
 <e71b065e-554e-4dee-06cc-b1cea6b3de53@cogentembedded.com>
 <20170630120106.GB16820@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway22.websitewelcome.com ([192.185.47.168]:31599 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752507AbdF3Tgu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2017 15:36:50 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id EC8F53B91B
        for <linux-ide@vger.kernel.org>; Fri, 30 Jun 2017 14:36:47 -0500 (CDT)
In-Reply-To: <20170630120106.GB16820@htj.duckdns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Tejun, Sergei,

Quoting Tejun Heo <tj@kernel.org>:

> On Fri, Jun 30, 2017 at 12:42:38PM +0300, Sergei Shtylyov wrote:
>> Hello!
>>
>> On 6/30/2017 8:22 AM, Gustavo A. R. Silva wrote:
>>
>> > Print error message and propagate the return value of
>> > platform_get_irq on failure.
>>
>>    You should have probably mentioned that this function no longer returns 0
>> on error.
>
> Yeah, the patches looks good to me but I'd really appreciate more
> context in the changelogs.  Gustavo, can you please respin the
> patches?
>

Absolutely.

What do you think about the following changelog:

platform_get_irq() returns an error code, but the sata_rcar driver
ignores it and always returns -EINVAL. This is not correct, and
prevents -EPROBE_DEFER from being propagated properly.

Print error message and propagate the return value of platform_get_irq
on failure. Also, with this change function sata_rcar_probe() no longer
returns 0 on error.


Thank you!
--
Gustavo A. R. Silva




