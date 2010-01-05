From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Fix Promise UDMA33 IDE driver (pdc202xx_old)
Date: Mon, 04 Jan 2010 22:26:58 -0800 (PST)
Message-ID: <20100104.222658.93634328.davem@davemloft.net>
References: <20100103002314.GA16528@flint.arm.linux.org.uk>
	<20100103223542.GA24920@flint.arm.linux.org.uk>
	<4B423E2F.9040808@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:51917
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753927Ab0AEG04 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jan 2010 01:26:56 -0500
In-Reply-To: <4B423E2F.9040808@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: rmk@arm.linux.org.uk, linux-ide@vger.kernel.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Date: Mon, 04 Jan 2010 22:14:55 +0300

>    I suggest that we completely ignore the "FIFO empty"
>    bit. dma_test_irq() method which is called eventually when doing FMA
>    should yield the needed result WRT FIFO flushing, filtering out .

Can someone implement and test such a revised patch?

Thanks!
