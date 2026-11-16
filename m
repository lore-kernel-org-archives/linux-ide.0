Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841854;
	b=RzXLhtH6GUXPiXHJt43EmOdg1wnWCCtwUYayIvntXRl+1HMKRHI1XHimjDvtR2rsJkRG
	 TimbGUB/VeV3QTVtf56yjVDLuMowUpSUR0yjKAhlCyL4Evj/ShDMU18rycCKTiroeDF1L
	 nkKghM9+CZtn5NHMl7nP1/0BipwYVwHU4clkIpnezIUbl8+yx3IgDfepNPVsSEkIfW43d
	 fIHOSYRZsIQAur5Xrzvg4dIA9NxE4GBcTdgXFLJRfQwydFYzbqGauROP6a340jHgJurhJ
	 Wl2vrNHFu7LJoiG3Twj3gXMPaxxwg/QAjlHurQYqif4RNYVKHrpvmPPIvO7s+Fbj/YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841854;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=IayUwrGPm0PfJc1kIjd9luokl0oxaOWZD+iyZVMpE8g=;
	b=rJLRPF3RbEY2f07BoYHlNmkbWcPE+KFPXNUQILpVoHhai8X6/nI9ZSCCAepFlOt8f8Bo
	 ehSKQkn/7KYGyGrsLazsQ1jycI2P7WAKcJ+fPV7VZ9X2ctecA1FZ8P0wyjQEJS3g0P8iB
	 /M2AUfCwQ+d2WfIhuwa7otx53gN0GCNV+7t1RJtRAT/f49LCdlr3FyOgIQTaSxBFvFZ3F
	 KkD4lDEp16QXjjvy6Wi7DI3AV+8pVReqJ/U+3HYc88+T3GCUcfTGnsefu8gwEXd4Lt0XE
	 +9JzO0KmFEoVYNVHgTqZFWAVdr0CvPn2RBR/LYC+3WIhrWRLQ+ILPocs0M4kHeRY+kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbSLksih;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFEA606A8AA;
	Mon, 16 Nov 2026 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbSLksih
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A371F000D3;
	Mon, 16 Nov 2026 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794841853;
	bh=IayUwrGPm0PfJc1kIjd9luokl0oxaOWZD+iyZVMpE8g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EbSLksihU8MEaXOAajteti7dhmV0M1DY8TpnrN3WkBmHcpOWsMQlp9lafITIOIpRt
	 jsmuTvuC6p2J45FphM8Q8FOEsAVmAIJkbadG623jagUGfzvy/US97MN9ONG3fLxw2R
	 +WWRk0OuK7jXslgYwdXzcc6KubRThkczyZFHBW9lU61F7kVzfTIpGrgefH0K6TAAqm
	 uaNC9LeabW2qkadrbPCbUamWudO8VJ6ew3NMpUGID4OxBsAY8gbbNBu129PwIugBTB
	 y5rnX7I1sTKwkEMyciN4YGou8b/T3TLq0McAqofyfvirU8LSiwTakAA0LEjx9/ke2E
	 3OFPNDLklHRVQ==
Message-ID: <932b724d-b062-4b99-aa25-6da2ac1c45e4@kernel.org>
Date: Mon, 16 Nov 2026 07:10:51 -0800
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/12] drivers/ata: Stop using 32-bit MSR interfaces
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
References: <20261116150208.1572254-1-jgross@suse.com>
 <20261116150208.1572254-5-jgross@suse.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261116150208.1572254-5-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 07:02, Juergen Gross wrote:
> The 32-bit MSR interfaces rdmsr() and wrmsr() are planned to be
> removed. Use the related 64-bit variants instead.
> 
> In drivers/ata/pata_cs5536.c don't redefine rdmsr() and wrmsr() as
> empty macros for avoiding misuse, but guard the affected code via
> a simple #ifdef.
> 
> Switch pio_cmd_timings[] to a u32 type array in order to avoid a cast
> to u32 when constructing final MSR values.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Niklas Cassel <cassel@kernel.org>

Please change the patch title to be:

ata: pata_cs553X: Stop using 32-bit MSR interfaces

Other than that,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
