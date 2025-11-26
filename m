Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B466F28B40E
	for <linux-ide@vger.kernel.org>; Wed, 26 Nov 2025 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143661; cv=none; b=pMrvnaA4CHafRIcZ1fGM/Elsjb3cLGu1sPm2pf7LR2lBYnwv8gEKx0U+Y2Of1o4Lr4YQJjkctjogJDn7u+RjRuUEs3ms9RT/qpwV2RTzKoq9fJFvB8Uq9LTD8usI1+GRT3ECmvP/zF3oDlQI45ftxFOdwCcpH0LPEBuhkjPuzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143661; c=relaxed/simple;
	bh=tTKTXILE3AMrulQgXsIQNchw6DqShVbqOwqrTayxn2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIZWsEKrvosxhdcSII4aBXOBXjBSzLp6T3FWl1l2KeuGVtlUfahIsrs6UG01mCWNPQWUCWuhAi7UraHQbV1UmQGu9zVjv+ZrbJo4CRfQXBiwJqgkL+v1sOLKT/eZpiGRd3zSnd0Nb/zLlPEDgrZikgX2FhBeZmz6mcDWNNg4X5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOE8dLTc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOE8dLTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3836BC113D0;
	Wed, 26 Nov 2025 07:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764143661;
	bh=tTKTXILE3AMrulQgXsIQNchw6DqShVbqOwqrTayxn2M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NOE8dLTcsbqdNgIE7nTjBvoFIiumvSvBOEQGDwPYNOd/5rPPxxZyYELWCYZKWVaG2
	 UinVUXc+07kW5WAcHoiD8FOBy7tk4xD6xkCFl1q684uFI5xDT28YRAK4E0G7yIXG5W
	 ZlLxbvAs1wtDc20x57LfhvOB4YmXWoNWTRzH+jnVzHzzm8HYUBw9Ezmeow00bnFl7P
	 WA9IkaphC2xNom7uD1IYccj/hGBRxWpSlrZbnGFk2sdGr3S5PBaXOYfJJ4HSwznBYx
	 4/JMFen6z8OgVVIio1WEDjRhUI4K63u9A7OkAb1Xq4kSqDNisMklfCn/2ZSvSHw+Dx
	 hqm6JVvG9VE2Q==
Message-ID: <0c380e65-1425-4dda-b6ae-f3cf4f69f8e6@kernel.org>
Date: Wed, 26 Nov 2025 16:50:09 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata: avoid long timeouts on hot-unplugged SATA
 DAS
To: Henry Tseng <henrytseng@qnap.com>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
 Kevin Ko <kevinko@qnap.com>, SW Chen <swchen@qnap.com>
References: <27a5386e-1cc9-438b-bf05-41f7dcbb3f77@kernel.org>
 <20251121101407.978550-1-henrytseng@qnap.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251121101407.978550-1-henrytseng@qnap.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/25 7:14 PM, Henry Tseng wrote:
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
>   [   53.905168] pcieport 0000:00:07.0: pciehp: Slot(14): Link Down
>   [   54.069159] sd 7:0:0:0: [sda] Synchronize Cache(10) failed:
>       Result: hostbyte=DID_OK driverbyte=DRIVER_OK
>   ...
>   [   54.330226] sd 0:0:0:0: [sdb] Synchronize Cache(10) failed:
>       Result: hostbyte=DID_OK driverbyte=DRIVER_OK

So I had an M.2 AHCI adapter and a USB4/Thunderbolt USB-C/M.2 enclosure which
allowed me to recreate the problem, and also test your patch.
I confirm the above, but I am really not a big fan of the above DID_OK. Because
the host did not do OK at all since it is gone !

So on top of your patch, I applied this diff:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a80a7e657041..52312ea6eb32 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5076,6 +5076,12 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
        qc->flags |= ATA_QCFLAG_ACTIVE;
        ap->qc_active |= 1ULL << qc->tag;

+       /* Make sure the device is still accessible. */
+       if (!ata_adapter_is_online(ap)) {
+               qc->err_mask |= AC_ERR_HOST_BUS;
+               goto err;
+       }
+
        /*
         * We guarantee to LLDs that they will have at least one
         * non-zero sg if the command is a data command.
@@ -5088,9 +5094,6 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
                if (ata_sg_setup(qc))
                        goto sys_err;

-       if (!ata_adapter_is_online(ap))
-               goto sys_err;
-
        /* if device is sleeping, schedule reset and abort the link */
        if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
                link->eh_info.action |= ATA_EH_RESET;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 434774e71fe6..c760732712c4 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2981,6 +2981,9 @@ ata_scsi_find_dev(struct ata_port *ap, const struct
scsi_device *scsidev)
 {
        struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);

+       if (!ata_adapter_is_online(ap))
+               return NULL;
+
        if (unlikely(!dev || !ata_dev_enabled(dev)))
                return NULL;

The first part (change in libata-core) only moves the check for
ata_adapter_is_online() earlier and sets AC_ERR_HOST_BUS for the err mask. The
more interesting change is the ata_adapter_is_online() added to
ata_scsi_find_dev(), which if the adapter is unplugged, will return NULL for
the device and prevent any command issuing, but also return DID_BAD_TARGET as
the status of the scsi command.

With this change, unplugging the adapter leads to quick cleanup. I see this:

[   95.198300] thunderbolt 0-0:3.1: retimer disconnected
[   95.201121] thunderbolt 0-3: device disconnected
[   95.216189] pcieport 0000:00:07.1: pciehp: pending interrupts 0x0108 from
Slot Status
[   95.216200] pcieport 0000:00:07.1: pciehp: Slot(13): Link Down
[   95.216202] pcieport 0000:00:07.1: pciehp: Slot(13): Card not present
[   95.216203] pcieport 0000:00:07.1: pciehp: pciehp_unconfigure_device:
domain:bus:dev = 0000:2b:00
[   95.216208] ahci 0000:2d:00.0: PME# disabled
[   95.259543] sd 2:0:0:0: [sda] Synchronizing SCSI cache
[   95.259580] sd 2:0:0:0: [sda] Synchronize Cache(10) failed: Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIV
ER_OK
[   95.259583] sd 2:0:0:0: [sda] Stopping disk
[   95.259589] sd 2:0:0:0: [sda] Start/Stop Unit failed: Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[   95.259688] ahci 0000:2d:00.0: AHCI controller unavailable!
[   95.259697] ata3.00: Check power mode failed (err_mask=0x20)
[   95.396292] ahci 0000:2d:00.0: AHCI controller unavailable!
[   95.396297] ata1: failed to stop engine (-19)
...
[   95.396359] ahci 0000:2d:00.0: AHCI controller unavailable!
[   95.396359] ata32: failed to stop engine (-19)
[   95.903412] pcieport 0000:2c:00.0: PME# disabled
[   95.903645] pcieport 0000:2b:00.0: PME# disabled
[   95.903904] pci 0000:2d:00.0: device released
[   95.903910] pci_bus 0000:2d: busn_res: [bus 2d] is released
[   95.904211] pci 0000:2c:00.0: device released
[   95.904215] pci_bus 0000:2c: busn_res: [bus 2c-2d] is released
[   95.904583] pci 0000:2b:00.0: EDR: Notify handler removed
[   95.905017] pci 0000:2b:00.0: device released

So about 800ms to cleanup the adapter device (and this one is odd as it has
only 6 ports but shows 32 ports !).

So can you merge the diff above into your patch and send a V3 ?
Thanks.

-- 
Damien Le Moal
Western Digital Research
