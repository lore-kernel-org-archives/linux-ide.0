From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add human-readable error value decoding
Date: Thu, 10 May 2007 19:47:37 -0400
Message-ID: <4643AF19.5080309@garzik.org>
References: <46428103.3040003@shaw.ca> <4642E92D.5010509@gmail.com> <46431D19.1070308@rtr.ca> <46434AE5.8060605@garzik.org> <46438FAC.1030702@rtr.ca> <464391B3.7040708@garzik.org> <4643AB76.1000408@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33699 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409AbXEJXrm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 May 2007 19:47:42 -0400
In-Reply-To: <4643AB76.1000408@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Robert Hancock wrote:
> I don't think this is as big of a deal here as in other cases, like oops 
> output. With libata errors, if they're at the console (which they'd have 
> to be to see these messages), unless something has actually caused a 
> panic the scrollback buffer should still be functional and they'd be 
> able to see the entire output..


Scrollback rarely works as planned, for me.  Overall, a balance must be 
found.

More information is more helpful.  But.

There are downsides to spewing everything possible, upon error.  You 
cause logging to the possibly problematic disk, you push older messages 
out of the printk ring buffer, etc., etc.

	Jeff


