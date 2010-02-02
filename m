From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 00/68] ide2libata
Date: Tue, 02 Feb 2010 15:19:00 -0800 (PST)
Message-ID: <20100202.151900.211475917.davem@davemloft.net>
References: <20100201125845.3f468363@lxorguk.ukuu.org.uk>
	<20100201.051432.226757615.davem@davemloft.net>
	<4B68B0CF.1040907@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37500
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751298Ab0BBXSs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Feb 2010 18:18:48 -0500
In-Reply-To: <4B68B0CF.1040907@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Jeff Garzik <jeff@garzik.org>
Date: Tue, 02 Feb 2010 18:10:07 -0500

> But hey...  if you want to accept patches slowly turning IDE into
> libata, that's your call :) It just seems quite contrary to what has
> been sold to the remaining IDE users.

What I said back then was based upon the presumption that
the drivers has a small tester base, thus any change to
any particular driver isn't likely to get much testing.

If the drivers get truly shared between IDE and ATA, that
presumption is entirely removed, the ATA testers will
be hitting the same driver code that whatever remaining
IDE users will be.

So if the sharing can be done in a sane manner, I'm OK
with that kind of plan.

What Bart has posted with all of the ifdefs and stuff,
I've stated over and over I don't agree with and don't
think is sane.

Doing it by making the data structures actually be the
same, and not using any ifdefs, that would be sane to me.
