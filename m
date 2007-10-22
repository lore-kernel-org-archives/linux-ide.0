From: Mark Lord <liml@rtr.ca>
Subject: Re: ATA tape drive STT3401A needs DRQ HSM workaround too
Date: Mon, 22 Oct 2007 10:18:08 -0400
Message-ID: <471CB120.2010108@rtr.ca>
References: <471C6C44.2030607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2503 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354AbXJVOSK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2007 10:18:10 -0400
In-Reply-To: <471C6C44.2030607@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Albert Lee <albertcc@tw.ibm.com>

Tejun Heo wrote:
> Hello, all.
> 
> There was a bug report involving ATA tape drive STT3401A and the drive
> also sets DRQ with device error and works correctly if the check is
> ignored.  I saw patch implementing needed horkage.  What's the plan
> here?  Blacklist all tape drives or individual ones as they come up?

Speaking of which, I haven't yet tossed my ATAPI tape drive into the rubbish.

Anyone want it?  Free, tapes included!

-ml
