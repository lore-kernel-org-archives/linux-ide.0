From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_pcmcia: Minor cleanups and support for dual
 channel cards
Date: Mon, 26 Nov 2007 15:40:47 +0000
Message-ID: <20071126154047.63021652@the-village.bc.nu>
References: <20071119144307.7b67f09e@the-village.bc.nu>
	<474774A6.5020906@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43884 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752085AbXKZPnz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Nov 2007 10:43:55 -0500
In-Reply-To: <474774A6.5020906@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

setup and it821x fixes can go to mainstream for 2.6.25 I think - no bad
reports yet.

BTW so we don't duplicate work right now I'm working on a full DMA engine
based driver for the INIC162x. Dunno if I'll ever get it to work as the
docs are a bit minimal but we shall see.
