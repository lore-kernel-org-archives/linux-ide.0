From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] sata_rcar: fix error return code in sata_rcar_probe()
Date: Fri, 30 Jun 2017 14:54:48 -0500
Message-ID: <20170630145448.Horde.UwmUU7eGbQI-QPoebHrhBsT@gator4166.hostgator.com>
References: <20170630052210.GA19186@embeddedgus>
 <e71b065e-554e-4dee-06cc-b1cea6b3de53@cogentembedded.com>
 <20170630120106.GB16820@htj.duckdns.org>
 <20170630143645.Horde.FKDELy036LbmnxownuGOszF@gator4166.hostgator.com>
 <3944946f-5737-df9f-e8f4-61648f6e0d89@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3944946f-5737-df9f-e8f4-61648f6e0d89@cogentembedded.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Sergei,

Quoting Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:

> On 06/30/2017 10:36 PM, Gustavo A. R. Silva wrote:
>
>>>>> Print error message and propagate the return value of
>>>>> platform_get_irq on failure.
>>>>
>>>>   You should have probably mentioned that this function no longer  
>>>> returns 0
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
>
>    This *was* correct, because it prevented returning 0 on error.
>

Yeah, I got it.

>> prevents -EPROBE_DEFER from being propagated properly.
>
>    Yes, this is a real problem.
>
>> Print error message and propagate the return value of platform_get_irq
>> on failure. Also, with this change function sata_rcar_probe() no longer
>> returns 0 on error.
>
>    It never did -- I was talking about platform_get_irq() which  
> might return 0 on error until I fixed it:
>

Yep, I sent a new email immediately after I realized this was  
incorrect. Please,
check it out.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af
>

Great work!

Thank you
--
Gustavo A. R. Silva
