Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D3F1B29AA;
	Mon,  9 Sep 2024 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868043; cv=none; b=Kpmf5HnKrACDjNYTt3T0Upfn5Rx+LU2h46JzcIHCic3Kq1KmFMLqpzfgG6eY6c/zhFneM/KfCjRCykUcJaNzSD9HELHjgA831QqgfxWnYePUdhSYFA+yk6RpJBuSfxTP6IvHqwLmaQE+7iqggH/9NvjyE2hn0g486NxOA1DqYbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868043; c=relaxed/simple;
	bh=52N3f9o56u1e7uBI7QkITFYHxjCsOHRZkUjtRy+H2i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfPEYyU5Za3jFNOlgDqKwAQbzscDiqv1mnm/x6wY+5QKBmGDDNxWShhRKuDbXAWfOe37Ycnadl3LUM4tO0jVNx7ewEiX2ogkaBAY9hcEyDNyOkSTEk3qdMVlUhdvVEhfh6fOKdxHi6rCw7efLM2sam6sWugmicjUTiz5wDpQG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLmmBrCA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLmmBrCA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF63C4CECA;
	Mon,  9 Sep 2024 07:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725868043;
	bh=52N3f9o56u1e7uBI7QkITFYHxjCsOHRZkUjtRy+H2i4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tLmmBrCA/BLVhPsrIyHp3316xvRbnkGobPystKZyIIJP7MZISFAv+h3hBqr2xW/ra
	 TqBMuX5X4ielqiIrbLY9Edgfjq0nyqISOgEMIJaW/mEEnkr7aYKROYunB0pCJL9WOA
	 xoDLw3c5pwuw3PIQnR+sdIjgZzX/GQeJBGHfiMAgefdAmQZBzwSMPps5sy7UvpZM6D
	 0crB4H4A42/QkjrYdTtGDnuvGoYSs1ZAOOsXD5sB8sZWc0T9k5hdLlQcssG/rq37Zz
	 06wp65LCBedm8Wzw3hMYmqXfGGc9Aj+j4bHvRQudA3SUteVZCLJxl9zBx2VWoJi2cG
	 nao3xc/G66Jyg==
Date: Mon, 9 Sep 2024 09:47:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ahci: Marvell controllers prefer DMA for ATAPI
Message-ID: <Zt6oB7r6k9k2BFvf@ryzen.lan>
References: <20240908094604.433035-1-chenhuacai@loongson.cn>
 <Zt6l6DVeDGzb5W7N@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt6l6DVeDGzb5W7N@ryzen.lan>

On Mon, Sep 09, 2024 at 09:38:16AM +0200, Niklas Cassel wrote:
>
> Device specific quirks are defined in __ata_dev_quirks in libata-core.c.

Side note: the name "__ata_dev_quirks" is so far only queued up in:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.12

In older versions (and in mainline) it is still called "ata_device_blacklist".


Kind regards,
Niklas
