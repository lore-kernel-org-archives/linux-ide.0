From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.26-rc2 1/3] sata_promise: fix irq clearing buglets
Date: Mon, 19 May 2008 17:42:41 -0400
Message-ID: <4831F451.5050801@garzik.org>
References: <200805171647.m4HGlZFW015961@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38607 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763736AbYESVmn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 May 2008 17:42:43 -0400
In-Reply-To: <200805171647.m4HGlZFW015961@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> This patch fixes two bugs in sata_promise's irq status clearing paths:
> 1. When clearing the irq status for a specific port, the driver
>    read the global SEQMASK register. This is wrong because that
>    clears the irq status for _all_ ports.
> 2. pdc_thaw() incorrectly added the PDC_INT_SEQMASK host register
>    offset to a per-port ata engine base address. This resulted in
>    it reading the unrelated PDC_PKT_SUBMIT register, which did not
>    have the desired irq status clearing effect.
> 
> In both cases the fix is to read from the port's Command/Status
> register. This also matches what Promise's own driver does.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> ---
>  drivers/ata/sata_promise.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

applied 1-3


