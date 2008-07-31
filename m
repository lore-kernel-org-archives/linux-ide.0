From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ata_piix: subsys 106b:00a3 is apple ich8m
 too
Date: Thu, 31 Jul 2008 01:50:36 -0400
Message-ID: <489152AC.9060501@garzik.org>
References: <da38d7b90807240227q165cb5elad937973a58bf88f@mail.gmail.com>	 <488D757B.6000002@gmail.com>	 <da38d7b90807280101y44ef5624of99f7038967405a6@mail.gmail.com>	 <da38d7b90807281154p6cd45e0pf0acd83cd583d06a@mail.gmail.com>	 <488E7D0F.4040204@gmail.com> <da38d7b90807282255l5aabd1c7lb763307a5bac9c64@mail.gmail.com> <488EB362.1090307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42425 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbYGaFuj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 01:50:39 -0400
In-Reply-To: <488EB362.1090307@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Felipe Sere <dodofxp@gmail.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Subsys 106b:00a3 also is the weird apple ich8m which chokes when the
> latter two ports are accessed, add it.  Reported by Felipe Sere.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Felipe Sere <dodofxp@gmail.com>
> ---
> This leaves a whole - 00a2.  Is there anyone who can verify whether
> 00a2 exists or not?  I feel a bit uncomfortable about adding it
> blindly.
> 
>  drivers/ata/ata_piix.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index a90ae03..c294121 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -250,6 +250,7 @@ static const struct pci_device_id piix_pci_tbl[] = {
>  	/* Mobile SATA Controller IDE (ICH8M), Apple */
>  	{ 0x8086, 0x2828, 0x106b, 0x00a0, 0, 0, ich8m_apple_sata },
>  	{ 0x8086, 0x2828, 0x106b, 0x00a1, 0, 0, ich8m_apple_sata },
> +	{ 0x8086, 0x2828, 0x106b, 0x00a3, 0, 0, ich8m_apple_sata },
>  	/* Mobile SATA Controller IDE (ICH8M) */
>  	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },

applied


