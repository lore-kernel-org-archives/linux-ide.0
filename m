From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA ATAPI UDMA - first in Linux
Date: Fri, 14 May 2004 16:05:23 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A52683.8050604@pobox.com>
References: <1084563800.8752.53.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3521 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262459AbUENUFg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 16:05:36 -0400
In-Reply-To: <1084563800.8752.53.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> Google etc. tells me noone on Earth has yet massively distributed a host
> that speaks SATA ATAPI UDMA.
> 
> SATA ATAPI I find.
> SATA UDMA I find.
> ATAPI UDMA I find.
> 
> SATA ATAPI UDMA I do not find.
> 
> Not yet in Linux, Mac OS X, Windows, etc.
> 
> If you know different, please speak up, else I'll believe the SATA ATAPI
> UDMA Linux work now happening here will be the first such public work.


Windows and Linux have both supported SATA ATAPI -- which implicitly 
includes UDMA from looking at the bridges -- for a while now, in various 
  OS drivers.

If you have an ICH5 or Silicon Image 3112, I bet you could use your 
ATAPI device using the existing Linux IDE driver...

	Jeff



