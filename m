Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6AB13B7A3
	for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797081; cv=none; b=J/z/v0Xph0R1udfvrnp2N2D7yNR8ix46JNLdErt4c3zQZQwSRgogtQI5HfiRlkBDv86LCQWT9220+Mt7bGxdTkDjv3LssVtPv31oZP0qUHTdOT/XXuYdQu94GdJt32jjxVQ3viIEMABu49o648ovLIB5Vu26yH00lV+llxO9av8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797081; c=relaxed/simple;
	bh=ZsODSloPCgn+fqclZtEKMamJx8EY4abm3KvfDXxIA2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJb0yh0eK/fLNQ2YYWekevB+y1WkCRJWNENuwO1oZBq3XRyc6ymp/vlqHBR5WWIWmorBEAvoll63YJoydUmNJniDClgoIc+noAY+1b6S0qDwNpvQzuEZkRpjFjMiYSmgOWcRPCWaHsX7Ycfb+6Z6yHKIGQMVvJYgLDCQdv7A7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkGbZ2EX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkGbZ2EX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D78C4CEE2;
	Wed, 16 Apr 2025 09:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744797078;
	bh=ZsODSloPCgn+fqclZtEKMamJx8EY4abm3KvfDXxIA2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KkGbZ2EXOVdjNh29ekKA/+oe01RBRXiLCW9DjNT89E5ETvXbyAyfsSJwoxRNKzp9r
	 6lV9NJSl1uI8um0+mEQ9Hv5z8GSf45PdYZaGcd4wB28xA42FMCAr46myPPAfF89nZ6
	 cUDPqyz7AsU8v7U+Hevu2DaLI2K8qMBK5jv4jhRB1kB/BPH/Mqr0HsJhckGVvajj0u
	 l/sxoMQrVpGUzXwwyF39Ju4Z5MpEabCx5mle4m4ebulX6HdznTbRXQXCn6ZiE+deeI
	 8pyP+FKeft4WMWfjPDvwCd4JkiecM+pMdjcD7cv5yEAiyRNbuHoKXUS4EmUdFPaCPz
	 nbk5SVzGUte1g==
Message-ID: <66399aac-8b53-4e52-b32b-5da191dc4b44@kernel.org>
Date: Wed, 16 Apr 2025 18:50:30 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Successful NCQ commands sense_valid cleanups/fixes
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 Hannes Reinecke <hare@suse.de>
References: <20250416093127.63666-5-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250416093127.63666-5-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 6:31 PM, Niklas Cassel wrote:
> Hello all,
> 
> Here comes some minor cleanups/fixes related to the sense_valid field in
> the Successful NCQ commands log.
> 
> 
> Kind regards,
> Niklas
> 
> 
> Changes since v2:
> -Picked up tags.
> -Changed "1ULL << tag" to "1 << tag" in patch 2/3 (Damien).
> -Improved subject in patch 3/3.
> 
> 
> Niklas Cassel (3):
>   ata: libata-sata: Save all fields from sense data descriptor
>   ata: libata-sata: Simplify sense_valid fetching
>   ata: libata-sata: Use BIT() macro to convert tag to bit field

Looks good. I will rebase for-6.16 on rc3 next Monday and apply 2/3 and 3/3.
Thanks !



-- 
Damien Le Moal
Western Digital Research
