From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Wed, 23 Jan 2008 16:38:06 +0300
Message-ID: <4797433E.4040707@ru.mvista.com>
References: <200801212144.29511.asalnikov@ru.mvista.com>	<4796526F.1090103@ru.mvista.com> <20080122222207.18221939@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:8109 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751346AbYAWNhQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Jan 2008 08:37:16 -0500
In-Reply-To: <20080122222207.18221939@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, bzolnier@gmail.com

Hello.

Alan Cox wrote:

>>    Why you chose to use ioread32() and iowrite32() if your device is strictly 
>>memory mapped? Those functions add some overhead, and boil down to readl() and 

> There are distinct portability advantages but you shouldn't mix
> ioread32/iowrite32 with ioremap as that isn't guaranteed to work.

    Hm, pci_iomap() boils down to ioremap(), so

> readl/writel does fine and fixes up the driver.

    Which brings up another issue with the latest patch: Anton, where do you 
call ioremap() or something alike to get the virtual address of the registers?

MBR, Sergei
