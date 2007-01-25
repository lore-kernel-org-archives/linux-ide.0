From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: implement HDIO_GET_IDENTITY
Date: Thu, 25 Jan 2007 02:42:05 -0500
Message-ID: <45B85F4D.40004@pobox.com>
References: <20070102111849.GD10987@htj.dyndns.org> <20070102111940.GE10987@htj.dyndns.org> <20070102112007.GF10987@htj.dyndns.org> <45B80666.3090708@pobox.com> <45B83CD1.9010801@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34828 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965677AbXAYHmP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jan 2007 02:42:15 -0500
In-Reply-To: <45B83CD1.9010801@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> 'hdparm -I' doesn't work with ATAPI devices and sg_sat is not widely
>>> spread yet leaving no easy way to access ATAPI IDENTIFY data.
>>> Implement HDIO_GET_IDENTITY such that at least 'hdparm -i' works.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> applied
> 
> This patch is not necessary -- The SG_IO/ATA16 support patches replace it.
> 
> I believe Tejun and I were in agreement that proper
> ATA16 support for ATAPI was the better way to go.

I like both approaches.  I think direct support of HDIO_GET_IDENTITY can 
reduce the number of failure points, while making old tools work a bit 
better.


> I'll regenerate that one last (boot/modparm) patch
> that failed on upstream for you -- later this week.

Thanks,

	Jeff



