From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2/2] sata_mv: remove iounmap in mv_platform_remove
Date: Thu, 14 Feb 2008 14:40:40 -0500
Message-ID: <47B49938.8090709@rtr.ca>
References: <12029369502995-git-send-email-saeed@marvell.com>	 <12029369532977-git-send-email-saeed@marvell.com>	 <47B345A6.9000605@pobox.com>	 <c70ff3ad0802140456v50e0b0faj2c2b1f7d11c60fc5@mail.gmail.com>	 <47B46FA4.4070606@rtr.ca> <c70ff3ad0802141033g712be583p3d4a0269568803c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3772 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbYBNTkn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Feb 2008 14:40:43 -0500
In-Reply-To: <c70ff3ad0802141033g712be583p3d4a0269568803c6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Saeed Bishara <saeed@marvell.com>, jeff@garzik.org, htejun@gmail.com, linux-ide@vger.kernel.org, nico@cam.org, byron.bbradley@gmail.com

saeed bishara wrote:
>>  Mmm.. sounds like a bug to me.  Possibly two bugs:
>>
>>  1. the ioremap() should fail if the range is already mapped, and
>>  2. we should free the resources on module unload.
>>
>>  I suppose this would be mostly automatic if the code simply
>>  were to use devm_ioremap() instead of ioremap().
> my understanding for the /proc/iomem was totaly wrong..
> the ioremap() actually allocated different address each time,
..

Good.  That makes a lot more sense.

> I don't know if should fail if the range is already mapped,
> but maybe the name (remap) hints that it is shouldn't.
> anyway, I replaced ioremap with devm_ioremap and it looks fine. I'll
> send the new patch in different email.
..

I think that the code should first call devm_request_region()
to reserve the ioports -- this will then fail if the ports are in-use.
After success there, it should then call devm_ioremap(),
which gives a virtual address back (the "remap" part) for use within the kernel.

Cheers
