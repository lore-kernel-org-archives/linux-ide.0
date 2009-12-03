From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple
 PowerMac/PowerBook IDE controller
Date: Fri, 04 Dec 2009 10:55:41 +1100
Message-ID: <1259884541.2076.1239.camel@pasglop>
References: <20091202003630.29919100851@ozlabs.org>
	 <4B1772D0.5030303@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41816 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755069AbZLCX4a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Dec 2009 18:56:30 -0500
In-Reply-To: <4B1772D0.5030303@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, tj@kernel.org

On Thu, 2009-12-03 at 03:12 -0500, Jeff Garzik wrote:

> Looks fine to me.  Two minor comments, which might perhaps be ignored if 
> that is your taste:
> 
> * prefer enums to #define's, for constants

yeah well ... I lifted those definitions from the old driver and didn't
feel like changing them all :-) I might do a separate patch later to
clean that up, we don't actually use a lot of those anymore since I use
pre-calculated tables, though they are good to keep as documentation.

> * prefer direct function call to "ap->ops->foo_bar()", because 
> ap->ops->foo_bar() is guaranteed to be a constant value known to the 
> driver.  The driver is the entity responsible for the function pointer.
>
> Maybe saves a cycle or two.  Not terribly important, but hey, calling 
> ap->ops->sff_exec_command() from pata_macio_bmdma_setup() is a hot path.

Makes sense. I'm tempted to make that a separate patch tho, since I've
already queued up the existing one and it's just a relatively minor
performance optim. 

Cheers,
Ben.


