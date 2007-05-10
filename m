From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.21-mm1 1/2] sata_promise: fix another error decode
 regression
Date: Wed, 09 May 2007 20:16:34 -0400
Message-ID: <46426462.7050900@garzik.org>
References: <200705062012.l46KCVoK026743@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50581 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755357AbXEJAQj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 May 2007 20:16:39 -0400
In-Reply-To: <200705062012.l46KCVoK026743@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> The sata_promise error decode update changed pdc_host_intr()
> to return and not complete the qc after detecting an error.
> Unfortunately not completing the qc:s causes them to always
> time out on error, which is wrong and has nasty side-effects.
> 
> This patch updates pdc_error_intr() to call ata_port_abort(),
> similar to ahci and sata_sil24. Doing this is important as it
> makes EH see the original error and not a bogus timeout.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> ---
> Thanks to Tejun for educating me about the significance of
> ata_port_abort()/ata_port_freeze() in ahci and sata_sil24's
> error intr paths.
> 
>  drivers/ata/sata_promise.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletion(-)

applied 1-2...
