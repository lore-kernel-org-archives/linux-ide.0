Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080710F1
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642030; cv=none; b=niakZ2oSxs2KvdIK+bLIzMhi/aiMZjJqOc69M2WbFBVCmO7tsMdGgFe7VamIMsdNxz79DvjTQbuYynsER2hoeJ43EIqnbyvuACPdVZBBDk0HTUZ19IDqJhBasNbXJys59+b5u89Sayn/QCKgDtbFF7HihBPVQ9nOQcpRDNtcltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642030; c=relaxed/simple;
	bh=K/jtHkSIk4RHYAjUCh+6F6uAvYB0BziDf1JjjkIUQP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LoHRdA4XXojGPROOIARl3LSiW0fVsOu88lq8m2uLOsCK3/CL6BgwaUTWMCL3ZxcuVL57+bcMG6wGqef81XqrG4dAkozXpSQ+TLc6Spn0D6cQTExJ6aE6saH2pL0jGZfNb5GARANfzrKLMrZZz6sqO1fXadeHHVjDHrEI6EDWGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncmzqMJv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncmzqMJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81418C4CEF1;
	Tue,  2 Dec 2025 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764642029;
	bh=K/jtHkSIk4RHYAjUCh+6F6uAvYB0BziDf1JjjkIUQP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ncmzqMJv9CxMn3w93sFjg21cVMT+BWC0j1uaTh5Vk4dkj+rbrcbzxhypGjDn2I/8w
	 vrYl1R/syFB/d/TtR0Nlhneeqck8HhEgRV6HaBFcvlm+rsMke7Q2HKiIo+3QU5QJu0
	 MUGpm/xAh1qq9yTMpvJC3QGcS/bNGX6wLPUaaFnPFdASBEAEdqCIU50LfxZ5/93SIZ
	 TTHjPLK53YGvKQKJy745OYGpGacritXgy/JrYi6InKi1E5D9jgG9DUBOhvoaSNPa4c
	 UkEuDXJ4dTzRWuvLCoLn3Zsf8vvS46Pzp3kdvU47CAC/1kBvfkdgBn+UftEazJfKYL
	 Y1TVzyyHlbxhw==
Message-ID: <f83e02c8-7e92-4dbd-8d43-9810f3ccc68a@kernel.org>
Date: Tue, 2 Dec 2025 11:20:21 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] ata: libata-core: Quirk DELLBOSS VD max_sectors
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, xxjack12xx@gmail.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 stable+noautosel@kernel.org
References: <20251201123501.246282-10-cassel@kernel.org>
 <20251201123501.246282-12-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251201123501.246282-12-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 21:35, Niklas Cassel wrote:
> Commit 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP") increased
> the default max_sectors_kb from 1280 KiB to 4096 KiB.
> 
> DELLBOSS VD with FW rev MV.R00-0 times out when sending I/Os of size
> 4096 KiB.
> 
> Enable ATA_QUIRK_MAX_SEC, with value 8191 (sectors) for this device,
> since any I/O with more sectors than that lead to I/O timeouts.
> 
> With this, the DELLBOSS VD SATA controller is usable again.
> 
> Cc: stable+noautosel@kernel.org # depends on Move quirk flags to their own enum
> Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
