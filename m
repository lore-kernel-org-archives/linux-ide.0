From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH -mm 2/6] cpu_relax(): ide_wait_stat()
Date: Wed, 21 Jun 2006 23:19:41 +0100
Message-ID: <1150928381.15275.136.camel@localhost.localdomain>
References: <20060621205942.GB22516@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:27010 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030326AbWFUWEV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jun 2006 18:04:21 -0400
In-Reply-To: <20060621205942.GB22516@rhlx01.fht-esslingen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Ar Mer, 2006-06-21 am 22:59 +0200, ysgrifennodd Andreas Mohr:
> Add cpu_relax() to drivers/ide/ide-iops.c/ide_wait_stat().

You don't need cpu_relax() when the loop contains a reference to
external memory busses. The CPU will stall on the inb() anyway, and when
this occurs processors with multiple-threads will do the right thing
implicitly. If you could look at the instruction stream it would look
something like

dec count
jump out if zero
inb
read request to the bus
[stall]
then to the PCI bridge
[stall]
then eventually to the device
[Huge mindbogglingly relativley long period of time stalled]
answer finally arrives back over the PCI bus
compare
...


Same comment for floppy. Rest look ok

Perhaps this needs documenting however.

Alan

