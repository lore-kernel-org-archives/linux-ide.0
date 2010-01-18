From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide/ide-cs: fix order of releasing resources
Date: Sun, 17 Jan 2010 18:59:24 -0800 (PST)
Message-ID: <20100117.185924.13978043.davem@davemloft.net>
References: <201001141650.17348.bzolnier@gmail.com>
	<20100115.013117.223126399.davem@davemloft.net>
	<20100116185124.GA7040@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36077
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751116Ab0ARC7P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Jan 2010 21:59:15 -0500
In-Reply-To: <20100116185124.GA7040@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: w.sang@pengutronix.de
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux@dominikbrodowski.net

From: Wolfram Sang <w.sang@pengutronix.de>
Date: Sat, 16 Jan 2010 19:51:24 +0100

>> > bzolnier:
>> > - release resources in ide_release() to fix ordering of events
>> > - remove stale FIXME note while at it
>> 
>> Ok this does look better, Wolfram can you test this?
> 
> Works as expected.

Great, thanks for testing.
