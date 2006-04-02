From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Spradic device disconnections
Date: Sun, 02 Apr 2006 07:33:51 -0400
Message-ID: <442FB69F.30000@pobox.com>
References: <20060401145006.GA6504@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:30848 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932312AbWDBLd4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 07:33:56 -0400
In-Reply-To: <20060401145006.GA6504@localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Aloni <da-x@monatomic.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, Mark Lord <lkml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>, sander@humilis.net, dror@xiv.co.il

Dan Aloni wrote:
> Mar 31 10:41:12 14.10.240.6 kernel: ata12: no device found (phy stat 00000101) 

Well, with 0x101, the hardware is telling us "device presence detected, 
but phy communications not yet established"

So, my first instinct would be to look at __mv_phy_reset() code block 
just above the comment /* work around errata */, and increase the length 
of the timeout from 200ms to 1-5 seconds.

My second instinct would be to increase the number of retries from 5.

	Jeff


