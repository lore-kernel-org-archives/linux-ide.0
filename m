From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious IRQs
Date: Tue, 25 Nov 2008 12:08:12 -0500
Message-ID: <492C30FC.2090200@garzik.org>
References: <49263552.8090602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56420 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752163AbYKYRIQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Nov 2008 12:08:16 -0500
In-Reply-To: <49263552.8090602@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> The DMA_IRQ bit in the bmdma status register is always set when IDEIRQ
> is asserted allowing spurious IRQ detection.  Detect spurious IRQs and
> clear them.  This protects ata_piix against nobody-cared which gets
> reported not so rarely.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/ata_piix.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)

It's tough to call this #upstream-fixes material, unfortunately...  For 
this late into -rc, I am very nervous about changing the ATA interrupt 
path for millions of machines.

	Jeff




