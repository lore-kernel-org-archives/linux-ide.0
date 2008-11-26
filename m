From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious IRQs
Date: Thu, 27 Nov 2008 02:45:00 +0900
Message-ID: <492D8B1C.405@kernel.org>
References: <49263552.8090602@kernel.org>	<20081121102504.63007bf6@lxorguk.ukuu.org.uk>	<492C30EE.9080600@garzik.org>	<492CBA05.8000107@kernel.org> <20081126104731.4b370d18@lxorguk.ukuu.org.uk> <492D88B9.7040608@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48057 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169AbYKZRpR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Nov 2008 12:45:17 -0500
In-Reply-To: <492D88B9.7040608@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Alan Cox wrote:
>>> All BMDMA controllers I know about are sata_sil (already has private
>>> irq handler) and ata_piix (this patch).  Alan, how do other
>>> controllers do it?
>>
>> CMD chipsets do a register read .. from PCI config space (gak)
>> SIL680 is similar
>> SI3112 adds the fact you need to keep at the PHY as well.
>> Promise uses a magic register at dmabase + 0x1D which holds irq bits
>>
>> What I'd like to understand better is why we need any
>> of these ...
> 
> Indeed!

Well, this patch was necessary for a netbook with PATA SSD.  The ATA
implementation of the SSD was quite flaky and under certain
circumstances, during resume SRST, the drive would raise the IRQ line
regardless of NIEN and will stay that way for several seconds, thus
triggering nobody cared.  Other than detecting and clearing the
spurious IRQ, there just isn't much driver can do to work around
problems like this.

Thanks.

-- 
tejun
