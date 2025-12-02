Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2829318BC3D
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 02:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764643494; cv=none; b=PKg1QpSbm/DIQjiZ3e/LeSbc2+ON/RMbsAH3V/w5LbNwwNOsEYWXb772dUrGzrxI/JNcZwX8wnr/IkDoos1mejJsz341cuys+ZfWTp+WsGdVFjI+OZY3icnohjpnAGN2FmDDVM3ymBf1OVP+8i5Qw2/5OL8iNSY31rz5mzObTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764643494; c=relaxed/simple;
	bh=1Y3VEfM8S3497tV5n9uL037xpLb3zCLu6sng9dy1TCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/1yOm+vcp56idqrz3b8OdIHxNHN2ZQ4bf1DXBZofitAAYOCrSY31d3z7xlExj5+VhCarB6Nh6D49dXZfSZSTx1w96VIHSimtmfdh7qrTcDJLzVIVtS3zLizOZlTe5ikz9pfnzkYB1muMDC1FuXipeT8k3ZMfa7oEks8v1pEgzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgM/DLN6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgM/DLN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA26AC4CEF1;
	Tue,  2 Dec 2025 02:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764643493;
	bh=1Y3VEfM8S3497tV5n9uL037xpLb3zCLu6sng9dy1TCc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IgM/DLN66paVkVH8+xUOT7o/T4I5il73J7QdbYg9R0QzD8QGhcJFp34sAHSYFPFoJ
	 djwBgnwbbhHrySNkVqpUSdEBIy2+bhHtOAzCZYMyTMCgTyjm9x/lKo1jXWhYEFbOJz
	 rWg366N/+CSDsxvLs5faPbc7ZPBrcwJKLD16jGpvNK9E35XOb6oYL8kJU4m+rGM1J7
	 9673T+dXEQDC6T9N5jjre6aFKSMXlC/rxkCghNPE/RAj1t0tUkzfyLI1SN9RSxaSoj
	 cigz18vfxJLpOfGzO66g9ZBQ6wSgTk59+ZIieZPOCEgYeAkCcTsNtTFYHARGPk2D8i
	 VEMjj2xZiyobQ==
Message-ID: <984729e3-7c63-47a0-b066-a0a826d4983c@kernel.org>
Date: Tue, 2 Dec 2025 11:44:51 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: libata: avoid long timeouts on hot-unplugged SATA
 DAS
To: Henry Tseng <henrytseng@qnap.com>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
 Kevin Ko <kevinko@qnap.com>, SW Chen <swchen@qnap.com>
References: <20251201094622.1475358-1-henrytseng@qnap.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251201094622.1475358-1-henrytseng@qnap.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 18:46, Henry Tseng wrote:
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
>   [   59.965496] pcieport 0000:00:07.0: pciehp: Slot(14): Link Down
>   [   60.002502] sd 7:0:0:0: [sda] Synchronize Cache(10) failed:
>       Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
>   ...
>   [   60.103050] sd 0:0:0:0: [sdb] Synchronize Cache(10) failed:
>       Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
> 
> In this test setup with two disks, the hot-unplug sequence shrinks from
> about 226 seconds (~3.8 minutes) between the Link Down event and the
> last SYNCHRONIZE CACHE failure to under a second. Without this patch the
> total delay grows roughly with the number of disks, because each disk
> gets its own SYNCHRONIZE CACHE and qc timeout series.
> 
> If the underlying PCI device is already gone, these commands cannot
> succeed anyway. Avoid issuing them by introducing
> ata_adapter_is_online(), which checks pci_channel_offline() for
> PCI-based hosts. It is used from ata_scsi_find_dev() to return NULL,
> causing the SCSI layer to fail new commands with DID_BAD_TARGET
> immediately, and from ata_qc_issue() to bail out before touching the
> HBA registers.
> 
> Since such failures would otherwise trigger libata error handling,
> ata_adapter_is_online() is also consulted from ata_scsi_port_error_handler().
> When the adapter is offline, libata skips ap->ops->error_handler(ap) and
> completes error handling using the existing path, rather than running
> a full EH sequence against a dead adapter.
> 
> With this change, SYNCHRONIZE CACHE and START STOP UNIT commands
> issued during hot-unplug fail quickly once the PCI channel is offline,
> without qc timeout spam or long libata EH delays.
> 
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Henry Tseng <henrytseng@qnap.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
