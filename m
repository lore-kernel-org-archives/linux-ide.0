Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AA349CE7;
	Mon,  1 Jun 2026 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303636; cv=none; b=puY+fU/a7kNpqQXqgUSt7H7p7Z1fQ4cNjKLfDUQmPZLbL5GbAKtOJalmTti9gRdKHyBmbPN5QZkTF0kstsl0Maw+HhO5V5Sa63mgQWKX1118WvVt9zpViqm8wljnYXIev2rrA+9hyxU4usYNj+5+wne5+J8xmHlNMtQVYiz58uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303636; c=relaxed/simple;
	bh=20NpGxCjbe0n+m8Gv+yd1iv15QR7kAOI4KRcr2I83bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDXT2OJXxGtDQzMbLv27PRWxAOHLJH8ygrPTS5fiDzT7gYbVsHn2tRQUB8YKa1vJO2UZI4eZiIEKtp8V91AfcOkRx8PlRIaUyJZr1lzbo7nqDGcfh5FsZiEswt3x2WIniFg/z/dQ2zRd5qiZr1W7INlnbGVwBLfYb8out4mjSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFIF2a8V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFIF2a8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3621F00899;
	Mon,  1 Jun 2026 08:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780303635;
	bh=oNsrgp5DQ9LWzj7wab8/emIHi1D2wcX+XgNUEl23dCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XFIF2a8Vqw7mfC3L3una0n8gt2baZE99DrCYgCCtuP0ilOczEZjWTTKifNNe3U6wR
	 vxSTCEmwdO+uD5s6KuIf01TXNGPnQ6Ey4CR4MS1hZNuAW1d1Vxaq5Dt69X9XsdBOeV
	 AlmU0hM2M/H7vkq8rPzPZHu6SKaVOF8s5e4jDF7K6jrx41JkwszoYM8P0/OKyTbvf+
	 iM2KqSKLqWwmE+75xssHMwwKzKxelqivlnYBScs5IKIANNw5m3tdd5M96fx61I5wsv
	 HnGNv04A4u8u8ero7TuN1JrRbQBE/+fOle9i7db19J9JjSXiifaKEtRez7RFCtlyr6
	 L45aEgW9CI0RQ==
Date: Mon, 1 Jun 2026 10:47:11 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] ata: ahci_tegra: remove devm_kcalloc()
Message-ID: <ah1HD1aOyTnMBEqD@ryzen>
References: <20260530004135.43088-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530004135.43088-1-rosenp@gmail.com>

On Fri, May 29, 2026 at 05:41:35PM -0700, Rosen Penev wrote:
> Combine allocations into one by using a flexible array member.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: Rebase

V1: https://lore.kernel.org/linux-ide/20260324211629.26924-1-rosenp@gmail.com/

Jon Hunter said that he (in addition to myself) was not a fan of this:
https://lore.kernel.org/linux-ide/63d71f4c-97c0-4c2f-ac92-0a643fcdf75f@nvidia.com/

Since there are no changes since V1 (except for a rebase), and no new
motivation/reasoning in the commit log, I intend to ignore this patch,
unless Jon feels otherwise.


Kind regards,
Niklas
