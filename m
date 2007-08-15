From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] pata_hpt37x: actually clock HPT374 with 50 MHz DPLL
 (take 2)
Date: Wed, 15 Aug 2007 04:19:36 -0400
Message-ID: <46C2B718.8030106@garzik.org>
References: <200708102058.46160.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41751 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759014AbXHOITi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 04:19:38 -0400
In-Reply-To: <200708102058.46160.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, rah@bash.sh

Sergei Shtylyov wrote:
> The DPLL tuning code always set up it for 66 MHz due to wrong UltraDMA mask
> including mode 5 used to check for the necessity of 66 MHz clocking -- this
> caused 66 MHz clock to be used for HPT374 chip that does not tolerate it.
> While fixing this, also remove PLL mode from the TODO list -- I don't think
> it's still a relevant item.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> This is against the current Linus tree -- with wording in the header fixed. :-)
> 
>  drivers/ata/pata_hpt37x.c |   12 ++++--------
>  1 files changed, 4 insertions(+), 8 deletions(-)

applied 1-2 to #upstream-fixes


