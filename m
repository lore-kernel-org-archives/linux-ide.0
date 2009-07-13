From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] IDE: palm_bk3710: convert clock usage after clkdev conversion
Date: Mon, 13 Jul 2009 14:01:55 -0700
Message-ID: <87vdlwfgak.fsf@deeprootsystems.com>
References: <1246919176-28683-1-git-send-email-khilman@deeprootsystems.com>
	<4A5B7B29.7070400@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:15820 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813AbZGMVB6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jul 2009 17:01:58 -0400
Received: by wa-out-1112.google.com with SMTP id j5so457228wah.21
        for <linux-ide@vger.kernel.org>; Mon, 13 Jul 2009 14:01:57 -0700 (PDT)
In-Reply-To: <4A5B7B29.7070400@ru.mvista.com> (Sergei Shtylyov's message of "Mon\, 13 Jul 2009 22\:21\:29 +0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Sergei Shtylyov <sshtylyov@ru.mvista.com> writes:

> Hello.
>
> Kevin Hilman wrote:
>
>> DaVinci core code has converted to the new clkdev API so
>> clock name strings are not needed.  Instead, just the a
>> 'struct device' pointer is needed.
>>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
>> ---
>> Fix needed for 2.6.31

Can this fix be merged for the .31-rc series please?

Thanks,

Kevin

>>  drivers/ide/palm_bk3710.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/ide/palm_bk3710.c b/drivers/ide/palm_bk3710.c
>> index 3c1dc01..f8eddf0 100644
>> --- a/drivers/ide/palm_bk3710.c
>> +++ b/drivers/ide/palm_bk3710.c
>> @@ -318,7 +318,7 @@ static int __init palm_bk3710_probe(struct platform_device *pdev)
>>  	int i, rc;
>>  	struct ide_hw hw, *hws[] = { &hw };
>>  -	clk = clk_get(&pdev->dev, "IDECLK");
>> +	clk = clk_get(&pdev->dev, NULL);
>>  	if (IS_ERR(clk))
>>  		return -ENODEV;
>>  
>
>    It doesn't seem strictly necessary for 2.6.31 -- only in the sense
> that "IDECLK" isn't named so anymore, however, clk_get() should still
> work.
>
> MBR, Sergei
