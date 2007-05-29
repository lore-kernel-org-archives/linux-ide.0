From: Jeff Garzik <jeff@garzik.org>
Subject: Re: cirrus ep93xx pata driver
Date: Mon, 28 May 2007 21:27:10 -0400
Message-ID: <465B816E.5060407@garzik.org>
References: <44FC0779.9030405@garzik.org> <20060921115533.GA26960@xi.wantstofly.org> <4513B21A.30507@garzik.org> <20070128202117.GA6147@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49516 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbXE2B1N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 May 2007 21:27:13 -0400
In-Reply-To: <20070128202117.GA6147@xi.wantstofly.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-ide@vger.kernel.org

I know it's probably a low priority, but could you rediff this against 
the current libata?

I'm wondering where we are in terms of hooks that you need.  Since you 
posted this we added some hooks for the pata_scc driver, most notably 
->irq_on() hooks.  And other code you modify, such as the 
ata_bus_reset() function, is slated for deletion once all drivers have 
been converted over to the new EH (done, in testing).

I'm betting libata-core only has a little way to go before pata_ep93xx 
will work.

	Jeff



