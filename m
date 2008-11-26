From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious IRQs
Date: Wed, 26 Nov 2008 15:26:42 +0300
Message-ID: <492D4082.7070208@ru.mvista.com>
References: <49263552.8090602@kernel.org>	<20081121102504.63007bf6@lxorguk.ukuu.org.uk>	<492C30EE.9080600@garzik.org>	<492CBA05.8000107@kernel.org> <20081126104731.4b370d18@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:1822 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751244AbYKZM0w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Nov 2008 07:26:52 -0500
In-Reply-To: <20081126104731.4b370d18@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello.

Alan Cox wrote:

>> All BMDMA controllers I know about are sata_sil (already has private
>> irq handler) and ata_piix (this patch).  Alan, how do other
>> controllers do it?
>>     
>
> CMD chipsets do a register read .. from PCI config space (gak)
> SIL680 is similar
>   

   Similar to the chips driven by sata_sil you mean?
   Both 680 and 3112 certainly have the INTRQ status in the MMIO 
register (yes, alternatively seen thru the PCI config space). IIRC it's 
not a latched status, so doesn't require clearing...

> Promise uses a magic register at dmabase + 0x1D which holds irq bits
>   

   Yes, if you mean the chips driven by [pata_]pdc202xx_old -- don't 
know about SATA.

MBR, Sergei


