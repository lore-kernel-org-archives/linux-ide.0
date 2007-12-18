From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_sil: fix spurious IRQ handling
Date: Mon, 17 Dec 2007 20:37:20 -0500
Message-ID: <47672450.70703@garzik.org>
References: <4759DB17.9010505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37116 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563AbXLRBhX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Dec 2007 20:37:23 -0500
In-Reply-To: <4759DB17.9010505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, mark.paulus@technologist.com, sveint@gmail.com, bug-track@fisher-privat.net

Tejun Heo wrote:
> Interestingly, sata_sil raises spurious interrupts if it's coupled
> with Sil SATA_PATA bridge.  Currently, sata_sil interrupt handler is
> strict about spurious interrupts and freezes the port when it occurs.
> This patch makes it more forgiving.
> 
> * On SATA PHY event interrupt, serror value is checked to see whether
>   it really is PHYRDY CHG event.  If not, SATA PHY event interrupt is
>   ignored.
> 
> * If ATA interrupt occurs while no command is in progress, it's
>   cleared and ignored.
> 
> This fixes bugzilla bug 9505.
> 
>   http://bugzilla.kernel.org/show_bug.cgi?id=9505
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied #upstream-fixes


