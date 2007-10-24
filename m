From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] jmicron: update quirk for JMB361/3/5/6
Date: Tue, 23 Oct 2007 21:25:39 -0400
Message-ID: <471E9F13.2040600@garzik.org>
References: <20071023062731.GC18322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38329 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753393AbXJXBZl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2007 21:25:41 -0400
In-Reply-To: <20071023062731.GC18322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, ethanhsiao@jmicron.com

Tejun Heo wrote:
> Set bits 0, 4, 5 and 7 of PCI configuration register 0x40 in the
> quirk.  This has the following effects and is recommended by the
> vendor.
> 
> * Force enable of IDE channels (used to be left alone as BIOS
>   configured)
> 
> * Change initial phase behavior of PIO cycle such that the host pulls
>   down the bus instead of tristating it.  Vendor recommends this
>   setting.
> 
> The above settings are better for the current generation of
> controllers and needed for the upcoming next generation.
> 
> Tested on JMB363.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Ethan Hsiao <ethanhsiao@jmicron.com>
> ---
>  drivers/pci/quirks.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: work/drivers/pci/quirks.c
> ===================================================================
> --- work.orig/drivers/pci/quirks.c
> +++ work/drivers/pci/quirks.c
> @@ -1230,7 +1230,7 @@ static void quirk_jmicron_ata(struct pci
>  	case PCI_DEVICE_ID_JMICRON_JMB363:
>  		/* Enable dual function mode, AHCI on fn 0, IDE fn1 */
>  		/* Set the class codes correctly and then direct IDE 0 */
> -		conf1 |= 0x00C2A102; /* Set 1, 8, 13, 15, 17, 22, 23 */
> +		conf1 |= 0x00C2A1B3; /* Set 0, 1, 4, 5, 7, 8, 13, 15, 17, 22, 23 */
>  		break;

applied


