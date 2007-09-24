From: Mark Lord <liml@rtr.ca>
Subject: Re: CompactFlash and HD unhappy together on the same IDE channel
Date: Mon, 24 Sep 2007 18:03:00 -0400
Message-ID: <46F83414.2040809@rtr.ca>
References: <46C69913.1060505@g7.org>	<46C799E8.8080407@rtr.ca>	<20070819175632.349d11c5@the-village.bc.nu>	<46EC70A0.1000800@g7.org>	<20070922191248.5f2bc74a@the-village.bc.nu>	<46F693BD.8070604@rtr.ca> <20070923184045.6358014a@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2254 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754354AbXIXWDB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Sep 2007 18:03:01 -0400
In-Reply-To: <20070923184045.6358014a@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Malcolm Gillies <malcolm@g7.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> The solution is beginning to look more and more obvious:  default to not use MDMA
>> modes for CF devices at boot.  And eventually provide a sysfs or libata parameter
>> (or support/snoop SET_XFER_MODE) to change the mode later.
> 
> I strongly disagree.
> 
> We need to understand *why*, we need to fix any actual bugs we have.
> Lots and lots of people have no problems here. The people with problems
> and pure PATA all seem to have piix chips.

Well, there's a reasonable point.

But when we see a CF card on a *SATA* controller, we *know* there's a bridge chip
in there someplace, and we know that the common bridges don't do MWDMA.

Cheers
