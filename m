From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Delay on intialization ide subsystem(most likely)
Date: Tue, 09 Jun 2009 09:26:27 +1000
Message-ID: <1244503587.8971.9.camel@pasglop>
References: <20090425170203.74603b9c@power-debian>
	 <200905201756.14769.bzolnier@gmail.com>
	 <20090530144643.76cb456e@power-debian>
	 <200906082220.41763.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38389 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858AbZFHX0m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Jun 2009 19:26:42 -0400
In-Reply-To: <200906082220.41763.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrey Gusev <a.gusev1980@mail.ru>, linux-ide@vger.kernel.org, petkovbb@gmail.com, linuxppc-dev@ozlabs.org

On Mon, 2009-06-08 at 22:20 +0200, Bartlomiej Zolnierkiewicz wrote:

> > [   70.584122]  hdb:<3>ide-pmac lost interrupt, dma status: 8480
> 
> DMA status indicates that DMA transfer is still active according to
> the controller.  This one is really a platform/hardware specific issue.

I've partially missed that thread. Is the a bugzilla entry or
something ? Is this a regression ?

Cheers,
Ben.


