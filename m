From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.21-rc2] pata_legacy: fix io/irq mismatch
Date: Tue, 06 Mar 2007 04:05:45 -0500
Message-ID: <45ED2EE9.1070809@garzik.org>
References: <200703031957.l23JviQQ005254@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51810 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933102AbXCFJFt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 04:05:49 -0500
In-Reply-To: <200703031957.l23JviQQ005254@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: alan@redhat.com, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> pata_legacy fails to detect the disk on my old ISA/VLB 486:
> it starts to probe io=0x1f0 ctr=0x3f6 irq=15, complains
> loudly about IDENTIFYs timing out, and finally fails.
> (Sorry I couldn't capture the kernel's boot messages.)
> 
> It turns out that the driver's mapping from io to irq in
> legacy_irq[] is wrong: index 0 for io=0x1f0 has irq=15 but
> should have irq=14, and index 1 for io=0x170 has irq=14 but
> should have irq=15. This is confirmed by a comparison with
> include/asm-i386/ide.h:ide_default_irq().
> 
> This patch swaps the first two elements in legacy_irq[],
> which makes pata_legacy work on my 486.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

applied


