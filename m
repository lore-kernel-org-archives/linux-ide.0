Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633834C7C
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747207097; cv=none; b=u+X531q3pN74Z3Re8IpQljOr9On14MyCnb3siAUUGorpIeYP4afu5Nl+ESIuuPgKn/JrrLQrZDr8R+h19d4/KXBvG3s4CjL2uqyWg2YkiK5JEiLg8PkAac1kuAS4uaImtSqCslczhsA64XWfyzNs97ZUHcuybKK9eqeQ8rpmV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747207097; c=relaxed/simple;
	bh=ZdbsO05a5cvrz6N2ByTvdttGV/LBYylVRgyTc+0P4gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qu3UoXDb/Cls9azPPP508yoo/Jj0hp3Ft498WhAUH9vGURCA/CmlJDpDWC5Z0PuOP+iqioyuwg/JbewEm3jml89m0xidkUejIICqIYjFvoAhL94Fg2EZiDAv0fyzlUNNXKk3rpAQcOBOsvlJQ38OHuQExjRF8u8X+goQZdwD9kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYkeLrlP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYkeLrlP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E563C4CEEB;
	Wed, 14 May 2025 07:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747207096;
	bh=ZdbsO05a5cvrz6N2ByTvdttGV/LBYylVRgyTc+0P4gU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RYkeLrlPao5YrMf6wB7XkYaXIuas7c7WziM89SxfR5ggAJ4HFO0DC1AkITqnA3qbd
	 ZF5tAydVfBktowJ6bhK8i9XoioGVLnFNzxnpRAGrUc8nxLXymuqG30I+cOi4foHA8M
	 gzebp3NMv7G2g3/Az+w/6vngDscIZHg54yWsPhBQYBwhtBHMT8il7c+koBhgD4TbwK
	 QCo6Ti4LUnY5ZVugBp10KCceQzc3LzA7UEMJhfqXi4S6vm9n2BacimLncepsW78HRY
	 /GjcOGAB2Nw9jJ4CFuxR6ciWsBqX5fZOvndX9zDr1a8guCbmDkCPUEKo3C67MVRxDQ
	 vPDC+QWZOcmJg==
Message-ID: <538f1b73-b806-4443-9e49-5aa1910fa1ff@kernel.org>
Date: Wed, 14 May 2025 16:18:13 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: Print if port is external on boot
To: Niklas Cassel <cassel@kernel.org>
Cc: Mikko Korhonen <mjkorhon@gmail.com>, linux-ide@vger.kernel.org
References: <20250512084359.62178-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250512084359.62178-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/25 17:44, Niklas Cassel wrote:
> Commit affccb16c117 ("ata: ahci: print the lpm policy on boot") added a
> lpm-pol print during boot, which shows the LPM policy used by each port.
> 
> While the LPM policy is usually determined by the Kconfig
> CONFIG_SATA_MOBILE_LPM_POLICY, the Kconfig value is overridden e.g. if
> firmware has marked the port as hotplug capable / external.
> 
> Commit f97106b10d9a ("ata: ahci: Add debug print for external port") did
> add a debug print to show if LPM was disabled because firmware has marked
> the port as external, however, because devices having broken LPM (even
> though they claim to support it) is more common than one would have hoped,
> print "ext" during boot if firmware has marked the port is external.
> 
> This will make it easier to debug certain LPM issues, e.g. if firmware has
> enabled/marked only some of the ports as hotplug capable / external.
> 
> Before (port marked as external by firmware):
> ata1: SATA max UDMA/133 abar m4096@0xfebd3000 port 0xfebd3100 irq 57 lpm-pol 0
> 
> After (port marked as external by firmware):
> ata1: SATA max UDMA/133 abar m4096@0xfebd3000 port 0xfebd3100 irq 57 lpm-pol 0 ext
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Applied to for-6.16. Thanks !

-- 
Damien Le Moal
Western Digital Research
