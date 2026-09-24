Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC43E5595
	for <linux-ide@vger.kernel.org>; Thu, 24 Sep 2026 03:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221983; cv=none; b=QaNEXSbTJNSPtskEA34IvgLWyzS2rJ4c1NlNe3xtHgwyVRR8lff+vXYPD98fScpmuOkp3q/MzCU0xyp2QrBDLYtQqUpcx0e1Fzt3Sx+1o59qpIqqc7xRW6M4w+MO9F5oc2ZJzR9Q+E2lDOpDafhF5XTyO+w1xgs7Q6XOVR/fIVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221983; c=relaxed/simple;
	bh=SB1azxFsk0eowNfXnO6InP3su2a5W1SkD5miwjUKclI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vai3mVwrNJdPSjrTmZL/iN7rqdr4FSqTBHpdQP45EYIrTvNql60SkD4iJMvqrZ8EPUH1bT9OKT/rOTDXiA4eypBfbNb8UnokKiG+JanBK7b2axKBqUk7xtlWvHaguT6paQa5G8FV2J1jXGXYUurxz0QOtEH5h0Y986Sa8qz6qE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqkxL3O2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqkxL3O2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567011F000FF;
	Thu, 24 Sep 2026 03:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790221981;
	bh=SyZf+u49sgD9vPreKcWsEs3zoY48i/ohMGBaZXEI2VA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MqkxL3O28nS0kaz/MRsxtjIRvoF2d57hXuadN80aHxHT2e4Berm+GEAsuy0Bjp49D
	 ak7Swaf2KdwRLReOpr/7y146Psd2umCbV4sIgoYTITYtO3WV/N6NzAbOLOFrK3xRVQ
	 Rp8kPEh99vttlXdH3tDJe4fXHvAxiwydmMYys9nKmLwldlDZ0IyRQ0J5mmLuulEaRQ
	 N/M47tfxOcQyvz3rHK0eKwozND3N4SCovYxXBwSIAMTczRoYqUo3aKyZYPT8ANW7kx
	 jHjQY+i3V+HnozTF2JGfoYPUeavE6oc2ClXo9qBspYIIH68K4WjgbUkwxDsem2+U5T
	 KxQ1ieGrmKCHQ==
Message-ID: <88fb216a-6024-49d2-97ae-79a1592541ff@kernel.org>
Date: Thu, 24 Sep 2026 12:52:59 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: name the libata/linux for-next branch
To: Matthias Goergens <matthias.goergens@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20260924033545.3624716-1-matthias.goergens@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260924033545.3624716-1-matthias.goergens@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 12:35, Matthias Goergens wrote:
> The T: entry for LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
> names libata/linux without a branch.  The repository's HEAD (master,
> 8d3ae59288f1) is a commit from 2026-08-16 that mainline already
> contains.  linux-next pulls for-next from this repository (Next/Trees,
> next-20260923), and on 2026-09-24 that branch carried work not yet in
> mainline.  Name the branch so the entry identifies where development
> happens.
> 
> Documentation/process/submitting-patches.rst sends contributors to the
> T: entry to find the tree to prepare patches against, so a branch-less
> entry whose HEAD is already in mainline points them at the wrong tree.
> 
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
