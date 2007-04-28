From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sat, 28 Apr 2007 16:50:33 -0400
Message-ID: <4633B399.80101@garzik.org>
References: <4633AB75.7070107@rtr.ca> <4633B0A6.6090705@garzik.org> <4633B235.6060401@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54330 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030684AbXD1Uui (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 16:50:38 -0400
In-Reply-To: <4633B235.6060401@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Actually, I'm not so sure that this problem hasn't *already* been
> posted to this very mailing list.
> 
> http://lkml.org/lkml/2006/10/1/264
> http://www.mail-archive.com/linux-ide@vger.kernel.org/msg05078.html
> ...

What Tejun said at the end of that thread :)

That one is a phy-level problem, when it starts complaining about 
10b-to-8b decode and non-recoverable communication errors.

I'm keeping an open mind, but with the drivers being different from each 
other, I want to see how libata encounters that failure mode in the field.

	Jeff


