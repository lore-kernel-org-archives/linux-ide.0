From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] ahci/sata_vsc: drop intx manipulation on msi
 enable
Date: Mon, 16 Feb 2009 19:10:33 -0500
Message-ID: <499A0079.2030703@garzik.org>
References: <49792C0B.6070602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55490 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbZBQAKh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Feb 2009 19:10:37 -0500
In-Reply-To: <49792C0B.6070602@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> There's no need to turn off intx explicitly on msi enable.  This is
> automatically handled by pci.  Drop it.
> 
> Note that, in sata_vsc's case, it was completely redundant; however,
> for ahci, it might be needed on machines if the BIOS turns intx off
> during boot.  However, there's no evidence of such behavior for ahci
> and the only such case seems to be ICH5 PATA according to ata_piix.
> Also, given the way ahci operates, it's highly unlikely BIOS ever
> disables IRQ for the controller.  However, as this change has slight
> possibility of introducing failure, please schedule it for #upstream.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> There are similar places in sata_sis and sata_uli.  I have no idea
> whether they're there because they're needed or just copied over from
> other drivers.  Eh...

Most of them were just copied, IIRC.

as for this patch:  applied the ahci portion.

For sata_vsc, ISTR there being a hardware-specific reason why the 
MSI+INTX manipulation was done in that fashion.  Needs a bit of 
research, or at least, real world testing results for the MSI and !MSI 
cases...

	Jeff



