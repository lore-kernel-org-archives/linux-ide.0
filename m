From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH libata-dev#upstream-fixes] pata_amd: fix an obvious bug
 in cable detection
Date: Sat, 24 Feb 2007 20:52:22 -0500
Message-ID: <45E0EBD6.2010008@garzik.org>
References: <20070205080128.GH1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58320 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933624AbXBYBwZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Feb 2007 20:52:25 -0500
In-Reply-To: <20070205080128.GH1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, stable@kernel.org

Tejun Heo wrote:
> 80c test mask is at bits 18 and 19 of EIDE Controller Configuration
> not 22 and 23.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This makes unreliable cable detection even more unreliable.  Please
> consider for -stable.  Thanks.
> 
>  drivers/ata/pata_amd.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: work/drivers/ata/pata_amd.c
> ===================================================================
> --- work.orig/drivers/ata/pata_amd.c
> +++ work/drivers/ata/pata_amd.c
> @@ -128,7 +128,7 @@ static void timing_setup(struct ata_port
>  
>  static int amd_pre_reset(struct ata_port *ap)
>  {
> -	static const u32 bitmask[2] = {0x03, 0xC0};
> +	static const u32 bitmask[2] = {0x03, 0x0C};
>  	static const struct pci_bits amd_enable_bits[] = {
>  		{ 0x40, 1, 0x02, 0x02 },
>  		{ 0x40, 1, 0x01, 0x01 }
> @@ -247,7 +247,7 @@ static void amd133_set_dmamode(struct at
>   */
>  
>  static int nv_pre_reset(struct ata_port *ap) {
> -	static const u8 bitmask[2] = {0x03, 0xC0};
> +	static const u8 bitmask[2] = {0x03, 0x0C};
>  	static const struct pci_bits nv_enable_bits[] = {

applied


