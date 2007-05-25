From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sil680 MMIO changes moved to branch
Date: Fri, 25 May 2007 00:41:18 -0400
Message-ID: <465668EE.7020108@garzik.org>
References: <4656591A.6090701@garzik.org>	 <1180066312.32247.1098.camel@localhost.localdomain>	 <4656655D.7070109@garzik.org> <1180067378.32247.1105.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51354 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377AbXEYElU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 May 2007 00:41:20 -0400
In-Reply-To: <1180067378.32247.1105.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan <alan@lxorguk.ukuu.org.uk>

Benjamin Herrenschmidt wrote:
> On Fri, 2007-05-25 at 00:26 -0400, Jeff Garzik wrote:
>> Just replace the ata_std_softreset() call with code that does MMIO 
>> flushes on a safe register?
> 
> Yeah well... if just reading altstatus is enough, I don't see the point
> of doing anything MMIO-dependant or whatever. I can just add reading of
> it after all 3 SRST bit toggles unconditionally.

Sorry, to be clear I would not want to change the core code to bang 
AltStatus in the middle of the SRST twiddles...

The core code only fails (in theory) for PATA+MMIO cases, and the 
easiest fix should be to read some innocuous vendor-specific register. 
That allows the core code to stay unchanged, requiring only two drivers 
(pdc and sil680) to be updated with this flushing behavior.

All other discussion of ata_pause() seemed like an unrelated side 
discussion, unless I missed something?

	Jeff



