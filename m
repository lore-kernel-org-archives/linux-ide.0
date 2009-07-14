From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] IDE: palm_bk3710: convert clock usage after clkdev
	conversion
Date: Tue, 14 Jul 2009 16:23:53 -0700
Message-ID: <636c5030907141623p7b884a44q3ff95fde0897f8dc@mail.gmail.com>
References: <1246919176-28683-1-git-send-email-khilman@deeprootsystems.com>
	 <4A5B7B29.7070400@ru.mvista.com> <87vdlwfgak.fsf@deeprootsystems.com>
	 <20090713.140705.140939312.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f184.google.com ([209.85.210.184]:58144 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756241AbZGNXaV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2009 19:30:21 -0400
Received: by yxe14 with SMTP id 14so4780832yxe.33
        for <linux-ide@vger.kernel.org>; Tue, 14 Jul 2009 16:30:21 -0700 (PDT)
In-Reply-To: <20090713.140705.140939312.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com

On Mon, Jul 13, 2009 at 2:07 PM, David Miller<davem@davemloft.net> wrot=
e:
> From: Kevin Hilman <khilman@deeprootsystems.com>
> Date: Mon, 13 Jul 2009 14:01:55 -0700
>
>> Sergei Shtylyov <sshtylyov@ru.mvista.com> writes:
>>
>>> Hello.
>>>
>>> Kevin Hilman wrote:
>>>
>>>> DaVinci core code has converted to the new clkdev API so
>>>> clock name strings are not needed. =A0Instead, just the a
>>>> 'struct device' pointer is needed.
>>>>
>>>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>>
>>> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>>
>>>> ---
>>>> Fix needed for 2.6.31
>>
>> Can this fix be merged for the .31-rc series please?
>>
>>> =A0 =A0It doesn't seem strictly necessary for 2.6.31 -- only in the=
 sense
>>> that "IDECLK" isn't named so anymore, however, clk_get() should sti=
ll
>>> work.
>
> Either it's needed or it isn't. =A0It seems like it isn't, and since
> the rules for integrating changes in the RC series right now is
> strict, I'm only going to merge something if it is actually
> necessary.
>

OK, after looking closer at clkdev, it looks like things will continue
to work in .31 without this patch, so this is merely confusing, and
not broken.

I'm ok if it waits until next merge window.

Thanks,

Kevin
