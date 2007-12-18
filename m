From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 9/9] pata_legacy: restructure and revamp
Date: Tue, 18 Dec 2007 17:08:42 -0500
Message-ID: <476844EA.10204@garzik.org>
References: <200712140001.lBE01j6b025453@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43144 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754464AbXLRWIo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2007 17:08:44 -0500
In-Reply-To: <200712140001.lBE01j6b025453@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> Rework the pata_legacy driver to have an internal way to plug multiple
> legacy interface types and designs into the driver.
> 
> This driver supports
> 	- Generic legacy ISA on primary/secondary and tertiary ports
> 	- BIOS or jumper configured legacy ports
> 	- VLB controllers that snoop the mode set for PIO
> 		(Cirrus CLPD7220, Adaptec AIC25VL01)
> 	- Promise PDC20230
> 	- Holtek 6560A/B
> 	- Opti VLB controllers
> 	- QDI 6500/6580/6580DP controllers
> 
> The new driver also adds an "all" option so you can load all the PCI
> drivers you have, decide you have a controller that is totally unknown and
> then load pata_legacy all=1 to grab the primary/secondary ports as a last
> resort fallback.
> 
> TODO:
> 	Add ST412 support (needs some kind of geometry hook in libata core code)
> 	Winbond W83759A in programmable mode (aka DTC2278)
> 	Find more insane VLB controllers to support
> 
> This driver obsoletes pata_qdi, which can go once this is settled in.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_legacy.c |  765 ++++++++++++++++++++++++++++--------
>  1 file changed, 607 insertions(+), 158 deletions(-)

ACK but needs rediffing


