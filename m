From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] ide update
Date: Fri, 19 Aug 2005 00:08:54 +0100
Message-ID: <1124406535.20755.12.camel@localhost.localdomain>
References: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:4505 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932504AbVHRWln (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Aug 2005 18:41:43 -0400
In-Reply-To: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Iau, 2005-08-18 at 23:37 +0200, Bartlomiej Zolnierkiewicz wrote:
> +	},{	/* 14 */
> +		.name		= "Revolution",
> +		.init_hwif	= init_hwif_generic,
> +		.channels	= 2,
> +		.autodma	= AUTODMA,
> +		.bootable	= OFF_BOARD,
>   	}

This seems rather odd - the driver asks for AUTODMA yet because its IDE
generic contains no code to retune the device interface for DMA ?


BTW whats the status on the CS5535 driver that someone submitted a while
back ?

