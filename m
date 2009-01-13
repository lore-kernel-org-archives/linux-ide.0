From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne
 boards
Date: Tue, 13 Jan 2009 16:02:38 +1100
Message-ID: <1231822958.22571.38.camel@pasglop>
References: <20090112233909.221080@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47850 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbZAMFCz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jan 2009 00:02:55 -0500
In-Reply-To: <20090112233909.221080@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org


> Yes, it can wait.
> Although I would like to know from the powerpc maintainer, if my platform
> patches could still go in 2.6.29, if I resend them in the next days? I guess it's
> too late, right?

Yes it is. I'll put them in -next after -rc2 or later, when we are happy
with them. That gives us a bit of time to do extra polishing.

Ben.


