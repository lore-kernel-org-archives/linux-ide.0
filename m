From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne
 boards
Date: Tue, 13 Jan 2009 13:33:37 +0100
Message-ID: <20090113123337.199060@gmx.net>
References: <20090112233909.221080@gmx.net> <1231822958.22571.38.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:47712 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758137AbZAMMdj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jan 2009 07:33:39 -0500
In-Reply-To: <1231822958.22571.38.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca, bzolnier@gmail.com


-------- Original-Nachricht --------
> Datum: Tue, 13 Jan 2009 16:02:38 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
> Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne boards

> > Yes, it can wait.
> > Although I would like to know from the powerpc maintainer, if my
> > platform patches could still go in 2.6.29, if I resend them in the next days? I
> > guess it's too late, right?
> 
> Yes it is. I'll put them in -next after -rc2 or later, when we are happy
> with them. That gives us a bit of time to do extra polishing.
Good, then I'll send out a new patch for the IDE driver and the current one
can be reverted.

Gerhard
