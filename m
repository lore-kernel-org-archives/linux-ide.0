Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7B3748E
	for <linux-ide@vger.kernel.org>; Fri,  2 Feb 2024 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706839941; cv=none; b=obKD7HPA5xba4HNN9uHP/2ScGvbdi+FpoBBsMKAGxfkryQV9RgwS76DfXQk0huA8xXBZh7aEV7DxyOFVIpPmkLQ5iRiRW+Bfzh6IsIDLn2cgDmDEKRFC5rOJoxWdXMo/bwAUK7hpSu685TQLpSoUZrv2VbAStA/kybetfc+yq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706839941; c=relaxed/simple;
	bh=j6ITNWjCYnHsuEgL4vvO9gj/ofIqMlzMHSfiJN1niww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlv6qMrwTjZOwU2L3i8VrIENakLzrG9CMnnGEOIuAxcIkMTKPDIMDhrwZuO25qs+AwlAWrFjCBed2eTfcH5YDLKsNcNmW9h04AyaSw59IyVaRU+SKW4guZ65vF2QO4NS/eWHjzNqElZOmv20zIpF0MvstXrJdTOQW0L9M+it3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZvjWQHq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZvjWQHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005D7C433C7;
	Fri,  2 Feb 2024 02:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706839940;
	bh=j6ITNWjCYnHsuEgL4vvO9gj/ofIqMlzMHSfiJN1niww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jZvjWQHqAgdF+Uelgh54s/NNTIdragyLoNH8NIMMKVYIR1m+Z8NHYszsJoEpifqSQ
	 QmNoXjRdcqlhh2u0/aK4QOz9f4DL4ksxQEHsqC0Q2VAeNhIkbJT31ohjxWEiTaw59X
	 s5UJT4dyWUiESVeITUhBe3q0tpRDKK1D0ZruNkB7dvKpWc4GTYLkX/oprLYIxyJTI/
	 CLkFl9rliheAdGHzwOYCxVklNHYgunL/vqRYBbi2aP1CgyBAnbd4pu1mtr9LPZFSVb
	 K2/KBJGp/jPXvquMnQ0weosApliRzdkvjERte6E0RVfhwjcjprihyVSFYnGuWEPwpL
	 AmMN17L0H/R8w==
Message-ID: <c8b84364-580c-4bd2-8730-290a888c546e@kernel.org>
Date: Fri, 2 Feb 2024 11:12:17 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ata: ahci: Drop low power policy board type
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>, Daniel Drake <drake@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jian-Hong Pan <jhp@endlessos.org>, Dieter Mummenschanz
 <dmummenschanz@web.de>, Mario Limonciello <mario.limonciello@amd.com>,
 Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>,
 linux-ide@vger.kernel.org
References: <20240201161507.1147521-1-cassel@kernel.org>
 <20240201161507.1147521-6-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240201161507.1147521-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 01:15, Niklas Cassel wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The low power policy board type was introduced to allow systems
> to get into deep states reliably.  Before it was introduced `min_power`
> was causing problems for a number of drives.  New power policies
> `min_power_with_partial` and `med_power_with_dipm` have been introduced
> which provide a more stable baseline for systems.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> [cassel: rebase patch and fix trivial conflicts]
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Let's get this in linux-next ASAP so that it gets plenty of testing.

-- 
Damien Le Moal
Western Digital Research

