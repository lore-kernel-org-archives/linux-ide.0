From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Possibly SATA related freeze killed networking and RAID
Date: Tue, 20 Nov 2007 22:05:12 +0000
Message-ID: <20071120220512.46b9e975@the-village.bc.nu>
References: <d00698fb0711201109m23ff096eiabeb22c8f9a917dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46816 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755916AbXKTWHM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Nov 2007 17:07:12 -0500
In-Reply-To: <d00698fb0711201109m23ff096eiabeb22c8f9a917dc@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: noah <noah123@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

>  kernel: [734344.717844] irq 21: nobody cared (try booting with the
> "irqpoll" option)
>  kernel: [734344.717866]

Your machine decided to emit interrupt 21 without an apparent reason.
Whatever caused that made the kernel shut down IRQ 21 at which point the
disk drives on that IRQ were no longer being serviced. Everything on IRQ
21 would have died - which may be why your networking failed too.

What do you have on IRQ 21 and is this a one off ?
