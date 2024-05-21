Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBDD770E2
	for <linux-ide@vger.kernel.org>; Tue, 21 May 2024 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296151; cv=none; b=HWm5yox9YO742s0+JEmnxPoRSvi/K6fu9ceOCQ/zABuv0Odce8hsog423itdkab1cp6sg0H5CUSJ3z/MPpTXiq4PvRjlxFFYoF0nTY6Q6PDOHRCGpE66Ve9e34GGuN/CKu/0Yj0f2S0nsjRJ09HwBhINZup4vnyS3ntU6OcGsI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296151; c=relaxed/simple;
	bh=SDVX0iUnE/9/V4ApZTS7ExA6B4huv4qG1DBu/8Ugdec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8m+gcBSEdRKrWYgL6mXZE2mhUOKsLJIZ2paeKMpFDTKcjXlvi6y3yBEc7LPoYr73IWq1eaGlR5J65Mt96/X1IefTNU1GGY3Gd0FZwlooFFrvfVMFUSTiUKvP5fV1OTzIEMye25TplPmAqlu2r9Dicgz01J2x4KckMYueIgrSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnhPYNOO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnhPYNOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE0FC32789;
	Tue, 21 May 2024 12:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716296151;
	bh=SDVX0iUnE/9/V4ApZTS7ExA6B4huv4qG1DBu/8Ugdec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnhPYNOOY93zzkPm2gRwbazeLNunGwmIvphl3WwW7oZwRcSzweb0/CLY2IEMVuqhv
	 yx6y5TjwRoRkrAHyvzUVz24Sq23aEOVL4uaGxY2eMXsNCefpqwerFozIp6SIZ1Bwh4
	 kiCjEtScIN7R3VAfKqeH7txq7pnVpbPNMG2fqo9+/33fThS5+a3/8iU6M/UOk9jJlz
	 h+iRKJ5eEmemKaqG3mGv1lhiuJbNv96dNEBI9bEMBKsu2/vk2PuEPYIcEpVdRRGzPQ
	 +sE8UKNQX1yKqx2F0YHcnJPbJ4wmSFKkvtAGHyy1QRtM5fPS5vGVKSex0D5BKfR3DX
	 SR7SMP+e8/f5A==
Date: Tue, 21 May 2024 14:55:47 +0200
From: Niklas Cassel <cassel@kernel.org>
To: dev@kayoway.com
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 1/1] ata: ahci: Revert "ata: ahci: Add Intel Alder
 Lake-P AHCI controller to  low power chipsets list"
Message-ID: <ZkyZ0zeJZ8sM9liP@ryzen.lan>
References: <20240513135302.1869084-1-dev@kayoway.com>
 <20240517053902.44622-1-dev@kayoway.com>
 <20240517053902.44622-2-dev@kayoway.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517053902.44622-2-dev@kayoway.com>

On Fri, May 17, 2024 at 02:39:02PM +0900, dev@kayoway.com wrote:
> From: Jason Nader <dev@kayoway.com>
> 
> Commit b8b8b4e0c052 ("ata: ahci: Add Intel Alder Lake-P AHCI controller
> to low power chipsets list") added Intel Alder Lake to the ahci_pci_tbl.
> 
> Because of the way that the Intel PCS quirk was implemented, having
> an explicit entry in the ahci_pci_tbl caused the Intel PCS quirk to
> be applied. (The quirk was not being applied if there was no explicit
> entry.)
> 
> Thus, entries that were added to the ahci_pci_tbl also got the Intel
> PCS quirk applied.
> 
> The quirk was cleaned up in commit 7edbb6059274 ("ahci: clean up
> intel_pcs_quirk"), such that it is clear which entries that actually
> applies the Intel PCS quirk.
> 
> Newer Intel AHCI controllers do not need the Intel PCS quirk,
> and applying it when not needed actually breaks some platforms.
> 
> Do not apply the Intel PCS quirk for Intel Alder Lake.
> This is in line with how things worked before commit b8b8b4e0c052 ("ata:
> ahci: Add Intel Alder Lake-P AHCI controller to low power chipsets list"),
> such that certain platforms using Intel Alder Lake will work once again.
> 
> Signed-off-by: Jason Nader <dev@kayoway.com>
> ---
>  drivers/ata/ahci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 6548f10e61d9..07d66d2c5f0d 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -429,7 +429,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_pcs_quirk }, /* Comet Lake PCH RAID */
>  	/* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not tested yet */
>  	{ PCI_VDEVICE(INTEL, 0x4b63), board_ahci_pcs_quirk }, /* Elkhart Lake AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x7ae2), board_ahci_pcs_quirk }, /* Alder Lake-P AHCI */
>  
>  	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
>  	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> -- 
> 2.45.1
> 

The patch looks good, I will queue it up once 6.10-rc1 is out!


Kind regards,
Niklas
