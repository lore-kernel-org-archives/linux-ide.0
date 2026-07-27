Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD09C22576E;
	Mon, 27 Jul 2026 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116957; cv=none; b=S7diUcUfJ2jXLrX7yB7PYTOkbrRklkQSNPY+2WIfyBYDv5lJnXi1mwwgOakZFwHebHT3UciBUo6ajjM/ULfI/I0mkNXhvE2f8yBdV+2tkiWWh9FAfj6eJ6PQ3KSRPaxOIWkhcg3Sx7+XUGnOOTwK0vKJeMEKn4fkHvxmvLChR80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116957; c=relaxed/simple;
	bh=/R5qpTppHWjCdqfWqbd5E8fH8sYefEH1r2QS96y8KE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEhB/WaXab0DUXdqd3cvQ0KenhXOjvhkT8jse7pZL/16zn+7nIHi1mzFm9hPNJqKhDr3GRGXd9LjVl7QwoSl4k5gz2E/M0XWTrsmlMj1j1HvZy7K7QzhuKaP5pts95+i6OJRsk2XunlipT3PBkFJJiQ8kfTX95xZiwVoyeCRj6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoFpagRa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoFpagRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E05C1F000E9;
	Mon, 27 Jul 2026 01:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785116956;
	bh=cb8FomLOlG/0LEVY2D8JFEa1/4M/pA3WZ5EOj19sQ7s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OoFpagRaiWCYu4TbthNgOrhBmVFUL6IHGIfhEXIDzWeZWos+XguMpdydhzx9kU/ps
	 HYbCjwoRhTM1H8bVm8pL2ivrwlzfwpjwSbl3R+JQetaV93eKXOhcCH5dQVnqXFvrt0
	 Rb5XGsle5Ezc594osgv8k9MTnPnMbC8RbHTGzr5+75cZJffIDJvTMbAQ+zLZW2gpGi
	 io72v0T7xEwK0YTIVcjrp6E8iNiIJzfUXrxgsg8/o7KotstQYNT56oTItMsXCbwCPl
	 uFxehMCEPVWWDSzA7z2ewVkGZId34nymJhzjsPbh8NhfgyN8UGdhCOlx9VVcGgFSaJ
	 rkIwc6Zswol3A==
Message-ID: <6c9f7828-daf4-4770-b9c0-02efdf22c97b@kernel.org>
Date: Mon, 27 Jul 2026 10:49:15 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: avoid kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
References: <20260725015209.1207666-1-rdunlap@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260725015209.1207666-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/26 10:52, Randy Dunlap wrote:
> Modify comments to prevent kernel-doc warnings:
> - use "/*" for a non-kernel-doc comment
> - add a Returns: section for ata_id_major_version()
> 
> Warning: include/linux/ata.h:770 Cannot find identifier on line:
>  *
> Warning: include/linux/ata.h:782 function parameter 'id' not described in 'ata_id_sct_data_tables'
> Warning: include/linux/ata.h:782 expecting prototype for Word(). Prototype was for ata_id_sct_data_tables() instead
> Warning: include/linux/ata.h:820 No description found for return value of 'ata_id_major_version'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied to for-7.2-fixes with the comment tweak we discussed. Thanks!

-- 
Damien Le Moal
Western Digital Research
