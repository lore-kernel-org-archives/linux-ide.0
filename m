From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] 2.6.17-rc5: the latest consensus libata resume fix
Date: Sun, 28 May 2006 22:43:43 -0400
Message-ID: <447A5FDF.1080205@rtr.ca>
References: <200605272245.30108.axboe@suse.de> <Pine.LNX.4.64.0605271716030.5623@g5.osdl.org> <4478F681.8050607@garzik.org> <200605281128.00532.liml@rtr.ca> <20060528171424.GA12982@suse.de> <4479F487.5080507@garzik.org> <4479F76D.40506@rtr.ca> <447A03CC.50300@garzik.org> <20060528222832.GA26918@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:34446 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751117AbWE2Cnp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 May 2006 22:43:45 -0400
In-Reply-To: <20060528222832.GA26918@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
>
> Mark is right, ATA_BUSY alone does _not_ work for me. I agree it's a
> little odd based on the printk output, it must be a timing thing.

I think maybe your drive is doing something like this ("B"==BUSY, "D"==DRQ):

BBBDDBBBBBB

Where the first couple of BBB last less than 10usec.

Cheers
