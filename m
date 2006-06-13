From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 06/10] libata: implement new Power Management framework
Date: Tue, 13 Jun 2006 16:37:04 +0800
Message-ID: <1150187824.7132.42.camel@forrest26.sh.intel.com>
References: <11501274293403-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23349 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750792AbWFMItQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 04:49:16 -0400
In-Reply-To: <11501274293403-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Tue, 2006-06-13 at 00:50 +0900, Tejun Heo wrote:
>  
>  int ata_pci_device_resume(struct pci_dev *pdev)
>  {
> +	struct ata_host_set *first_hset = dev_get_drvdata(&pdev->dev);
> +	struct ata_host_set *host_set;
> +	int tmp, rc = 0;
> +
>  	pci_set_power_state(pdev, PCI_D0);
>  	pci_restore_state(pdev);
>  	pci_enable_device(pdev);
>  	pci_set_master(pdev);
> -	return 0;
> +
> +	for (host_set = first_hset; host_set; host_set = host_set->next) {
> +		tmp = ata_host_set_resume(host_set);
> +		if (tmp)
> +			rc = tmp;
> +	}
> +
> +	return rc;
>  }
>  #endif /* CONFIG_PCI */

Similar here. Is it possible to introduce two controller-level
callbacks, say ->pre_resume(), which is called before
pci_set_power_state(), ->post_resume(), which is called after for()
loop? This is needed by AHCI resume. Otherwise most code of
ata_pci_device_resume() will be duplicated in ahci_pci_device_resume().
Another point is for AHCI resume we need to wait the resume operation of
all ports to complete before calling ->post_resume().

Thanks,
Forrest
