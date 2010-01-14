From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide/ide-cs: fix order of releasing resources
Date: Thu, 14 Jan 2010 01:59:38 -0800 (PST)
Message-ID: <20100114.015938.224705378.davem@davemloft.net>
References: <1263324894-28117-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53379
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754938Ab0ANJ73 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2010 04:59:29 -0500
In-Reply-To: <1263324894-28117-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: w.sang@pengutronix.de
Cc: linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux@dominikbrodowski.net, bzolnier@gmail.com

From: Wolfram Sang <w.sang@pengutronix.de>
Date: Tue, 12 Jan 2010 20:34:54 +0100

> ide_detach() called first ide_release() and then release_region(). This
> produced the following warnings:
> 
>   Trying to free nonexistent resource <000000000000c10e-000000000000c10e>
>   Trying to free nonexistent resource <000000000000c100-000000000000c107>
> 
> This is true, because the callchain inside ide_release() is:
> 
>   ide_release -> pcmcia_disable_device -> pcmcia_release_io
> 
> So, the whole io-block is already gone for release_region(). To fix
> this, just swap the order of releasing (and remove the now obsolete
> shadowing).
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Applied, thanks a lot!
