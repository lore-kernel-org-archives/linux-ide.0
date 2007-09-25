From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH] pata_sis: add missing UDMA5 timing value in sis_66_set_dmamode()
Date: Tue, 25 Sep 2007 18:06:42 -0400
Message-ID: <46F98672.7070603@redhat.com>
References: <20070921072905.GC10660@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52108 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbXIYWG6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 18:06:58 -0400
In-Reply-To: <20070921072905.GC10660@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, desaster.area@addcom.de, alan@redhat.com, bzolnier@gmail.com

On 09/21/2007 03:29 AM, Tejun Heo wrote:
> sis_66_set_dmamode() also handles early UDMA100 (SIS630 ET) but is
> missing udma timing value for UDMA100.  According to sis5513, this
> should be 0x8000.  This caused UDMA100 device to fail on pata_sis till
> it downgrades to UDMA66 while it works fine on sis5513 at UDMA100.
> 
> Reported by Adam Blech.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Adam Blech <desaster.area@addcom.de>
> ---
>  drivers/ata/pata_sis.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
> index da3f720..3b5be77 100644
> --- a/drivers/ata/pata_sis.c
> +++ b/drivers/ata/pata_sis.c
> @@ -376,8 +376,9 @@ static void sis_66_set_dmamode (struct ata_port *ap, struct ata_device *adev)
>  	int drive_pci = sis_old_port_base(adev);
>  	u16 timing;
>  
> +	/* MWDMA 0-2 and UDMA 0-5 */
>  	const u16 mwdma_bits[] = { 0x008, 0x302, 0x301 };
> -	const u16 udma_bits[]  = { 0xF000, 0xD000, 0xB000, 0xA000, 0x9000};
> +	const u16 udma_bits[]  = { 0xF000, 0xD000, 0xB000, 0xA000, 0x9000, 0x8000 };
>  
>  	pci_read_config_word(pdev, drive_pci, &timing);
>  

Is this going into 2.6.23?
It's not in 2.6.23-rc8-mm1...
