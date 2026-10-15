Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BCF1A2C0B;
	Thu, 15 Oct 2026 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043075; cv=none; b=UiEVuj/lCi+mbECLFxPzAPFPTrt/eiPu8oXlmRjuFeGChZo4Pc/BMOpeKgw4GbJyvR91rEZsQ7f/u8jyP8GHl0QRQF02UxKjGm/PmiFt5upzU+WF9Q877A/zQnZiBcvUnc4hph7K8wtgtUmCXMtFK/PvmkP2PRRwQ7Cx3v5N6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043075; c=relaxed/simple;
	bh=pBeT3LEgRNmfd9zROFBVhschewtlY/BCOwof21X2Pb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcCNcmSZc+isBJC8bOo8wydhx9ZKrC4F1mgFOb0eQMbr/L0ZZITsKgopyhQZLmburYfLrpNYyjQp0B9AR9P9wdpjVaazOhnNZIetx5uTp0I6Rtkj88AH5BO9a+G0pak3shHIa2muuU4NYMrEkWahlN78snjYlBpivMN6q8IAtiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDyuB2f5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDyuB2f5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B861F000C4;
	Thu, 15 Oct 2026 05:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792043074;
	bh=o9NrBccd/oeQhP75cgqi1LalTU0++UhD5KpRWtwhOtI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NDyuB2f5BML1vo1T8r2detAXX7lQf0LnxFFoNpLDkl9wrseKWJeK6p09BeR+vX6hR
	 ZhiUP02jIXUDGHZFy0D2Qiv7QKL70VZ3f1hNFc/jslhXbft1wa/Oxq56lUkzXnQkdd
	 b/ZCIsLvq31bmya1WzVPSKnHpdC3OzlEqLQDHlL3QkSYu+wmujchRS7IOjMWaSsZjJ
	 2QXIKeedWdzw5VnbdYMZjUaiCGvPxIOdKTsMHKAJnTsMULEs1to54GRn/SST2oO2g1
	 MxmB0XJVK996YygAjyFh4KirqoCaZu1XXHRTetLN014YMo9Z6exRhMRE+7iEkZ/teA
	 aAkIwXBVTpjhA==
Message-ID: <9fcb4b3d-150f-4ab0-9191-423bda696549@kernel.org>
Date: Thu, 15 Oct 2026 07:44:32 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci: preserve preset port masks
To: zhoumin <teczm@foxmail.com>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_E0E7052529B6851284963EB90DF4D28CBB06@qq.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <tencent_E0E7052529B6851284963EB90DF4D28CBB06@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/15 5:06, zhoumin wrote:
> ahci_get_port_mask() returns zero for absent or unmatched parameters,
> overwriting the mask set by the Marvell PATA quirk.
> 
> Update the mask in place only when parsing a global value or a matching
> device entry. Preserve existing numeric parsing and override behavior.
> 
> Fixes: 70c1595c181c ("ata: ahci: Allow ignoring the external/hotplug capability of ports")
> Signed-off-by: zhoumin <teczm@foxmail.com>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
