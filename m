From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFT] hpt366: reset DMA state machine on timeouts
Date: Fri, 22 Jun 2007 17:33:02 +0100
Message-ID: <20070622173302.49864a63@the-village.bc.nu>
References: <200706212154.47398.sshtylyov@ru.mvista.com>
	<20070622151359.GD8840@austin.ibm.com>
	<20070622165431.3b4997f7@the-village.bc.nu>
	<20070622160306.GF8840@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60032 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757852AbXFVQ1U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jun 2007 12:27:20 -0400
In-Reply-To: <20070622160306.GF8840@austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

> > Turn off UDMA and you turn off cable side error protection, so if your
> > error is caused by noise you just did the electronic version of a long
> > walk off a short pier.
> 
> Right. Yes. Clearly, I must be debugging with half a brain, here.

Half a brain each so together we can manage ;)

I've had a look at your other traces and while I don't yet know why the
first DMA timed out with the libata driver the rest of the sequence looks
like the same hang as with the old driver. I'll propogate Sergei's fix
across at some point.

Thanks
Alan
