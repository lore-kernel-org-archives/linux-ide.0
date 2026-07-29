Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186E047FAE9;
	Wed, 29 Jul 2026 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330623; cv=none; b=hzt6WSjmb68JAQeTaIEVucRUreiINGKbQAWfr4qo5XnQwHyRH5sKS1/Y/YUYqGyz+wGqfLVfWFAO7KF7fgVWPaV1M1+jfYvVeOF7lMCA3YdHuMFSdrXnwDlvvJcNL9zQgEv/QJgEbMYkVolyX49Fy74EGAt65DcQT5GpP6bZvqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330623; c=relaxed/simple;
	bh=o+IQEMT5WpOG4ll0+xXsRke0LZEVA6C6yeMuiUkQ/7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4bO3W64Mnz1gdU3EWvXK41Glr9gdkMEzWZ7jy0+2g58lIXsXLiiiRgDqNJq97DmVHxAtmUDNbvlmrFwvY9faWfcAmWtijuoWf9pE++nGo9kvJaPhs65uMHXaC6MYE+GK5zpMm7ZcS2dNeyJ+3c8uQIv83f0EcWxu9DfdkPL4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNIQeUD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNIQeUD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342211F000E9;
	Wed, 29 Jul 2026 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785330622;
	bh=o+IQEMT5WpOG4ll0+xXsRke0LZEVA6C6yeMuiUkQ/7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nNIQeUD/et3wP1uvpcRrrqlZCV3lsN66OkQE0YIi/+/t+XIghbPJr44/b1f4ocLNx
	 /QNTjDAhgJbrC4qC2aCBlMxZf3eU1hpI0EsNf7n3BmGgrXNuUFb3X3DpxfH2krlxhD
	 y5N0DwSqjJkcKdQcClQSiKBBu2npmGI0q5DEziGEff9q8j9ClL1LJ1xI3MzGGJ2VyU
	 KmTpnfZcfCfxwXIVEDyCe5PUmHY47KpdG6myZhjH2LbHsXJJG/Q6ejP8vLxYapgoky
	 XmTzbeqbuQ3AAdCNeiKphVFJNOXo/JIEfs6+syCbC6vieZF8J57hysqfpMR+VLoIhV
	 YKGaO+PQP5dUA==
Date: Wed, 29 Jul 2026 15:10:17 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: dlemoal@kernel.org, linux@zary.sk, axboe@kernel.dk,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	shuangpeng.kernel@gmail.com
Subject: Re: [PATCH] ata: pata_parport: Fix use-after-free in new_device_store
Message-ID: <amn7udA2btlcum-N@ryzen>
References: <7a9734be161cd051063ccc3bdeb377c55a83c4bf.1785327915.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a9734be161cd051063ccc3bdeb377c55a83c4bf.1785327915.git.xiaopei01@kylinos.cn>

On Wed, Jul 29, 2026 at 08:27:53PM +0800, Pei Xiao wrote:

(snip)

> Fixes: 72f2b0b21850 ("drivers/block: Move PARIDE protocol modules to drivers/ata/pata_parport")

This does not look like the correct Fixes tag, since it is simply moving
files.

Not saying that it is super important to have a Fixes tag.

Without having looked, I'm guessing that there is a chance that this has
been racy/broken since the driver was introduced.


Kind regards,
Niklas
