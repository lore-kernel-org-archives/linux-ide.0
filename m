From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: blacklist for early irq problem
Date: Thu, 30 Nov 2006 15:37:33 -0500
Message-ID: <456F410D.9070007@rtr.ca>
References: <200611180759.34622.t.powa@gmx.de> <20061118002357.564dbb9d.akpm@osdl.org> <455F790C.2030509@garzik.org> <456BDCAC.4060609@tw.ibm.com> <456C4514.9090107@tw.ibm.com> <456C4ACC.1050806@rtr.ca> <456C8A51.3000605@garzik.org> <456EA7D6.2050101@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:65040 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1031376AbWK3Uhf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Nov 2006 15:37:35 -0500
In-Reply-To: <456EA7D6.2050101@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, matthieu castet <castet.matthieu@free.fr>, Tobias Powalowski <t.powa@gmx.de>

Albert Lee wrote:
>..
> +	/* Devices with early IRQ */
> +	{ "CD-ROM 36X/AKW",   NULL,		ATA_HORKAGE_EARLY_IRQ },

Ahhh.. the 36X/AKW drive!  I should have known.
This one has caused all kinds of grief in the past for me,
though I no longer remember the exact details of it.

My two drives of this model finally stopped working (mechanically)
earlier this year, and got binned.  Good riddance!

Cheers

