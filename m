From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 16:51:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611281650280.4244@woody.osdl.org>
References: <456CB72A.3010004@local.se> <Pine.LNX.4.64.0611281444330.4244@woody.osdl.org>
 <456CC4C5.6090003@garzik.org> <Pine.LNX.4.64.0611281531550.4244@woody.osdl.org>
 <456CD67C.8050909@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:38883 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1755138AbWK2Aw2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 19:52:28 -0500
In-Reply-To: <456CD67C.8050909@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jonas Lundgren <jonas@local.se>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org



On Tue, 28 Nov 2006, Jeff Garzik wrote:
> 
> ap->host (struct ata_host) already has a spinlock for precisely just that...
> :)

Right, but do we actually take it? I'm not seing any spin_lock's in 
ata_piix.c, but I don't know the SATA layers enough to say whether upper 
layers take it or not..

		Linus
