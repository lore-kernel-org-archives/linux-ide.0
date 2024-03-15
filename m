Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCB71759E
	for <linux-ide@vger.kernel.org>; Fri, 15 Mar 2024 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490132; cv=none; b=ktYP5zSAf3RRW6JBCl+X4EN+ZExUiYNGAq7lUuOMFtWBs1tBgBl4LyDTM1WS/EjMW7NZYmeWVv2t1wtYRI7+SmXzmFXV/7Y5Nqj8EtENkHNZqI0Hwh5YCytQrPFINpNXdnoGhhK2MSTdgLJyPj80k6ErdNTd3BkDfXGyWRce6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490132; c=relaxed/simple;
	bh=Qn/ZckGbQGKiZYx3oE+vJEGq+FJ0baD3c4bmaiVYfIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqrvsmqEJ1fFP0O1TaeTOH8IOSRWMkYbWB2YLAvJvX/oTzzJ76fA92Ru3gUfcIB/wuxn3xtvcCFnAKjHm1c/ffSWjIeHYEbTxd1TMYkegMpOKgmRtiti7QQT+9mAzisABW5kU5/g2sS7MIJ29Yq+kmiIW11+CPkjmm4XBPeddlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSPT3kcF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSPT3kcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984A2C433F1;
	Fri, 15 Mar 2024 08:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710490132;
	bh=Qn/ZckGbQGKiZYx3oE+vJEGq+FJ0baD3c4bmaiVYfIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GSPT3kcF7+FIKJN29dg9wWpaPSqQLvs+wkqUT/9yjneU4B2n0fYcvo2Pc6mlAK+ZJ
	 lmPwpJN+2W8mAMseb270vIiOksQ1Dyoah3e0bvvVFaH7Rlcl3n5SAWFUo5LgO+Fwln
	 W0/hDR6eSaNwgSD6wyZTrooc2tdBds+8hRk7di8cq0eZxIlprdHCgrg+acfDrfFY8Q
	 oIdzAaC7lqnzsziBgu3Nc+K7+GZzym2TD4Lo2D6iidTiRc+R3fGq6NEg6twAYot5Hd
	 ieWhXg2OZUWOSn86lCIlOAgdv0QNtHZjFApxc4zTVU0hTeSwcIWBAnzxxKpFu9s6km
	 64oVcl4r1x0Qw==
Message-ID: <cf873588-4355-4052-b4c6-8f1d86f7bb77@kernel.org>
Date: Fri, 15 Mar 2024 17:08:50 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libata-sata: Check SDB_FIS for completion of DMA
 transfer before completing the commands.
To: Saurav Kashyap <skashyap@marvell.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, soochon@google.com,
 Manoj Phadtare <mphadtare@marvell.com>
References: <20240315054414.27954-1-skashyap@marvell.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240315054414.27954-1-skashyap@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 14:44, Saurav Kashyap wrote:
> This issue is seen on Marvell Controller with device ids 0x9215 and 0x9235.

I do not see 0x9215 listed. Is this one supposed to work OK with generic AHCI ?

> Its reproduced within a minute with block size of 64K, 100 threads,
> 100 jobs and  512 iodepth on AMD platform. With decreased work load it
> takes 8-9 hrs.
> 
> Sequence leading to an issue as per PCIe trace
> - PxSact is read with slots 7 and 24 being cleared.
> - Host starts processing these commands while data is not in system
>   memory yet.

This is a serious hardware bug, but is this issue tied to the fact that the host
is AMD ? Does the same issue happen with different hosts (e.g. Intel, ARM, etc)
? And what about devices ? Do you see this error if you change devices too ? Or
does this happen only with one particular device model/vendor ? (in which case,
the issue could be with the device and not the adapter).

> - Last pkt of 512B was sent to host.
> - SDB.FIS is copied, telling host command slot 24 is done.
> 
> Reading SDB.FIS confirms the transfer is complete.
> 
> Cc: Soochon Radee <soochon@google.com>
> Tested-by: Manoj Phadtare <mphadtare@marvell.com>
> Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
> ---
> v1->v2:
> Added workload and platform related details in the description.
> 
>  drivers/ata/libata-sata.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 0fb1934875f2..7cdeb0a38c5b 100644
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

It really looks like this should be done in ahci_qc_complete() instead of here
per qc. And the fact that you need to do this also tend to indicate that the
*device* is sending incorrect SDB FIS... Are you really sure it is an adapter
issue ?

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

This is not acceptable as-is because this adds overhead for all well-behave
AHCI/SATA adapters that do not have this bug. Given the problem at hand, I am
tempted to suggest that any device attached to these adapters should simply be
marked with ATA_HORKAGE_NONCQ to disable NCQ. But even then, if the adapter
raises an interrupt before all data is transferred, things will break.

I am very reluctant to even try to add a workaround such broken adapter, if this
really turns out to be an adapter issue (as opposed to a device issue).

Have you looked at sata_mv.c ? Anything relevant to these adapters in there ?

>  			ata_qc_complete(qc);
>  			nr_done++;
>  		}

-- 
Damien Le Moal
Western Digital Research

