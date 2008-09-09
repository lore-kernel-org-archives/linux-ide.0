From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: UDMA failure with UDMA/100 CF card, pata_pdc2027x, MPC8347
Date: Tue, 9 Sep 2008 14:58:11 +0100
Message-ID: <20080909145811.55cc4726@lxorguk.ukuu.org.uk>
References: <48C67C5A.8050006@btconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55175 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752625AbYIIN6x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Sep 2008 09:58:53 -0400
In-Reply-To: <48C67C5A.8050006@btconnect.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: richw@netcomuk.co.uk
Cc: richard.whitlo@btconnect.com, linux-ide@vger.kernel.org

> Having throttled back to PIO4, it seems to work - but does anyone have 
> any ideas why the exceptions in all UDMA modes?

Usually with a CFA device it means you are not using a UDMA capable (and
UDMA rated) adapter. Unfortunately while proper ATA cabling and devices
have a negotiation system there isn't a way to discover this particular
situation.

The boot option "libata.dma=3" disables CFA DMA but leaves ATA and ATAPI
DMA enabled for such cases.
