From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 07/13] libata-hp: implement unload-unplug
Date: Fri, 19 May 2006 12:10:21 -0400
Message-ID: <446DEDED.3040200@pobox.com>
References: <11480537073074-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:19626 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932432AbWESQKd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 12:10:33 -0400
In-Reply-To: <11480537073074-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement unload unplug - driver unloading / PCI removal via hot
> unplug path.  This is done by ata_port_detach() which requests detach
> of all devices, schedules EH and wait for it to complete.  EH path is
> slightly modified to handle this (e.g. force zero eh_info during
> unloading).  With this patch, EH and unloading are properly
> synchronized and unloading should be safe under any circumstances.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/ahci.c        |    1 +
>  drivers/scsi/libata-core.c |   47 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/libata-eh.c   |    7 ++++---
>  include/linux/libata.h     |    1 +
>  4 files changed, 53 insertions(+), 3 deletions(-)
> 
> 894a291fa186a541ef3eb74d01f0947fb40ad97e
> diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
> index afb3805..98fffca 100644
> --- a/drivers/scsi/ahci.c
> +++ b/drivers/scsi/ahci.c
> @@ -1396,6 +1396,7 @@ static void ahci_remove_one (struct pci_
>  	for (i = 0; i < host_set->n_ports; i++) {
>  		ap = host_set->ports[i];
>  
> +		ata_port_detach(ap);
>  		scsi_remove_host(ap->host);

Seems like a nice cleanup would be to move scsi_remove_host() into 
ata_port_detach() ?  It would be nice to remove that tidbit of SCSI host 
management from the ->remove() hook in various drivers (mostly ahci, 
sata_sil24, and libata-core).

ACK.

	Jeff



