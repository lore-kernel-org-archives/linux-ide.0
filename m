From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [patch] SB700 contains more than one IDE channel
Date: Thu, 27 Sep 2007 16:18:47 +0400
Message-ID: <46FB9FA7.7090403@ru.mvista.com>
References: <5CAB7B5D6F8AB84AA868A46B47A5070544C164@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:32550 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751205AbXI0MTG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 08:19:06 -0400
In-Reply-To: <5CAB7B5D6F8AB84AA868A46B47A5070544C164@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <Shane.Huang@amd.com>, bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, gregkh@suse.de, "Su, Henry" <Henry.Su@amd.com>

Hello.

Shane Huang wrote:

> SB700 supports one physical IDE channel, but SB700 SATA controller
> supports combined mode. When the SATA combined mode is enabled,
> two SATA ports(port4 and port5) share one IDE channel from IDE
> controller, and PATA will share the other IDE channel.

> Our previous patch adding SB700 IDE device ID only support one
> IDE channel, which contains bug. The attached patch fix the bug.

> Signed-off-by: shane.huang@amd.com

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ----------------------------------------------
> diff -ruN linux-2.6.23-rc5_orig/drivers/ide/pci/atiixp.c
> linux-2.6.23-rc5/drivers/ide/pci/atiixp.c
> --- linux-2.6.23-rc5_orig/drivers/ide/pci/atiixp.c	2007-09-01
> 14:08:24.000000000 +0800
> +++ linux-2.6.23-rc5/drivers/ide/pci/atiixp.c	2007-09-28
> 00:35:55.000000000 +0800
> @@ -325,7 +325,7 @@
>  	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 0},
>  	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 0},
>  	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 1},
> -	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_IDE, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 1},
> +	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_IDE, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 0},
>  	{ 0, },
>  };
>  MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);

    The inlined patch has suffered from word wrapping, and the attached one 
luckily didn't; yet the attachment has a wrong MIME type -- patches should be 
text/plain.

MBR, Sergei
