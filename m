From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/6] sata_sil: kill bogus PCI ID 0x1095/0x0240
Date: Sun, 05 Mar 2006 02:41:47 -0500
Message-ID: <440A963B.4080406@pobox.com>
References: <11415422321792-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:22987 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752082AbWCEHlu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 02:41:50 -0500
In-Reply-To: <11415422321792-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Silicon Image confirmed that 0x1095/0x0240 has never been used for
> 3112.  Kill it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Carlos Pardo <Carlos.Pardo@siliconimage.com>
> 
> ---
> 
>  drivers/scsi/sata_sil.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> 4c960f8b73294d01b9307ea6775304fc8556e550
> diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
> index 8cb662d..0d962a4 100644
> --- a/drivers/scsi/sata_sil.c
> +++ b/drivers/scsi/sata_sil.c
> @@ -90,7 +90,6 @@ static void sil_post_set_mode (struct at
>  
>  static const struct pci_device_id sil_pci_tbl[] = {
>  	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
> -	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
>  	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3512 },
>  	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
>  	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },


These things just don't get made up out of thin air.  I'm wonder if it 
applies to a Silicon Image product running under a proprietary driver, 
or OEM product with a bunch of SiI chips on it.  In any case, I'm 
reluctant to remove it.

	Jeff


