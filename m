From: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [RFT] hpt366: reset DMA state machine on timeouts
Date: Fri, 22 Jun 2007 11:03:06 -0500
Message-ID: <20070622160306.GF8840@austin.ibm.com>
References: <200706212154.47398.sshtylyov@ru.mvista.com> <20070622151359.GD8840@austin.ibm.com> <20070622165431.3b4997f7@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:56515 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756279AbXFVQDI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jun 2007 12:03:08 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5MG38nJ029579
	for <linux-ide@vger.kernel.org>; Fri, 22 Jun 2007 12:03:08 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5MG371h144938
	for <linux-ide@vger.kernel.org>; Fri, 22 Jun 2007 10:03:07 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5MG373e014293
	for <linux-ide@vger.kernel.org>; Fri, 22 Jun 2007 10:03:07 -0600
Content-Disposition: inline
In-Reply-To: <20070622165431.3b4997f7@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Fri, Jun 22, 2007 at 04:54:31PM +0100, Alan Cox wrote:
> >    I'm not sure what to do if this had been the only disk in the system.
> >    Maybe if the eror reate exceed 100/minute, then dma is turned off 
> >    permanently?
> 
> Turn off UDMA and you turn off cable side error protection, so if your
> error is caused by noise you just did the electronic version of a long
> walk off a short pier.

Right. Yes. Clearly, I must be debugging with half a brain, here.

--linas
