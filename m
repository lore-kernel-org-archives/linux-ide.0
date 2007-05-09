From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch] Add the device IDs for AMD/ATI SB700
Date: Wed, 09 May 2007 15:09:33 +0200
Message-ID: <4641C80D.7020108@gmail.com>
References: <FFECF24D2A7F6D418B9511AF6F3586020197F6A6@shacnexch2.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-7
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:43676 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679AbXEINKI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 May 2007 09:10:08 -0400
Received: by py-out-1112.google.com with SMTP id a29so151415pyi
        for <linux-ide@vger.kernel.org>; Wed, 09 May 2007 06:10:07 -0700 (PDT)
In-Reply-To: <FFECF24D2A7F6D418B9511AF6F3586020197F6A6@shacnexch2.atitech.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Henry Su <henry.su@amd.com>
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, bzolnier@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, xiaosuzi520@hotmail.com

Henry Su wrote:
> --- linux-2.6.21.1.orig/drivers/ide/pci/atiixp.c	2007-05-10 06:30:17.000000000 +0800
> +++ linux-2.6.21.1/drivers/ide/pci/atiixp.c	2007-05-10 07:18:39.000000000 +0800
> @@ -353,6 +353,7 @@ static struct pci_device_id atiixp_pci_t
>  	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>  	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>  	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
> +	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_IDE, PCI_ANY_ID, 
> +PCI_ANY_ID, 0, 0, 1},
>  	{ 0, },
>  };
>  MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
> 
> --- linux-2.6.21.1.orig/drivers/ata/ahci.c	2007-05-10 06:30:14.000000000 +0800
> +++ linux-2.6.21.1/drivers/ata/ahci.c	2007-05-10 07:41:41.000000000 +0800
> @@ -415,6 +415,7 @@ static const struct pci_device_id ahci_p
>  	/* ATI */
>  	{ PCI_VDEVICE(ATI, 0x4380), board_ahci_sb600 }, /* ATI SB600 non-raid */
>  	{ PCI_VDEVICE(ATI, 0x4381), board_ahci }, /* ATI SB600 raid */

Wasn't there a patch which dropped SB600 raid entry?  I think I heard
there's no device which has 0x4381 as its DID.

-- 
tejun
