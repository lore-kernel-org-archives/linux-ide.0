Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603518FDD6
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683119; cv=none; b=mzlqxIum3NQFjg/wcYIMoDZuEO8azJ0ZhODmfvCKs+uK1fMeN20zgl//APU28Mel+BBtOwHQbXYdvpWcZ/iVxDAgI2P/dl6f35lDCatPL1yhZ6YA0UgqY/qEw3EWPrZTuVVj6T9RJmwUZVBjDEbRGL1alsO366jHwymAVk2HtXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683119; c=relaxed/simple;
	bh=TxbtduwY6bLCQPeaN+TMgpuFlLh5zJdX6ljmDjjlLmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUZp6rD6gRUDHEpe/VZYU2OXw0a0XrroymaMvPyQMK6FmreGOJtHPz343FqOQD9WOIQzVFx4RFrRovdu8j4TTrv5udIMjdJh2APVTaOhLUOaBEh2VIr6IoG3kpoCQssv2qbDSeBnEepqxj6R3L1j+zlK4I9z7YObsApBDytgvAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYF7uAMc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYF7uAMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6410DC4FEEA;
	Mon, 26 Aug 2024 14:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724683119;
	bh=TxbtduwY6bLCQPeaN+TMgpuFlLh5zJdX6ljmDjjlLmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYF7uAMcsLLlXLumB3HKptM3WGCvFTyxGbpytDfjm7fCOOrdGcU/4X7SKo//8yCOx
	 LH+Dl7yjSGiTe3kK8qZYJR1IdVim22ih+mjB5unlVg8M6vLRL8wIy91iRG1nD6H4jO
	 nPNC7CKEVq3aRQG5GUctNn3Lh04z3MkLr8BLOJw6WWRy4Tma4XcpBeCT0Q3bzFq1if
	 CJRueiVW5eqI2pknOWOAm1z0BD9p84duVLQw7cgGdmcgHhroTm37NE4OfIe1dssvTt
	 aIxH+q5EUGhmyHpelsmxTevZ/wZoQHP50G0llKGSAm9x5OWbxANhZSbVQ1X38Lm1L/
	 zM9azYtvxaXug==
Date: Mon, 26 Aug 2024 16:38:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/7] ata: libata: Fix ata_tdev_free() kdoc comment
Message-ID: <ZsyTa7MRhLfiZkp9@ryzen.lan>
References: <20240826073106.56918-1-dlemoal@kernel.org>
 <20240826073106.56918-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826073106.56918-2-dlemoal@kernel.org>

On Mon, Aug 26, 2024 at 04:31:00PM +0900, Damien Le Moal wrote:
> Fix the kdoc comment of ata_tdev_free() to correctly describe that this
> function operates on a ATA device and not on a link or PHY.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-transport.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index 48800cd0e75d..474816a9efa1 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -660,14 +660,14 @@ static int ata_tdev_match(struct attribute_container *cont,
>  }
>  
>  /**
> - * ata_tdev_free  --  free a ATA LINK
> - * @dev:	ATA PHY to free
> + * ata_tdev_free  --  free a ATA device
> + * @dev:	ATA device to free
>   *
> - * Frees the specified ATA PHY.
> + * Free the specified ATA device.

Perhaps: "Frees the sysfs entry for the specified ATA device."

Perhaps do similar changes to the other ata_tdev_ functions.

E.g. for ata_tdev_delete() - "Remove the sysfs entry for the specified ATA device".


>   *
>   * Note:
> - *   This function must only be called on a PHY that has not
> - *   successfully been added using ata_tdev_add().
> + *   This function must only be called on a device that has not successfully
> + *   been added using ata_tdev_add().
>   */
>  static void ata_tdev_free(struct ata_device *dev)
>  {
> -- 
> 2.46.0
> 
