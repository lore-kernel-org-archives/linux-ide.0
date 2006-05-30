From: Jeff Garzik <jeff@garzik.org>
Subject: Re: jgarzik and max-sectors: out of memory
Date: Tue, 30 May 2006 00:58:37 -0400
Message-ID: <447BD0FD.1000200@garzik.org>
References: <4478AA6C.5070305@garzik.org> <200605272243.41832.axboe@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:17126 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750963AbWE3E6k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:58:40 -0400
In-Reply-To: <200605272243.41832.axboe@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, Hannes Reinecke <hare@suse.de>

Jens Axboe wrote:
> Yep lets please do that, I don't think libata ever had any problems with 256 
> sectors other than perhaps a worry that it would break "something" :-)

There were definite bugs in the past with 256 (versus <= 255) sectors...

	Jeff


