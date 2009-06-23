From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] cs5520: add missing IRQ setup for the second port
Date: Tue, 23 Jun 2009 16:44:29 -0700 (PDT)
Message-ID: <20090623.164429.179899088.davem@davemloft.net>
References: <20090623094206.4d1f1b5b@lxorguk.ukuu.org.uk>
	<200906231159.01295.bzolnier@gmail.com>
	<20090623163324.715421f5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53423
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758606AbZFWXoZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 19:44:25 -0400
In-Reply-To: <20090623163324.715421f5@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: bzolnier@gmail.com, elendil@planet.nl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 23 Jun 2009 16:33:24 +0100

>> > The cs5520 isn't a standard IDE controller in the first place and doesn't
>> > have two channels anyway. It's special as it uses non standard bar
>> 
>> Please note that both cs5520.c / pata_cs5520.c assume that the controller
>> has two ports (please verify whether they need some fixing, thanks)..
> 
> It can it turns out have two if the relevant external logic is present.

Ok, so previously the code would set both port IRQs to 14.  But now
only the first port IRQ gets initialized to 14, any subsequent port
has it's IRQ left uninitiailized.

What should we do?  I guess "do nothing and wait until we see a bug
report from an actual user" is a valid response...
