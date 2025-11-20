Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C1283151
	for <linux-ide@vger.kernel.org>; Thu, 20 Nov 2025 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627685; cv=none; b=VmDC5m14fbpcaR8S4dJ1BEEvV8HZ4WTxoxuzBp4jAWube0TysOctqeZz+k+j2SQ4BeJCF4YR6lET2cH4TLhxHaDoxaUuBGYP9I0xTNZhS2+LaepCw2X4qdJgpNycfiCF+CVCjHGUgYUubTlF5s15hSITL5lsPbQAaekN5yqmHvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627685; c=relaxed/simple;
	bh=TRfw8nHJpchQfRHnEH7J5kv9DkRg2dBGbqBhvz68elU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1z5miPWRR0Q20lA6qtsNBokwxlTu0f32UkSCr6jMs+gVDn8HKOyOu23CrM1djyIK3dNhdzBD/0CFc5dv8SX6j5wzGghOXInLdCNRdak1igEv0l53at8occHLMy7F9WUAbn0p9j48bRXej7Fl2Q9LrPV7H0sLmEaLdJjRHKPdPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ragfpbNo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ragfpbNo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E68C4CEF1;
	Thu, 20 Nov 2025 08:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763627684;
	bh=TRfw8nHJpchQfRHnEH7J5kv9DkRg2dBGbqBhvz68elU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ragfpbNoOVnVqWho9FCJYuYuMnGsMMfHbLIIuXxT2j7RvXU8OXmQF4INfcjPO11mT
	 t4j0tGkBJLE9Xj27K9qPUjPafAM3xTynjbxALY7j/EJcD1J1LhhmXHWk0XA7rNsNPY
	 cGwPrY9Zloc5TXNcmHIpYSti1WyryY4Zv1tFPXqjg/w2DemrPHCMHrLOFiyPIYexMk
	 0Rms2RyDKN9OQJ/1EAyvGt7GzI9lvQPmymf0YkKrS4gEcCR549sp1nye3IIVgyVeaC
	 HEb//eOCpTYoAUDAzC64K2rtmNHkfLVdyjhtoxRK4xMRq9kjNqoFFxWzQakEjIN8NA
	 QkkNbbeciKZpw==
Message-ID: <27a5386e-1cc9-438b-bf05-41f7dcbb3f77@kernel.org>
Date: Thu, 20 Nov 2025 17:30:38 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: avoid long timeouts on hot-unplugged SATA
 DAS
To: Henry Tseng <henrytseng@qnap.com>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
 Kevin Ko <kevinko@qnap.com>, SW Chen <swchen@qnap.com>
References: <20251120073513.702344-1-henrytseng@qnap.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251120073513.702344-1-henrytseng@qnap.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 4:35 PM, Henry Tseng wrote:
> When a SATA DAS enclosure is connected behind a Thunderbolt PCIe
> switch, hot-unplugging the whole enclosure causes pciehp to tear down
> the PCI hierarchy before the SCSI layer issues SYNCHRONIZE CACHE and
> START STOP UNIT for the disks.
> 
> libata still queues these commands and the AHCI driver tries to access
> the HBA registers even though the PCI channel is already offline. This
> results in a series of timeouts and error recovery attempts, e.g.:
> 
>   [  824.778346] pcieport 0000:00:07.0: pciehp: Slot(14): Link Down
>   [  891.612720] ata8.00: qc timeout after 5000 msecs (cmd 0xec)
>   [  902.876501] ata8.00: qc timeout after 10000 msecs (cmd 0xec)
>   [  934.107998] ata8.00: qc timeout after 30000 msecs (cmd 0xec)
>   [  936.206431] sd 7:0:0:0: [sda] Synchronize Cache(10) failed:
>       Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
>   ...
>   [ 1006.298356] ata1.00: qc timeout after 5000 msecs (cmd 0xec)
>   [ 1017.561926] ata1.00: qc timeout after 10000 msecs (cmd 0xec)
>   [ 1048.791790] ata1.00: qc timeout after 30000 msecs (cmd 0xec)
>   [ 1050.890035] sd 0:0:0:0: [sdb] Synchronize Cache(10) failed:
>       Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> 
> With this patch applied, the same hot-unplug looks like:
> 
>   [   55.452526] pcieport 0000:00:07.0: pciehp: Slot(14): Link Down
>   [   55.496563] sd 7:0:0:0: [sda] Synchronize Cache(10) failed:
>       Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
>   [   55.617450] sd 0:0:0:0: [sdb] Synchronize Cache(10) failed:
>       Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> 
> In this test setup with two disks, the hot-unplug sequence shrinks from
> about 226 seconds (~3.8 minutes) between the Link Down event and the
> last SYNCHRONIZE CACHE failure to under 200 ms. Without this patch the
> total delay grows roughly with the number of disks, because each disk
> gets its own SYNCHRONIZE CACHE and qc timeout series.
> 
> If the underlying PCI device is already gone, these commands cannot
> succeed anyway. Avoid issuing them by introducing
> ata_port_pci_channel_offline(), which checks pci_channel_offline() for
> PCI-based hosts and is used in both ata_scsi_queuecmd() and
> ata_qc_issue().
> 
> For SCSI-originated commands we now complete the request immediately
> with DID_BAD_TARGET instead of queuing it. For internal ATA commands
> we fail the qc with AC_ERR_SYSTEM early without touching the HBA
> registers.
> 
> With this change, SYNCHRONIZE CACHE issued during hot-unplug fails
> quickly with DID_BAD_TARGET, without qc timeout spam, and the whole
> unplug completes much faster.

