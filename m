Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE2D1E4AE
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2024 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708036568; cv=none; b=Ub3QymYbZOW8R6Q8RPZXaVfjEaZC37QRp6OGP5Q+iAjE9jgHod/X+IpmIwwO5c51qM1XErzOHINwFNIQj5uIOQjdBAJB4l+Ed6X+9VZJ3cZInCjnyn1V2vjbEZT19vBsPBZaX3DZcHvw/4mCfh3pCCNL+1y18lQShMy+4rvqiAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708036568; c=relaxed/simple;
	bh=7mdSnFTkHZs18WqVyOhH6sOkDfUb8VJTbPBB+oPI52w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uz15nNX7nH9Bf3s7skwaqPpobClsyK9JnamMAv2rx0068y1P6i09eHYKXuuUaJEP6Cgk5TXAfJ8yFDx5UJ1zVZMruc6DOXFxlOlmTMAuaY2qA1pOCk+HyFh+UUAKqc8JCH0NvuwdgQHnPpp3C9DtpwRVrUGvkFjGsJcqmxBXJK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyQTnzjO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyQTnzjO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AE8C433C7;
	Thu, 15 Feb 2024 22:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708036568;
	bh=7mdSnFTkHZs18WqVyOhH6sOkDfUb8VJTbPBB+oPI52w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TyQTnzjO0nOoDUBz3GlnrKP7H0cAAxfiFD2BXTMBMhfF4cfun1jzv1DeNIQM/4Rad
	 cSR7r9/Y2BbaqFatYMnOmR7jenhZv0SWcICfYH8GD5CE9d/SDoEmwyklI1G2HdGy4L
	 4R9lCe21/TMUvWQQtta7bHcJvkwojBNQSmjer5A4d+DL0cRgvFrrJ1K/C8YHGj5JQj
	 ksO69yhlImxyzTO9NRBE6mak1UkxD6Ga7rPgABlN8jyw6hWK60NlQuB8ahu1C9+HjR
	 2aUgVHZh8bmOEyXGTdcbU1exHKTYvGOaCBxSyVsrzeGpnoNfuwd1D/R+7avOt0xTax
	 EiLebfkEBrMNw==
Message-ID: <80fb74e2-080c-41db-8f18-715ec79441bf@kernel.org>
Date: Fri, 16 Feb 2024 07:36:07 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] ahci: rename board_ahci_nomsi
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-ide@vger.kernel.org
References: <20240214130015.952685-1-cassel@kernel.org>
 <20240214130015.952685-5-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240214130015.952685-5-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/24 22:00, Niklas Cassel wrote:
> The naming format of the board_ahci_no* boards are:
> board_ahci_no_debounce_delay
> board_ahci_pcs_quirk_no_devslp
> board_ahci_pcs_quirk_no_sntf
> 
> Rename board_ahci_nomsi to board_ahci_no_msi to match the other boards.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

