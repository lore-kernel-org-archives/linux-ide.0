From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: SB600 ahci can't do MSI
Date: Tue, 29 Apr 2008 17:43:53 -0400
Message-ID: <48179699.1020004@garzik.org>
References: <4816C9A2.9000503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40841 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326AbYD2Vnz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 17:43:55 -0400
In-Reply-To: <4816C9A2.9000503@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Shane Huang <Shane.Huang@amd.com>

Tejun Heo wrote:
> SB600 ahci can't do MSI.  Blacklist it.
> 
> This fixes bz#10507.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Shane Huang <Shane.Huang@amd.com>
> ---
> drivers/ata/ahci.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: tree0/drivers/ata/ahci.c
> ===================================================================
> --- tree0.orig/drivers/ata/ahci.c
> +++ tree0/drivers/ata/ahci.c
> @@ -433,7 +433,7 @@ static const struct ata_port_info ahci_p
>     /* board_ahci_sb600 */
>     {
>         AHCI_HFLAGS    (AHCI_HFLAG_IGN_SERR_INTERNAL |
> -                 AHCI_HFLAG_32BIT_ONLY |
> +                 AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_MSI |
>                  AHCI_HFLAG_SECT255 | AHCI_HFLAG_NO_PMP),
>         .flags        = AHCI_FLAG_COMMON,
>         .link_flags    = AHCI_LFLAG_COMMON,

applied


