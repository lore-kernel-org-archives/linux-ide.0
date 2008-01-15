From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] [POWERPC] pasemi: Move electra-ide to pata_of_platform
Date: Tue, 15 Jan 2008 14:42:11 -0500
Message-ID: <478D0C93.8060204@garzik.org>
References: <20080109190852.GA18827@localhost.localdomain> <20080115164033.GA25328@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40931 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbYAOTm1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Jan 2008 14:42:27 -0500
In-Reply-To: <20080115164033.GA25328@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

Olof Johansson wrote:
> Move electra-ide glue over to the new pata_of_platform framework, and
> add the quirks needed to that driver.
>     
> ---
> 
> Applied with the rest of the patches to pasemi.git for-2.6.25
> 
>  arch/powerpc/platforms/pasemi/electra_ide.c |   96 ----------------------------
>  b/arch/powerpc/configs/pasemi_defconfig     |    4 -
>  b/arch/powerpc/platforms/pasemi/Kconfig     |    9 --
>  b/arch/powerpc/platforms/pasemi/Makefile    |    1 
>  b/drivers/ata/pata_of_platform.c            |   20 ++++-
> 5 files changed, 17 insertions(+), 113 deletions(-)

ACK


