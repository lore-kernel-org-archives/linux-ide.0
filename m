From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 06/10] libata: implement new Power Management framework
Date: Tue, 13 Jun 2006 14:25:28 +0800
Message-ID: <1150179928.7132.19.camel@forrest26.sh.intel.com>
References: <11501274293403-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:52345 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932925AbWFMGif (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 02:38:35 -0400
In-Reply-To: <11501274293403-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Tue, 2006-06-13 at 00:50 +0900, Tejun Heo wrote:
> @@ -5584,22 +5683,51 @@ int pci_test_config_bits(struct pci_dev 
>  
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

My original understanding is that a host_set represents a physical SATA
controller in a PCI slot. In which case will a SATA controller include
multiple host_set?

Forrest
