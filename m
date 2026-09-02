Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91E389460
	for <linux-ide@vger.kernel.org>; Wed,  2 Sep 2026 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327589; cv=none; b=l1U4cBcjNeG12JOOKtBlkLA0KkArJyUCdMzalDLya45nyxr5h+t2ZAftukMDmyq0ObOWPwuRFho9HVo6sKwXO+YEGiGgeKkse8tHNhJNb1jMUn6Csfvy1qoErSbaQ2oQf/XcCFWOlnmJ/OlS7BLc0UkzLn5dHA5OBIrIdICSbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327589; c=relaxed/simple;
	bh=o2oogFwdJ6ja0LfOyxgFn1WBWILaNDne2Q6jSPYRUsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8oHB/9LU6y/TPgBpe6h8mBQf5wSluaw2KvnaAMrd1vLwgBHwzxVXsGS6TvG9FaU0K+z8wCdAqR+lKH8vLGfKU/V/FuM7pK5zMZmJcDHIhheRxmEGd1IVbgqbzyyD1JX8V67ITgLiTd0h7Oto74PRCY6kcbcZFe3QSpuKDBxH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsHybvoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsHybvoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095A71F000E9;
	Wed,  2 Sep 2026 05:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788327587;
	bh=o2oogFwdJ6ja0LfOyxgFn1WBWILaNDne2Q6jSPYRUsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GsHybvoCfu+HP1FWTwoBiMSqUaqfj5W+6xflWGjv7dO2u0s4/CdF6EUoDYzcDxKLa
	 zhBRV6zdcikqCz6sTSpVNJSuD6VwV/DZ/jH0qrgF3uy2FqzRstkQxcaILYuNiBUBdg
	 DXr+sx6dVuzdZpHXgfUkQxw4RNgGg0Lxj8fmS9YtVjNeR+Bk39a+LCTsd+7EViEveQ
	 /ba3cH0rbjDsKVw1xn2WPRTV232siVoRo1RDwPOsiiCHeIFhtcKyN9LlxwCMuzCF9W
	 y5tFJFrVmMS8lih642NUcgI/ZczMJttYopoNvlLRv9A8sf9zMW5HT9SaaEV7a1KVCR
	 J8nLvXIcFnNaQ==
Date: Wed, 2 Sep 2026 07:39:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-scsi: do not raise UA for storage element
 depopulation and restoration
Message-ID: <ape2oGgWOqfHYx9w@ryzen>
References: <20260902020828.1436048-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902020828.1436048-1-dlemoal@kernel.org>

On Wed, Sep 02, 2026 at 11:08:28AM +0900, Damien Le Moal wrote:
> Currently, the translation of the trnalated ATA commands REMOVE ELEMENT
> AND TRUNCATE and RESTORE ELEMENTS AND REBUILD are completed using the

Nit: trnalated / translated

I also think that we can drop "Currently, " as it provides no value.

Then it becomes:
"
The translation of the translated ATA commands REMOVE ELEMENT
AND TRUNCATE and RESTORE ELEMENTS AND REBUILD are completed using the
"

It sounds a bit weird to repeat translated twice. Perhaps something like:
"
The libata command completion for the ATA commands 'REMOVE ELEMENT AND
TRUNCATE' and 'RESTORE ELEMENTS AND REBUILD' is handled using the
"


No need to send a new patch, just tell me and I can fixup when applying.


Kind regards,
Niklas
