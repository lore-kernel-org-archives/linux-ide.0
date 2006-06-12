From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/10] libata: power down controller only on PMSG_SUSPEND
Date: Mon, 12 Jun 2006 12:32:09 -0400
Message-ID: <448D9709.30305@pobox.com>
References: <11501274283030-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51352 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750748AbWFLQcY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2006 12:32:24 -0400
In-Reply-To: <11501274283030-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> The controller only needs to be powered down on PMSG_SUSPEND.  Skip
> powering down for all other messages.  This makes disk suspend prep
> cycle more efficient and helps controllers which have problems waking
> up from D3hot without intervening power removal.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/libata-core.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> 85016ad86323924d10dc99ac9d7e9e5c0b967b8e
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 9a3bd15..51d3b4b 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -5661,7 +5661,10 @@ int ata_pci_device_suspend(struct pci_de
>  {
>  	pci_save_state(pdev);
>  	pci_disable_device(pdev);
> -	pci_set_power_state(pdev, PCI_D3hot);
> +
> +	if (state.event == PM_EVENT_SUSPEND)
> +		pci_set_power_state(pdev, PCI_D3hot);

If this change makes sense for the D0->D3 transition, surely it would 
make sense to cover the other operations (save-state, disable) as well?

	Jeff



