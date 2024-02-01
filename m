Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF3158D73
	for <linux-ide@vger.kernel.org>; Thu,  1 Feb 2024 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774986; cv=none; b=NGjPV7mc9KPF46/GTacKvtqJH+0Kx9sOiAksls/FMSrNQg5VaXhRSCrJbGHXPoj6E69BOnBM9EpMqf5k5a3+3VG/Z5UkRyyzPX8Z6y8KaSRMR2CypTzrSNzZyZZ2IVI06iNAZnyJ8sO93ojskUxYda9DZwvXjRjeHV638I0r2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774986; c=relaxed/simple;
	bh=ni314pA7z3OwFN/rjanx5lxIflo7C8KY2eXtHCAPtTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lDN1U3AeyqipJgWpMeeGCE0v/nXS5qg2OkWcEz/jjvZVAQwFOUqeDCzCBM374kizVwdnSkOjDpN84XwYW+qzFtmyCBs5RQ0EgETojo3uJer65dLm4EEjq8uQG7B0lRBkZIv7dc+tqNXtl1QBHcu6mVoY+lbsstLOIZtsNI4KyI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaJ1JXfE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaJ1JXfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D062EC433F1;
	Thu,  1 Feb 2024 08:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706774986;
	bh=ni314pA7z3OwFN/rjanx5lxIflo7C8KY2eXtHCAPtTw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=DaJ1JXfEo17Z6YJwK903RlGlQqM1zeCTR/nlbQwjcLND3KEI6eqzEecrEDXX9M+5+
	 /oWC4OkK5LfjyfE+iFbqLbkUHU2d5xRJN8ORO2P2O+eCEbv5HmdkhrOjkf845YHRrm
	 pcnHqoedCna4jbvgsD1treaG9EqSbvIOT3SjNrRPnXtGfyo8RTENKJRmsN1VG00qS1
	 rSaBV7aVJXpsCP2rpq8qSiN0JaT+b+H+mArekogaorKTWiJXpLQH+2VR1iuFaMCcng
	 G0SPSWSyuuP3rUxdsuS7TnEcS2TLZDEM4UZF0AGbvam71xK+wVqoHMrus7sKN473oa
	 21dguWXQqOPIg==
Message-ID: <d8dcd103-b8ec-4398-8bca-80ab1a2684ab@kernel.org>
Date: Thu, 1 Feb 2024 17:09:44 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Aw: Re: Re: Re: [PATCH 0/2] Power management fixes
Content-Language: en-US
To: Dieter Mummenschanz <dmummenschanz@web.de>, cassel@kernel.org,
 linux-ide@vger.kernel.org
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <DU0P251MB082515FC8FE77424231B475CF4682@DU0P251MB0825.EURP251.PROD.OUTLOOK.COM>
 <345be856-8959-4148-bcae-00b3fbcd0d08@kernel.org>
 <trinity-0be6e8a8-e6d3-4d60-be0d-59592a9edd65-1706010022623@3c-app-webde-bap10>
 <a72daedd-48c4-4eaf-9a77-a34679636a8c@kernel.org>
 <trinity-0df92d73-be55-433c-bdb2-4387f7ea590b-1706686178879@3c-app-webde-bap43>
 <3f7cef2a-5ba4-465b-a1f5-77e2bcc50ddb@kernel.org>
 <ZboztvrqKKdLQ1mt@x1-carbon>
 <1a7f5f79-95d2-4efb-a76a-6b7cd0cfe006@kernel.org>
 <trinity-f42c04e5-aa43-40a6-b65c-ff6229421bc8-1706771527600@3c-app-webde-bs18>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <trinity-f42c04e5-aa43-40a6-b65c-ff6229421bc8-1706771527600@3c-app-webde-bs18>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/24 16:12, Dieter Mummenschanz wrote:
> 
>> Indeed. What is the AHCI adapter here ?
>> It would be interesting if it is a Tiger Lake :)
> 
> No It's an older Coffeelake/Cannonlake Platform.
> 
> lspci -v |grep AHCI shows:
> 
> 00:17.0 SATA controller: Intel Corporation Cannon Lake PCH SATA AHCI Controller (rev 10) (prog-if 01 [AHCI 1.0])
>         Subsystem: CLEVO/KAPOK Computer Cannon Lake PCH SATA AHCI Controller

Thanks. Can you send the PCI-IDs too please ? (lspci -n -s 00:17.0)

-- 
Damien Le Moal
Western Digital Research

