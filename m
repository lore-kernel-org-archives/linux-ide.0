From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 1/3] pata_hpt366: fix cable detection,
Date: Tue, 09 Dec 2008 17:15:34 +0900
Message-ID: <493E2926.4050509@kernel.org>
References: <493E289F.1010000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37700 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbYLIIQN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Dec 2008 03:16:13 -0500
In-Reply-To: <493E289F.1010000@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rt>

Tejun Heo wrote:
> pata_hpt366 is strange in that its two channels occupy two PCI
> functions and both are primary channels and bit1 of PCI configuration
> register 0x5A indicates cable for both channels.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>

I tested this patch for all four combinations of 40/80c cables and it
always worked correctly.

Thanks.

-- 
tejun
