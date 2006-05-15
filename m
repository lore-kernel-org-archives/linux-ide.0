From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Promise TX4 + SiI 3726 : only one disk visible
Date: Mon, 15 May 2006 19:40:34 -0400
Message-ID: <44691172.8040402@pobox.com>
References: <6EB652BF05BEE44FA2A29B23F3A71528045B3857@UBIMAIL1.ubisoft.org> <44690D90.2030208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:27603 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750782AbWEOXki (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 19:40:38 -0400
In-Reply-To: <44690D90.2030208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jerome Vuarand <jerome.vuarand@ubisoft.com>, linux-ide@vger.kernel.org, jerome.vuarand@gmail.com

Tejun Heo wrote:
> PMP support requires support from low-level drivers (sata_sil24, 
> sata_promise,...) and sata_promise doesn't have it yet.  As noted above, 
> the only supported card is SiI3124/32 and I'm working on AHCI.  As for 
> sata_promise, I don't know.  I don't have the card nor the document, so 
> it won't come out of me.  Jeff is planning to work on sata_promise and 
> he might also do PM stuff, I guess.

FWIW, for sata_promise (PDC205xx):

I just looked in the docs, for Port Multiplier stuff.  There is a single 
vendor-proprietary 4-bit "PM port" MMIO register for each channel (aka 
each SATA port).

You may program this register only when the port is idle, no active 
commands nor DMA.

	Jeff


