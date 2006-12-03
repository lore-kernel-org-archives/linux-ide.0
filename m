From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.19 1/3] sata_promise: PHYMODE4 fixup
Date: Sun, 03 Dec 2006 08:05:28 -0500
Message-ID: <4572CB98.6050700@garzik.org>
References: <200612010955.kB19twqh002446@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:20941 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1759647AbWLCNFa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Dec 2006 08:05:30 -0500
In-Reply-To: <200612010955.kB19twqh002446@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> This patch adds code to fix up the PHYMODE4 "align timing"
> register value on second-generation Promise SATA chips.
> Failure to correct this value on non-x86 machines makes
> drive detection prone to failure due to timeouts. (I've
> observed about 50% detection failure rates on SPARC64.)
> 
> The HW boots with a bad value in this register, but on x86
> machines the Promise BIOS corrects it to the value recommended
> by the manual, so most people have been unaffected by this issue.
> 
> After developing the patch I checked Promise's SATAII driver,
> and discovered that it also corrects PHYMODE4 just like this
> patch does.
> 
> This patch depends on the sata_promise SATAII updates
> patch I sent recently.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

applied

