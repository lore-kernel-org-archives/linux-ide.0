From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sis5513 fix for SiS962 chipset
Date: Fri, 10 Sep 2004 17:06:43 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1094828803.13450.4.camel@thomas.tec.linutronix.de>
References: <1094826555.7868.186.camel@thomas.tec.linutronix.de>
	 <4141BFDF.1050200@inet6.fr>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:63387
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S267452AbUIJPN5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Sep 2004 11:13:57 -0400
In-Reply-To: <4141BFDF.1050200@inet6.fr>
List-Id: linux-ide@vger.kernel.org
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

On Fri, 2004-09-10 at 16:53, Lionel Bouton wrote:
> Thomas Gleixner wrote the following on 09/10/2004 04:29 PM :
> 
> >Hi,
> >
> >1. If the fake 5513 id bit is not set by the BIOS we must have the 5518
> >id in the device table.
> >
> >2. If the register remapping is not set by the BIOS then the enable bit
> >check in ide_pci_setup_ports will fail. It's safe to switch to the
> >remapping mode here. Keeping the not remapped mode would need quite big
> >changes AFAICS.
>
> I was worried about these when 5518 was introduced but couldn't test on 
> the hardware I had at hand and nobody reported hitting this so it went 
> under the carpet. What hardware did you use to test ?

Compact PCI ICP-P4 from Inova Computers.

They have not set the 5513 fake id bit and the remapping bit isn't set
either. I did thorough testing both on 2.4 and 2.6 and encountered no
problems yet. I suspect there are more boards around with similar
settings.

tglx


