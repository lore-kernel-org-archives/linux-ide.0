From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH ide] : Increase WAIT_DRQ to support slow CF cards
Date: Mon, 26 Oct 2009 18:19:22 -0700 (PDT)
Message-ID: <20091026.181922.261475236.davem@davemloft.net>
References: <4AE64031.5060105@gmail.com>
	<20091026.174525.154760254.davem@davemloft.net>
	<51f3faa70910261807h54f05f73j48b67067ee3dde70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:48335
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755503AbZJ0BS7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Oct 2009 21:18:59 -0400
In-Reply-To: <51f3faa70910261807h54f05f73j48b67067ee3dde70@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hancockrwd@gmail.com
Cc: phdm@macqel.be, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Robert Hancock <hancockrwd@gmail.com>
Date: Mon, 26 Oct 2009 19:07:18 -0600

> libata only busy-waits for 50 microseconds, if not set then it sleeps
> for 2ms and polls for another 10 microseconds, if still not set it
> tries the whole thing again at 16ms intervals. Only after (typically)
> 30 seconds does it give up.

Porting that kind of logic over to IDE is a non-starter.

It's easier to get people to move over to using the ATA layer for
their devices.

Meanwhile we should provide a way for things to work, and
realistically the only way to do that currently is to bump the
WAIT_DRQ value to some large number.

And that's exactly the kind of patch I'm willing to accept for this.
