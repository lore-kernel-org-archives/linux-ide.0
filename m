From: Mark Lord <liml@rtr.ca>
Subject: Re: libata-eh/pmp command sequence on NCQ media error
Date: Wed, 30 Apr 2008 22:45:41 -0400
Message-ID: <48192ED5.9030402@rtr.ca>
References: <480F9D29.4070603@rtr.ca> <480FF229.2060808@rtr.ca> <481168FA.5020709@pobox.com> <4811E2FB.4040100@rtr.ca> <48120269.8020101@gmail.com> <4818E5B2.1040801@rtr.ca> <4818E73D.9070201@rtr.ca> <48191422.30409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2552 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989AbYEACpo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Apr 2008 22:45:44 -0400
In-Reply-To: <48191422.30409@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
>>> So why are we taking a hammer to things there?
> 
> Hmmm... The reset action might be too heavy handed but maybe keeping 
> that categorized as ATA bus error is still a good idea so that multiple 
> errors w/ that bit set can trigger speed down.
> 
>> FWIW, this patch fixes it for me (and fixes a misleading printk).
>> Or I could just clear that bit from sata_mv before invoking EH.
>> (??)
> 
> Does the bit get set for the host link or pmp fanout links?
..

It's only on the pmp fanout link. 
Dunno why it gets set, but it does.

Cheers

