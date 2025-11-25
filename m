Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF35288D6
	for <linux-ide@vger.kernel.org>; Tue, 25 Nov 2025 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764045286; cv=none; b=DgyhL1ERrgfpI/n2zSL1fRCnxTWlQ9iKstcYkCjHXUNdDWFOx35fKUwJSxtLSCoKT6hgIKmn09mhMmgAWMS/YgMtYo+27f2EH1mUzXvUEUu6tOMnAgvxk1i7g3tBF6dyJFC+dcl/j5XUICm2B8AmIYmXD2Opjjmd7yqRupoN2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764045286; c=relaxed/simple;
	bh=+1roETXJigZaCGO8+BIWPkOkI2UxnE1HIzCLaJut4VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZ2ZV4cBbRiDdTVikMbJZpJGonCZkDW71q6VedMPMRovr5xxIIr5qwpYVMwqU9W1sxDzZ4jv0uO/6KJGzVfTAkvwRRxlILTNfhbTT4Q13llt8s0WwF/rhc90+PlCgGZweDL1pn/N2iWjwVVEkswTRNN7GA8tnzqdO6z+Xg+XZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/MfWDR0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/MfWDR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C01C4CEF1;
	Tue, 25 Nov 2025 04:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764045285;
	bh=+1roETXJigZaCGO8+BIWPkOkI2UxnE1HIzCLaJut4VE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h/MfWDR0Hj/BVjXsfEivv3QApZe7rPAN1c57qO5bLftEdWdhmcwJbay/0M637x/sd
	 cs/COJguO9P2GGkjReR+i7igzpt2UaWZrIu7CEortCrQEYkxMS/azI7E18B1WK7iPZ
	 Nl+8mgjfh4ygL5pFUiZ2Yr5ZFtepiCODZKQnlv37jIn9ZKsFQJaf9gEOL34EBv6B0Z
	 3D7Vetspm+49DuMp3EN6pCUhEAg9jdM4oLZAaxt88aegvdVUpoU6R8pRCbyEsVEV+t
	 HCqzgs+DIrM2cbx48Y5XS0QIUS8ywTOytHzuYzMqlLc2iYaSts7Xy+xb0AvZNlvzEj
	 CqAmkS0Lx0eHQ==
Message-ID: <cd332a64-d8e1-4bb1-853c-d1087164b93f@kernel.org>
Date: Tue, 25 Nov 2025 13:30:34 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ata: libata: Allow more quirks
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, xxjack12xx@gmail.com
References: <20251124134414.3057512-5-cassel@kernel.org>
 <20251124134414.3057512-8-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251124134414.3057512-8-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/25 10:44 PM, Niklas Cassel wrote:
> We have currently used up all 32-bits in the struct ata_device struct
> member quirks. Thus, it is currently not possible to add another quirk.
> 
> Change the struct ata_device struct member quirks from an unsigned int to
> an unsigned long long.
> 
> Doing this core level change now, will make it easier for whoever needs to
> add another quirk, as they will not need to also do core level changes.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
