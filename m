From: sean <seandarcy2@gmail.com>
Subject: Re: does AHCI work on intel 915 ICH6 controllers? Is it supposed
   to?
Date: Thu, 09 Jun 2005 09:53:22 -0400
Message-ID: <d89hcm$7ej$1@sea.gmane.org>
References: <d87q4j$d37$1@sea.gmane.org> <42A7A191.7040700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:20131 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262385AbVFIOb1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jun 2005 10:31:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DgNhl-0005kB-Hl
	for linux-ide@vger.kernel.org; Thu, 09 Jun 2005 16:08:21 +0200
Received: from ool-4356fcdd.dyn.optonline.net ([67.86.252.221])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 09 Jun 2005 16:08:21 +0200
Received: from seandarcy2 by ool-4356fcdd.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 09 Jun 2005 16:08:21 +0200
In-Reply-To: <42A7A191.7040700@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Jeff Garzik wrote:
[...........]
> Plain vanilla ICH6 does not support AHCI, but other ICH6 variants such 
> as ICH6-R do.  If your chip does support AHCI, then your BIOS is not 
> enabling it.
> 
> AHCI support is clearly indicated by Region 5, a memory (MMIO) region:
> 
>>         Region 0: I/O ports at e880 [size=8]
>>         Region 1: I/O ports at e800 [size=4]
>>         Region 2: I/O ports at e480 [size=8]
>>         Region 3: I/O ports at e400 [size=4]
>>         Region 4: I/O ports at e080 [size=32]
>>         Region 5: Memory at feb3fc00 (32-bit, non-prefetchable) [size=1K]
> 
> 
> Regards,
> 
>     Jeff
> 

Thanks for the quick response. I've sent another request to 
gigabyte for a BIOS update.  Fat chance.

sean


