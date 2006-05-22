From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_mv: endian annotations
Date: Mon, 22 May 2006 19:16:33 -0400
Message-ID: <44724651.9070605@pobox.com>
References: <20060521115116.GG7930@mipter.zuzino.mipt.ru> <44715C16.5070600@pobox.com> <200605221856.18673.liml@rtr.ca> <200605221902.03541.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:24482 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751010AbWEVXQi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2006 19:16:38 -0400
In-Reply-To: <200605221902.03541.liml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-ide@vger.kernel.org

Mark Lord wrote:
> On Monday 22 May 2006 18:56, Mark Lord wrote:
>> On Monday 22 May 2006 02:37, Jeff Garzik wrote:
>>> Alexey Dobriyan wrote:
>>>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>>> Unless Mark objects, I'll merge this into #upstream (2.6.18) soon.
>>>
>>> 	Jeff
>> Well, if we're going to use the endian annotation types,
>> then we may as well mark *all* of the __le* hardware fields,
>> not just a few of them.
>>
>> Thus, this extended version of Alexey's original patch:
> 
> Okay, for real this time:
> 
> Signed-off-by: Mark Lord <liml@rtr.ca>

Thanks, it's in my 'Pending' folder now.

If you would, install sparse and make sure 'make check' (kernel makefile 
target) continues to be happy with sata_mv.  That's largely what the 
endian types are for -- advanced source analysis tools like sparse.

	Jeff



