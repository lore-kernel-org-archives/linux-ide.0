From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: waits up to 10 microseconds for early irq problem
Date: Tue, 28 Nov 2006 14:13:21 -0500
Message-ID: <456C8A51.3000605@garzik.org>
References: <200611180759.34622.t.powa@gmx.de> <20061118002357.564dbb9d.akpm@osdl.org> <455F790C.2030509@garzik.org> <456BDCAC.4060609@tw.ibm.com> <456C4514.9090107@tw.ibm.com> <456C4ACC.1050806@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:10132 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S936041AbWK1TN1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 14:13:27 -0500
In-Reply-To: <456C4ACC.1050806@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: albertl@mail.com, Linux IDE <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, matthieu castet <castet.matthieu@free.fr>, Tobias Powalowski <t.powa@gmx.de>

Mark Lord wrote:
> It's only worthwhile if the poll was actually necessary.
> My question is, do we really want this overhead in the hot path
> on every single ATA interrupt, or should we instead simply blacklist
> those devices with the problem?


Nod...  that's my thinking as well

	Jeff


