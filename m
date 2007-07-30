From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev#upstream] libata: implement and use ata_port_desc()
 to report port configuration
Date: Mon, 30 Jul 2007 13:56:07 +0900
Message-ID: <46AD6F67.5080206@gmail.com>
References: <20070729103421.GG22374@htj.dyndns.org>	<20070729143106.446924ba@the-village.bc.nu>	<46ACAC2D.8050307@gmail.com> <20070729185532.180daea3@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:3571 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbXG3E4M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jul 2007 00:56:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1661330wah
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 21:56:12 -0700 (PDT)
In-Reply-To: <20070729185532.180daea3@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
>>> Looks as sane an approach. Some obvious errors in the conversion but
>>> simply wrong types I/O v MMIO etc not flaws in the proposal
>> Care to point out?
> 
> I didn't save it but it was things like HPT3x3 seemed to be claiming to
> be MMIO - trivial stuff we can clean up in a merge.

Ah.. I see.  iomap() interface hides ioport/mmio very well and I just
assumed it was mmio as most controllers which map single BAR and use
parts of it for different ports use mmio.  Fixed.

>>> Unfortunately there is one big horror you've left unconverted - the status
>>> address printing in ata_wait_... That is why I ended up going the way I
>>> did.
>> The only thing I can find is DPRINTK in ata_wait_idle() which can and
>> should simply be converted to ata_port_printk("abnormal Status 0x%x\n",
>> status).  After all some controller don't even have Status register (FIS
>> based ones, ahci, sil24).
> 
> That is probably very sensible yes.

Will add this to the series and repost, thanks.

-- 
tejun
