From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Thu, 29 Nov 2007 23:19:25 -0500
Message-ID: <474F8F4D.6070706@rtr.ca>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468202627-git-send-email-htejun@gmail.com> <20071129160555.38ee2edc@the-village.bc.nu> <474EE561.7010207@gmail.com> <474EE5F8.1030409@gmail.com> <474F0B11.7000205@rtr.ca> <474F4294.9030203@gmail.com> <474F6163.3030500@rtr.ca> <474F68B9.2090203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1046 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184AbXK3ET2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Nov 2007 23:19:28 -0500
In-Reply-To: <474F68B9.2090203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org, albertl@mail.com, jens.axboe@oracle.com

Tejun Heo wrote:
> Mark Lord wrote:
>
>> If I were doing this, I'd probably just do PIO for all non bulk xfer
>> opcodes, same as you, for ease of maintainership.
>>
>> But I'd also think really hard about some way to allow full DMA
>> for chipsets/drives that can be trusted.  Not a whitelist (like Alan,
>> I don't believe in those), but something..
> 
> Does module parameter / sysfs node sound good enough to you?
..

Oooohh.. I *like* the idea of a sysfs attr or two (per drive) for this..

:) 

