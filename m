From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 00/68] ide2libata
Date: Tue, 02 Feb 2010 15:29:13 -0800 (PST)
Message-ID: <20100202.152913.168590626.davem@davemloft.net>
References: <4B68B0CF.1040907@garzik.org>
	<20100202.151900.211475917.davem@davemloft.net>
	<20100202232748.61e29030@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55340
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754469Ab0BBX3B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Feb 2010 18:29:01 -0500
In-Reply-To: <20100202232748.61e29030@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: jeff@garzik.org, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 2 Feb 2010 23:27:48 +0000

>> If the drivers get truly shared between IDE and ATA, that
>> presumption is entirely removed, the ATA testers will
>> be hitting the same driver code that whatever remaining
>> IDE users will be.
> 
> Assuming the data structures matching does that is a bit like assuming
> you can test one TCP stack using another one because they use the same
> packet format.

I don't really think those two situations are the same.

And Bart's patch set show that things are pretty darn
close already.
