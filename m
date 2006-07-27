From: Mark Lord <liml@rtr.ca>
Subject: Re: PATCH: Add full Compact Flash support to libata
Date: Thu, 27 Jul 2006 13:55:05 -0400
Message-ID: <44C8FDF9.9030205@rtr.ca>
References: <1154016810.13509.61.camel@localhost.localdomain>	 <44C8FAE5.1000400@rtr.ca> <1154023449.13509.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:18883 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751897AbWG0RzH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Jul 2006 13:55:07 -0400
In-Reply-To: <1154023449.13509.71.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, akpm@osdl.org

Alan Cox wrote:
> Ar Iau, 2006-07-27 am 13:41 -0400, ysgrifennodd Mark Lord:
>> Alan Cox wrote:
>>> This is mostly interesting from the embedded end of the universe
>>> where people use the CFA high speed non UDMA modes more. Some generic
>>> controllers can do PIO5 and friends, that will follow later on.
>> Cool.  Do you have one to test with?
> 
> Controller or device ?
> 
> The VIA and ALi controllers can be persuaded to do PIO5 etc with a good
> cable and CF adapter.

Device.  I think I have some controllers here that can be programmed
for similar rates, but mostly I just want a peek at the raw identify
data from a CF device that has some of the new modes.

My Sandisk Extreme-II card does not support them; apparently the
newer Extremem-IV (and perhaps III) cards *do* though.

Cheers
