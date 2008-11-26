From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious IRQs
Date: Wed, 26 Nov 2008 15:37:29 +0300
Message-ID: <492D4309.3070006@ru.mvista.com>
References: <49263552.8090602@kernel.org>	<20081121102504.63007bf6@lxorguk.ukuu.org.uk>	<492C30EE.9080600@garzik.org>	<492CBA05.8000107@kernel.org> <20081126104731.4b370d18@lxorguk.ukuu.org.uk> <492D40F3.5000506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:2149 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752157AbYKZMhg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Nov 2008 07:37:36 -0500
In-Reply-To: <492D40F3.5000506@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, I wrote:

>>> irq handler) and ata_piix (this patch).  Alan, how do other
>>> controllers do it?
>>>     
>>
>> CMD chipsets do a register read .. from PCI config space (gak)
>>   
> All BMDMA controllers I know about are sata_sil (already has private
>
>   The late chips do have the alternate interrupt latch bits in I/O 
> space (at BMIDE base + 3).

   Just looked into th driver, so to be correct the MRDMODE register is 
at BMIDE base + 1.

MBR, Sergei


