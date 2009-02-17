From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] amd74xx: fix typo in drivers/ide/amd74xx.c
Date: Tue, 17 Feb 2009 01:47:07 -0500
Message-ID: <499A5D6B.7010008@garzik.org>
References: <499A5621.5000104@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56836 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488AbZBQGrN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Feb 2009 01:47:13 -0500
In-Reply-To: <499A5621.5000104@cn.fujitsu.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wei Yongjun <yjwei@cn.fujitsu.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Wei Yongjun wrote:
> Fix the typo of dev->vendor to dev->device.
> 
> Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>
> ---
>  drivers/ide/amd74xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
> index 69660a4..77267c8 100644
> --- a/drivers/ide/amd74xx.c
> +++ b/drivers/ide/amd74xx.c
> @@ -166,7 +166,7 @@ static unsigned int init_chipset_amd74xx(struct pci_dev *dev)
>  	 * Check for broken FIFO support.
>  	 */
>  	if (dev->vendor == PCI_VENDOR_ID_AMD &&
> -	    dev->vendor == PCI_DEVICE_ID_AMD_VIPER_7411)
> +	    dev->device == PCI_DEVICE_ID_AMD_VIPER_7411)

Acked-by: Jeff Garzik <jgarzik@redhat.com>


