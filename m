From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Tue, 22 Jan 2008 22:22:07 +0000
Message-ID: <20080122222207.18221939@lxorguk.ukuu.org.uk>
References: <200801212144.29511.asalnikov@ru.mvista.com>
	<4796526F.1090103@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47743 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751346AbYAVWYi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jan 2008 17:24:38 -0500
In-Reply-To: <4796526F.1090103@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Anton Salnikov <asalnikov@ru.mvista.com>, linux-ide@vger.kernel.org, bzolnier@gmail.com

>     Why you chose to use ioread32() and iowrite32() if your device is strictly 
> memory mapped? Those functions add some overhead, and boil down to readl() and 

There are distinct portability advantages but you shouldn't mix
ioread32/iowrite32 with ioremap as that isn't guaranteed to work.
readl/writel does fine and fixes up the driver.

