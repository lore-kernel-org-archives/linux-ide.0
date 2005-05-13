From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [rfc/patch] libata -- port configurable delays
Date: Fri, 13 May 2005 19:07:25 -0400
Message-ID: <4285332D.1060808@pobox.com>
References: <20050513185850.GA5777@kvack.org> <4284FC6E.7060300@pobox.com>	 <20050513200312.GA6555@kvack.org> <1116021178.20545.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:47503 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262433AbVEMXHi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 May 2005 19:07:38 -0400
In-Reply-To: <1116021178.20545.3.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Alan Cox wrote:
>>>4) It may be worthwhile to rewrite the loop to check the Status register 
>>>_first_, then delay.
> 
> 
> The 400nS delay after a command is required before status becomes valid.
> This isn't about 'incorrect' devices in the command case. It is about
> strictly correct behaviour and propogation/response times. For the cases
> its not required and you wan to keep PCI load down then checking first
> is clearly logical.

The 400nS delay isn't the one in the loop.  I was referring to the other 
delay.

Putting the Status register read first will also flush out any posted 
writes, before delaying, and potentially exit more rapidly if the device 
is immediately ready.

	Jeff


