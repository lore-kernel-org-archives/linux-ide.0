From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: add PCI ID for new VIA chip
Date: Tue, 17 Apr 2007 10:50:45 -0400
Message-ID: <4624DEC5.80403@garzik.org>
References: <6f61137b0704021327r29739526g359a94567f123a4d@mail.gmail.com> <20070411082714.GC10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39812 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030574AbXDQOut (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 10:50:49 -0400
In-Reply-To: <20070411082714.GC10619@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Maarten Vanraes <maarten.vanraes@gmail.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Add PCI ID for new VIA chip.  Original patch is from Maarten Vanraes.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Maarten Vanraes <maarten.vanraes@gmail.com>
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index faa7588..3675964 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -413,6 +413,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  
>  	/* VIA */
>  	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */
> +	{ PCI_VDEVICE(VIA, 0x6287), board_ahci_vt8251 }, /* VIA VT8251 */
>  
>  	/* NVIDIA */
>  	{ PCI_VDEVICE(NVIDIA, 0x044c), board_ahci },		/* MCP65 */

applied.

I also have a couple other VIA PCI ID updates that I need to apply, 
which were submitted recently from VIA themselves.

	Jeff



