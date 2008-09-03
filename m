From: Richard A Nelson <cowboy@cavein.org>
Subject: Re: [PATCH] ahci: Fix long standing Marvell regressions
Date: Wed, 3 Sep 2008 11:54:36 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0809031151200.742@hygvzn-guhyr.pnirva.bet>
References: <20080903000538.7500eaf8@lxorguk.ukuu.org.uk> <48BDCF09.7000603@garzik.org> <20080903142941.3f25d235@lxorguk.ukuu.org.uk> <20080903144834.35276de7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.cavein.org ([66.245.249.51]:56180 "EHLO mail.cavein.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819AbYICTIi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Sep 2008 15:08:38 -0400
In-Reply-To: <20080903144834.35276de7@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 3 Sep 2008, Alan Cox wrote:

> We can't automate that for the other devices as we don't actually know
> how to check the PATA port on them.

I happen to have one of the others:
 	Marvell Technology Group Ltd. 88SE6121 SATA II Controller (rev b1)

It is not in use, likely as a result of the issues at hand, I don't
recall exactly what transpired at the time.

I have no specs, but would be happy to run any software diagnostics
if they'd be of help
-- 
Rick Nelson
"I would rather spend 10 hours reading someone else's source code than
10 minutes listening to Musak waiting for technical support which isn't."
(By Dr. Greg Wettstein, Roger Maris Cancer Center)
