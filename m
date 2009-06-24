From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] cs5520: add missing IRQ setup for the second port
Date: Wed, 24 Jun 2009 02:36:22 -0700 (PDT)
Message-ID: <20090624.023622.26554425.davem@davemloft.net>
References: <20090623163324.715421f5@lxorguk.ukuu.org.uk>
	<20090623.164429.179899088.davem@davemloft.net>
	<20090624102200.7debd041@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:48651
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758285AbZFXJgS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2009 05:36:18 -0400
In-Reply-To: <20090624102200.7debd041@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: bzolnier@gmail.com, elendil@planet.nl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 24 Jun 2009 10:22:00 +0100

>> What should we do?  I guess "do nothing and wait until we see a bug
>> report from an actual user" is a valid response...
> 
> I doubt you ever will.
> 
> The docs don't say so I'd assume its hard coded 14/15 as if it was ISA
> (its not an IDE storage class device so doesn't have the PCI config bits
> to switch between legacy and native modes).

Ok, that makes sense.  I'll set the second port's IRQ to 15.

Thanks!
