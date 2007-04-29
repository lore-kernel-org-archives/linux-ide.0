From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sat, 28 Apr 2007 23:46:02 -0400
Message-ID: <463414FA.5080802@garzik.org>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu> <4633BEE7.8020005@garzik.org> <4633BF6D.40902@rtr.ca> <46340E63.5070209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56043 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754534AbXD2DqG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 23:46:06 -0400
In-Reply-To: <46340E63.5070209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> and thus clear DRQ, right?  Stuck DRQ after SRST seems odd to me.

Unfortunately not odd on ata_piix, which can get stuck DRQ-on somewhere 
deep inside its IDE emulation engine.  And neither draining the FIFO nor 
SRST nor a couple other tricks ever helped.  The only thing that seemed 
to make any difference was an enable/disable reset via our beloved PCS 
register.

	Jeff


