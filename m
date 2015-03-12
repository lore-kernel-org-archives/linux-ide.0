From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] ide: pdc202xxx_new: Remove do_gettimeofday() usage for ktime_get
Date: Thu, 12 Mar 2015 11:24:15 -0700
Message-ID: <CALAqxLXKqch7DnP0EgnsPnF4zq3zDj5CUXJTuv+t7nBM9iboEA@mail.gmail.com>
References: <1426181032-2397-1-git-send-email-john.stultz@linaro.org>
	<5501D7E7.6040603@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35028 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbbCLSYb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Mar 2015 14:24:31 -0400
Received: by ieclw3 with SMTP id lw3so53631056iec.2
        for <linux-ide@vger.kernel.org>; Thu, 12 Mar 2015 11:24:30 -0700 (PDT)
In-Reply-To: <5501D7E7.6040603@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org

On Thu, Mar 12, 2015 at 11:16 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 03/12/2015 08:23 PM, John Stultz wrote:
>
>> As part of the y2038 cleanups, this patch removes the do_gettimeofday
>> usage replacing it with ktime_get.
>
>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-ide@vger.kernel.org
>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>> ---
>>   drivers/ide/pdc202xx_new.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>
>
>> diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
>> index df73cbd..94bd05f 100644
>> --- a/drivers/ide/pdc202xx_new.c
>> +++ b/drivers/ide/pdc202xx_new.c
>
> [...]
>>
>> @@ -273,8 +274,7 @@ static long detect_pll_input_clock(unsigned long
>> dma_base)
>>          * Calculate the input clock in Hz
>>          * (the clock counter is 30 bit wide and counts down)
>>          */
>> -       usec_elapsed = (end_time.tv_sec - start_time.tv_sec) * 1000000 +
>> -               (end_time.tv_usec - start_time.tv_usec);
>> +       usec_elapsed = (long)ktime_to_ns(ktime_sub(end_time,
>> start_time))/1000;
>
>
>    Please add spaces around / to be consistent with this file's (and general
> kernel) coding style.

Thanks for the review! Will fix in the next iteration.

thanks
-john
