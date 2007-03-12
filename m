From: "Paul Rolland" <rol@as2917.net>
Subject: RE: [git patches] libata fixes
Date: Mon, 12 Mar 2007 09:00:54 +0100
Message-ID: <001b01c7647c$921ced00$4b00a8c0@donald>
References: <45F4F30F.9010603@gmail.com>
Reply-To: <rol@as2917.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tag.witbe.net ([81.88.96.48]:52724 "EHLO tag.witbe.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965283AbXCLIB1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Mar 2007 04:01:27 -0400
In-Reply-To: <45F4F30F.9010603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>, 'Linus Torvalds' <torvalds@linux-foundation.org>
Cc: 'Jeff Garzik' <jeff@garzik.org>, 'Alan Cox' <alan@redhat.com>, 'Andrew Morton' <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "'Eric D. Mudama'" <edmudama@gmail.com>

Hello,

> It involves a long timeout, so it's bothersome.  This is caused by
> Silicon Image 4726/3726 storage processor (SATA Port Multiplier with
> extra features) attached to one of the ICH ports.

Yes, I think this is the part Asus is using for it's EZ-Raid feature
on this motherboard, and they seem to like their EZ-Raid, so it's likely
to become more and more common.
 
> If the first  downstream port in the PMP is empty and it gets reset in
I confirm it is empty in my config.

> work very well with the current ATA reset sequence and gets identified
> only after a few failures thus causing long timeout.
30s to 1min ;(
 
> I keep forgetting about this.  I'll ask SIMG how to deal with 
> this.  For
> the time being, connecting a device to the PMP port should remove the
> timeouts.

That sounds a quite expensive solution ;)

Paul

