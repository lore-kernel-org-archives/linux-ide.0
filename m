From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv: endian annotations
Date: Mon, 22 May 2006 18:58:02 -0400
Message-ID: <447241FA.6070101@rtr.ca>
References: <20060521115116.GG7930@mipter.zuzino.mipt.ru> <44715C16.5070600@pobox.com> <200605221856.18673.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:44446 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750751AbWEVW6D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2006 18:58:03 -0400
In-Reply-To: <200605221856.18673.liml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-ide@vger.kernel.org

Mark Lord wrote:
> On Monday 22 May 2006 02:37, Jeff Garzik wrote:
>> Alexey Dobriyan wrote:
>>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>> Unless Mark objects, I'll merge this into #upstream (2.6.18) soon.
>>
>> 	Jeff
> 
> Well, if we're going to use the endian annotation types,
> then we may as well mark *all* of the __le* hardware fields,
> not just a few of them.
> 
> Thus, this extended version of Alexey's original patch:
> 
..

Scrub that.. I'll redo it and repost shortly, after gcc finishes with it.

-ml
