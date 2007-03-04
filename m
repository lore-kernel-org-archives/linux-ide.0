From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH/RFC]: recovery from power-up-in-standby feature
Date: Sun, 04 Mar 2007 17:04:54 -0500
Message-ID: <45EB4286.7040108@rtr.ca>
References: <45EB2F6D.7050407@rtr.ca> <20070304223206.65195c66@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1607 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbXCDWE4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Mar 2007 17:04:56 -0500
In-Reply-To: <20070304223206.65195c66@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> (2) The more common method is for the drive to require an explicit
>> set-features "spin-up" subcommand after the IDENTIFY.
> 
> I notice there is no ATA version check - was this feature in all versions
> of ATA ?

No, the feature was not in early versions.
But it is not entirely clear to me that the version information
is actually guaranteed to be present in all cases before the
drive has spun-up.

Instead, the standards seem to be relying upon detection of
the "power up in standby" signature values.

The signature word (2) has been "reserved" from ATA1 onward,
and the only assigned uses thus far are for the specific signatures
that this patch looks for.

Cheers
