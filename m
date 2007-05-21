From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Allow a controller specific post bus reset
 method
Date: Mon, 21 May 2007 17:10:05 +0100
Message-ID: <20070521171005.26b0d6d4@the-village.bc.nu>
References: <20070521152843.0f202d6b@the-village.bc.nu>
	<4651B653.8010201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59638 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755697AbXEUQGh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 12:06:37 -0400
In-Reply-To: <4651B653.8010201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, akpm@osdl.org, linux-ide@vger.kernel.org

> ata_bus_post_reset() is a separate function only because it was written
> that way at the beginning.  It's really not a separate logical API and I
> was thinking of folding it into ata_bus_softreset() or
> ata_std_softreset() after old EH is gone.  Also it's a bit ugly to call
> ap->ops->* from a ap->ops callback.  I think the correct solution here
> is to write a separate ->softreset method.

It means copying a lot of code but I can do

> Hmmm... I guess what's failing is the nsect==1 && lbal==1 test, right?

Yep

> Jeff, do we really need that test?  dev0 doesn't clear BSY till PDIAG-
> is asserted from dev1 anyway.  Maybe just limit the waiting there to a
> few secs?

Alan
