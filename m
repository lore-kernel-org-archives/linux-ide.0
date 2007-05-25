From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: sil680 MMIO changes moved to branch
Date: Fri, 25 May 2007 14:57:19 +1000
Message-ID: <1180069039.32247.1108.camel@localhost.localdomain>
References: <4656591A.6090701@garzik.org>
	 <1180066312.32247.1098.camel@localhost.localdomain>
	 <4656655D.7070109@garzik.org>
	 <1180067378.32247.1105.camel@localhost.localdomain>
	 <465668EE.7020108@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52805 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbXEYE50 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 May 2007 00:57:26 -0400
In-Reply-To: <465668EE.7020108@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan <alan@lxorguk.ukuu.org.uk>

On Fri, 2007-05-25 at 00:41 -0400, Jeff Garzik wrote:
> Sorry, to be clear I would not want to change the core code to bang 
> AltStatus in the middle of the SRST twiddles...
> 
> The core code only fails (in theory) for PATA+MMIO cases, and the 
> easiest fix should be to read some innocuous vendor-specific
> register. 
> That allows the core code to stay unchanged, requiring only two
> drivers 
> (pdc and sil680) to be updated with this flushing behavior.

Ok. Will do that then.

> All other discussion of ata_pause() seemed like an unrelated side 
> discussion, unless I missed something?

Yes, I think we drifted because ata_pause is the other known case where
MMIO needs flushing.

