Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEEEEC2
	for <linux-ide@vger.kernel.org>; Wed, 28 Aug 2024 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724808830; cv=none; b=n/FuBfz750wr6LNiQI0SgOisGsoZt3stQ6316RaUD5utdBrAtcC35TYVAIRcYREUHyxcbrGPRJ+56qggI8lWT/jk7KdGQ+DP3yTFCCTI1I9fbpu7sJwTsAtxW0xNnrPNl4d8CmiHXX+ipNtawFV7sOxyJd6mVAJQLDFPb3UfqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724808830; c=relaxed/simple;
	bh=rQe2zRMuWnNgiiXnGVfDlskKanfXlz15RK9AQyRyCfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aydVj9XDUq0gObcfqe4jF84EeP/i+gtF46zVBGayDBBj56KBDQVTJoSTZ5Q3ffLY6XIgBNdPJhMXbhZMpPo76wXuKSW3qgMDLp3arPYmAWnFbaWRO5aqTHZlxTz6MalObnw1dFseocDmbOgRfw8hHlK1Zw/x0NpuIi7eXVgGRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFjAz94A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFjAz94A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA59C32782;
	Wed, 28 Aug 2024 01:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724808830;
	bh=rQe2zRMuWnNgiiXnGVfDlskKanfXlz15RK9AQyRyCfI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=eFjAz94A2x6zIgweJI86kuuR8XXVnpXFquox6V82jJmply119DkfXFZSH1m1v1W4S
	 pVhAwDy6igah1WMxAhOMkoETYAWS1na/eIJ0GRmN2diaUZ1HU7zJ2QIAzrjRwouaNp
	 X6ybftHY8DmJqBmEwCWecKNTEYO3p5PWIVo1ORNrwMbCMBEjMtOgPPyEWmtxjMjKP4
	 ykZ5aN24FjJkrp6w2MyPYal5zkoEBGp4qNEzrw6A06YVpUgNJuUhS+Jyl0SnXmEDeP
	 8eCQotP7BWvkrnpKyjNSXmYsCz3+HpVj7Y0jSFMrIoxe5LRquXcrkUohOpqS2LjoIn
	 T8NcT+8XEAfRg==
Message-ID: <017166fc-59b6-4d56-8b97-f9a0f7629f0c@kernel.org>
Date: Wed, 28 Aug 2024 10:33:48 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci_brcm: Use
 devm_platform_ioremap_resource_byname() helper function
To: Zhang Zekun <zhangzekun11@huawei.com>, cassel@kernel.org,
 linux-ide@vger.kernel.org
References: <20240827105823.36193-1-zhangzekun11@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240827105823.36193-1-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/24 19:58, Zhang Zekun wrote:
> platform_get_resource_byname() and devm_ioremap_resource() can be
> replaced by devm_platform_ioremap_resource_byname(), which can
> simplify the code logic a bit, No functional change here.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

Applied to for-6.12. Thanks !


-- 
Damien Le Moal
Western Digital Research

