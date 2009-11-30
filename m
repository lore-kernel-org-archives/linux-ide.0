From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata PM question
Date: Mon, 30 Nov 2009 16:51:49 +1100
Message-ID: <1259560309.2076.60.camel@pasglop>
References: <1259547765.2076.48.camel@pasglop>
	 <1259547943.2076.50.camel@pasglop> <1259552541.2076.56.camel@pasglop>
	 <4B1341AF.2000208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:49528 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbZK3Fwd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Nov 2009 00:52:33 -0500
In-Reply-To: <4B1341AF.2000208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>


> Looks like the only libata driver that currently does LED blinking is 
> ahci (for external enclosures) and it's just handled there using 
> qc_issue plus a timer. Most drivers don't need this and given that you 
> need to do it only for specific devices and only your driver has that 
> knowledge, I don't see much problem with just sticking the LED trigger 
> call into your qc_issue or something similar. No sense in trying to make 
> something generic if it's not generic..

Ok, thanks. Will stick it in pata_macio for the internal hard disk(s)
only.

Cheers,
Ben.


