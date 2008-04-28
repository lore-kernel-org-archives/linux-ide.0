From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_mv performance; impact of NCQ
Date: Mon, 28 Apr 2008 16:07:55 -0400
Message-ID: <48162E9B.2030400@garzik.org>
References: <20080426001657.GD17369@modernduck.com> <da824cf30804252013l3a62166bk5ef03fb034fd47d5@mail.gmail.com> <20080428171449.GI17369@modernduck.com> <48160C39.6000701@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56744 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765812AbYD1UIB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Apr 2008 16:08:01 -0400
In-Reply-To: <48160C39.6000701@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jody McIntyre <scjody@sun.com>, Grant Grundler <grundler@google.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jody McIntyre wrote:
>>
>> We turn write caching off for data integrity reasons (write reordering
>> does bad things to journalling file systems if power is interrupted -
>> and at the scale of many Lustre deployments, it happens often enough to
>> be a concern.)  I'm also concerned about the effects of NCQ in this area
>> so we'll probably turn it off anyway.
> ..
> 
> I haven't done a detailed examination lately, but..
> 
> Both write-caching and NCQ re-ordering should be safe on Linux.
> The kernel will issue FLUSH_CACHE_EXT commands as required to checkpoint
> data to the disk.

It depends on the fs's use of barriers (or not).

Without barriers, FLUSH CACHE[ EXT] isn't issued very often.

	Jeff



