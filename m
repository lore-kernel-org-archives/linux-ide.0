From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_sil24: configure max read request
 size to 4k
Date: Mon, 27 Oct 2008 23:58:02 -0400
Message-ID: <49068DCA.8010205@garzik.org>
References: <4902AE1E.5020504@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54375 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbYJ1D6K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 23:58:10 -0400
In-Reply-To: <4902AE1E.5020504@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Due to request posting limitations, bandwidth of sil3132 is limited to
> around 120MB/s with the minimum pci-e payload size (128bytes) which is
> used by most consumer systems.  However, write throughput can be
> slightly (~3%) increased by increasing the max read requeset size.
> Configure it to 4k which is the maximum supported.  This optimization
> is also done by SIMG's windows driver.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/sata_sil24.c |    5 +++++
>  1 file changed, 5 insertions(+)
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index 4621807..ccee930 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -1329,6 +1329,11 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		}
>  	}
>  
> +	/* Set max read request size to 4096.  This slightly increases
> +	 * write throughput for pci-e variants.
> +	 */
> +	pcie_set_readrq(pdev, 4096);
> +
>  	sil24_init_controller(host);
>  

applied


