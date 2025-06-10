Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE7246BA4;
	Tue, 10 Jun 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565112; cv=none; b=UT2ozWNzb+jsnlMyVnlIsNtkv8CMKMzmKtrlwPP6TUMR6i5hsXM9BgQ7Vu28I913KPkxw4M8h6WkY0Da5AEdY0msUxFyE+33kSvTJW/D93onwRoMxJJcO6Zgv3RkyJpXuDQWJ+vv8oyiAb0PYCW6gYbLRDiZ23MnKp+AHo8SQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565112; c=relaxed/simple;
	bh=F77oOQ5o+TGyFsFaewUxO4I/JYy/wApknI4F+a/DJb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsl2TfoAtWXt3uTc+IXUTq76qA8ARYU7vZN3QzNcfAwQCkVLZxBUWwN6GWaT+QMZNwP1j03ZNbANZoGfqGUjnXru7s6Gsp2lNP4krQ6pwg46f19svktRtPkwld23aWuzpip3mESOYQ19gU4QnwOW4QhPjRmDO5pbG5vqbQfgAfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNA1+5du; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNA1+5du"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749565110; x=1781101110;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F77oOQ5o+TGyFsFaewUxO4I/JYy/wApknI4F+a/DJb0=;
  b=QNA1+5duP+vqPIftD18TQ7yM6I8+EQ/mO/e4JCvXbxQ6Z8r54mXzguDq
   4orhwEajtqBeULcroxbO0yE65t5XvToYGTBf/LJn5XdNcbDvyQ4OiAEy3
   7KIN15l5IpiNKlLr1NlFua3khMaMhKKgcnIniHdEbLXrQUFHGbwiAIrvU
   99zeIiHaxz3YeOFdA143HpxsHOcFHUkjxOyZ3Fv4P6ewN9DbE0y7Qpqlc
   kbuHYKItY2qqBCBHOF40qg+ISPfQGENtN12botloYKU+RKkxgnLy0Rbb5
   a5OenGPFKejIm/uH2+TdFyE8ZKbURWnyfcXdhluCum8z1QueNHdqSx5xp
   g==;
X-CSE-ConnectionGUID: 0caNT4ccRga54gpWqznh9Q==
X-CSE-MsgGUID: LkSesDivQOmluFvpeKknIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="61953585"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="61953585"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 07:18:30 -0700
X-CSE-ConnectionGUID: RqMmOiGfShaLmdHUEXjUtw==
X-CSE-MsgGUID: GmMUuOmnRxa/we/M4S7gSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="151847886"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 07:18:30 -0700
Received: from [10.124.220.93] (unknown [10.124.220.93])
	by linux.intel.com (Postfix) with ESMTP id 7C78220B5736;
	Tue, 10 Jun 2025 07:18:29 -0700 (PDT)
Message-ID: <460664b1-df24-4f15-a9b9-6ff2e6a20227@linux.intel.com>
Date: Tue, 10 Jun 2025 07:18:29 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: pata_macio: Fix PCI region leak
To: Philipp Stanner <phasta@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250610135413.35930-2-phasta@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250610135413.35930-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/10/25 6:54 AM, Philipp Stanner wrote:
> pci_request_regions() became a managed devres functions if the PCI
> device was enabled with pcim_enable_device(), which is the case for
> pata_macio.
>
> The PCI subsystem recently removed this hybrid feature from
> pci_request_region(). When doing so, pata_macio was forgotten to be
> ported to use pcim_request_all_regions(). If that function is not used,
> pata_macio will fail on driver-reload because the PCI regions will
> remain blocked.
>
> Fix the region leak by replacing pci_request_regions() with its managed
> counterpart, pcim_request_all_regions().
>
> Fixes: 51f6aec99cb0 ("PCI: Remove hybrid devres nature from request functions")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Changes in v2:
>    - Add Fixes: tag and rephrase commit message, since the merge window
>      closed already. (Niklas)
> ---
>   drivers/ata/pata_macio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
> index fbf5f07ea357..f7a933eefe05 100644
> --- a/drivers/ata/pata_macio.c
> +++ b/drivers/ata/pata_macio.c
> @@ -1298,7 +1298,7 @@ static int pata_macio_pci_attach(struct pci_dev *pdev,
>   	priv->dev = &pdev->dev;
>   
>   	/* Get MMIO regions */
> -	if (pci_request_regions(pdev, "pata-macio")) {
> +	if (pcim_request_all_regions(pdev, "pata-macio")) {
>   		dev_err(&pdev->dev,
>   			"Cannot obtain PCI resources\n");
>   		return -EBUSY;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

