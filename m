Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038C2285CB9
	for <linux-ide@vger.kernel.org>; Tue, 15 Sep 2026 04:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789445323; cv=none; b=fKKDdAaqElWtTDx4VjEVFG1naP2eBQgf4geTKpiQSaXyW1YBxuRWNAv0PJeDK2qzlGR2AgUCleSQOsIGQVxwYWORyK48EFd/eMUWk5EE72mxJobIsE/wFalldRCcBEbG1IgHzz/jHXxouIK+hmxeRlOT8qxfmRFy1MDeb6bU14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789445323; c=relaxed/simple;
	bh=qPINpfBsXKEfZP0CNQcmTEMeCUw9rcYG2Z8YdVK15PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOI4gsU8Kkx7lkiGk3W5kSXd37bwldN/qxdyZU9RqMEUefeS6Sz0ZXorm0B6Zz5nlXeHmkxyJtGFehS1KqMRFeSSz0olehm9WfAyLb0up7ipYbZBs/kynwx8igLjpuc0p0PpwORAAXhzwGXhW3QiIL+bhJymD7bPzXgVrNvCOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxXRLgLB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxXRLgLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A030D1F000FF;
	Tue, 15 Sep 2026 04:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789445321;
	bh=lRmIKyxS5lP9foMEbglPEKa/Ew7Yk3y3DtU+0PMWePg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DxXRLgLBC4oyw277asGaDyxfSPLxA958IUtrCOd65B/LFiWCqdriiFnnWVuGS/X1z
	 mH29Mvk3so6D0v9Wo5XLZdbM1cfZM5m3WlfaXRNPwaXbnUUK45hsVrMuEG/vuAIezP
	 qQKShSCvPfmnV7z3G9dSj4147qJvTBjKPmmOHtTsbAnX5sWyG4+kafRntwef5fPdFA
	 fa55CZuNxXhxwQDyzfQmGdg/cZPEACeDLRCsLGB4XoufGjR+qETOwcFCPvgF3nF8RV
	 cZNcisgc8Ub0k1mhJr1oyAgX012D6mLBa9rGHle31plzszycNywlSRxJpZyPpr1QqI
	 hxBAXiQznEkHg==
Message-ID: <1897c1cc-7732-4aca-910a-b5bea41272e3@kernel.org>
Date: Tue, 15 Sep 2026 11:08:38 +0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] ata: libata-core: Fix the ata_host_register() kdoc
To: Niklas Cassel <cassel@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>, linux-ide@vger.kernel.org
References: <20260910171406.131211-7-cassel@kernel.org>
 <20260910171406.131211-12-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260910171406.131211-12-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/11 0:14, Niklas Cassel wrote:
> ata_host_register() does not start the ports of the host, it requires
> them to have been started already:
> 
> 	/* host must have been started */
> 	if (!(host->flags & ATA_HOST_STARTED)) {
> 		dev_err(host->dev, "BUG: trying to register unstarted host\n");
> 		WARN_ON(1);
> 		return -EINVAL;
> 	}
> 
> Fix the kdoc accordingly, and fix the grammar of the last sentence while
> at it.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
