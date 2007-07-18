From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches 1/2] warnings: attack valid cases spotted by warnings
Date: Tue, 17 Jul 2007 23:29:54 -0400
Message-ID: <469D8932.9080101@garzik.org>
References: <20070717214239.GF28448@devserv.devel.redhat.com>	<ada8x9epuip.fsf@cisco.com> <469D3E66.3010502@garzik.org>	<adamyxuo2w6.fsf@cisco.com>	<alpine.LFD.0.999.0707171954230.27353@woody.linux-foundation.org> <adaejj6o1aw.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52200 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898AbXGRD37 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jul 2007 23:29:59 -0400
In-Reply-To: <adaejj6o1aw.fsf@cisco.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roland Dreier <rdreier@cisco.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, chas@cmf.nrl.navy.mil, rolandd@cisco.com, dwmw2@infradead.org, gregkh@suse.de

Roland Dreier wrote:
> In this case the code is basically
> 
> 	u32 x;
> 
> 	for (n = 0; cond; ++n) {
> 		...
> 		if (!n)
> 			x = something;
> 		...
> 	}
> 
> 	if (n) {
> 		...
> 		use(x);
> 		...
> 	}
> 
> and gcc still warns...


Interestingly, the above accurately describes a common code pattern 
matching code which caused gcc to emit the uninit'd-var warnings.

For the record I think initializating 'f0' to zero is safer for the 
reasons Linus gave, and in addition, f0 is or'd with a value written to 
a hardware register, which means things should go awry (if they go) in a 
semi-predictable manner.

According to the assembly language produced, sure it is larger -- by one 
(per function) MOV that is adjacent to other initializations, making it 
highly likely the initializations are all streamed together.  I doubt 
one MOV per function will make a huge difference, considering the peace 
of mind it buys.

	Jeff


