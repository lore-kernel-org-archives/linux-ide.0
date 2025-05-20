Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B172A7260A
	for <linux-ide@vger.kernel.org>; Tue, 20 May 2025 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733369; cv=none; b=rriFiK+WHyHpcTefBP3EwT0C3yvkS5WFG7W/W+C0rTIecuxEtvwnXKhBEYJMB7Wbdns76HzO9gFSSVtxhTNHHykwR+wjQC0O9TV6Cpygdy04hvnSCBf9hzqvKMn3ZiUIu7MwSsc6TABz+2WbEdofqfxTbFhvCxrkGbdQaueUxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733369; c=relaxed/simple;
	bh=9zM39MvfkjoH+H+U08m5XfKQ5XNvvIXGQhi9ad3cn/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPcCcDLq+ZaNzN4s4+bA8FcrXlqTRHOfsLM72i+e7+EtgdsQqaYGsRW6Hne+3BoxkhppQ5WBbh2MhSfkr6zbI7CA9dJMnN8xl36Sic+rzXdmFOyGqaLR3ToQJCWnJHMxjc5vLtkvUaT3CsEMhKESUVGbIcVHth3Wa40FPyiD998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLB6B5De; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLB6B5De"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB06C4CEE9;
	Tue, 20 May 2025 09:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747733369;
	bh=9zM39MvfkjoH+H+U08m5XfKQ5XNvvIXGQhi9ad3cn/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tLB6B5DeoAQwb/CQKVgBelvFc2IbEZaSwseLGu3+VmgKq28baxFei1li5UofULD7o
	 q5Q4aG5JU5oTuZ0B0z2YKvNvynOxxgO7pcw0141jwdPLjWnln77NofWLBFUMH97XT0
	 UOa+XNP6tpG7j9J1O6O6PHmWKH2wHwJ8Wat/lyxfdW1kizS8+eT+oqi/OymquRvjsL
	 WSm8ketZ55kwEJ2zD6wmW7VUVrpYvhaPjlJV+epugZ6r1LtX+JutqLZD//9mFir2Wi
	 U/KBeLTMv2VDxDeGQFJItchEDciCLGxdZoceA1R+8AKtdxb9GK8ZaBn786JGTos1UD
	 2nZ3uxftpyDnA==
Message-ID: <001a24b4-1f77-42db-91ad-462bc835e275@kernel.org>
Date: Tue, 20 May 2025 11:29:26 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-acpi: Do not assume 40 wire cable if no
 devices are enabled
To: Tasos Sahanidis <tasos@tasossah.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
References: <20250519085945.1399466-1-tasos@tasossah.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250519085945.1399466-1-tasos@tasossah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/05/19 10:56, Tasos Sahanidis wrote:
> On at least an ASRock 990FX Extreme 4 with a VIA VT6330, the devices
> have not yet been enabled by the first time ata_acpi_cbl_80wire() is
> called. This means that the ata_for_each_dev loop is never entered,
> and a 40 wire cable is assumed.
> 
> The VIA controller on this board does not report the cable in the PCI
> config space, thus having to fall back to ACPI even though no SATA
> bridge is present.
> 
> The _GTM values are correctly reported by the firmware through ACPI,
> which has already set up faster transfer modes, but due to the above
> the controller is forced down to a maximum of UDMA/33.
> 
> Resolve this by modifying ata_acpi_cbl_80wire() to directly return the
> cable type. First, an unknown cable is assumed which preserves the mode
> set by the firmware, and then on subsequent calls when the devices have
> been enabled, an 80 wire cable is correctly detected.
> 
> Since the function now directly returns the cable type, it has been
> renamed to ata_acpi_cbl_pata_type().

Nit: "it has been renamed" -> "it is renamed"

> @@ -530,13 +534,17 @@ int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
>  		xfer_mask = ata_acpi_gtm_xfermask(dev, gtm);
>  		ata_unpack_xfermask(xfer_mask, NULL, NULL, &udma_mask);
>  
> -		if (udma_mask & ~ATA_UDMA_MASK_40C)
> -			return 1;
> +		ret = ATA_CBL_PATA40;
> +
> +		if (udma_mask & ~ATA_UDMA_MASK_40C) {
> +			ret = ATA_CBL_PATA80;

Please change this to "return ATA_CBL_PATA80;" and change the last return at the
end of the function to "return ATA_CBL_PATA40;". That will be cleaner.

Other than these, this looks good.

-- 
Damien Le Moal
Western Digital Research
