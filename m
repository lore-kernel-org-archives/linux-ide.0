From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata DMADIR support
Date: Mon, 17 May 2004 17:32:25 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A92F69.6030309@pobox.com>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>	<1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com> <1084828840.3211.26.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30367 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262103AbUEQVch
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 May 2004 17:32:37 -0400
In-Reply-To: <1084828840.3211.26.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> My memory of my share of the SATA ATAPI UDMA flurry tells me that my Si
> 3611CT80 r1.4 bridge hangs with status = xD0 if we ask it to copy DMA
> Data In, without having prepared op xA0 "PACKET" features = x05 DMA In
> rather than x01 DMA Out.
> 
> Are you not convinced?

I am convinced that your hardware requires DMADIR.

I am not convinced that there is no way to detect this condition at 
runtime, based on some hardware characteristic, or output.



> I agree, by connecting my compliant only-DMADIR-capable bridge to a
> compliant PATA DMA device I have ended up violating ATA/PI 6 by claiming
> classic UDMA in op xA1 "IDENTIFY" "word" 88 (line 12 offset 0), when in
> fact the abomination I built only actually supports the DMADIR that
> ATA/PI 7 claims will be described in "word" 62 (line 7 offset 6).

Well, the expected behavior is proper implementation of word 62, bit 15 
at the very least :)

If hardware requires the DMADIR bit, it should set the feature bit that 
says "I require DMADIR".  If not, one could justifyably claim the 
hardware is not operating to spec.


> I imagine I was not the first and I will not be the last to fall into
> this spiked pit.  Particularly vulnerable will be the people who resell
> compliant PATA ATAPI UDMA devices and then fall into erroneously
> believing that adding a compliant SATA/PATA bridge makes a compliant
> SATA ATAPI UDMA device.

<shrug>  Honestly, I think the requirement of a data-direction bit was 
inevitable.  I'm surprised you don't have one for ATA devices. 
Consider:  what data direction will a vendor-reserved SCSI opcode 
require?  The OS driver cannot know.

If you accept that premise, then these changes to ATA were required...

	Jeff



