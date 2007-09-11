From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] IDE fixes for 2.6.23-rc6
Date: Tue, 11 Sep 2007 19:40:32 -0400
Message-ID: <46E72770.5070608@garzik.org>
References: <200709112237.40613.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49305 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755049AbXIKXkh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Sep 2007 19:40:37 -0400
In-Reply-To: <200709112237.40613.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Please pull from:
> 
> master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/
> 
> to receive the following updates:
> 
>  drivers/ata/pata_ali.c         |    7 ++
>  drivers/ide/Kconfig            |    4 +-
>  drivers/ide/ide-iops.c         |    3 +-
>  drivers/ide/pci/alim15x3.c     |    7 ++
>  drivers/ide/pci/hpt366.c       |  138 +++++++++++++++++++++++-----------------
>  drivers/ide/pci/pdc202xx_new.c |    9 ++-
>  drivers/ide/pci/via82cxxx.c    |   15 +++-
>  drivers/ide/ppc/mpc8xx.c       |    1 -
>  drivers/ide/setup-pci.c        |   41 +++++-------
>  include/linux/ide.h            |   13 ++++
>  10 files changed, 141 insertions(+), 97 deletions(-)
> 
> 
> Bartlomiej Zolnierkiewicz (1):
>       via82cxxx: add Arima W730-K8 and other rebadgings to short cables list
> 
> Daniel Exner (1):
>       pata_ali/alim15x3: override 80-wire cable detection for Toshiba S1800-814
> 
> Kumar Gala (1):
>       mpc8xx: Only build mpc8xx on arch/ppc
> 
> Mikael Pettersson (1):
>       pdc202xx_new: PLL detection fix
> 
> Sergei Shtylyov (5):
>       ide: fix PCI refcounting
>       pdc202xx_new: fix PCI refcounting
>       hpt366: fix PCI clock detection for HPT374 (take 4)
>       ide: add ide_dev_is_sata() helper (take 2)
>       hpt366: UltraDMA filter for SATA cards (take 2)
> 
> Tony Breeds (1):
>       pmac: build fix
> 
> 
> diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
> index 94e5edc..71bdc3b 100644
> --- a/drivers/ata/pata_ali.c
> +++ b/drivers/ata/pata_ali.c
> @@ -48,6 +48,13 @@ static struct dmi_system_id cable_dmi_table[] = {
>  			DMI_MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736"),
>  		},
>  	},
> +	{
> +		.ident = "Toshiba Satelite S1800-814",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "S1800-814"),
> +		},
> +	},
>  	{ }
>  };
>  

ACK


