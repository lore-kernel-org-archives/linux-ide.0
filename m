From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2/2] sata_mv: remove iounmap in mv_platform_remove
Date: Thu, 14 Feb 2008 11:43:16 -0500
Message-ID: <47B46FA4.4070606@rtr.ca>
References: <12029369502995-git-send-email-saeed@marvell.com> <12029369532977-git-send-email-saeed@marvell.com> <47B345A6.9000605@pobox.com> <c70ff3ad0802140456v50e0b0faj2c2b1f7d11c60fc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3040 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754759AbYBNQnS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Feb 2008 11:43:18 -0500
In-Reply-To: <c70ff3ad0802140456v50e0b0faj2c2b1f7d11c60fc5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Mark Lord <mlord@pobox.com>, Saeed Bishara <saeed@marvell.com>, jeff@garzik.org, htejun@gmail.com, linux-ide@vger.kernel.org, nico@cam.org, byron.bbradley@gmail.com

saeed bishara wrote:
>>  > this will fix crash bug when doing rmmod to the driver, this is because the
>>  > port_stop function get called later and it could access the device's registers.
>>  >
>>
>>  Where does the iounmap() now get done instead of that place?
>>
> nowhere, the /proc/iomem still shows that sata_mv uses io mempry after
> the rrmod, but when I re-load the driver, I can see it reuses the same
> io address range. so it doesn't waste io mem  resources.
..

Mmm.. sounds like a bug to me.  Possibly two bugs:

1. the ioremap() should fail if the range is already mapped, and
2. we should free the resources on module unload.

I suppose this would be mostly automatic if the code simply
were to use devm_ioremap() instead of ioremap().

Cheers
