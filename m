From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] libata: don't set IORDY for reset
Date: Tue, 23 Jun 2009 01:57:32 -0400
Message-ID: <4A406ECC.9090803@garzik.org>
References: <4A30663D.9050008@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47998 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757547AbZFWF5c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Jun 2009 01:57:32 -0400
In-Reply-To: <4A30663D.9050008@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, gnoutchd@union.edu, constantine.gavrilov@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Before issuing reset, libata configures xfermode to PIO0 which makes
> some drivers turn on IORDY which may cause the controller to lock up
> if the port is not occupied.  IORDY isn't necessary at this point
> anyway.  Make ata_pio_need_iordy() return zero if it's being called
> for reset.
> 
> This fixes bko#11703.  Reported and tracked down by Daniel Gnoutcheff
> and Constantine Gavrilov.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Daniel Gnoutcheff <gnoutchd@union.edu>
> Cc: Constantine Gavrilov <constantine.gavrilov@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
>  drivers/ata/libata-core.c |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

applied


