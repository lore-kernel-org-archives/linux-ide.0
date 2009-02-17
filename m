From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] amd74xx: fix typo in drivers/ide/amd74xx.c
Date: Tue, 17 Feb 2009 14:23:42 +0300
Message-ID: <499A9E3E.2030400@ru.mvista.com>
References: <499A5621.5000104@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:20211 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750886AbZBQLXs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Feb 2009 06:23:48 -0500
In-Reply-To: <499A5621.5000104@cn.fujitsu.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wei Yongjun <yjwei@cn.fujitsu.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hello.

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
>  		t &= 0x0f;
>  	else
>  		t |= 0xf0;
>   

Already submitted by Roel Kluin.

MBR, Sergei


