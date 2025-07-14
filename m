Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703B22F772;
	Mon, 14 Jul 2025 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477393; cv=none; b=FA8u6Nx21jJ86RNZ6Hu/uW0bN03TFQDE3nxix5Mcy2HlsekTYcYrf7NnteplIHpyNieHf3fH3bf2HLNkJCN1YzOPZBsQCeGyrKzG+7Lb26otuRtMds0dTE0bu2FNcs9wggxn4lAGnGTY4xv1EthrtiXQvp253kt8zh/XN4EjnWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477393; c=relaxed/simple;
	bh=oGY0ZfWG8V0qgiGx+Qoguyob8WIJvGseS2Sxb/zeRwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFD5+Pk5TeSo+Fan+wtnLjy7ie04GY/3yIaBuspSpynvxeb3X3kVs7yjbs4sDVpnbmakBY83g0JZDBQzlhP4+0BNjq3Q+eKX1D8LV0RySJlj+E1j3C8mtiziTctVo91DgkmHNkWXsSTdTny4gSEcQHazaursWyxkeTFTeKz6AVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX/N0djR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX/N0djR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F96C4CEF5;
	Mon, 14 Jul 2025 07:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752477392;
	bh=oGY0ZfWG8V0qgiGx+Qoguyob8WIJvGseS2Sxb/zeRwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WX/N0djRPbL9RNwLU1wZW4BKjR/sDhPidL9t2ChyX1bSabCQ+gDGxPrrviBxLatOn
	 jVhA6WjI0TCbpkQKDltWlOMrGq6+lOoPmGhtqVxYDtc9SQqV+5Om/jWmi5dv1IZX2+
	 jDNtZtJFcrBOVqOXep2w3fYHkybmriRKxVOjmsxl/6DJI8z1EE0/Ryrd/lf33incMM
	 rLHLuHvTQ1nLLwOohV9CRdGUXHY901C8hEb4s6YzMEh28o2CKKUiZaCJMt/JcT6dut
	 OPdFoDwB/Hg6YeHust2nUpVJJzS+mRDt3uhAKFHsdZMT8ZT+ittdlj9lr03wDMxsyy
	 PhEt9MLSZ/btg==
Message-ID: <2e63f7ec-f9ed-4ad3-b27b-a5d6e120bff6@kernel.org>
Date: Mon, 14 Jul 2025 16:14:14 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] pata_rdc: Use registered definition for the RDC
 vendor
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250711113650.1475307-1-andriy.shevchenko@linux.intel.com>
 <6d0b19d8-fb1a-4a3f-9a21-7c696df880c0@kernel.org>
 <aHSt65bhITAzN_2x@smile.fi.intel.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aHSt65bhITAzN_2x@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/25 4:12 PM, Andy Shevchenko wrote:
> On Mon, Jul 14, 2025 at 09:32:09AM +0900, Damien Le Moal wrote:
>> On 7/11/25 8:36 PM, Andy Shevchenko wrote:
>>> Convert to PCI_VDEVICE() and use registered definition for RDC vendor
>>> from pci_ids.h.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Commit title needs "ata: " prefix. Niklas, can you add it when applying ?
> 
> I took the output of
> 
> $ git log --oneline --no-merges -- drivers/ata/pata_rdc.c
> 
> and tried to deduct what will be the driver specific prefix, there are no
> ata: pata_rdc: prefixed changes, so it appears that I made wrong assumption.

It is probably because that driver has not been touched in a long time :)
These days, we try to be consistent with the patch titles and have the "ata: "
prefix for all of them to make git log searches easier.


-- 
Damien Le Moal
Western Digital Research
