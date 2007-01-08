From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH libata #promise-sata-pata] sata_promise: unbreak 20619
Date: Sun, 07 Jan 2007 20:46:13 -0500
Message-ID: <45A1A265.20504@garzik.org>
References: <200701062031.l06KV64q022234@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51497 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030430AbXAHBqP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Jan 2007 20:46:15 -0500
In-Reply-To: <200701062031.l06KV64q022234@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> The PATA support patch for sata_promise appears, from
> code inspection, to break the PATA-only 20619 chip.
> 
> The patch removes the SATA flag from the TX2plus SATA+PATA
> boards' common flags, with the intention of adding it back
> via the _port_flags[] entries for those boards' SATA ports.
> 
> However, it unconditionally marks ports 0 and 1 as SATA
> for all boards. This causes the 20619 (TX4000) to announce
> its first two PATA ports as SATA | ATA_FLAG_SLAVE_POSS.
> 
> I don't have a TX4000 so I don't know what the actual
> consequences of this bug are, but surely this isn't Ok.
> 
> Fixed by moving the port 0 and 1 settings as SATA into
> the TX4 and TX2plus specific initialisation code.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Given that I agree with your RFC, this means I can drop all these 
#promise-sata-pata patches, and kill the #promise-sata-pata branch soon, 
right?

	Jeff



