From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious IRQs
Date: Thu, 04 Dec 2008 11:33:43 -0500
Message-ID: <49380667.5040705@rtr.ca>
References: <49263552.8090602@kernel.org>	<20081121102504.63007bf6@lxorguk.ukuu.org.uk>	<492C30EE.9080600@garzik.org>	<492CBA05.8000107@kernel.org>	<20081126104731.4b370d18@lxorguk.ukuu.org.uk>	<492D88B9.7040608@garzik.org>	<492D8B1C.405@kernel.org> <20081126184024.3447c017@lxorguk.ukuu.org.uk> <492D9C30.8080208@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:39098 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbYLDQcd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Dec 2008 11:32:33 -0500
In-Reply-To: <492D9C30.8080208@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Alan Cox wrote:
..
>> We need to start using enable/disable_irq and/or local chip IRQ masking
>> for PIO in some places anyway.
> 
> Agreed.  I think we should use disable/enable_irq for all controller
> which don't have proper IRQ masking mechanism (NIEN doesn't count) for
> both reliability and so that we move PIO out of irq handler.  Jeff,
> this has come up quite a few times now, what do you think?
..

Keep in mind that disable_irq() is nasty for other devices
sharing the same PCI interrupt as the IDE interface..
