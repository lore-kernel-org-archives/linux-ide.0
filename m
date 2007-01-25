From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: implement HDIO_GET_IDENTITY
Date: Thu, 25 Jan 2007 00:14:57 -0500
Message-ID: <45B83CD1.9010801@rtr.ca>
References: <20070102111849.GD10987@htj.dyndns.org> <20070102111940.GE10987@htj.dyndns.org> <20070102112007.GF10987@htj.dyndns.org> <45B80666.3090708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4816 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933238AbXAYFO7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jan 2007 00:14:59 -0500
In-Reply-To: <45B80666.3090708@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> 'hdparm -I' doesn't work with ATAPI devices and sg_sat is not widely
>> spread yet leaving no easy way to access ATAPI IDENTIFY data.
>> Implement HDIO_GET_IDENTITY such that at least 'hdparm -i' works.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> applied

This patch is not necessary -- The SG_IO/ATA16 support patches replace it.

I believe Tejun and I were in agreement that proper
ATA16 support for ATAPI was the better way to go.

I'll regenerate that one last (boot/modparm) patch
that failed on upstream for you -- later this week.

Cheers
