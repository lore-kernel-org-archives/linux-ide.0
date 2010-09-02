From: David Miller <davem@davemloft.net>
Subject: Re: WARNINGs because of ide-proc handling
Date: Thu, 02 Sep 2010 15:14:16 -0700 (PDT)
Message-ID: <20100902.151416.242137052.davem@davemloft.net>
References: <20100831205605.GA23636@pengutronix.de>
	<20100901.193332.77341159.davem@davemloft.net>
	<20100902212839.GA20070@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59812
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753000Ab0IBWOA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Sep 2010 18:14:00 -0400
In-Reply-To: <20100902212839.GA20070@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: w.sang@pengutronix.de
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

From: Wolfram Sang <w.sang@pengutronix.de>
Date: Thu, 2 Sep 2010 23:28:39 +0200

> Dunno, if it is correct, though. The strange thing is that the code is like
> this for two years and, surprisingly, I don't see the problem with 2.6.33.
> Also, the proc-entry for my hard-disk is fine. I can't see any suspicious
> commits in the ide-directory except maybe the BKL pushdown had a side-effect
> regarding the serialization of the sequence? Ah, too late today to seriously
> think about such issues...

I don't think it's the BKL pushdown, it seems it would be due to something
else to me.

Thanks for your analysis and suggested patch, I'll take a look at this.
