From: David Miller <davem@davemloft.net>
Subject: Re: drivers/ide/au1xxx-ide.c: use resource_size()
Date: Mon, 23 Nov 2009 12:20:38 -0800 (PST)
Message-ID: <20091123.122038.64001211.davem@davemloft.net>
References: <BD79186B4FD85F4B8E60E381CAEE190901EE5C0C@mi8nycmail19.Mi8.com>
	<20091123.103810.44071453.davem@davemloft.net>
	<BD79186B4FD85F4B8E60E381CAEE190901EE5C3E@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:50524
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755589AbZKWUUU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2009 15:20:20 -0500
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901EE5C3E@mi8nycmail19.Mi8.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hartleys@visionengravers.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Date: Mon, 23 Nov 2009 15:01:02 -0500

> On Monday, November 23, 2009 11:38 AM, David Miller wrote:
>>>  
>>> -	ahwif->regbase = (u32)ioremap(res->start, res->end - res->start + 1);
>>> +	ahwif->regbase = (u32)ioremap(res->start, resource_size(res));
>>>  	if (ahwif->regbase == 0) {
>>>  		ret = -ENOMEM;
>>>  		goto out;
>>
>> That needs some fixing.  ioremap()'s return value is an
>> "__iomem" pointer, not an integer.  ->regbase's type should be
>> changed to something like "void __iomem *" etc.
> 
> FWIW, following is an updated patch that fixes the "__iomem" pointer.

Please, I've already applied your resource_size() patch, and you
should submit a seperate patch relative to that in order to address
the ioremap() pointer issues.

Thank you.
