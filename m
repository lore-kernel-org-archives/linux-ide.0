From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA speed. Should be 150 or 133?
Date: Sun, 26 Jun 2005 09:59:12 -0400
Message-ID: <42BEB4B0.8090405@pobox.com>
References: <Pine.LNX.4.62.0506240135340.29382@bizon.gios.gov.pl> <42BB794B.6080109@rtr.ca> <Pine.LNX.4.62.0506241127210.3016@bizon.gios.gov.pl> <42BC284E.7050202@rtr.ca> <Pine.LNX.4.62.0506242032290.1394@bizon.gios.gov.pl> <42BE0B7D.4050307@rtr.ca> <Pine.LNX.4.62.0506261229430.2421@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:38347 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261205AbVFZN7X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 09:59:23 -0400
In-Reply-To: <Pine.LNX.4.62.0506261229430.2421@bizon.gios.gov.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Oledzki <olel@ans.pl>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Krzysztof Oledzki wrote:
> 
> 
> On Sat, 25 Jun 2005, Mark Lord wrote:
> 
>> Krzysztof Oledzki wrote:
>>
>>>
>>> # hdparm -I /dev/sda
>>>
>>> /dev/sda:
>>> (...)
>>>         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 
>>> *udma6
>>> (...)
>>>
>>> This one? udma6?
>>
>>
>> Yup.  udma6 == UDMA/133
> 
> 
> So, how this line would look like for SATA150?

Unchanged.  SATA150 only goes to udma6.

	Jeff



