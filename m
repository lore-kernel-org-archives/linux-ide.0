From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_pcmcia: Minor cleanups and support for dual
 channel cards
Date: Tue, 4 Dec 2007 20:22:43 +0000
Message-ID: <20071204202243.29edfccd@the-village.bc.nu>
References: <20071119144307.7b67f09e@the-village.bc.nu>
	<474774A6.5020906@garzik.org>
	<20071126154047.63021652@the-village.bc.nu>
	<4755AC8D.8030308@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54593 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751183AbXLDU1Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 15:27:24 -0500
In-Reply-To: <4755AC8D.8030308@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

> it sounds like all patches in the branch except for "DF/ERR" should go 
> upstream for 2.6.25?

Yes

> 
> And in addition, "pata_pcmcia: Minor cleanups and support for dual 
> channel cards" should go upstream after the above pata_pcmcia change is 
> applied?

Yes

and DF/ERR goes in the bin obsoleted by Mark/Tejuns changes to handle
sticky error on tapes
