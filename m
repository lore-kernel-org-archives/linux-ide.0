From: Brad Campbell <brad@wasp.net.au>
Subject: Re: libata dev_config call order wrong.
Date: Sun, 29 Aug 2004 21:47:56 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <413216CC.5080100@wasp.net.au>
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:43677 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S268246AbUH2RrV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Aug 2004 13:47:21 -0400
In-Reply-To: <41321288.4090403@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> 
> Take a look at what ATA_DFLAG_LOCK_SECTORS does ;-)  Here's hoping 
> that's the last piece of the puzzle...

HAHA! He says. That was not in 2.6.8.1! That solves that one.

Frankly, now I'm running a WD2500BB on one of those converters on a RAID-5 I'm just going to leave 
the 200 sector hack in my kernel until we figure out a way to detect the bridges. I can't see any 
other clean way of doing it.

> BTW I just sent email to SiI to see if there is a way to detect a 
> PATA->SATA bridge.

Man I hope so.. I don't want to resort to having to throw these board away or constantly patch my 
kernel! I could just go and buy some more SATA drives I guess, but where would the fun be in that!

Oh well. I'm far more familiar with the libata, scsi and block layer internals now. And I can muddle 
my way through bk. *PLUS* I did not actually lose any data, so it's all been good really.

I'm almost tempted to buy some of the other bridges on the market to see if the exhibit the same 
behaviour. The data I can find on these Sil chips makes no mention of any limitations (mind you the 
data I can find is pretty poor all round)

Cheers for all the encouragement.

If your ever flying through Dubai, stop in for a beer :p)

Regards,
Brad
