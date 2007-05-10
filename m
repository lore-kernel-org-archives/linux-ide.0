From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add human-readable error value decoding
Date: Thu, 10 May 2007 17:42:11 -0400
Message-ID: <464391B3.7040708@garzik.org>
References: <46428103.3040003@shaw.ca> <4642E92D.5010509@gmail.com> <46431D19.1070308@rtr.ca> <46434AE5.8060605@garzik.org> <46438FAC.1030702@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60632 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758908AbXEJVmP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 May 2007 17:42:15 -0400
In-Reply-To: <46438FAC.1030702@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Mark Lord wrote:
> If we're compiling the messages into the kernel regardless,
> then it doesn't really make much sense to NOT show all of them
> on the error paths.


Not true.  Uncontrolled message spewage inevitably results in critical 
information scrolling off the screen, before a user can take a digital 
photo of the output...  Or of users being confused by subsequent error 
fallout (i.e. multiple oopses reporting problem).

Moderation and restraint still have roles to play...  :)

	Jeff




