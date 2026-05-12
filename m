Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A32A47DFA2
	for <linux-ide@vger.kernel.org>; Tue, 12 May 2026 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571752; cv=none; b=VnUCz8S/dTm/QVrdxBpwS/69MKzqbWazhQwCMzaPEfXjpkGg2wfxyZoo7bIHk+7No4DE72FcuvndZs/Z+tkU2SHc2JduljAfPEUMgbhmgxgmimJfbDZ9bxoZfp3wYZ/PM48NEGHYFT2iU9fKbi7jnVoI79p4VHKAdmYGCPp7wvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571752; c=relaxed/simple;
	bh=0z/NeAvulEGvvzib6tHOckQnVwBPxdKXtUmLnT0zySc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8jYSH55eBN8FotLFqCIZOEOBOUKLwOLY5mMr2OcqrR4s2VU+5UUXlSrnOx84lCVWbuMB4SySaoLttaClRvBeO8lTaRBYDaME1wSEeCXIKviIlCWA9VZZYvcWfwIWhRb31yu69SlTvjb/NIwwHguP5CRKgflyi7zLjOIqF1uF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QImTb2tw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QImTb2tw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781F0C2BCB0;
	Tue, 12 May 2026 07:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778571751;
	bh=0z/NeAvulEGvvzib6tHOckQnVwBPxdKXtUmLnT0zySc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QImTb2twg93MP7Clms/jkjwWQ0SF1JxhcJcMInNtnwItQalNdWuCIfk69c7jdrqOg
	 RD6lbkn9tGfWJeYsLMNM8d/RJ40TQn5fRHc5RaMgxql5hXqCwj4X4ZjWRyns1atI8b
	 fHRwiQb25+NLBuV7AHwqcAS/5++mA9exswZKKmvOyB/hho8uiW2TO4sOgFvsP8ZNbq
	 typnTjnUc4NjjB00wFc+0I7MWmChws45Wt0yVuMK2Lnhq5gZQv0EqxxoS3ySUAfcSe
	 wlDGAPHKwoHL8sncp6sBUiWXmi5kvfQ0IAFJH0c4K53MmMrtFwuxiz2DXrLNAKstyM
	 5sl5WptT5rT8g==
Message-ID: <20ed30b4-66a1-4ca6-aa1a-98960273797f@kernel.org>
Date: Tue, 12 May 2026 16:42:28 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ata: libata-scsi: do not needlessly defer commands
 when using PMP with FBS
To: Tommy Kelly <linux@tkel.ly>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, "Martin K. Petersen"
 <martin.petersen@oracle.com>, John Garry <john.g.garry@oracle.com>
References: <20260508195051.188207-4-cassel@kernel.org>
 <20260508195051.188207-6-cassel@kernel.org>
 <cc742ac4-4278-4546-be6e-07b74f1be979@kernel.org>
 <38ec669a-f69c-4c55-9f47-995d6722806f@tkel.ly>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <38ec669a-f69c-4c55-9f47-995d6722806f@tkel.ly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 11:41, Tommy Kelly wrote:
> On 5/11/26 19:01, Damien Le Moal wrote:
>> Looks OK. However Tommy did see a warning, so I wonder if we still have
>> something missing...
> Sorry if I'm causing confusion, for clarity:
> I didn't see the warning with this v3 patchset applied.
> I saw a warning with vanilla linux 6.19.12.
> I just recently got FBS working so I was reporting any issues with old code + FBS for completeness.
> 
> With this v3 patchset + FBS, no issues or warnings.

Thank you for clarifying. It would be interesting to test this v3 but without
the FBS support. Could you try please ?

> 
> Best,
> Tommy


-- 
Damien Le Moal
Western Digital Research
