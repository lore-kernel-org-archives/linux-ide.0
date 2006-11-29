From: Mark Lord <liml@rtr.ca>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 21:51:16 -0500
Message-ID: <456CF5A4.3040304@rtr.ca>
References: <456CB72A.3010004@local.se> <Pine.LNX.4.64.0611281444330.4244@woody.osdl.org> <456CC4C5.6090003@garzik.org> <Pine.LNX.4.64.0611281531550.4244@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:24082 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1755296AbWK2CvT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 21:51:19 -0500
In-Reply-To: <Pine.LNX.4.64.0611281531550.4244@woody.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Jonas Lundgren <jonas@local.se>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

> How hard would it be to just force a shared spinlock between two sata 
> channels on the same "controller"? It sounds like Jonas has a very 
> repeatable setup, so even if I can't repeat my problem, if the performance 
> degradation on writes is related, he can check his thing..

Kinda like the "ide0=serialize" flag for the IDE subsystem, I suppose.

We certainly don't want it to be the default, as millions of ata_piix 
systems already out there seem to be working just fine (not all of them
running Linux, but enough of them to extrapolate to the zillions of
identical models).

It must be something new with ICH8 that we're not doing correctly yet.

???
