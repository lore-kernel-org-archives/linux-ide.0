From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] blacklist NCQ on Seagate Barracuda ST380817AS
Date: Sun, 30 Sep 2007 13:26:50 -0400
Message-ID: <46FFDC5A.7070509@rtr.ca>
References: <20070930160548.235be972@localhost>	<20070930152908.1f58d39d@the-village.bc.nu> <20070930164610.20818867@localhost> <46FFBB2D.6060004@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4776 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756056AbXI3R0w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Sep 2007 13:26:52 -0400
In-Reply-To: <46FFBB2D.6060004@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Paolo Ornati <ornati@fastwebnet.it>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Paolo Ornati wrote:
>> On Sun, 30 Sep 2007 15:29:08 +0100
>> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>
>>>> Seagate Barracuda ST380817AS has troubles with NCQ. For example,
>>>> unpacking a tarball on an XFS filesystem gives this:
>>>>
>>>> ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
>>>> ata1.00: cmd 61/40:00:29:a3:98/00:00:00:00:00/40 tag 0 cdb 0x0 data 
>>>> 32768 out
>>>>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)  
>>> What makes you sure that is an NCQ problem ?
>>
>> It goes away with:
>> echo 1 > /sys/block/sda/device/queue_depth
>>
>> I have this problem only with XFS, and even with XFS it goes away
>> mounting with "nobarrier"...
> 
> This last is an interesting datapoint.
> 
> I wonder if libata has a generic problem with NCQ + FLUSH CACHE.

Yeah, that's pretty suspicious.  Prior to issuing a FLUSH_CACHE op,
one must first drain all outstanding NCQ commands (and not issue new ones).

I'm sure the code must *try* to do that, but perhaps there's a bug in there?
Or just another drive bug?

??
