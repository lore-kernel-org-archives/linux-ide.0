From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ahci: qoriq: fixed using uninitialized variable warnings
Date: Wed, 9 Sep 2015 12:57:19 +0200
Message-ID: <55F0108F.30609@redhat.com>
References: <1441790182-20248-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46927 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbbIIK5W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Sep 2015 06:57:22 -0400
In-Reply-To: <1441790182-20248-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuantian.Tang@freescale.com
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Hi,

On 09-09-15 11:16, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
>
> kbuild test robot reports the warnings:
> drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
>>> include/asm-generic/io.h:163:2: warning: 'px_is' may be used
>>> uninitialized in this function [-Wuninitialized]
> drivers/ata/ahci_qoriq.c:70:14: note: 'px_is' was declared here
>>> include/asm-generic/io.h:163:2: warning: 'px_cmd' may be used
>>> uninitialized in this function [-Wuninitialized]
> drivers/ata/ahci_qoriq.c:70:6: note: 'px_cmd' was declared here
>
> This patch fixed it by assigning 0 to px_is and px_cmd variables.
> This patch also remove line 'struct ccsr_ahci *reg_base' which is
> not referred by any other codes and thus a dead one.
>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>

LGTM: Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/ata/ahci_qoriq.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
> index e5e4988..f790852 100644
> --- a/drivers/ata/ahci_qoriq.c
> +++ b/drivers/ata/ahci_qoriq.c
> @@ -49,7 +49,6 @@ enum ahci_qoriq_type {
>   };
>
>   struct ahci_qoriq_priv {
> -	struct ccsr_ahci *reg_base;
>   	enum ahci_qoriq_type type;
>   	void __iomem *ecc_addr;
>   };
> @@ -67,7 +66,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
>   {
>   	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
>   	void __iomem *port_mmio = ahci_port_base(link->ap);
> -	u32 px_cmd, px_is, px_val;
> +	u32 px_cmd = 0, px_is = 0, px_val;
>   	struct ata_port *ap = link->ap;
>   	struct ahci_port_priv *pp = ap->private_data;
>   	struct ahci_host_priv *hpriv = ap->host->private_data;
>
