From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_pcmcia: Minor cleanups and support for dual channel
 cards
Date: Tue, 04 Dec 2007 14:37:49 -0500
Message-ID: <4755AC8D.8030308@garzik.org>
References: <20071119144307.7b67f09e@the-village.bc.nu>	<474774A6.5020906@garzik.org> <20071126154047.63021652@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41132 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbXLDThx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 14:37:53 -0500
In-Reply-To: <20071126154047.63021652@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> setup and it821x fixes can go to mainstream for 2.6.25 I think - no bad
> reports yet.
> 
> BTW so we don't duplicate work right now I'm working on a full DMA engine
> based driver for the INIC162x. Dunno if I'll ever get it to work as the
> docs are a bit minimal but we shall see.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Can you be a bit more specific, or confirm my guesses?  In #for-testing 
I have

> Alan Cox (4):
>       libata: fix (hopefully) all the remaining problems with devices failing setup
>       pata_pcmcia: Add support for dumb 8bit IDE emulations
>       libata-core: Don't have screaming fits over DF/ERR combinations
>       libata/pata_it821x: Improve handling of poorly compatible emulations

it sounds like all patches in the branch except for "DF/ERR" should go 
upstream for 2.6.25?

And in addition, "pata_pcmcia: Minor cleanups and support for dual 
channel cards" should go upstream after the above pata_pcmcia change is 
applied?

	Jeff


