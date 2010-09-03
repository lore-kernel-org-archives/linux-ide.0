From: David Miller <davem@davemloft.net>
Subject: Re: WARNINGs because of ide-proc handling
Date: Fri, 03 Sep 2010 05:34:37 -0700 (PDT)
Message-ID: <20100903.053437.68134749.davem@davemloft.net>
References: <20100902212839.GA20070@pengutronix.de>
	<20100902.151416.242137052.davem@davemloft.net>
	<20100903055328.GA11991@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:51289
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751900Ab0ICMeU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Sep 2010 08:34:20 -0400
In-Reply-To: <20100903055328.GA11991@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: w.sang@pengutronix.de
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

From: Wolfram Sang <w.sang@pengutronix.de>
Date: Fri, 3 Sep 2010 07:53:28 +0200

> 
>> Thanks for your analysis and suggested patch, I'll take a look at this.
> 
> Thanks for your help. If we can't find something, I'll just do a bisect this
> weekend.

Frankly, at this point, I'm beginning suspect that the procfs stuff
simply never warned at some point in the past and that the IDE
code has had this problem for a while.