Wao... a hot-pluggable AHCI adapter. That is a new one...
And super dangerous with libata & AHCI driver as is: if the drives connected to
this adapter are not also declared as removabe devices and their write cache
disabled, random unplug of the drives will corrupt data/FS on the drive.

I understand what you are trying to fix here, but do not expect this setup to
be reliable without more patches.

See comments below.


> Signed-off-by: Henry Tseng <henrytseng@qnap.com>
> ---
>  drivers/ata/libata-core.c |  3 +++
>  drivers/ata/libata-scsi.c |  3 ++-
>  drivers/ata/libata.h      | 16 ++++++++++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 2a210719c4ce..49a59a90e8eb 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5060,6 +5060,9 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
>  		if (ata_sg_setup(qc))
>  			goto sys_err;
>  
> +	if (ata_port_pci_channel_offline(ap))
> +		goto sys_err;
> +
>  	/* if device is sleeping, schedule reset and abort the link */
>  	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
>  		link->eh_info.action |= ATA_EH_RESET;
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index b43a3196e2be..a49fd4bbf321 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4388,7 +4388,8 @@ int ata_scsi_queuecmd(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
>  	spin_lock_irqsave(ap->lock, irq_flags);
>  
>  	dev = ata_scsi_find_dev(ap, scsidev);
> -	if (likely(dev))
> +
> +	if (likely(dev) && !ata_port_pci_channel_offline(ap))

libata-scsi implements a SAT (SCSI-to-ATA translation). It should *not* be
bothered with checking the underlying adapter state. So this is the wrong place
to put this.

Strictly speaking, the check for the PCI channel offline should go into
libahci, or any other PCI ATA adapter driver. But since that would be repeating
the code, I think it is acceptable to put this check in libata-core.c, in
ata_qc_issue().

>  		rc = __ata_scsi_queuecmd(cmd, dev);
>  	else {
>  		cmd->result = (DID_BAD_TARGET << 16);
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index e5b977a8d3e1..ff2eb824e51b 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -12,6 +12,8 @@
>  #ifndef __LIBATA_H__
>  #define __LIBATA_H__
>  
> +#include <linux/pci.h>

No. This should not be here. If you do as suggested above, libata-core.c
already includes linux/pci.h. It has functions such as ata_dev_check_adapter()
which already look at PCI devices. So your function
ata_port_pci_channel_offline() should be changed into something more generic,
like this:

static inline bool ata_adapter_is_online(struct ata_port *ap)
{
	struct device *dev;

	if (!ap || !ap->host)
		return false;

	dev = ap->host->dev;
	if (!dev)
		return false;

	if (dev_is_pci(dev) &&
	    pci_channel_offline(to_pci_dev(dev)))
		return false;

	return true;
}

and then, at the top of ata_qc_issue(), add something like:

	if (!ata_adapter_is_online(ap))
		goto sys_err;

> +
>  #define DRV_NAME	"libata"
>  #define DRV_VERSION	"3.00"	/* must be exactly four chars */
>  
> @@ -56,6 +58,20 @@ static inline bool ata_port_eh_scheduled(struct ata_port *ap)
>  	return ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS);
>  }
>  
> +static inline bool ata_port_pci_channel_offline(struct ata_port *ap)
> +{
> +	struct device *dev;
> +
> +	if (!ap || !ap->host)
> +		return false;
> +
> +	dev = ap->host->dev;
> +	if (!dev || !dev_is_pci(dev))
> +		return false;
> +
> +	return pci_channel_offline(to_pci_dev(dev));
> +}

This is too big a function to be inline. Make it a static function in
libata-core.c as suggested above.

> +
>  #ifdef CONFIG_ATA_FORCE
>  extern void ata_force_cbl(struct ata_port *ap);
>  #else


-- 
Damien Le Moal
Western Digital Research
