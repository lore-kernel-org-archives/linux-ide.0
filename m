From: David Miller <davem@davemloft.net>
Subject: Re: WARNINGs because of ide-proc handling
Date: Wed, 01 Sep 2010 19:33:32 -0700 (PDT)
Message-ID: <20100901.193332.77341159.davem@davemloft.net>
References: <20100831205605.GA23636@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:46916
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752314Ab0IBCdQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2010 22:33:16 -0400
In-Reply-To: <20100831205605.GA23636@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: w.sang@pengutronix.de
Cc: linux-ide@vger.kernel.org

From: Wolfram Sang <w.sang@pengutronix.de>
Date: Tue, 31 Aug 2010 22:56:05 +0200

> Hello,
> 
> I get the following warning (and some similar ones) on my laptop running
> 2.6.36-rc3 when removing a CF card via pcmcia:
> 
> [ 1087.602129] WARNING: at fs/proc/generic.c:816 remove_proc_entry+0x185/0x1d0()
> [ 1087.602137] Hardware name: Amilo M14255
> [ 1087.602142] name 'cache'
> ...
> 
> It turned out that none of the entries in ide_disk_proc[] gets created when
> inserting the card, so trying to remove them triggers this warning. Adding
> some debug printouts

Hmmm, at some point ide_host_add() or ide_host_register() should be invoked,
which should create the drive->proc and hwif->proc PROCFS directories.

What driver is your pcmcia IDE card using?
