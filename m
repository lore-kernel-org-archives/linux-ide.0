From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] pcmcia: add CNF-CDROM-ID for ide/pata
Date: Thu, 06 Aug 2009 13:24:13 -0700 (PDT)
Message-ID: <20090806.132413.156910755.davem@davemloft.net>
References: <1248625649-7193-1-git-send-email-w.sang@pengutronix.de>
	<20090806131642.GD3154@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:34365
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756181AbZHFUYE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Aug 2009 16:24:04 -0400
In-Reply-To: <20090806131642.GD3154@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: w.sang@pengutronix.de
Cc: linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, jeff@garzik.org

From: Wolfram Sang <w.sang@pengutronix.de>
Date: Thu, 6 Aug 2009 15:16:42 +0200

> as Jeff already picked up the pata part of this patch, I wondered how to
> proceed with the ide-cs-part. Will you pick it up for .31 or .32 or should it
> go via the pcmcia-tree (which will make its next pull-request for .32)?

Please just make a fresh submission of just the IDE part and I'll
apply it, thanks!
