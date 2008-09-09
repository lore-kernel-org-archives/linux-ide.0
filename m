From: Richard Whitlock <richard.whitlo@btconnect.com>
Subject: Re: UDMA failure with UDMA/100 CF card, pata_pdc2027x, MPC8347
Date: Tue, 09 Sep 2008 16:02:28 +0100
Message-ID: <48C69004.9030709@btconnect.com>
References: <48C67C5A.8050006@btconnect.com> <20080909145811.55cc4726@lxorguk.ukuu.org.uk>
Reply-To: richw@netcomuk.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from c2bthomr03.btconnect.com ([213.123.20.121]:7474 "EHLO
	c2bthomr03.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbYIIO5d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Sep 2008 10:57:33 -0400
In-Reply-To: <20080909145811.55cc4726@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org


>> Having throttled back to PIO4, it seems to work - but does anyone have 
>> any ideas why the exceptions in all UDMA modes?
>>     
>
> Usually with a CFA device it means you are not using a UDMA capable (and
> UDMA rated) adapter. Unfortunately while proper ATA cabling and devices
> have a negotiation system there isn't a way to discover this particular
> situation.
>   
We have a 2.6.20 port which uses arch/ppc (rather than arch/powerpc) 
which works fine on identical hardware, so I think everything is UDMA 
capable.
With our 2.6.20 ppc port, libata configures my lexar 4GB 300x CF card to 
run at UDMA/100 within about 1.5 seconds - since it works so well, I 
never really looked at the mechanics of it.
Any more ideas?



