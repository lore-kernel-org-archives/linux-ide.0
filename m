Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E2B511E75;
	Tue, 13 Oct 2026 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904427; cv=none; b=nmhN+q01OJyc6OagHxhfZ0bJGyD0MoMlGZDmj7mYNQ4ScQTu+UqBCrAyvx/NaqPF81WOvykZKTLV+Yz/4Y6G2qL/BI5VZhOjN5yuFTMv4AY68CTdc9QQdKccoTiNP+o3CxHntAgOYmnfa6jcXTBv8KH24g/fdEpved1bvunoz7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904427; c=relaxed/simple;
	bh=9zEIqFuZWEtgu0KkR5GZv9v6Sjazz2Imka+VfkdSX9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjZWN/UTSrroFQZdoLdGIlt6j2MBwFIyBRYDLJpC4fJmC1xV37oA2RRuL//JJqIwyECgq/LEGTCM36y40tJASiZB3VH9tpYj6pSyllmdfqApShnxDzXQ6eVQ5RyWBgKfnG7A6+dolmhJnCHUs3hIIxhiqSVxyzfNAxCN0c+LRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvdsZL7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvdsZL7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F9A1F000FF;
	Tue, 13 Oct 2026 15:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904426;
	bh=sn3ZmssDtT7tXiN2hojIY/CSB9a4rly0g/B30vn5O4U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mvdsZL7sL6xPN2Y0XhNXNweX7/YIUswWU2+zTWNrfru5WggtikvOFJs0To5iwKJVL
	 gRdjmn5n5BbbO0LiUboSaftYDb8IWypSFMPfmh9ixPwmqpiqCEe4o6mlsqKs3JbpCN
	 1MIDfAf3pyCqX12zhQI12WGsDDK6lh7SefVqs9/U+kHlH7eqCB1OJLYnRNC/k1v0Jm
	 eNgPnBlijKmBwrWQRvlMkeI0XnqTdWB2FIfMURTuGqAuEwyyR6GPWSeJesOP20H+tb
	 YpSsRcO/PMhJN2/3QcBCK8F1uxPAeUmHfslLumSbPHBB92pxeeVJUoVM4cLBkL0Prf
	 sxxwP6X5fz0lQ==
Message-ID: <d303c874-239b-42ec-b3b5-ff3f6f6f7a31@kernel.org>
Date: Tue, 13 Oct 2026 17:13:43 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 47/53] MAINTAINERS: add an entry for the SGI IOC4 ATA
 driver
To: Imre Kaloz <kaloz@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org
References: <cover.1791890466.git.kaloz@kernel.org>
 <7e185e14e16f071b0850087e30f6cac4af85b1f1.1791890466.git.kaloz@kernel.org>
 <abe9654f-c81d-427a-97ec-a9c4d4e18f74@kernel.org>
 <70b2e9c4-0b8a-1b73-1690-e9c31fbe080d@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <70b2e9c4-0b8a-1b73-1690-e9c31fbe080d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/10/13 15:38, Imre Kaloz wrote:
> As for merging: pata_sgiioc4 depends on the IOC4 support added earlier in 
> the series (asm/sn/ioc4.h and the MFD cell), so I’d like it to go through 
> the MIPS tree with your ack, if that works for you.

OK for me to have this go through the mips tree.


-- 
Damien Le Moal
Western Digital Research
