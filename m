From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH ide] : Increase WAIT_DRQ to support slow CF cards
Date: Mon, 26 Oct 2009 17:45:25 -0700 (PDT)
Message-ID: <20091026.174525.154760254.davem@davemloft.net>
References: <20091026162011.GA3289@frolo.macqel>
	<4AE64031.5060105@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:35400
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755633AbZJ0ApB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Oct 2009 20:45:01 -0400
In-Reply-To: <4AE64031.5060105@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hancockrwd@gmail.com
Cc: phdm@macqel.be, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Robert Hancock <hancockrwd@gmail.com>
Date: Mon, 26 Oct 2009 18:34:57 -0600

> This has come up before:
> 
> http://marc.info/?l=linux-ide&m=123064513313466&w=2
> 
> I think this timeout should not even exist. libata has no such timeout
> (only the overall command completion timeout), and I can't find any
> reference in current ATA specs to the device being required to raise
> DRQ in any particular amount of time.

So is the issue that, whilst we should wait for BUSY to clear,
waiting around for DRQ is unreasonable?

It seems that WAIT_DRQ is passed to ide_wait_stat() but that
only controls how long we wait for BUSY to clear, the ATA_DRQ
'bad' bit we pass there only gets probed in a fixed limit loop:

	for (i = 0; i < 10; i++) {
		udelay(1);
		stat = tp_ops->read_status(hwif);

		if (OK_STAT(stat, good, bad)) {
			*rstat = stat;
			return 0;
		}
	}
	*rstat = stat;
	return -EFAULT;

Therefore, if increasing WAIT_DRQ helps things for people, it's
because the BUSY bit needs that much time to clear in these
cases.

The talking in that thread seems to state that the ATA layer
waits only for BUSY to clear, it does not wait for DRQ.  But
from the data we're seeing here, it is in fact BUSY which needs
so much more time to clear so removing the DRQ bit probe to
be more like ATA won't fix anything.
