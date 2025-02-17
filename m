Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4D2217F5C;
	Mon, 17 Feb 2025 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791758; cv=none; b=YcRCr21ht7wBsxkY+urrxdgrlnFQ/s8yD81sSqeuKrZT0KeGC+enGPBdqEVtOupN+PEsBjHV+PUepwKNGXo7UF28ORzPSZSxLsb2KK5T2jk/ac8K2RI7t2i3+cqCQiARGKiZBnHPQZfiqSxY2VPvE6CV6SwQrBIdTxYQsKvMmcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791758; c=relaxed/simple;
	bh=qkv3HKQas5OClAlP9ioHPxV9oFCI17HlCuoCYUoE89M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB2DKnU89Yjr029ugs1lJ7BKNxoHpKvSZMOm9dnzcOXyLcXB/IGugzNEHc1KZxw8aJaMi135CWUCO9U2OTNlppufBLG621uSgUfklO9ez7hi0wGdrC0+GsNIxVCBk06dv3N5eu4OTS9SRYf69faJZkqLHT+MvdrwMCW9a5JPgi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ77auKP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ77auKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDC6C4CED1;
	Mon, 17 Feb 2025 11:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739791758;
	bh=qkv3HKQas5OClAlP9ioHPxV9oFCI17HlCuoCYUoE89M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQ77auKPsH2NTHcg32ORVuCQCWAhfIxaEZurFSxtgYy2rhP7Mt+7C8TxgTAH+kBbe
	 V8KWU54WQzYTADkGMFOeESM4pF794i138j6MUhCKsjutgKSXd40lRXaeYceqAbbFOx
	 41H72VbHNsghwbyFjfvI9sSZbQZw027jFM0ROc++u9NxzCIgQ1WuF0iRIr9h+SVda1
	 zXWAy9rzwyYOtN8vPubLjsseT8/zPOiLmTcEKfijHBtgaAAz8HSeZEvBJxjzmDTlQb
	 obnYXdr2RAFQUAEAvsEuq+FUcuDjirWeuHFrmAHPWVKulAjkUxLzj5YCPBYjzVDSY0
	 mJXMpUgNW7fMA==
Date: Mon, 17 Feb 2025 12:29:13 +0100
From: Niklas Cassel <cassel@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: chenhuacai@kernel.org, chenhuacai@loongson.cn, dlemoal@kernel.org,
	jiaxun.yang@flygoat.com, kernel@xen0n.name,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jie Fan <fanjie@uniontech.com>, Erpeng Xu <xuerpeng@uniontech.com>
Subject: Re: Re: [PATCH] ahci: Marvell controllers prefer DMA for ATAPI
Message-ID: <Z7MdiTptmxgiRXML@ryzen>
References: <Zt6l6DVeDGzb5W7N@ryzen.lan>
 <36B40EDC960C005C+20250217070120.666907-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36B40EDC960C005C+20250217070120.666907-1-wangyuli@uniontech.com>

Hello WangYuli,

On Mon, Feb 17, 2025 at 03:01:20PM +0800, WangYuli wrote:

[...]

> Tested-by: Jie Fan <fanjie@uniontech.com>
> Tested-by: Erpeng Xu <xuerpeng@uniontech.com>
> Tested-by: WangYuli <wangyuli@uniontech.com>

It is a bit weird to see Tested-by tags here, since your email does not
contain an actual patch.


> 
> Currently, due to the limited hardware I have access to, I'm unsure if this is a Marvell
> 88SE9215's specific issue or a general Marvell SATA controller problem.
> 
> So, I think it's reasonable to add a quirk to handle this for the Marvell 88SE9215 now.

I agree.

Feel free to submit a patch that adds a quirks for Marvell 88SE9215.


Kind regards,
Niklas
