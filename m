From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 06/10] libata: implement new Power Management framework
Date: Tue, 13 Jun 2006 16:17:14 +0800
Message-ID: <1150186634.7132.34.camel@forrest26.sh.intel.com>
References: <11501274293403-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3772 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750760AbWFMI3c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 04:29:32 -0400
In-Reply-To: <11501274293403-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Tue, 2006-06-13 at 00:50 +0900, Tejun Heo wrote:

>  int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
>  {
> -	pci_save_state(pdev);
> -	pci_disable_device(pdev);
> +	struct ata_host_set *first_hset = dev_get_drvdata(&pdev->dev);
> +	struct ata_host_set *host_set;
> +	int rc = 0;
> +
> +	for (host_set = first_hset; host_set; host_set = host_set->next) {
> +		rc = ata_host_set_suspend(host_set, state);
> +		if (rc)
> +			break;
> +	}
>  
> -	if (state.event == PM_EVENT_SUSPEND)
> -		pci_set_power_state(pdev, PCI_D3hot);
> +	if (rc == 0) {
> +		pci_save_state(pdev);
> +		pci_disable_device(pdev);
>  
> -	return 0;
> +		if (state.event == PM_EVENT_SUSPEND)
> +			pci_set_power_state(pdev, PCI_D3hot);
> +	} else {
> +		/* Resume the first host_set too if the second one
> +		 * failed to sleep.
> +		 */
> +		if (host_set != first_hset)
> +			ata_host_set_resume(first_hset);
> +	}
> +
> +	return rc;
>  }

Is it possible to add a callback in ata_pci_device_suspend() to do
controller-level operation before calling pci_save_state()......?
One possible solution is to put this callback into a structure together
with host_set.
Otherwise user-defined ahci_pci_device_suspend() will duplicate most
code of ata_pci_device_suspend().

Thanks,
Forrest
