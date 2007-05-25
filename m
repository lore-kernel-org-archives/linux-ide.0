From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch] Add the device IDs for AMD/ATI SB700
Date: Thu, 24 May 2007 23:00:04 -0400
Message-ID: <46565134.9040009@garzik.org>
References: <FFECF24D2A7F6D418B9511AF6F3586020197F6A6@shacnexch2.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-7
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50638 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752632AbXEYDAK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 23:00:10 -0400
In-Reply-To: <FFECF24D2A7F6D418B9511AF6F3586020197F6A6@shacnexch2.atitech.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Henry Su <henry.su@amd.com>
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, bzolnier@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, xiaosuzi520@hotmail.com

Henry Su wrote:
> --- linux-2.6.21.1.orig/drivers/ata/pata_atiixp.c	2007-05-10 06:30:14.000000000 +0800
> +++ linux-2.6.21.1/drivers/ata/pata_atiixp.c	2007-05-10 07:17:07.000000000 +0800
> @@ -283,6 +283,7 @@ static const struct pci_device_id atiixp
>  	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP300_IDE), },
>  	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP400_IDE), },
>  	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP600_IDE), },
> +	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP700_IDE), },


Patch applied manually.

Your patches are all technically correct -- but you really need to fix
your email so that we can receive and apply your patches via scripts.

This is a basic step that every kernel contributor needs to take.

	Jeff


