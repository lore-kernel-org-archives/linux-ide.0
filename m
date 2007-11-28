From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Current sata_inic attempts (was pata_pcmcia: Minor cleanups and
 support for dual channel cards)
Date: Wed, 28 Nov 2007 13:03:05 +0000
Message-ID: <20071128130305.63312057@the-village.bc.nu>
References: <20071119144307.7b67f09e@the-village.bc.nu>
	<474774A6.5020906@garzik.org>
	<20071126154047.63021652@the-village.bc.nu>
	<474CCAC5.7030407@gmail.com>
	<20071128093952.77652450@the-village.bc.nu>
	<474D51A1.1050107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40487 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753170AbXK1NGf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 08:06:35 -0500
In-Reply-To: <474D51A1.1050107@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, akpm@osdl.org, linux-ide@vger.kernel.org

> That sounds consistent with my failed try.  I thought the problem was
> caused by the controller not willing to switch out of legacy mode.
> aLGCY bit of IDMSTAT register indicates that the controller is in legacy
> mode.  No matter what I do to it, it just won't go off.  Have you
> managed to clear that bit?

Yes - I see 0x0020 -> stopped but the LGCY bit clear

