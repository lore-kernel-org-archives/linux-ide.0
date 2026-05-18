Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096703DB638
	for <linux-ide@vger.kernel.org>; Mon, 18 May 2026 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096277; cv=none; b=AaoTaEfElNbttS5ba1w0nVbR5MDeO8PioKkNeAkmGKqwhnbrsVaP5z7HD191zwyjtTpI/oSsu7BEle99VbCSIlaj64nN5KPz8K3tBn42+gCj1zqs68bT3p5G5Xv9xaOYCOofPmMc+r6+6/n84rnxgfOemlBICG5mNTghycP2dyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096277; c=relaxed/simple;
	bh=geFm4uI1xXZZxhnYl7l4wU45bTS8VD0SqX7Fi3q3nEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3knqnTPdkXpzsKwdfqCrJpHVPhOH5xLGXSw5laYISMe/SeGdaa8a1vbPHeNQxPOPFBIkXBq0rP9o54bFHz5jeUW77z+v6UwC44irK0DWuS8pwoVhuhOWWUVICP6/QPkuD1UYLwg64VydNemipiVe0nEers5j3iZCdMVh6P+INU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYUXllqc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYUXllqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01D3C2BCB7;
	Mon, 18 May 2026 09:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779096276;
	bh=geFm4uI1xXZZxhnYl7l4wU45bTS8VD0SqX7Fi3q3nEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SYUXllqcdDtZILE2hoKVcgE8QvsBes0DZ8iw5Mz4idgm8wFEH1576bsALAC7/AnN4
	 1FnVVqfia/7IPH61bb25MElRXpdp6HaXHqGisZ00X+Ls4EBcX/TOwX6V0TDQ7aOq5j
	 68SW50xeEe8bjqbGQmU/dOhOfznsxH35j91k4511C8N5oNNgmJiaBjAC3atIulCZpQ
	 yYGhtduBcWzDJ9rVhe/gjabdI+Sm/whQA2u75Qs1QTkDDHs8I9u0Hs32QXBvjedevr
	 oc1uCkuCxD+okIVG20C3Y7UPy+504Ab33/yKw4gWkFrd3BUJHILyqDIK2e4qbnUgLe
	 53EVQB2GV9nWQ==
Message-ID: <c3219ead-b8a7-443e-b7cb-14ecd3ee9f5b@kernel.org>
Date: Mon, 18 May 2026 11:24:33 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] ata: libata-scsi: do not needlessly defer commands
 when using PMP with FBS
To: Niklas Cassel <cassel@kernel.org>, Tommy Kelly <linux@tkel.ly>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 John Garry <john.g.garry@oracle.com>
Cc: linux-ide@vger.kernel.org
References: <20260514073858.1175072-6-cassel@kernel.org>
 <20260514073858.1175072-10-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260514073858.1175072-10-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/14 9:39, Niklas Cassel wrote:
> The SATA specification does not allow a non-NCQ command to be issued while

s/SATA/ATA (or ACS)

> an NCQ command is outstanding.
> 
> Commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> introduced a feature where a deferred non-NCQ command gets issued from a
> workqueue. The design stores a single non-NCQ command per port.
> 
> However, when using Port Multipliers (PMPs), specifically PMPs that
> support FIS-Based Switching (FBS), non-NCQ and NCQ commands can be mixed
> on the same port, just not for the same link, see e.g. ata_std_qc_defer()
> which is, and always has operated on a per-link basis.
> 
> Therefore, move the deferred_qc from struct ata_port to struct ata_link.
> This way, when using a PMP with FBS, we will not needlessly defer commands
> to all other links, just because one link issued a non-NCQ command while
> having an NCQ command outstanding. Only commands for that specific link
> will be deferred.
> 
> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
