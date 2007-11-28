From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] pata_pcmcia: Minor cleanups and support for dual channel
 cards
Date: Wed, 28 Nov 2007 10:56:21 +0900
Message-ID: <474CCAC5.7030407@gmail.com>
References: <20071119144307.7b67f09e@the-village.bc.nu>	<474774A6.5020906@garzik.org> <20071126154047.63021652@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:33001 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758131AbXK1B41 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 20:56:27 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1071949rvb
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 17:56:27 -0800 (PST)
In-Reply-To: <20071126154047.63021652@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> setup and it821x fixes can go to mainstream for 2.6.25 I think - no bad
> reports yet.
> 
> BTW so we don't duplicate work right now I'm working on a full DMA engine
> based driver for the INIC162x. Dunno if I'll ever get it to work as the
> docs are a bit minimal but we shall see.

Great, are you gonna use the ADMA interface?

-- 
tejun
