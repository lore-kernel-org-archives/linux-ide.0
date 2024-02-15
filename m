Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98931E4AE
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2024 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036380; cv=none; b=b7Nyf42//NnGLJZkE1/6smFl/qgJM7lMJHElXOuSBMGgvR9rOUnzBIlTlv2KOmWfYJtztOLRUdv8vL08KzBFaVWgSfX99+0/jo9aS6TE9ihi5UHzMgxBVKWiEodi2/+8g21wDpM3dY5P+//k1kDvRv70xv+PYyev9zrs3eYUkVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036380; c=relaxed/simple;
	bh=l/Z+YBp1q/veJGN/6JnWLjsVJ0pgUB815mJsDcMoKzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLadF5G1q/AMPjOZYz9sE419FaBNR0uKF5GZRv54Q/y9m/HNXdTgK0OCXKmkNiy6FFf4cQbHnMfrPmpl26bcfHoACNOZzbwfBGGzBOOPTx8YWXZygNe4SHnwcFkUI1e65jLYU2g17YZr5IMwef0VF5Ek9O0eSQe9vWyNxvvZ2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXdwvC1/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXdwvC1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87116C433F1;
	Thu, 15 Feb 2024 22:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708036380;
	bh=l/Z+YBp1q/veJGN/6JnWLjsVJ0pgUB815mJsDcMoKzA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mXdwvC1/qk4sL+444qt5mpnbgwLQlbUTpNd5CcgfkTQsz1pXytUz92PRwxsJo+2m/
	 Vyos6/Ul9ztt+F/niOsMuU7NwlDqzguPKZceXtg+Il7pPDX26xk77DyTFN7PfM0U7z
	 p4pSMCuur2Qm72fz89qdnOOdkFQQ8XBVXQV9C/UQJakEbG/Zx/PR+qjbKjvikalx8C
	 Jm3YEME9ByTLH7in/w8vn42Cwu6Iaz7hSBMdtUGJqtMS1d74D0yd5OQVr5OcNbjOM4
	 FJ4RxjlsfcW0W/4eKiqGdyXaShG+jD5ADLHq1/K5S0bg+YUQIwsB36bal1quPhO71b
	 wWDWjniueOR7Q==
Message-ID: <724f3683-f27f-41d9-975a-158a9cca96b5@kernel.org>
Date: Fri, 16 Feb 2024 07:32:57 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] ahci: rename board_ahci_nosntf
To: Niklas Cassel <cassel@kernel.org>, Dan Williams
 <dan.j.williams@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-ide@vger.kernel.org
References: <20240214130015.952685-1-cassel@kernel.org>
 <20240214130015.952685-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240214130015.952685-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/24 22:00, Niklas Cassel wrote:
> Commit 7edbb6059274 ("ahci: clean up intel_pcs_quirk") added a new board
> type (board_ahci_pcs_quirk) which applies the Intel PCS quirk for legacy
> platforms. However, it also modified board_ahci_avn and board_ahci_nosntf
> to apply the same quirk.
> 
> board_ahci_avn is defined under the label:
> /* board IDs for specific chipsets in alphabetical order */
> This is a board for a specific chipset, so the naming is perfectly fine.
> (The name does not need to be suffixed with _pcs_quirk, since all
> controllers for this chipset require the quirk to be applied).
> 
> board_ahci_nosntf is defined under the label:
> /* board IDs by feature in alphabetical order */
> This is a board for a specific feature/quirk. However, it is used to
> apply two different quirks.
> 
> Rename board_ahci_nosntf to more clearly highlight that this board ID
> applies two different quirks.
> 
> Fixes: 7edbb6059274 ("ahci: clean up intel_pcs_quirk")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

