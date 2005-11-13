From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2.6.15-rc1] libata: fix passthru for slave devices
Date: Sat, 12 Nov 2005 21:50:03 -0500
Message-ID: <4376A9DB.9080107@rtr.ca>
References: <4375CA38.9000905@superbug.demon.co.uk> <437607B5.7060605@rtr.ca> <43762CEF.2070704@pobox.com> <43764853.5050306@rtr.ca> <43764904.5030309@rtr.ca> <4376788E.9010503@pobox.com> <437680BA.40707@rtr.ca> <437685A5.3020804@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:14299 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751011AbVKMCuE
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Nov 2005 21:50:04 -0500
In-Reply-To: <437685A5.3020804@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Mark Lord wrote:
> 
>> +    if ((qc->ap->flags & ATA_FLAG_SLAVE_POSS))
> 
> kill the extra parens

No.  Those parens are needed, to help gcc distinguish between
a common programming error and intentional use of "&" rather than "&&".

 > +        tf->command = qc->dev->devno ?
 > +            (tf->command | ATA_DEV1) : (tf->command & ~ATA_DEV1);

But I could kill *those* extran parens, while I do s/command/device/ .

Cheers
