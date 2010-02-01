From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 00/68] ide2libata
Date: Mon, 01 Feb 2010 03:17:25 -0800 (PST)
Message-ID: <20100201.031725.144446744.davem@davemloft.net>
References: <20100129232540.41f6c4f6@lxorguk.ukuu.org.uk>
	<20100131.234726.124893364.davem@davemloft.net>
	<20100201110723.54870f7f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38029
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751648Ab0BALRM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2010 06:17:12 -0500
In-Reply-To: <20100201110723.54870f7f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: jeff@garzik.org, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 1 Feb 2010 11:07:23 +0000

> I'm amazed that you'd suggest trashing the current ATA stack to make the
> maintenance of the old ones easier - which aren't supposed to be in flux
> in the first place.

I'm not, I'm saying leave the ATA stack as it is, but make the IDE
legacy layer such that PATA drivers can compile into it.
