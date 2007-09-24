From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: CompactFlash and HD unhappy together on the same IDE channel
Date: Mon, 24 Sep 2007 23:29:32 +0100
Message-ID: <20070924232932.475ff29d@the-village.bc.nu>
References: <46C69913.1060505@g7.org>
	<46C799E8.8080407@rtr.ca>
	<20070819175632.349d11c5@the-village.bc.nu>
	<46EC70A0.1000800@g7.org>
	<20070922191248.5f2bc74a@the-village.bc.nu>
	<46F693BD.8070604@rtr.ca>
	<20070923184045.6358014a@the-village.bc.nu>
	<46F83414.2040809@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42799 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753683AbXIXWXS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 18:23:18 -0400
In-Reply-To: <46F83414.2040809@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Malcolm Gillies <malcolm@g7.org>, linux-ide@vger.kernel.org

> But when we see a CF card on a *SATA* controller, we *know* there's a bridge chip
> in there someplace, and we know that the common bridges don't do MWDMA.


If we see CF on SATA we already should kill the MWDMA modes as we'll see
word 95 showing SATA if the bridge is properly implemented. I guess it
might not show as Major rev 5+. I'll investigate that because it is a
good heuristic.
