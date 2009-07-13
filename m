From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] IDE: palm_bk3710: convert clock usage after clkdev
 conversion
Date: Mon, 13 Jul 2009 14:07:05 -0700 (PDT)
Message-ID: <20090713.140705.140939312.davem@davemloft.net>
References: <1246919176-28683-1-git-send-email-khilman@deeprootsystems.com>
	<4A5B7B29.7070400@ru.mvista.com>
	<87vdlwfgak.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:34779
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752103AbZGMVHC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jul 2009 17:07:02 -0400
In-Reply-To: <87vdlwfgak.fsf@deeprootsystems.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com

From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Mon, 13 Jul 2009 14:01:55 -0700

> Sergei Shtylyov <sshtylyov@ru.mvista.com> writes:
> 
>> Hello.
>>
>> Kevin Hilman wrote:
>>
>>> DaVinci core code has converted to the new clkdev API so
>>> clock name strings are not needed.  Instead, just the a
>>> 'struct device' pointer is needed.
>>>
>>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>
>> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>
>>> ---
>>> Fix needed for 2.6.31
> 
> Can this fix be merged for the .31-rc series please?
> 
>>    It doesn't seem strictly necessary for 2.6.31 -- only in the sense
>> that "IDECLK" isn't named so anymore, however, clk_get() should still
>> work.

Either it's needed or it isn't.  It seems like it isn't, and since
the rules for integrating changes in the RC series right now is
strict, I'm only going to merge something if it is actually
necessary.
