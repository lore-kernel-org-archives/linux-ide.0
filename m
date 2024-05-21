Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5691B757F7
	for <linux-ide@vger.kernel.org>; Tue, 21 May 2024 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297210; cv=none; b=q2wC/4wegUNTbvn34YDOzvP8YDhuCXc8pF8Z11QClyPvA6ogeyNWpOURhjG4FM/EmpM67KbwRhyCuNYZiXohC4coZvVRb/Hi54WXMj/0vagagyRb8suZQdsZuWEdgDQ4ebYgdh4rGcLv7ztj2MlKWU5w4fCyMpWtXjqRmK16wVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297210; c=relaxed/simple;
	bh=AMGWsIZdicuL56ZBuf2ZunHH4PYgLcUCCngq/d+Z144=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leTtq48WLrEnn5n32qny62oWS8w0uBj8pVfQjXZMhvZT5+g/WnV002O8prSQKSHPyBW/jqrO6WYY7Pl9/RDuVrdQePPt9UrLJCqIJEP0xRcuwiNWJqpahEzWGfqMsq9ksUEP2AiNJ4efKpgSebSgdCm7DB5HbLaCwPz3cx/hCO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDn4P0/M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDn4P0/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D66C2BD11;
	Tue, 21 May 2024 13:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716297210;
	bh=AMGWsIZdicuL56ZBuf2ZunHH4PYgLcUCCngq/d+Z144=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDn4P0/MQWJWP7cpb0OjnxfOXFfT/MgxdNfpsnQWjD1+tMvI0KvdtpD0nILh5MDBP
	 seIwtw/qXjj3W92W6zN2AwGckNdxsukfnhMsaOq5aQlpWxPc0RFuPQKbkIp07AqAwH
	 5Tvogyk75Up31r4G6UxtsuD/iG0V9tb5b3L/uHN5fATyBRGcN78ly+hrubrtDYvLyq
	 nnFTydR71OYgrhyBkwjIaNl7dMNG+lpLJt4ztbCxAerusjN7qoZNGKWKFUBaNrQ63M
	 wRBwdtdh9xzo0OKXJ0W1VUYMBbMvTAasgxfBrTlWbKmMKLCW0HRpf6ee8op8KW4rPq
	 /2fLt+ijd/mjQ==
Date: Tue, 21 May 2024 15:13:25 +0200
From: Niklas Cassel <cassel@kernel.org>
To: dev@kayoway.com
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 1/1] ata: ahci: Revert "ata: ahci: Add Intel Alder
 Lake-P AHCI controller to  low power chipsets list"
Message-ID: <Zkyd9Uw3IrQBRfvB@x1-carbon.wireless.wdc>
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

Thinking more about this, could you please send a v3 with:
Cc: stable@vger.kernel.org # 6.7
Fixes: b8b8b4e0c052 ("ata: ahci: Add Intel Alder Lake-P AHCI controller to low power chipsets list")

and change the subject to something like:
ata: ahci: Do not apply Intel PCS quirk on Intel Alder Lake


Kind regards,
Niklas
