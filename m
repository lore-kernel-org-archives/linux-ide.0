From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 01/12] sata_mv more cosmetic changes
Date: Tue, 06 May 2008 13:57:16 -0400
Message-ID: <48209BFC.9010401@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca> <482066DB.7000609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3527 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764891AbYEFR5S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 13:57:18 -0400
In-Reply-To: <482066DB.7000609@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> -- add missing _OFS to tails of register offset definitions.
> 
> 
> bleh.  from the department of redundant redundancies :)  Those types of 
> constants are usually either register bits or register offsets, and from 
>  reading the code it is always clear which is which.  IMO, _OFS is 
> redundant.
..

Heh.. that's actually my opinion, too.

But the original authors seemed to use _OFS in many places,
so I'm just trying to create some consistency from it all.  ;)

Cheers
