From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: purpose of resetproc() in struct hwif_s
Date: Mon, 08 Dec 2003 10:13:07 +1100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1070838786.11006.39.camel@gaston>
References: <20031207074241.GA188106@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.86.99.235]:22690 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264570AbTLGXOS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Dec 2003 18:14:18 -0500
In-Reply-To: <20031207074241.GA188106@sgi.com>
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: linux-ide@vger.kernel.org


> My question is, what should it be doing?  Is turning shutting off
> DMA and clearing interrupts sufficient if we don't think we need
> to reset the controller?  Could it be harmful?

I added this callback a while back because the winbond was switching
to what seems, according to the (very bad) documentation, some 8
bits only mode when sensing an ATA reset done via the control reg.
You don't _have_ to do anything special if your controller don't
play such tricks, though if you have ways of putting back the controller
to some sane idle state (in case we reset after a DMA failure), it
might be wise to do so. 

Ben.

