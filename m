From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes take#2] sata_sil24: add DID for another
 adaptec falvor
Date: Fri, 04 Jul 2008 09:10:50 -0400
Message-ID: <486E215A.8020808@garzik.org>
References: <486AED59.7020606@kernel.org> <20080702085517.61909c74@lxorguk.ukuu.org.uk> <486B40B4.30708@kernel.org> <486B414F.2050701@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46214 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430AbYGDNLC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Jul 2008 09:11:02 -0400
In-Reply-To: <486B414F.2050701@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>, Travis Read <ics@dark.net.au>

Tejun Heo wrote:
> There's another DID used for Adaptec card.  Add it.
> 
> Reported by Travis Read.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Travis Read <ics@dark.net.au>
> ---
>  drivers/ata/sata_sil24.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index 8ee6b5b..84ffcc2 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -370,6 +370,7 @@ static const struct pci_device_id sil24_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x3124), BID_SIL3124 },
>  	{ PCI_VDEVICE(CMD, 0x3132), BID_SIL3132 },
>  	{ PCI_VDEVICE(CMD, 0x0242), BID_SIL3132 },
> +	{ PCI_VDEVICE(CMD, 0x0244), BID_SIL3132 },
>  	{ PCI_VDEVICE(CMD, 0x3131), BID_SIL3131 },
>  	{ PCI_VDEVICE(CMD, 0x3531), BID_SIL3131 },
>  

applied


