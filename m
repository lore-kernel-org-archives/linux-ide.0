From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] drivers/ide: PATA driver	for Celleb
Date: Tue, 21 Nov 2006 22:02:30 +1100
Message-ID: <1164106951.5597.33.camel@localhost.localdomain>
References: <200611210959.kAL9x8eH026223@toshiba.co.jp>
	 <4562CFD4.6040702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41154 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S934281AbWKULCG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Nov 2006 06:02:06 -0500
In-Reply-To: <4562CFD4.6040702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Akira Iguchi <akira2.iguchi@toshiba.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org


> > We use a drivers/ide driver because its design is more suitable for
> > SCC IDE controller than libata driver. Since SCC supports only 32bit
> > read/write, we must override many callbacks of ata_port_operations
> > by modifying generic helpers. Each time the libata common code is
> > updated, we must update those modified helpers. It is very hard for us.
> > But we will try to implement the libata driver as needed.
> > 
> > This patch set is intended to be merged to 2.6.20.
> > If you have any comment, please write to me.
> 
> Care to post libata version (even if it's not complete)?  Let's work 
> something out.

The main problem is error handling / reset code.

With the current libata, basically, you can only override the whole
thing pretty much at the toplevel. The problem is with things like
ata_std_prereset, ata_std_softreset and ata_std_postreset and callees.

We can either comletely re-implement them but that seems fairly dodgy to
me, or find a way to add hooks. At the end of the day, all they need is:

 - write to the control register
 - read & write of nsect_addr & lbal_addr

I wonder how much of these could be replaced by either a hook, or
taskfile accessors (possibly with a special flag).

Cheers,
Ben.


