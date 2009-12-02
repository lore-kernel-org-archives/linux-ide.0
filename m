From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple
 PowerMac/PowerBook IDE controller
Date: Wed, 02 Dec 2009 11:00:27 +1100
Message-ID: <1259712027.2076.1055.camel@pasglop>
References: <20091201070834.6A840B7B63@ozlabs.org>
	 <4B14CD22.4020806@kernel.org> <1259709552.2076.1053.camel@pasglop>
	 <4B15A67C.2030102@kernel.org> <1259710543.2076.1054.camel@pasglop>
	 <4B15AA4F.5040309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39591 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754717AbZLBABQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 19:01:16 -0500
In-Reply-To: <4B15AA4F.5040309@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Jeff Garzik <jeff@garzik.org>, Holger Macht <hmacht@suse.de>

On Wed, 2009-12-02 at 08:44 +0900, Tejun Heo wrote:
> > BTW. For a plug event, what should I do ? freeze is fine ? Or just
> > schedule eh ? Right now, when plugging I see an exception Emask 0x10
> > etc... message in the log when plugging which isn't totally nice :-)
> 
> freeze() and please don't fight the EH messages from low level driver.
> If it's too much, we need to update core layer but given the variety
> of phy related bugs, I think we need those messages.

Eh, ok :-) No biggie.

Cheers,
Ben.


