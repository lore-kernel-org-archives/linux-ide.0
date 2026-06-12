Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9090130F938;
	Fri, 12 Jun 2026 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781265222; cv=none; b=kXP9BQf+KmBw17vrHVHPySrkF6fCZNP0qvIi+UooEQcwmz3oZCD/vB29ew8tANef81Y96E+fmkp/B9d9mIn6EchjFnqsNEfF056feULYZ29HrIQoRSD8tKV5NylnUFgthFzPZRZzRjwdCmIiX8enPIKhJsOOcq3qFKt4GquGXRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781265222; c=relaxed/simple;
	bh=zrPXgKwmlo88Jv8u9GB4OIl3Q3x5ViWU82huEdjLt60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaEh4bBcl0HY1VEm3jSySD19SaPqMmPp9PnGdE3cDNsucJrFcEtQcn/HR6tG7hPd2SRzcw/IUyXRvmI2krabXro8kvvLl4Es1lGuGoKMWoTRRuhyn4vTYhlBgDNZxJTw8/YAG62A8g84ibaKwf/yZO8+tExPtr5q0JD+s3U4otQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjm7jbYA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjm7jbYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647041F000E9;
	Fri, 12 Jun 2026 11:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781265221;
	bh=eSHeurP/hTsBtiSIS+r1mIWxEKIVU56nlh8S3iGVQls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gjm7jbYAiS8TevTlLwuh3ZavWJ5qzDV+NOA//TxaUfub2UHfFNtCZtE+W7TDj1efJ
	 aqm8ug+zowDPO3hP6O2QHkrdHccV11m+dODvHmrxSkCgnC91hb/LXzv4SGWe2PuhDu
	 t2aV6A91DVDdCSHMLqRxxmUCm7D71YHDbBrg5dg9qEX9WbmfMqnwF2ilvY2gwCAw9f
	 bxdSgDFjTpb56GnjSJVVv9GkOeJGYxrDOb8ei2isQtd/xeh5AuMwS/0pQItsr33y+u
	 BIuzNwyYr77feDNgM7ssgQJKzO60HnrNYaUvOkKVvLIY+VOotF2sU6kJ5WC7OwWP9Y
	 RS8cQij4gw18g==
Message-ID: <78750170-1bc9-4e3e-a7e9-460f388b9ef4@kernel.org>
Date: Fri, 12 Jun 2026 20:53:38 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ata: Use named initializers for pci_device_id
 arrays
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Niklas Cassel <cassel@kernel.org>,
 Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1781252167.git.ukleinek@kernel.org>
 <616e527a0c6cd367f3301438501d8345b0675df1.1781252168.git.ukleinek@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <616e527a0c6cd367f3301438501d8345b0675df1.1781252168.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/26 17:21, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> The mentioned robustness is relevant for a planned change to struct
> pci_device_id that replaces .driver_data by an anonymous union.
> 
> Also drop the comma after a few list terminators.
> 
> This patch doesn't modify the compiled array, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Nice !

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
