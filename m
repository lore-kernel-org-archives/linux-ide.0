From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] AVR32 PATA driver
Date: Tue, 07 Aug 2007 14:14:27 -0400
Message-ID: <46B8B683.6060000@garzik.org>
References: <200708071126.08735.kngregertsen@norway.atmel.com> <200708071127.09751.kngregertsen@norway.atmel.com> <20070807165409.4c2a4451@the-village.bc.nu> <200708071939.34266.gregerts@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43589 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934290AbXHGSPG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Aug 2007 14:15:06 -0400
In-Reply-To: <200708071939.34266.gregerts@stud.ntnu.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristoffer Nyborg Gregertsen <gregerts@stud.ntnu.no>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>, linux-ide@vger.kernel.org

Kristoffer Nyborg Gregertsen wrote:
> On Tuesday 07 August 2007 17:54:09 Alan Cox wrote:
>>  +static int pata_at32_get_pio_mask(void)
>>
>>> +{
>>> +	switch (max_pio) {
>>> +	case 0:
>>> +		return 0x01;
>>> +	case 1:
>>> +		return 0x03;
>>> +	case 2:
>>> +		return 0x07;
>>> +	case 3:
>>> +		return 0x0f;
>>> +	case 4:
>>> +		return 0x1f;
>>> +	default:
>>> +		return 0x01;
>> What is wrong with just using  (1 << max_pio) - 1 as the range is only
>> 0-4 anyway.
> 
> Since max_pio is a module argument it may be invalid. Perhaps:
> 
> if (0 <= max_pio && max_pio <= 4)
> 	return (1 << max_pio) - 1;
> else
> 	return 0x01;
> 
> Or is it common to trust the module arguments to be sane?

Well, a higher level issue, you should not have a max_pio module 
parameter at all.  Other drivers do not have such a thing.

	Jeff



