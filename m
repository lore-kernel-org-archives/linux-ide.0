From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_sil: Greatly improve DMA support
Date: Sat, 19 May 2007 17:31:11 -0400
Message-ID: <464F6C9F.4060503@garzik.org>
References: <fa.SqfRJHzGgf3m6sdJPwJTwHDPSuw@ifi.uio.no> <464F2D83.6000506@shaw.ca> <464F6BB1.9050609@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58248 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754709AbXESVbN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 May 2007 17:31:13 -0400
In-Reply-To: <464F6BB1.9050609@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>

Jeff Garzik wrote:
> rotfl.  Boy am I dumb.  I -thought- my patch, written months ago, 
> included that bit.  But obviously it does not.  Let's add that...

Or not.  It just gets rid of the 64k boundary -and- allows for larger 
scatter/gather entries.  LBT does not add 64-bit DMA support.

That answers that :)  Thanks for poking me to take a trip down memory 
lane...

	Jeff


