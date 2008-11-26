From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious IRQs
Date: Wed, 26 Nov 2008 12:34:49 -0500
Message-ID: <492D88B9.7040608@garzik.org>
References: <49263552.8090602@kernel.org>	<20081121102504.63007bf6@lxorguk.ukuu.org.uk>	<492C30EE.9080600@garzik.org>	<492CBA05.8000107@kernel.org> <20081126104731.4b370d18@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34291 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307AbYKZRfA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Nov 2008 12:35:00 -0500
In-Reply-To: <20081126104731.4b370d18@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> All BMDMA controllers I know about are sata_sil (already has private
>> irq handler) and ata_piix (this patch).  Alan, how do other
>> controllers do it?
> 
> CMD chipsets do a register read .. from PCI config space (gak)
> SIL680 is similar
> SI3112 adds the fact you need to keep at the PHY as well.
> Promise uses a magic register at dmabase + 0x1D which holds irq bits
> 
> What I'd like to understand better is why we need any
> of these ...

Indeed!

	Jeff




