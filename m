From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_hpt3xx: Updates to match work done by Sergei to
 old IDE
Date: Tue, 17 Apr 2007 15:51:51 +0100
Message-ID: <20070417155151.5bc72825@the-village.bc.nu>
References: <20070411001649.1abecf4b@the-village.bc.nu>
	<4624DDED.9080200@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:44235 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030503AbXDQOsg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 10:48:36 -0400
In-Reply-To: <4624DDED.9080200@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

> > Pull DPLL clock from I/O not PCI space
> > Correct DPLL failure error handling
> 
> Looks OK to me, but...  should I still apply this, given the recent 
> regression reports that hit LKML less than 48 hours ago?

Only one report so far but its certainly a good idea to hold off and get
to the bottom of that.
