Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990DD125D9
	for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2024 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670332; cv=none; b=KFpm/hKSs3Gys7Rr1k14SjxLxu2BmTZTBmMVB73f1wDiokzX3fcic/CCGKRes55bnYsmkCaw6jgKGaOUz24opm8RyQ4udKS2AP/Le0PA3gFjfpaXKRjLMkQ4NX2eCrSYUZ52IM6ulwu7fqw7CHztAWPVQf9jkbq6wmzCd/PURDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670332; c=relaxed/simple;
	bh=cI6lthDhrG9mGw6b9UN2VGzLufgNTgZJPDaGn2YcuFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f79nFP7k65h6Wwh4YUiBQRPANT0rr9tk6iUQomeDnix2FE+BKX+L3mEknIA1T3FS9t+IgHep36xBK8d7o5Fsb60BGN2LC6pQC2dMzysAhEbZ+guNnxzd8FN5MvVcsFhWn0Z+oPN+6XE8yuEBReBNAsshdsBcOcvjE6QtV7MJ7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVp1oGY/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVp1oGY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6CDC43394;
	Fri, 23 Feb 2024 06:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708670332;
	bh=cI6lthDhrG9mGw6b9UN2VGzLufgNTgZJPDaGn2YcuFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PVp1oGY/OoPoPwCZGohqspxVFH5Mvi1tnHO8BHUZCcmiWBJf7T8SZbjlI4PEh+j0O
	 fkfUK4v16jKg4ejxLzIcsmOkI0YtBW5X5We/bgWsaNH6s/eEPQqTK1MeZ2pOoeqhBS
	 zvQUkAnStLgKRCvXxbF94qbxoRdv5O4fyyBrZj3s9wZjjAF/n4WmNoBpbiw4jmXRWZ
	 LkKLdBuf0Ku8zT3am+LCZocqMa8OGAo4QEwZbNNfql0aj6Sxxpt1Ks0Pnsc/eh22Fp
	 NRktL/mUyyEZ2H8HrYcGkyjFBP43bPgFEIlEz/HT4I1oqY4E2iP9A/uSJcrJJBWsxv
	 MsNQUO8dc8yyg==
Message-ID: <6e749e30-a35b-41f1-a4cb-97b6eff8328d@kernel.org>
Date: Fri, 23 Feb 2024 15:38:49 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libata-sata: Check SDB_FIS for completion of DMA transfer
 before completing the commands.
Content-Language: en-US
To: Saurav Kashyap <skashyap@marvell.com>, linux-ide@vger.kernel.org
Cc: soochon@google.com, Manoj Phadtare <mphadtare@marvell.com>
References: <20240223060752.4926-1-skashyap@marvell.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240223060752.4926-1-skashyap@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/23/24 15:07, Saurav Kashyap wrote:
> Sequence leading to an issue as per PCIe trace
> - PxSact is read with slots 7 and 24 being cleared.
> - Host starts processing these commands while data is not in system
>   memory yet.

What ? If the DMA transfers are not completed yet why is the adapter clearing
sact ? That sounds like a very nasty HW bug.

> - Last pkt of 512B was sent to host.
> - SDB.FIS is copied, telling host command slot 24 is done.

And then what ? could you please descibe all of this in more detail ? What
workloads was this ? What is the device used ? etc. This commit messsage is way
too short to describe what seems to be a very serious bug with an adapter that
you are not even mentioning here. Please expand this description.

> 
> Cc: Soochon Radee <soochon@google.com>
> Tested-by: Manoj Phadtare <mphadtare@marvell.com>
> Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
> ---
>  drivers/ata/libata-sata.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index b6656c287175..b2310f3a2a02 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -14,9 +14,11 @@
>  #include <scsi/scsi_eh.h>
>  #include <linux/libata.h>
>  #include <asm/unaligned.h>
> +#include <linux/pci.h>
>  
>  #include "libata.h"
>  #include "libata-transport.h"
> +#include "ahci.h"
>  
>  /* debounce timing parameters in msecs { interval, duration, timeout } */
>  const unsigned int sata_deb_timing_normal[]		= {   5,  100, 2000 };
> @@ -649,6 +651,7 @@ EXPORT_SYMBOL_GPL(sata_link_hardreset);
>  int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active)
>  {
>  	u64 done_mask, ap_qc_active = ap->qc_active;
> +	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>  	int nr_done = 0;
>  
>  	/*
> @@ -677,7 +680,30 @@ int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active)
>  		unsigned int tag = __ffs64(done_mask);
>  
>  		qc = ata_qc_from_tag(ap, tag);
> -		if (qc) {
> +		if (pdev->vendor == PCI_VENDOR_ID_MARVELL_EXT &&
> +		    (pdev->device == 0x9215 || pdev->device == 0x9235)) {
> +			struct ahci_port_priv *pp = ap->private_data;
> +			u8 *rx_fis = pp->rx_fis;
> +
> +			if (pp->fbs_enabled)
> +				rx_fis += ap->link.pmp * AHCI_RX_FIS_SZ;
> +
> +			if (!qc)
> +				continue;
> +
> +			if (ata_is_ncq(qc->tf.protocol)) {
> +				u32 *fis = (u32 *)(rx_fis + RX_FIS_SDB);
> +				u32 fis_active = fis[1];
> +
> +				if ((fis_active & (1 << tag))) {
> +					ata_qc_complete(qc);
> +					nr_done++;
> +				}
> +			} else {
> +				ata_qc_complete(qc);
> +				nr_done++;
> +			}
> +		} else if (qc) {
>  			ata_qc_complete(qc);
>  			nr_done++;
>  		}

-- 
Damien Le Moal
Western Digital Research

