Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650A346FB7
	for <linux-ide@vger.kernel.org>; Thu,  8 Jan 2026 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886374; cv=none; b=NOKrMBpKD4M9FJPo+GOTfjgTmtTQEcaksQuNSv8HWVfrVo7F2giOReMFt3R8D9/iBGxAQS7Tjju3423y4M8eh/g8j0teK7o+RMRn4+BPfFB2H8GOoJNPe+dY+7gMi0dQxfOFjhlkUdGtc9IAPbjAjLuVIKfJjt5huVzuI75CcIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886374; c=relaxed/simple;
	bh=Te7pxq6Wu5lN4ZgtxCrbpyOCf9wjVmFsUegNeS8/HQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfXTyIWKpf8uWv+j6OmBcVQlrIRM5YEdjgCs6lP+2qRJpoeyBURf+Z1Z/cB35qqyFPi2RlunNfeS4LHpF7u+0Pg54XvrnOkrNM1GgA/K0UY+MWJiMGDlf5ipD90z6YXOlH1rww7e2hCOCzR6m3hc2wj6FAPS2tVxQy6Fje4prK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=de79nI06; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="de79nI06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61904C116C6;
	Thu,  8 Jan 2026 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767886374;
	bh=Te7pxq6Wu5lN4ZgtxCrbpyOCf9wjVmFsUegNeS8/HQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=de79nI06auedj8rRkMxhAI2Did0I551MfWXwLwkSySz99gsg4ULAntrCpMEg0g0o5
	 ILB5lYz0Y/EYXwDUuuwHngbRlMGcscNynROFS0q1Onb0AplQL31FxLOs35h3hLDmOt
	 3bDLJw+8VEkji28ToLDBd0lzU0X37jaQvaY/KElsA217HyqI+prY2Wu3yC6xCHNcQL
	 rFGl1YTu+zdR/xqofC8BP/veOQAaQ9ltoovqjBHtaMeqKhumIYt1GKyG2ZdmSn47KH
	 LKs6sGPte0Ci5zNTqA1pZeAOQTFdiuvYTTZEo7ehCtcWVqo2E21PQDRvmVEHR2Cj0S
	 dBdq/dxg82v+w==
Message-ID: <42ea9b9a-e34a-401a-a083-daf08442a92c@kernel.org>
Date: Thu, 8 Jan 2026 16:32:51 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: Advertize device support for DIPM and HIPM
 features for ATAPI
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20260108141234.2837566-2-cassel@kernel.org>
 <aV_DqvnmcjoTXPKr@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aV_DqvnmcjoTXPKr@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/26 15:48, Niklas Cassel wrote:
> On Thu, Jan 08, 2026 at 03:12:34PM +0100, Niklas Cassel wrote:
>> Commit b1f5af54f1f5 ("ata: libata-core: Advertize device support for DIPM
>> and HIPM features") added prints if the device supports DIPM and HIPM,
>> however, it forgot to update the same print for ATAPI devices.
>>
>> Before changes:
>> ata1.00: ATAPI: Slimtype DVD A  DU8AESH, 6C2M, max UDMA/133
>>
>> After changes:
>> ata1.00: ATAPI: Slimtype DVD A  DU8AESH, 6C2M, max UDMA/133 HIPM DIPM
>>
>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Don't merge this.
> I think I have a nicer way.

Yeah. Adding a different "Features" message like we have for ATA and ZAC devices
would be better.

-- 
Damien Le Moal
Western Digital Research
