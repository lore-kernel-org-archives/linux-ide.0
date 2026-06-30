Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D2126C02;
	Tue, 30 Jun 2026 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782778817; cv=none; b=SiWIpWY2Mk00fxZsNZqnv8Cnf+w+IAzMqJElzoQKC1MY23Ngkgzs/D9L/8lnnoL25yCZ3y6N7EGW79zqnFkkwEe9pe+y1/9GNpfDn6Z9SWssfne4upP+XgVNblwF5GU9Ym3+H+4pYsOib/yxmgykf+ylgiCfBQFOU9mTsQMvSE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782778817; c=relaxed/simple;
	bh=88Pk4refYHGQBklS4ZwESUO4AsTYJuS/rPsufymujf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJ3gN5mYyA/VcmiSsqFLZy9vPcsQcj8jsibfWrudHjbHHBhCqrZcPPmRWM+BNPd0b+urLTUmni6OCrJ3exO6sYsUtDe27eThG6QtJ30+visbGOHoH/6fSvCOfmynPKmg/CEOesbudJsk0BL8roD4bq35x/Y5pgWgUsvf9ksWPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuAixWU+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuAixWU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AB81F000E9;
	Tue, 30 Jun 2026 00:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782778816;
	bh=NWQWOyEvTWUB/KiKEh5N8KwMd0K4J2AKUxVoZEfNgvM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iuAixWU+tEitm7Y2ljV3ZtpMAVI0q55g7AG7zEqZX2kCLv9PR/j76BRFVcu4m/zlI
	 J3qFQ2mACt5H9f8RZtLyLtE6E+/4iGV0x9V3oIoGANuupN5DGO9lps8v/x1oOUwJ6D
	 xCCa6BitF8dSLxYP3cU2EpQb2fGplG7BNCiXGOUov2uhZionVe3/LYKy0oLeVSpikS
	 gQE+5c85wn/uezugteRdx18l1WlzCfofhs4zW3Lx9/47/yGbFlupeOBtisJ+ZQ9S5i
	 kKELBSDkXe1sz54m6Sqcts5xNQUE6lFhGfRkAPqQw2m71LwzbHw1KhJTbQSLjVVW1z
	 ruqElwkpyXvYw==
Message-ID: <e1bfe23a-7517-4a8f-9c07-2097cc407f7a@kernel.org>
Date: Tue, 30 Jun 2026 09:20:13 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: limit simulated SCSI command copy to
 response length
To: Karuna Ramkumar <rkaruna@google.com>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, ipylypiv@google.com, tadamsjr@google.com
References: <20260629175024.2187500-1-rkaruna@google.com>
 <7bef0564-e263-41de-857a-03ecbacc789d@kernel.org>
 <CAD50Xqr9YKCT8Su55D4qWq4cy+sVtLRJhS8z+vYQkhsZH-oacg@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAD50Xqr9YKCT8Su55D4qWq4cy+sVtLRJhS8z+vYQkhsZH-oacg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 09:19, Karuna Ramkumar wrote:
> Thanks for the feedback! I'll push a new patch failing the command
> instead of the warning.

Please do not top post.

-- 
Damien Le Moal
Western Digital Research
