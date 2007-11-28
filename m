From: Tejun Heo <htejun@gmail.com>
Subject: Re: Current sata_inic attempts (was pata_pcmcia: Minor cleanups and
 support for dual channel cards)
Date: Wed, 28 Nov 2007 20:31:45 +0900
Message-ID: <474D51A1.1050107@gmail.com>
References: <20071119144307.7b67f09e@the-village.bc.nu>	<474774A6.5020906@garzik.org>	<20071126154047.63021652@the-village.bc.nu>	<474CCAC5.7030407@gmail.com> <20071128093952.77652450@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.181]:51453 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756935AbXK1Lbx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 06:31:53 -0500
Received: by ro-out-1112.google.com with SMTP id p4so2417833roc
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 03:31:52 -0800 (PST)
In-Reply-To: <20071128093952.77652450@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, akpm@osdl.org, linux-ide@vger.kernel.org

lAlan Cox wrote:
> On Wed, 28 Nov 2007 10:56:21 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Alan Cox wrote:
>>> setup and it821x fixes can go to mainstream for 2.6.25 I think - no bad
>>> reports yet.
>>>
>>> BTW so we don't duplicate work right now I'm working on a full DMA engine
>>> based driver for the INIC162x. Dunno if I'll ever get it to work as the
>>> docs are a bit minimal but we shall see.
>> Great, are you gonna use the ADMA interface?
> 
> This is the plan. I have the driver trying to do this but right now I get
> a single unsolicited CDB back when I reset the bus and my identify
> command times out.

That sounds consistent with my failed try.  I thought the problem was
caused by the controller not willing to switch out of legacy mode.
aLGCY bit of IDMSTAT register indicates that the controller is in legacy
mode.  No matter what I do to it, it just won't go off.  Have you
managed to clear that bit?

Thanks.

-- 
tejun
