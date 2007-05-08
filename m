From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY
Date: Tue, 8 May 2007 14:57:39 +0100
Message-ID: <20070508145739.2a879736@the-village.bc.nu>
References: <463EAB4D.3000309@tw.ibm.com>
	<463ED8B9.4060501@gmail.com>
	<463F0B25.40103@tw.ibm.com>
	<463F0DAD.5060307@gmail.com>
	<463F1374.1010100@tw.ibm.com>
	<20070507152856.5e817490@the-village.bc.nu>
	<46407E34.7030800@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33332 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S968005AbXEHNxv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 09:53:51 -0400
In-Reply-To: <46407E34.7030800@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: albertl@mail.com, albertcc@tw.ibm.com, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com

> > Oh yes, and also some controllers will corrupt their data stream if you
> > do this during a PIO transfer of a block of ATA data.
> 
> I also believe that to be true, but don't know exactly which hardware
> has that issue.

Some stuff which needs to block local irqs during the transfer anyway (eg
ancient VIA) which therefore doesn't raise that problem much if our
locking is careful (right now we block local irq but we can spin_lock
happily in these as they are almost always uniprocessor anyway)

There is also some intel stuff with this problem (PIIX4 errata 15, 440MX
errata 13.
