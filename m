From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.15-rc1] libata: fix passthru for slave devices
Date: Sat, 12 Nov 2005 22:20:57 -0500
Message-ID: <4376B119.6030303@pobox.com>
References: <4375CA38.9000905@superbug.demon.co.uk> <437607B5.7060605@rtr.ca> <43762CEF.2070704@pobox.com> <43764853.5050306@rtr.ca> <43764904.5030309@rtr.ca> <4376788E.9010503@pobox.com> <437680BA.40707@rtr.ca> <437685A5.3020804@pobox.com> <4376A9DB.9080107@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:48530 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751245AbVKMDVG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Nov 2005 22:21:06 -0500
In-Reply-To: <4376A9DB.9080107@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>> Mark Lord wrote:
>>
>>> +    if ((qc->ap->flags & ATA_FLAG_SLAVE_POSS))
>>
>>
>> kill the extra parens
> 
> 
> No.  Those parens are needed, to help gcc distinguish between
> a common programming error and intentional use of "&" rather than "&&".

How is this different from any other 'flags' test in libata?

	Jeff



